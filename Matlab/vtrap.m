function Out=vtrap(x,y)
if (abs(x/y) < 1e-6)
    Out= y*(1 - x/y/2);
else
    Out= x/(exp(x/y) - 1);
end