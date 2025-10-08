fid  = fopen('qfi_with_N_dual_ancilla','w+' ); % with N for three different values of (Bx,Bz) = (1,1), (2,1), (1,2) (t = 1 throughout)
t = 1; 
Bx1 = 1;
Bz1 = 1;
Bx2 = 2;
Bz2 = 1;
Bx3 = 0.1;
Bz3 = 1;
for m = 0:0.4:15
    N = round(2^m);
     
    qfi1 = qfi_2_alt(Bx1,Bz1,N);
    
     
    qfi2 = qfi_2_alt(Bx2,Bz2,N);
    
     
    qfi3 = qfi_2_alt(Bx3,Bz3,N);
    
    fprintf(fid,'%d\t %d\t %d\t %d\n',N, qfi1, qfi2, qfi3 );
    N
end 