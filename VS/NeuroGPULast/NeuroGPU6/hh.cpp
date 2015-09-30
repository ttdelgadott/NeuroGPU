#include "hh.h"
#include <math.h> // YYY add this line

float hinf_hh,htau_hh,minf_hh,mtau_hh,ninf_hh,ntau_hh;

float  vtrap(float x, float y) { // YYY add *float* x,y  
	if (fabs(x/y) < 1e-6) {;
	return y*(1 - x/y/2);
	}
	else
	{;
	return x/(exp(x/y) - 1);
	};
};

void rates(float v);

void InitModelHH(float v,float &m,float &h,float &n) { // YYY add rates declataion before
	rates(v);
	m=minf_hh;
	h=hinf_hh;
	n=ninf_hh;
};

void rates(float v) {
	float  alpha, beta, sum, q10;
	;
	// q10=3^((celsius - 6.3)/10); YYY CHANGE THIS to pow
	q10=pow(3,((celsius - 6.3)/10));
	;
	alpha=.1 * vtrap(-(v+40),10);
	beta=4 * exp(-(v+65)/18);
	sum=alpha + beta;
	mtau_hh=1/(q10*sum);
	minf_hh=alpha/sum;
	;
	alpha=.07 * exp(-(v+65)/20);
	beta=1 / (exp(-(v+35)/10) + 1);
	sum=alpha + beta;
	htau_hh=1/(q10*sum);
	hinf_hh=alpha/sum;
	;
	alpha=.01*vtrap(-(v+55),10) ;
	beta=.125*exp(-(v+65)/80);
	sum=alpha + beta;
	ntau_hh=1/(q10*sum);
	ninf_hh=alpha/sum;
};

void DerivModelHH(float dt, float v, float &m,float &h,float &n) {
	rates(v);
	m = m + (1. - exp(dt*(( ( ( - 1.0 ) ) ) / mtau_hh)))*(- ( ( ( minf_hh ) ) / mtau_hh ) / ( ( ( ( - 1.0) ) ) / mtau_hh ) - m) ;
	h = h + (1. - exp(dt*(( ( ( - 1.0 ) ) ) / htau_hh)))*(- ( ( ( hinf_hh ) ) / htau_hh ) / ( ( ( ( - 1.0) ) ) / htau_hh ) - h) ;
	n = n + (1. - exp(dt*(( ( ( - 1.0 ) ) ) / ntau_hh)))*(- ( ( ( ninf_hh ) ) / ntau_hh ) / ( ( ( ( - 1.0) ) ) / ntau_hh ) - n) ;
};

// YYY add sum conductivity float BreakpointModel(float &m,float &h,float &n,float gnabar,float gkbar,float gl,float el) {
// YYY add float v
// YYY change to void function
void BreakpointModelHH(float &sumCurrents, float &sumConductivity, float v, float m,float h,float n,float gnabar,float gkbar,float gl,float ena,float ek,float el) {
	float gk,gna;
	float ina,ik,il;
	gna=gnabar*m*m*m*h;
	ina=gna*(v-ena);
	gk=gkbar*n*n*n*n;
	ik=gk*(v-ek);
	il=gl*(v-el);
	sumCurrents= ina+ik+il;
	sumConductivity= gl+gk+gna;
};

