#include "it.h"
#include <math.h>

float vshift_it=0;
float vmin_it=-120;
float vmax_it=100;
float v12m_it=50;
float v12h_it=78;
float vwm_it=7.4;
float vwh_it=5.0;
float am_it=3;
float ah_it=85;
float vm1_it=25;
float vm2_it=100;
float vh1_it=46;
float vh2_it=405;
float wm1_it=20;
float wm2_it=15;
float wh1_it=4;
float wh2_it=50;
float ;
float hinf,htau,minf,mtau;

void trates_it(float v,float gbar_it,float cao_it) ;
void rates_it(float v_,float gbar_it,float cao_it) ;

void InitModel_it(float v,float &m,float &h,float gbar_it,float cao_it, float &ica) {
	trates_it(v+vshift_it,gbar_it,cao_it);
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

void DerivModel_it(float dt, float v,float &m,float &h,float gbar_it,float cao_it, float &ica) {
   trates_it (  v + vshift_it ,gbar_it,cao_it) ;
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

