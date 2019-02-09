function  GradPsiX = drift(Xval,dim) 

global alpha 

if dim == 1
    
OUGradPsi = @(x) -alpha*x;

GradPsiX = OUGradPsi(Xval);

end
if dim == 2
    
DuffGradPsi = @(x,y) -[x.^3-x,y];
    
GradPsiX  = DuffGradPsi(Xval(:,1),Xval(:,2));


end
