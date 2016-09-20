#include "hh.h"
#include <math.h>

__device__ void Cutrates_km(float v ,float gbar_km,float tha_km,float qa_km,float Ra_km,float Rb_km,float &a,float &b,float &ninf,float &ntau);
__device__ void Curates_km(float v ,float gbar_km,float tha_km,float qa_km,float Ra_km,float Rb_km,float &a,float &b,float &ninf,float &ntau);

float efun_km(float z) {
	if (fabs(z) < 1e-4) {;
		return  1 - z/2;
	}else{;
		return  z/(exp(z) - 1);
	};
};

__device__ void CuInitModel_km(float v,float &n,float gbar_km,float tha_km,float qa_km,float Ra_km,float Rb_km) {
float a,b,ninf,ntau;
    tadj_km = q10_km^((celsius - temp_km)/(10 )) ;
	Cutrates_km(v,gbar_km,tha_km,qa_km,Ra_km,Rb_km,a,b,ninf,ntau);
	n = ninf;
};

void trates_km(float v ,float gbar_km,float tha_km,float qa_km,float Ra_km,float Rb_km) {
                      ;
	rates_km(v,gbar_km,tha_km,qa_km,Ra_km,Rb_km);
};

void rates_km(float v ,float gbar_km,float tha_km,float qa_km,float Ra_km,float Rb_km) {
                      ;
    ;
    a = Ra_km * qa_km * efun_km(-(v - tha_km)/qa_km);
    ;
    b = Rb_km * qa_km * efun_km((v - tha_km)/qa_km);
        tadj_km = q10_km^((celsius - temp_km)/10);
        ntau = 1/tadj_km/(a+b);
	ninf = a/(a+b);
};

__device__ void CuDerivModel_km(float dt, float v,float &n,float gbar_km,float tha_km,float qa_km,float Ra_km,float Rb_km) {
float a,b,ninf,ntau;
   Cutrates_km (  v ,gbar_km,tha_km,qa_km,Ra_km,Rb_km,a,b,ninf,ntau);
    n = n + (1. - exp(dt*(( ( ( - 1.0 ) ) ) / ntau)))*(- ( ( ( ninf ) ) / ntau ) / ( ( ( ( - 1.0) ) ) / ntau ) - n) ;
   }

void BreakpointModel_km(MYSECONDFTYPE &sumCurrents, MYFTYPE &sumConductivity, float v,float &n,float gbar_km,float tha_km,float qa_km,float Ra_km,float Rb_km) {
gk=tadj_km*gbar_km*n;
ik=(1e-4)*gk*(v-ek);
sumCurrents+= ik;
sumConductivity+= gk;
};



