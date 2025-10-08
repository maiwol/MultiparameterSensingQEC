function out = pk(Bx,Bz,k,N)
            B = sqrt(Bx.^2 + Bz.^2) ;
            p1 = cos(B).^2 + (Bz.*sin(B)./B).^2 ;
            p2 = (Bx.*sin(B)./B).^2 ;
            out = nchoosek(N,k).*((p1.^k).*(p2.^(N-k)) + (p2.^k).*(p1.^(N-k))) ;
end