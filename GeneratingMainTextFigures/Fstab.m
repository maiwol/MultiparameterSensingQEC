function out = Fstab(Bx,Bz,N)

    B = sqrt(Bx.^2 + Bz.^2) ;     
    Fxx = 0;
    Fzz = 0;
    Fxz = 0;
    
    for k = 0:1:(N-1)/2
        [dpx,dpz] =  dpk(Bx,Bz,k,N);
        p = pk(Bx,Bz,k,N);
        Fxx = Fxx + (dpx.*dpx)./p;
        Fzz = Fzz + (dpz.*dpz)./p;
        Fxz = Fxz + (dpx.*dpz)./p;    
    end
    
  out = [Fxx,Fxz ; Fxz,Fzz];

end

