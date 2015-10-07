%Amit_rates_MainenNa
function vars_MainenNa = Amit_rates_MainenNa (vars_MainenNa, consts_MainenNa, vm)

AmitModelConstsIndicesDef_MainenNa;
AmitModelVarsIndicesDef_MainenNa;

tha = consts_MainenNa(tha_index);
Ra = consts_MainenNa(Ra_index);
qa = consts_MainenNa(qa_index);
Rb = consts_MainenNa(Rb_index);
q10 = consts_MainenNa(q10_index);
celsius = consts_MainenNa(celsius_index);
temp = consts_MainenNa(temp_index);
thi1 = consts_MainenNa(thi1_index);
Rd = consts_MainenNa(Rd_index);
qi = consts_MainenNa(qi_index);
thi2 = consts_MainenNa(thi2_index);
Rg = consts_MainenNa(Rg_index);
thinf = consts_MainenNa(thinf_index);
qinf = consts_MainenNa(qinf_index);

a = Amit_trap0_MainenNa(vm,tha,Ra,qa);
b = Amit_trap0_MainenNa(-vm,-tha,Rb,qa);

tadj = q10^((celsius - temp)/10);

mtau = 1/tadj/(a+b);
minf = a/(a+b);

a = Amit_trap0_MainenNa(vm,thi1,Rd,qi);
b = Amit_trap0_MainenNa(-vm,-thi2,Rg,qi);
htau = 1/tadj/(a+b);
hinf = 1/(1+exp((vm-thinf)/qinf));

vars_MainenNa(mtau_index) = mtau;
vars_MainenNa(minf_index) = minf;
vars_MainenNa(htau_index) = htau;
vars_MainenNa(hinf_index) = hinf;
