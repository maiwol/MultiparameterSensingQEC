function out = Fkpec(Bx,Bz,k,N)
%Outputs the FIM


[p1,p2] = qk(Bx,Bz,k,N);
[ddxp1,ddxp2,ddzp1,ddzp2]=dqk(Bx,Bz,k,N);

Fxx = (ddxp1.*ddxp1)./p1 + (ddxp2.*ddxp2)./p2;
Fzz = (ddzp1.*ddzp1)./p1 + (ddzp2.*ddzp2)./p2;
Fxz = (ddxp1.*ddzp1)./p1 + (ddxp2.*ddzp2)./p2;

out = [Fxx Fxz ; Fxz Fzz];



end

