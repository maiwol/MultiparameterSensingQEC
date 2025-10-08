fid  = fopen('cfi_with_N_no_ancilla','w+' ); % with N for three different values of (Bx,Bz) = (1,1), (2,1), (1,2) (t = 1 throughout)
t = 1; 
Bx1 = 1;
Bz1 = 1;
Bx2 = 2;
Bz2 = 1;
Bx3 = 1;
Bz3 = 2;
for N = [3:2:9, 11:10:101, 101:20:501, 501:100:5001]
    cfi1 = freecfi(Bx1,Bz1,N) ;  
    cfi2 = freecfi(Bx2,Bz2,N) ;
    cfi3 = freecfi(Bx3,Bz3,N) ;
    fprintf(fid,'%d\t %d\t %d\t %d\n',N, cfi1,cfi2,cfi3);
    N
end