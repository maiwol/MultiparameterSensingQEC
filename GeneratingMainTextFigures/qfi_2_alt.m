function out = qfi_2_alt(Bx,Bz,N) %outputs the Tr[inv(F_Q)] for GHZz X GHZx two probes 

[~,qx]=  qfix(Bx,Bz,N);
[~,qz]=  qfi(Bx,Bz,N);

q = qx+qz;
out = trace(inv(q));
end
