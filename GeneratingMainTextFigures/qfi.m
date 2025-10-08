function [out,outopt] = qfi(Bx,Bz,N) %outputs the Tr[inv(F_Q)]

sum1xx = 0;
sum1zz = 0;
sum1xz = 0;
sum2x = 0;
sum2z = 0;
sum3x = 0;
sum3z = 0;


for k = 0:1:N
    R = Rnk(Bx,Bz,k,N);
    [dRx,dRz] = dRnk(Bx,Bz,k,N);
    sum1xx = sum1xx + 2.*nchoosek(N,k).*dRx'.*dRx ;
    sum1zz = sum1zz + 2.*nchoosek(N,k).*dRz'.*dRz ;
    sum1xz = sum1xz + 2.*nchoosek(N,k).*dRx'.*dRz ;
    
    sum2x = sum2x + nchoosek(N,k).*dRx'.*R ;
    sum2z = sum2z + nchoosek(N,k).*dRz'.*R ;

    sum3x = sum3x + nchoosek(N,k).*R'.*dRx ;
    sum3z = sum3z + nchoosek(N,k).*R'.*dRz ;
end 

Qxx = sum1xx - sum2x.*sum3x ;
Qzz = sum1zz - sum2z.*sum3z ;
Qxz = sum1xz - sum2x.*sum3z;

Q = [Qxx Qxz; Qxz Qzz];
outopt = Q;
out = trace(inv(Q));
out = real (out) ;
end
