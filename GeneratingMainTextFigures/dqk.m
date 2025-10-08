  function [out1,out2,out3,out4] = dqk(Bx,Bz,k,N) %finds the derivatives wrt x and z
  dell = 0.0001;      
        
        [a1,b1] = qk(Bx+dell./2,Bz,k,N);
        [a1d,b1d] = qk(Bx-dell./2,Bz,k,N);
        [a2,b2] = qk(Bx,Bz+dell./2,k,N);
        [a2d,b2d] = qk(Bx,Bz-dell./2,k,N);
        
        out1 = (a1-a1d)./dell; %dp+/dBx
        out2 = (b1-b1d)./dell; %dp-/dBx
        out3 = (a2-a2d)./dell ; %dp+/dBz;
        out4 = (b2-b2d)./dell ; %dp-/dBz;
         
    end
