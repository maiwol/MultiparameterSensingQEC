function [a,b] = coeffts( Bx,Bz,k,N)

B = sqrt(Bx.^2+Bz.^2);
u00 = (cos(B)-1i.*Bz.*sin(B)./B);
u01 = -1i.*Bx.*sin(B)./B;
u11 = (cos(B)+ 1i.*Bz.*sin(B)./B);

a = u00.^(N-k).* u01.^k + u01.^(N-k).*u11.^k ;
b = u01.^(N-k).* u11.^k + u11.^(N-k).*u01.^k ;

end

