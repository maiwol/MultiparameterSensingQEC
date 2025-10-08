function out  = Fpec(Bx,Bz,N )

 B = sqrt(Bx.^2 + Bz.^2) ;
        
    out = zeros(2,2);
    for k = 0:1:(N-1)/2
         
        p = pk(Bx,Bz,k,N);
        out = out + p.* Fkpec(Bx,Bz,k,N);    
    end 
end

