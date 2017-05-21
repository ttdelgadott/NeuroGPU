#include "km.h"
#include <math.h>

float temp_km=23;
float q10_km=2.3;
float vmin_km=-120;
float vmax_km=100;
float tadj_km;
float ;
float a,b,ninf,ntau,tadj;

void trates_km(float v ,float gbar_km,float tha_km,float qa_km,float Ra_km,float Rb_km) ;
void rates_km(float v ,float gbar_km,float tha_km,float qa_km,float Ra_km,float Rb_km) ;

float efun_km(float z) {
	if (fabs(z) < 1e-4) {;
		return  1 - z/2;
	}else{;
		return  z/(exp(z) - 1);
	};
};

void InitModel_km(float v,float &n,float gbar_km,float tha_km,float qa_km,float Ra_km,float Rb_km) {
    tadj_km = q10_km^((celsius - temp_km)/(10 )) ;
	trates_km(v,gbar_km,tha_km,qa_km,Ra_km,Rb_km);
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

void DerivModel_km(float dt, float v,float &n,float gbar_km,float tha_km,float qa_km,float Ra_km,float Rb_km) {
float rhs[1];
float y[1];
float matq[1][1];
   trates_km (  v ,gbar_km,tha_km,qa_km,Ra_km,Rb_km) ;
    n = n + (1. - exp(dt*(( ( ( - 1.0 ) ) ) / ntau)))*(- ( ( ( ninf ) ) / ntau ) / ( ( ( ( - 1.0) ) ) / ntau ) - n) ;
   }

void BreakpointModel_km(MYSECONDFTYPE &sumCurrents, MYFTYPE &sumConductivity, float v,float &n,float gbar_km,float tha_km,float qa_km,float Ra_km,float Rb_km) {
gk=tadj_km*gbar_km*n;
ik=(1e-4)*gk*(v-ek);
sumCurrents+= ik;
sumConductivity+= gk;
};


