function  PsiX = Potential(Xval,dim) 


global alpha

if dim ==1
    
OUpsi = @(x) (alpha*x.^2)/2;

PsiX = OUpsi(Xval);

end

if dim == 2 


DuffPsi = @(x,y) (1/4)*(1+x.^4)+(1/2)*(y.^2-x.^2);

PsiX = DuffPsi(Xval(:,1),Xval(:,2));

end