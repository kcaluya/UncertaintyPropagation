function Xupd = EulerMaruyama(h,beta,Xold,drift,dim)
 
% Ornstein-Uhlenbeck  SDE 
% dX(t) = -alpha*X dt + sqrt(2/beta) dW(t)
% randn('state',0)

Xupd = Xold + (drift*h) + ((sqrt(2/beta))*sqrt(h)*randn(length(Xold),dim));


%  for i = 1:length(Xold)
%      Xupd(i) = Xold(i) - gradpsi(i)*h + ((sqrt(2/beta))*sqrt(h)*randn);
%  end
end