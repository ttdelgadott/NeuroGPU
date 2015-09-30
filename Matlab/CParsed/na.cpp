#include "na.h"
#include <math.h>

float vshift_na=-10;
float temp_na=23;
float q10_na=2.3;
float vmin_na=-120;
float vmax_na=100;
float tadj_na;
float ;
float hinf,htau,minf,mtau,tadj;

void trates_na(float v,float gbar_na,float tha_na,float qa_na,float Ra_na,float Rb_na,float thi1_na,float thi2_na,float qi_na,float thinf_na,float qinf_na,float Rg_na,float Rd_na) ;
void rates_na(float vm,float gbar_na,float tha_na,float qa_na,float Ra_na,float Rb_na,float thi1_na,float thi2_na,float qi_na,float thinf_na,float qinf_na,float Rg_na,float Rd_na) ;

float trap0_na(float v,float th,float a,float q) {
	if (fabs((v-th)/q) > 1e-6) {;
	        return  a * (v - th) / (1 - exp(-(v - th)/q));
	} else {;
	        return  a * q;
 	};
}	;

void InitModel_na(float v,float &m,float &h,float gbar_na,float tha_na,float qa_na,float Ra_na,float Rb_na,float thi1_na,float thi2_na,float qi_na,float thinf_na,float qinf_na,float Rg_na,float Rd_na) {
    tadj_na = q10_na^((celsius - temp_na)/10) ;
	trates_na(v+vshift_na,gbar_na,tha_na,qa_na,Ra_na,Rb_na,thi1_na,thi2_na,qi_na,thinf_na,qinf_na,Rg_na,Rd_na);
	m = minf;
	h = hinf;
};

void trates_na(float v,float gbar_na,float tha_na,float qa_na,float Ra_na,float Rb_na,float thi1_na,float thi2_na,float qi_na,float thinf_na,float qinf_na,float Rg_na,float Rd_na) {
                      ;
        ;
	;
	rates_na(v,gbar_na,tha_na,qa_na,Ra_na,Rb_na,thi1_na,thi2_na,qi_na,thinf_na,qinf_na,Rg_na,Rd_na);
};

void rates_na(float vm,float gbar_na,float tha_na,float qa_na,float Ra_na,float Rb_na,float thi1_na,float thi2_na,float qi_na,float thinf_na,float qinf_na,float Rg_na,float Rd_na) {
float  a, b;
	a = trap0_na(vm,tha_na,Ra_na,qa_na);
	b = trap0_na(-vm,-tha_na,Rb_na,qa_na);
        tadj_na = q10_na^((celsius - temp_na)/10);
	mtau = 1/tadj_na/(a+b);
	minf = a/(a+b);
		;
	a = trap0_na(vm,thi1_na,Rd_na,qi_na);
	b = trap0_na(-vm,-thi2_na,Rg_na,qi_na);
	htau = 1/tadj_na/(a+b);
	hinf = 1/(1+exp((vm-thinf_na)/qinf_na));
};

void DerivModel_na(float dt, float v,float &m,float &h,float gbar_na,float tha_na,float qa_na,float Ra_na,float Rb_na,float thi1_na,float thi2_na,float qi_na,float thinf_na,float qinf_na,float Rg_na,float Rd_na) {
   trates_na (  v + vshift_na ,gbar_na,tha_na,qa_na,Ra_na,Rb_na,thi1_na,thi2_na,qi_na,thinf_na,qinf_na,Rg_na,Rd_na) ;
    m = m + (1. - exp(dt*(( ( ( - 1.0 ) ) ) / mtau)))*(- ( ( ( minf ) ) / mtau ) / ( ( ( ( - 1.0) ) ) / mtau ) - m) ;
    h = h + (1. - exp(dt*(( ( ( - 1.0 ) ) ) / htau)))*(- ( ( ( hinf ) ) / htau ) / ( ( ( ( - 1.0) ) ) / htau ) - h) ;
   }

void BreakpointModel_na(MYSECONDFTYPE &sumCurrents, MYFTYPE &sumConductivity, float v,float &m,float &h,float gbar_na,float tha_na,float qa_na,float Ra_na,float Rb_na,float thi1_na,float thi2_na,float qi_na,float thinf_na,float qinf_na,float Rg_na,float Rd_na) {
gna=tadj_na*gbar_na*m*m*m*h;
ina=(1e-4)*gna*(v-ena);
sumCurrents+= ina;
sumConductivity+= gna;
};

