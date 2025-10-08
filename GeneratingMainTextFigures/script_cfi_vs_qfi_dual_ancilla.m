fid  = fopen('cfi_vs_qfi_with_N_dual_ancilla','w+' ); % with N for three different values of (Bx,Bz) = (1,1), (2,1), (1,2) (t = 1 throughout)
t = 1; 
Bx1 = 1;
Bz1 = 1;
Bx2 = 2;
Bz2 = 1;
Bx3 = 0.1;
Bz3 = 1;
for m = 0:0.4:12
    N = round(2^m);
    cfi1 = two_probe_cfi(Bx1,Bz1,1,N) ;
    
    
    cfi2 = two_probe_cfi(Bx2,Bz2,1,N) ;
     
    cfi3 = two_probe_cfi(Bx3,Bz3,1,N) ;
     
    fprintf(fid,'%d\t %d\t %d\t %d\n',N, cfi1, cfi2, cfi3 );
    N
end