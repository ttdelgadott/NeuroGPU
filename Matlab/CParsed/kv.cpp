#include "kv.h"
#include <math.h>

float temp_kv=23;
float q10_kv=2.3;
float vmin_kv=-120;
float vmax_kv=100;
float tadj_kv;
float ;
float a,b,ninf,ntau,tadj;

void trates_kv(float v ,float gbar_kv,float tha_kv,float qa_kv,float Ra_kv,float Rb_kv) ;
void rates_kv(float v ,float gbar_kv,float tha_kv,float qa_kv,float Ra_kv,float Rb_kv) ;

float efun_kv(float z) {
	if (fabs(z) < 1e-4) {;
		return  1 - z/2;
	}else{;
		return  z/(exp(z) - 1);
	};
};

void InitModel_kv(float v,float &n,float gbar_kv,float tha_kv,float qa_kv,float Ra_kv,float Rb_kv) {
    tadj_kv = q10_kv^((celsius - temp_kv)/(10 )) ;
	trates_kv(v,gbar_kv,tha_kv,qa_kv,Ra_kv,Rb_kv);
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

void DerivModel_kv(float dt, float v,float &n,float gbar_kv,float tha_kv,float qa_kv,float Ra_kv,float Rb_kv) {
   trates_kv (  v ,gbar_kv,tha_kv,qa_kv,Ra_kv,Rb_kv) ;
    n = n + (1. - exp(dt*(( ( ( - 1.0 ) ) ) / ntau)))*(- ( ( ( ninf ) ) / ntau ) / ( ( ( ( - 1.0) ) ) / ntau ) - n) ;
   }

void BreakpointModel_kv(MYSECONDFTYPE &sumCurrents, MYFTYPE &sumConductivity, float v,float &n,float gbar_kv,float tha_kv,float qa_kv,float Ra_kv,float Rb_kv) {
gk=tadj_kv*gbar_kv*n;
ik=(1e-4)*gk*(v-ek);
sumCurrents+= ik;
sumConductivity+= gk;
};



