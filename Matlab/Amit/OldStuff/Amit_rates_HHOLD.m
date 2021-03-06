function [minf hinf ninf mtau htau ntau]=Amit_rates_HH(v)
celsius=25;
q10=3^((celsius - 6.3)/10);
alpha=.1 * vtrap(-(v+40),10);
beta=4 * exp(-(v+65)/18);
sum=alpha + beta;
mtau=1/(q10*sum);
minf=alpha/sum;
alpha=.07 * exp(-(v+65)/20);
beta=1 / (exp(-(v+35)/10) + 1);
sum=alpha + beta;
htau=1/(q10*sum);
hinf=alpha/sum;
alpha=.01*vtrap(-(v+55),10) ;
beta=.125*exp(-(v+65)/80);
sum=alpha + beta;
ntau=1/(q10*sum);
ninf=alpha/sum;