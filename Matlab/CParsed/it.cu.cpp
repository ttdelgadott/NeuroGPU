#include "hh.h"
#include <math.h>

__device__ void Cutrates_it(float v,float gbar_it,float cao_it,float &hinf,float &htau,float &minf,float &mtau);
__device__ void Curates_it(float v_,float gbar_it,float cao_it,float &hinf,float &htau,float &minf,float &mtau);

__device__ void CuInitModel_it(float v,float &m,float &h,float gbar_it,float cao_it, float &ica) {
float hinf,htau,minf,mtau;
	Cutrates_it(v+vshift_it,gbar_it,cao_it,hinf,htau,minf,mtau);
	m = minf;
	h = hinf;
};

void trates_it(float v,float gbar_it,float cao_it) {
   ;
   rates_it(v,gbar_it,cao_it);
};

void rates_it(float v_,float gbar_it,float cao_it) {
float  a, b;
   minf = 1.0 / ( 1 + exp(-(v_+v12m_it)/vwm_it) );
   hinf = 1.0 / ( 1 + exp((v_+v12h_it)/vwh_it) );
   mtau = ( am_it + 1.0 / ( exp((v_+vm1_it)/wm1_it) + exp(-(v_+vm2_it)/wm2_it) ) ) ;
   htau = ( ah_it + 1.0 / ( exp((v_+vh1_it)/wh1_it) + exp(-(v_+vh2_it)/wh2_it) ) ) ;
};

__device__ void CuDerivModel_it(float dt, float v,float &m,float &h,float gbar_it,float cao_it, float &ica) {
float tadj;
float hinf,htau,minf,mtau;
   Cutrates_it (  v + vshift_it ,gbar_it,cao_it,hinf,htau,minf,mtau);
    m = m + (1. - exp(dt*(( ( ( - 1.0 ) ) ) / mtau)))*(- ( ( ( minf ) ) / mtau ) / ( ( ( ( - 1.0) ) ) / mtau ) - m) ;
    h = h + (1. - exp(dt*(( ( ( - 1.0 ) ) ) / htau)))*(- ( ( ( hinf ) ) / htau ) / ( ( ( ( - 1.0) ) ) / htau ) - h) ;
   }

void BreakpointModel_it(MYSECONDFTYPE &sumCurrents, MYFTYPE &sumConductivity, float v,float &m,float &h,float gbar_it,float cao_it, float &ica) {
float eca;
eca = nernst(DEF_cai,DEF_cao,2.);
gca=gbar_it*m*m*h;
ica=gca*(v-eca);
sumCurrents+= ica;
sumConductivity+= gca;
};

