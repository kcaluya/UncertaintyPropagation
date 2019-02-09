function [Xsort,rhosort d] = sorter(Xupd,rho_next)

    [Xsort d] = sort(Xupd);
    
    for i = 1:length(Xupd)
        
        rhosort(i) = rho_next(d(i));
    end
    
end
