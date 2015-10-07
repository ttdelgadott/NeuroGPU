function vars_MainenKv = Amit_rates_MainenKv (vars_MainenKv, consts_MainenKv, v)

AmitModelConstsIndicesDef_MainenKv;
AmitModelVarsIndicesDef_MainenKv;

Ra = consts_MainenKv(Ra_index);
Rb = consts_MainenKv(Rb_index);
tha = consts_MainenKv (tha_index);
qa = consts_MainenKv(qa_index);
q10 = consts_MainenKv(q10_index);
celsius = consts_MainenKv(celsius_index);
temp = consts_MainenKv(temp_index);


a = Ra * (v - tha) / (1 - exp(-(v - tha)/qa));
b = -Rb * (v - tha) / (1 - exp((v - tha)/qa));

tadj = q10^((celsius - temp)/10);
ntau = 1/tadj/(a+b);
ninf = a/(a+b);

vars_MainenKv(ntau_index) = ntau;
vars_MainenKv(ninf_index) = ninf;