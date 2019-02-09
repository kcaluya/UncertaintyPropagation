clc;
close all; 
clear;
% parameters 
global alpha

dim = 1;                                            % dimension in space

beta = 1;                                           % temperature

nSample = 400;                                      % number of samples  

alpha = 1;                                          % drift coefficient  

epsilon = .05;                                      % regularizing coefficient  

h = .001;                                           % time step

t_initial = 0;                                      %initial time

t_final = 4 ;                                       % final time 

numSteps= ceil((t_final-t_initial)/h);              % number of steps k, in discretization t=kh

tvect = t_initial:h:t_final;

tindx = [ 0 500 1000 2000 3000 numSteps] + 1;

fs = 10;                                            % fontsize

mean0 = 5 ;
% inital variance
sigma0 =  .2;  

%2D Mean and Variance
% mean0 =  [2,2];
% sigma0 = 4*eye(dim);

   
% generates initial positions
x0 = normrnd(mean0,sigma0,nSample,dim);

% generates initial pdf
rho_0 = normpdf(x0,mean0,sigma0);

% x0 = mvnrnd(mean0,sigma0,nSample);
% 
% % generates initial pdf
% rho_0 = mvnpdf(x0, mean0,sigma0);



%% One Dimesional Plots 
if dim == 1


% normalize initial pdf
rho_next(:,1) = rho_0/sum(rho_0);

% stores all the updated locations from the governing SDE
Xupd = zeros(nSample,dim,numSteps+1);

% sets initial location
Xupd(:,:,1) = x0;

tic
for j=1:numSteps
    
    % SDE update
    Xupd(:,:,j+1) = EulerMaruyama(h,beta,Xupd(:,:,j),drift(Xupd(:,:,j),dim),dim);
    % Generalized Sinkhorn Algorithm
    rho_next(:,j+1) = FixedPointIteration(beta,epsilon,h,rho_next(:,j),Xupd(:,:,j),Xupd(:,:,j+1),exp(-beta*Potential(Xupd(:,:,j),dim)));
   
end
toc;

% normalization of P
for i = 1:numSteps+1
   
 % sorts Xvalues decreasing    
[Xsort(:,i), rhosort(:,i)] =  sorter(Xupd(:,i),rho_next(:,i));

% computes the volume of pdfs from optimization problem

% computes the numerical volume
vol(i) = trapz(Xsort(:,i),rhosort(:,i));
% computes the numerical
intmeann(i) = trapz(Xsort(:,i),Xsort(:,i).*(rhosort(:,i)/vol(i))); 
% computes the numerical variance
intvarr(i) = trapz(Xsort(:,i),((Xsort(:,i)-intmeann(i)).^2).*(rhosort(:,i)/vol(i))); 

% normalizes the Pdf
rho_next_norm(:,i) = rho_next(:,i)/vol(i);

end

% variance over time for OU process
sigma_time = @ (t) (((sigma0)^2)*exp(-2*alpha*t))+((1-exp(-2*alpha*t))/(beta*alpha));
% mean over time for OU Process
mean_time = @(t)  mean0*exp(-alpha*t);

lw = 2;
fs = 20;


for jj = 1:length(tindx)
   
    
    subplot(2,3,jj)
    
    plot(Xsort(:,tindx(jj)),normpdf(Xsort(:,tindx(jj))...
    ,mean_time((tindx(jj)-1)*h),(sqrt(sigma_time((tindx(jj)-1)*h)))),'linewidth',lw);
    hold on
    plot(Xupd(:,:,tindx(jj)),rho_next_norm(:,tindx(jj)),'.')
    
    xlabel('x','fontsize',12)
    ylabel('rho','fontsize',12)
    
    title(['t = ',num2str((tindx(jj)-1)*h)],'FontSize',12)
end

sgtitle('1D Linear System','Fontsize',20)



figure(2)


plot(tvect,mean_time(tvect),'linewidth',lw)
hold on
plot(tvect,intmeann)

xlabel('time t','FontSize',fs)
ylabel('mean \mu','FontSize',fs)

figure(3)

plot(tvect,sigma_time(tvect),'linewidth',lw)
hold on
plot(tvect,intvarr)


xlabel('time t','FontSize',fs)
ylabel('variance \sigma^2','FontSize',fs)


figure(4);

for  k = 1:length(tindx)
 
 plot3((tindx(k)-1)*h*ones(nSample,1),Xupd(:,tindx(k)),rho_next_norm(:,tindx(k)),'.')
 hold on
 plot3((tindx(k)-1)*h*ones(nSample,1),Xsort(:,tindx(k)),normpdf(Xsort(:,tindx(k))...
     ,mean_time((tindx(k)-1)*h),(sqrt(sigma_time((tindx(k)-1)*h)))),'linewidth',lw);
 hold on
 
 
    
end

xlabel('time t','FontSize',fs)
ylabel('x','FontSize',fs)
zlabel('density \rho','FontSize',fs)

end

%% Duffing Oscillator Plots 
if dim == 2
           
% normalize initial pdf
rho_next(:,1) = rho_0/sum(rho_0);

% stores all the updated locations from the governing SDE
Xupd = zeros(nSample,dim,numSteps+1);

% sets initial location
Xupd(:,:,1) = x0;


tic
for j=1:numSteps
    
    % SDE update
    Xupd(:,:,j+1) = EulerMaruyama(h,beta,Xupd(:,:,j),drift(Xupd(:,:,j),dim),dim);
    % Generalized Sinkhorn Algorithm
    rho_next(:,j+1) = FixedPointIteration(beta,epsilon,h,rho_next(:,j),...
    Xupd(:,:,j),Xupd(:,:,j+1),exp(-beta*Potential(Xupd(:,:,j),dim)));
   
end
toc;

for k = 1:length(tindx)
    
  subplot(3,2,k)
   
  scatter(Xupd(:,1,tindx(k)),Xupd(:,2,tindx(k)),20,rho_next(:,tindx(k)),'filled','o','MarkerEdgeColor','k') 
  hold on
  
  xlabel('x_1','FontSize',12)
  ylabel('x_2','FontSize',12)
  title(['t = ',num2str((tindx(k)-1)*h)],'FontSize',12)
  
    
end
sgtitle('2D Nonlinear System','FontSize',20)
end
    
    
    
    
    
    
    
    
    
    
    






 
