#include "hh.h"
#include <math.h>

__device__ void Curates_hh2(float v,float gnabar_hh2,float gkbar_hh2,float gl_hh2,float el_hh2);

float vtrap_hh2(float x,float y) {
        if (fabs(x/y) < 1e-6) {;
                return  y*(1 - x/y/2);
        }else{;
                return  x/(exp(x/y) - 1);
        };
};

__device__ void CuInitModel_hh2(float v,float &m,float &h,float &n,float gnabar_hh2,float gkbar_hh2,float gl_hh2,float el_hh2) {
float ;
	Curates_hh2(v,gnabar_hh2,gkbar_hh2,gl_hh2,el_hh2);
	m = minf_hh2;
	h = hinf_hh2;
	n = ninf_hh2;
};

void rates_hh2(float v,float gnabar_hh2,float gkbar_hh2,float gl_hh2,float el_hh2) {
float  alpha, beta, sum, q10;
                      ;
        q10 = 3^((celsius - 6.3)/10);
                ;
        alpha = .1 * vtrap_hh2(-(v+40),10);
        beta =  4 * exp(-(v+65)/18);
        sum = alpha + beta;
	mtau_hh2 = 1/(q10*sum);
        minf_hh2 = alpha/sum;
                ;
        alpha = .07 * exp(-(v+65)/20);
        beta = 1 / (exp(-(v+35)/10) + 1);
        sum = alpha + beta;
	htau_hh2 = 1/(q10*sum);
        hinf_hh2 = alpha/sum;
                ;
        alpha = .01*vtrap_hh2(-(v+55),10) ;
        beta = .125*exp(-(v+65)/80);
	sum = alpha + beta;
        ntau_hh2 = 1/(q10*sum);
        ninf_hh2 = alpha/sum;
};

__device__ void CuDerivModel_hh2(float dt, float v,float &m,float &h,float &n,float gnabar_hh2,float gkbar_hh2,float gl_hh2,float el_hh2) {
float ek,ik,il;
float ;
   Curates_hh2 (  v ,gnabar_hh2,gkbar_hh2,gl_hh2,el_hh2);
    m = m + (1. - exp(dt*(( ( ( - 1.0 ) ) ) / mtau_hh2)))*(- ( ( ( minf_hh2 ) ) / mtau_hh2 ) / ( ( ( ( - 1.0) ) ) / mtau_hh2 ) - m) ;
    h = h + (1. - exp(dt*(( ( ( - 1.0 ) ) ) / htau_hh2)))*(- ( ( ( hinf_hh2 ) ) / htau_hh2 ) / ( ( ( ( - 1.0) ) ) / htau_hh2 ) - h) ;
    n = n + (1. - exp(dt*(( ( ( - 1.0 ) ) ) / ntau_hh2)))*(- ( ( ( ninf_hh2 ) ) / ntau_hh2 ) / ( ( ( ( - 1.0) ) ) / ntau_hh2 ) - n) ;
   }

void BreakpointModel_hh2(MYSECONDFTYPE &sumCurrents, MYFTYPE &sumConductivity, float v,float &m,float &h,float &n,float gnabar_hh2,float gkbar_hh2,float gl_hh2,float el_hh2) {
gna=gnabar_hh2*m*m*m*h;
ina=gna*(v-ena);
gk=gkbar_hh2*n*n*n*n;
ik=gk*(v-ek);
il=gl_hh2*(v-el_hh2);
sumCurrents+= ik;
sumConductivity+= gk;
};

