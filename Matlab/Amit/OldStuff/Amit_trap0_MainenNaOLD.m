function result = Amit_trap0_MainenNa(v,th,a,q) 

if (abs((v-th)/q) > 1e-6)
   result = a * (v - th) / (1 - exp(-(v - th)/q));
else
   result = a * q;
end;