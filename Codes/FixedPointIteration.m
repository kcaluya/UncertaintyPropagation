function [rho_next,comptime] = FixedPointIteration(beta,epsilon,h,rho_prev,D1,D2,xi)

% tolerance
tol = 1e-5;   

% max number of iterations for k                                                    
maxiter = 300;

nSample = length(D1);

% computes the distances      
C = pdist2(D1,D2,'squaredeuclidean'); 

% exponential of the cost matrix
Gamma = exp((-C)/(2*epsilon)); 
                     

lambda_1 = randn(nSample,1);

%lambda_1 = lambda_1/sum(lambda_1);
% initial conditions 
z0 = exp((h*lambda_1)/epsilon);    
% initial conditions for y and z
z = [z0,zeros(nSample,maxiter-1)];  

y = [rho_prev./(Gamma*z0),zeros(nSample,maxiter-1)];

Xi = (xi)/exp(1);

k = 1;
tic;
while k<maxiter 
 
    z(:,k+1) = (Xi./(Gamma'*y(:,k))).^(1/(((beta*epsilon)/(h))+1));
    
    y(:,k+1) = rho_prev ./ (Gamma*z(:,k+1));

    if (norm(z(:,k+1)-z(:,k))<tol && norm(y(:,k+1)-y(:,k))<tol)
         break;
     else
         k = k+1;
     end
end

comptime = toc;

rho_next = z(:,k).*(Gamma'*y(:,k));


%[error_y,error_z]=errorfunction(y,z,k);
% plot(1:k-1,error_y);
% hold on
% plot(1:k-1,error_z);
 %legend('y error','z error');




    



      
