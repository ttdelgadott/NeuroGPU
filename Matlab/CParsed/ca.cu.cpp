#include "hh.h"
#include <math.h>

__device__ void Cutrates_ca(float v ,float gbar_ca,float cao_ca,float &hinf,float &htau,float &minf,float &mtau);
__device__ void Curates_ca(float vm ,float gbar_ca,float cao_ca,float &hinf,float &htau,float &minf,float &mtau);

float efun_ca(float z) {
	if (fabs(z) < 1e-4) {;
		return  1 - z/2;
	}else{;
		return  z/(exp(z) - 1);
	};
};

__device__ void CuInitModel_ca(float v,float &m,float &h,float gbar_ca,float cao_ca, float cai, float &ica) {
float hinf,htau,minf,mtau;
    tadj_ca = q10_ca^((celsius - temp_ca)/(10 )) ;
	Cutrates_ca(v+vshift_ca,gbar_ca,cao_ca,hinf,htau,minf,mtau);
	m = minf;
	h = hinf;
};

void trates_ca(float v ,float gbar_ca,float cao_ca) {
	rates_ca(v,gbar_ca,cao_ca);
};

void rates_ca(float vm ,float gbar_ca,float cao_ca) {
float  a, b;
    tadj_ca = q10_ca^((celsius - temp_ca)/(10 ));
    a = 0.209*efun_ca(-(27+vm)/3.8);
	b = 0.94*exp((-75-vm)/17);
	;
	mtau = 1/tadj_ca/(a+b);
	minf = a/(a+b);
		;
	a = 0.000457*exp((-13-vm)/50);
	b = 0.0065/(exp((-vm-15)/28) + 1);
	htau = 1/tadj_ca/(a+b);
	hinf = a/(a+b);
};

__device__ void CuDerivModel_ca(float dt, float v,float &m,float &h,float gbar_ca,float cao_ca, float cai, float &ica) {
float hinf,htau,minf,mtau;
   Cutrates_ca (  v + vshift_ca ,gbar_ca,cao_ca,hinf,htau,minf,mtau);
    m = m + (1. - exp(dt*(( ( ( - 1.0 ) ) ) / mtau)))*(- ( ( ( minf ) ) / mtau ) / ( ( ( ( - 1.0) ) ) / mtau ) - m) ;
    h = h + (1. - exp(dt*(( ( ( - 1.0 ) ) ) / htau)))*(- ( ( ( hinf ) ) / htau ) / ( ( ( ( - 1.0) ) ) / htau ) - h) ;
   }

void BreakpointModel_ca(MYSECONDFTYPE &sumCurrents, MYFTYPE &sumConductivity, float v,float &m,float &h,float gbar_ca,float cao_ca, float cai, float &ica) {
float eca;
eca = nernst(cai,DEF_cao,2.);
gca=tadj_ca*gbar_ca*m*m*h;
ica=(1e-4)*gca*(v-eca);
sumCurrents+= ica;
sumConductivity+= gca;
};

