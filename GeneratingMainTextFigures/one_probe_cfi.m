function out = one_probe_cfi(Bx,Bz,t,N) %outputs the Tr[inv(F_c)]

B = sqrt(Bx.^2 + Bz.^2);
Bt = B.*t;
nx = Bx./B;
nz = Bz./B;

f1xx = ((2.*(nz.^2).*Bt + (nx.^2).* sin(2.*Bt)).^2)./(4.*sin(Bt).*sin(Bt).*(1-nx.*nx.*sin(Bt).*sin(Bt))) ;

f2xx = (nx.*nz.*(1-Bt.*cot(Bt))).^2./(1-nx.*nx.*sin(Bt).*sin(Bt)) ;


f1zz = ((2.*Bt -sin(2.*Bt)).^2)./(4.*sin(Bt).*sin(Bt).*(1-nx.*nx.*sin(Bt).*sin(Bt))) ;
f1zz = f1zz.*nx.^2.*nz.^2 ;

f2zz = (nz.^2 + (nx.^2).*Bt.*cot(Bt)).^2./(1-nx.*nx.*sin(Bt).*sin(Bt)) ;


f3 = (nx.* sin(Bt)).^2./ (1-(nx.* sin(Bt)).^2) ;

outx = (f1xx + (f2xx./ (f3 + N)))./(4.*N.*t^2) ;
outz = (f1zz + (f2zz./ (f3 + N)))./(4.*N.*t^2) ;

out = outx + outz ;


end

