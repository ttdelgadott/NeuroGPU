#include "kca.h"
#include <math.h>

float temp_kca = 23;
float q10_kca  = 2.3;
float vmin_kca = -120;
float vmax_kca = 100;
float tadj_kca;

float a,ntau,b,ninf;
void rates_kca(float ca,float gbar_kca,float caix_kca,float Ra_kca,float Rb_kca) ;

void InitModel_kca(float v,float &n,float gbar_kca,float caix_kca,float Ra_kca,float Rb_kca){
	rates_kca(cai,gbar_kca,caix_kca,Ra_kca,Rb_kca);
	n = ninf;
};

void rates_kca(float ca,float gbar_kca,float caix_kca,float Ra_kca,float Rb_kca) {

;
a = Ra_kca * cai^caix_kca;
b = Rb_kca;
tadj_kca = q10_kca^((celsius - temp_kca)/10);
ntau = 1/tadj_kca/(a+b);
	ninf = a/(a+b);
;
};


void DerivModel_kca(float dt, float v,float &n,float gbar_kca,float caix_kca,float Ra_kca,float Rb_kca){
   rates_kca (   cai ,gbar_kca,caix_kca,Ra_kca,Rb_kca) ;
    n = n + (1. - exp(dt*(( ( ( - 1.0 ) ) ) / ntau)))*(- ( ( ( ninf ) ) / ntau ) / ( ( ( ( - 1.0) ) ) / ntau ) - n) ;

void BreakpointModel_kca(MYSECONDFTYPE &sumCurrents, MYFTYPE &sumConductivity, float v,float &n,float gbar_kca,float caix_kca,float Ra_kca,float Rb_kca) {
gk=tadj_kca*gbar_kca*n;
ik=(1e-4)*gk*(v-ek);
sumConductivity+= gca;
};
;


