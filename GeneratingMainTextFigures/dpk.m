 function [out1,out2] = dpk(Bx,Bz,k,N)
 dell = 0.0001;
             out1 = (pk(Bx+dell./2,Bz,k,N)- pk(Bx-dell./2,Bz,k,N))./dell ; %dpk/dBx
             out2 = (pk(Bx,Bz+dell./2,k,N)- pk(Bx,Bz-dell./2,k,N))./dell ; %dpk/dBz 
 end
       

