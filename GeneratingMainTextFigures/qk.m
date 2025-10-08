 function [out1,out2] = qk(Bx,Bz,k,N)
        
        [a,b] = coeffts(Bx,Bz,k,N);
        out1 = (abs(a+b).^2)./ (2.*abs(a).^2 + 2.*abs(b).^2) ;
        out2 = (abs(a-b).^2)./ (2.*abs(a).^2 + 2.*abs(b).^2) ;
    end

