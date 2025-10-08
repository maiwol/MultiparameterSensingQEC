function out = freecfi(Bx,Bz,N)

f1 = Fstab(Bx,Bz,N);
f2 = Fpec(Bx,Bz,N);

f = f1+f2;
f = inv(f);
out = trace(f);

end

