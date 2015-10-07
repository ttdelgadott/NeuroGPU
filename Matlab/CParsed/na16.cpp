#include "na16.h"
#include <math.h>

float temp_na16=23;
float q10_na16=2.3;
float vmin_na16=-120;
float vmax_na16=100;
float tadj_na16;
float ;
float hinf,htau,minf,mtau,tadj;

void trates_na16(float v,float gbar_na16,float vshift_na16,float tha_na16,float qa_na16,float Ra_na16,float Rb_na16,float thi1_na16,float thi2_na16,float qi_na16,float thinf_na16,float qinf_na16,float Rg_na16,float Rd_na16) ;
void rates_na16(float vm,float gbar_na16,float vshift_na16,float tha_na16,float qa_na16,float Ra_na16,float Rb_na16,float thi1_na16,float thi2_na16,float qi_na16,float thinf_na16,float qinf_na16,float Rg_na16,float Rd_na16) ;

float trap0_na16(float v,float th,float a,float q) {
	if (fabs((v-th)/q) > 1e-6) {;
	        return  a * (v - th) / (1 - exp(-(v - th)/q));
	} else {;
	        return  a * q;
 	};
}	;

void InitModel_na16(float v,float &m,float &h,float gbar_na16,float vshift_na16,float tha_na16,float qa_na16,float Ra_na16,float Rb_na16,float thi1_na16,float thi2_na16,float qi_na16,float thinf_na16,float qinf_na16,float Rg_na16,float Rd_na16) {
    tadj_na16 = q10_na16^((celsius - temp_na16)/10) ;
	trates_na16(v+vshift_na16,gbar_na16,vshift_na16,tha_na16,qa_na16,Ra_na16,Rb_na16,thi1_na16,thi2_na16,qi_na16,thinf_na16,qinf_na16,Rg_na16,Rd_na16);
	m = minf;
	h = hinf;
};

void trates_na16(float v,float gbar_na16,float vshift_na16,float tha_na16,float qa_na16,float Ra_na16,float Rb_na16,float thi1_na16,float thi2_na16,float qi_na16,float thinf_na16,float qinf_na16,float Rg_na16,float Rd_na16) {
                      ;
        ;
	;
	rates_na16(v,gbar_na16,vshift_na16,tha_na16,qa_na16,Ra_na16,Rb_na16,thi1_na16,thi2_na16,qi_na16,thinf_na16,qinf_na16,Rg_na16,Rd_na16);
};

void rates_na16(float vm,float gbar_na16,float vshift_na16,float tha_na16,float qa_na16,float Ra_na16,float Rb_na16,float thi1_na16,float thi2_na16,float qi_na16,float thinf_na16,float qinf_na16,float Rg_na16,float Rd_na16) {
float  a, b;
	a = trap0_na16(vm,tha_na16,Ra_na16,qa_na16);
	b = trap0_na16(-vm,-tha_na16,Rb_na16,qa_na16);
        tadj_na16 = q10_na16^((celsius - temp_na16)/10);
	mtau = 1/tadj_na16/(a+b);
	minf = a/(a+b);
		;
	a = trap0_na16(vm,thi1_na16,Rd_na16,qi_na16);
	b = trap0_na16(-vm,-thi2_na16,Rg_na16,qi_na16);
	htau = 1/tadj_na16/(a+b);
	hinf = 1/(1+exp((vm-thinf_na16)/qinf_na16));
};

void DerivModel_na16(float dt, float v,float &m,float &h,float gbar_na16,float vshift_na16,float tha_na16,float qa_na16,float Ra_na16,float Rb_na16,float thi1_na16,float thi2_na16,float qi_na16,float thinf_na16,float qinf_na16,float Rg_na16,float Rd_na16) {
 {
   trates_na16 (  v + vshift_na16 ,gbar_na16,vshift_na16,tha_na16,qa_na16,Ra_na16,Rb_na16,thi1_na16,thi2_na16,qi_na16,thinf_na16,qinf_na16,Rg_na16,Rd_na16) ;
    m = m + (1. - exp(dt*(( ( ( - 1.0 ) ) ) / mtau)))*(- ( ( ( minf ) ) / mtau ) / ( ( ( ( - 1.0) ) ) / mtau ) - m) ;
    h = h + (1. - exp(dt*(( ( ( - 1.0 ) ) ) / htau)))*(- ( ( ( hinf ) ) / htau ) / ( ( ( ( - 1.0) ) ) / htau ) - h) ;
   }

void BreakpointModel_na16(MYSECONDFTYPE &sumCurrents, MYFTYPE &sumConductivity, float v,float &m,float &h,float gbar_na16,float vshift_na16,float tha_na16,float qa_na16,float Ra_na16,float Rb_na16,float thi1_na16,float thi2_na16,float qi_na16,float thinf_na16,float qinf_na16,float Rg_na16,float Rd_na16) {
gna=tadj_na16*gbar_na16*m*m*m*h;
ina=(1e-4)*gna*(v-ena);
sumCurrents+= ina;
sumConductivity+= gna;
};

