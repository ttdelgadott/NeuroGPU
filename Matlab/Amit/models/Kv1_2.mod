COMMENT
Kv1.2 channel changed according the data from Korngreen and Sakmann 2000
voltage gated potassium channel, Hodgkin-Huxley style kinetics.  

Kinetics were fit to data from recordings of nucleated patches derived 
from pyramidal neurons. Data recordings and fits from Alon Korngreen 

Changed by Mara Almog

ENDCOMMENT

INDEPENDENT {t FROM 0 TO 1 WITH 1 (ms)}

NEURON {
	SUFFIX Kv12
	USEION k READ ek WRITE ik
	RANGE  a, b, gkv12, gbar
	RANGE  ainf, taua, binf, taub
	GLOBAL q10, temp, tadj, vmin, vmax, vshift
}

PARAMETER {
	gbar = 0   	(pS/um2)	: 
	vshift = 0	(mV)		: voltage shift (affects all)
	temp = 21	(degC)		: original temp 
	q10  = 2.3				: temperature sensitivity
	v 			(mV)
	celsius		(degC)
	vmin = -120	(mV)
	vmax = 100	(mV)
}

UNITS {
	(mA) = (milliamp)
	(mV) = (millivolt)
	(pS) = (picosiemens)
	(um) = (micron)
} 

ASSIGNED {
	ik 		(mA/cm2)
	gkv12	(pS/um2)
	ek		(mV)
	ainf 		
	binf
	taua 	(ms)	
	taub 	(ms)
	taub1 	(ms)	
	tadj
}
 

STATE {a b}

INITIAL { 
	rates(v+vshift)
	a = ainf
	b = binf 
}

BREAKPOINT {
    SOLVE states METHOD cnexp
    gkv12 = tadj*gbar*a*a*b
	ik = (1e-4)*gkv12*(v-ek)
} 

LOCAL aexp, bexp,b1exp, z 

DERIVATIVE states {   		
    rates(v+vshift) 	
    a'  = (ainf-a)/taua
    b'  = (binf-b)/taub
}


PROCEDURE rates(v) {  
	:TABLE  taua, ainf, binf, taub DEPEND celsius FROM vmin TO vmax WITH 199
	tadj = q10^((celsius - temp)/10)
		
	taua = (1.25+(13*exp(-0.026*v)))/tadj               
	ainf = 1/(1+exp(-(v+45)/14.6))
	
	taub = ((4*v)+3330)/tadj
 	binf = 1/(1+exp(-(v+54)/(-11)))
}


