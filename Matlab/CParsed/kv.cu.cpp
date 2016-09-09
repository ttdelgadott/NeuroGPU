#include "hh.h"
#include <math.h>

__device__ void Cutrates_kv(float v ,float gbar_kv,float tha_kv,float qa_kv,float Ra_kv,float Rb_kv,float &a,float &b,float &ninf,float &ntau);
__device__ void Curates_kv(float v ,float gbar_kv,float tha_kv,float qa_kv,float Ra_kv,float Rb_kv,float &a,float &b,float &ninf,float &ntau);

float efun_kv(float z) {
	if (fabs(z) < 1e-4) {;
		return  1 - z/2;
	}else{;
		return  z/(exp(z) - 1);
	};
};

__device__ void CuInitModel_kv(float v,float &n,float gbar_kv,float tha_kv,float qa_kv,float Ra_kv,float Rb_kv) {
float a,b,ninf,ntau;
    tadj_kv = q10_kv^((celsius - temp_kv)/(10 )) ;
	Cutrates_kv(v,gbar_kv,tha_kv,qa_kv,Ra_kv,Rb_kv,a,b,ninf,ntau);
	n = ninf;
};

void trates_kv(float v ,float gbar_kv,float tha_kv,float qa_kv,float Ra_kv,float Rb_kv) {
                      ;
	rates_kv(v,gbar_kv,tha_kv,qa_kv,Ra_kv,Rb_kv);
};

void rates_kv(float v ,float gbar_kv,float tha_kv,float qa_kv,float Ra_kv,float Rb_kv) {
                      ;
    ;
    a = Ra_kv * qa_kv * efun_kv(-(v - tha_kv)/qa_kv);
    ;
    b = Rb_kv * qa_kv * efun_kv((v - tha_kv)/qa_kv);
        tadj_kv = q10_kv^((celsius - temp_kv)/10);
        ntau = 1/tadj_kv/(a+b);
	ninf = a/(a+b);
};

__device__ void CuDerivModel_kv(float dt, float v,float &n,float gbar_kv,float tha_kv,float qa_kv,float Ra_kv,float Rb_kv) {
float a,b,ninf,ntau;
   Cutrates_kv (  v ,gbar_kv,tha_kv,qa_kv,Ra_kv,Rb_kv,a,b,ninf,ntau);
    n = n + (1. - exp(dt*(( ( ( - 1.0 ) ) ) / ntau)))*(- ( ( ( ninf ) ) / ntau ) / ( ( ( ( - 1.0) ) ) / ntau ) - n) ;
   }

void BreakpointModel_kv(MYSECONDFTYPE &sumCurrents, MYFTYPE &sumConductivity, float v,float &n,float gbar_kv,float tha_kv,float qa_kv,float Ra_kv,float Rb_kv) {
gk=tadj_kv*gbar_kv*n;
ik=(1e-4)*gk*(v-ek);
sumCurrents+= ik;
sumConductivity+= gk;
};



