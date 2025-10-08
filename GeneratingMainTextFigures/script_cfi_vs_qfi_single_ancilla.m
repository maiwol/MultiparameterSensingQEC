fid  = fopen('cfi_vs_qfi_with_N_single_ancilla','w+' ); % with N for three different values of (Bx,Bz) = (1,1), (2,1), (1,2) (t = 1 throughout)
t = 1; 
Bx1 = 1;
Bz1 = 1;
Bx2 = 2;
Bz2 = 1;
Bx3 = 1;
Bz3 = 2;
for N = [10:10:100, 100 :20:500, 500:100:5000]
     
    cfi1 = one_probe_cfi(Bx1,Bz1,1,N) ;
    qfi1 = qfi(Bx1,Bz1,N);
    
   
    cfi2 = one_probe_cfi(Bx2,Bz2,1,N) ;
    qfi2 = qfi(Bx2,Bz2,N);
     
    cfi3 = one_probe_cfi(Bx3,Bz3,1,N) ;
    qfi3 = qfi(Bx3,Bz3,N);
    fprintf(fid,'%d\t %d\t %d\t %d\t %d\t %d\t %d\n',N,  cfi1,qfi1, cfi2,qfi2, cfi3,qfi3);
    N
end