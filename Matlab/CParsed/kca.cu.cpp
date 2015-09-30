#include "hh.h"
#include <math.h>

__device__ void Curates_kca(float cai,float gbar_kca,float caix_kca,float Ra_kca,float Rb_kca,float &a,float &b,float &ninf,float &ntau);

__device__ void CuInitModel_kca(float v,float &n,float gbar_kca,float caix_kca,float Ra_kca,float Rb_kca, float cai) {
float a,b,ninf,ntau;
	Curates_kca(cai,gbar_kca,caix_kca,Ra_kca,Rb_kca,a,b,ninf,ntau);
	n = ninf;
};

void rates_kca(float cai,float gbar_kca,float caix_kca,float Ra_kca,float Rb_kca) {
        ;
        a = Ra_kca * cai^caix_kca;
        b = Rb_kca;
        tadj_kca = q10_kca^((celsius - temp_kca)/10);
        ntau = 1/tadj_kca/(a+b);
	ninf = a/(a+b);
 ;
};

__device__ void CuDerivModel_kca(float dt, float v,float &n,float gbar_kca,float caix_kca,float Ra_kca,float Rb_kca, float cai) {
float a,b,ninf,ntau;
   Curates_kca (  cai ,gbar_kca,caix_kca,Ra_kca,Rb_kca,a,b,ninf,ntau);
    n = n + (1. - exp(dt*(( ( ( - 1.0 ) ) ) / ntau)))*(- ( ( ( ninf ) ) / ntau ) / ( ( ( ( - 1.0) ) ) / ntau ) - n) ;
   }

void BreakpointModel_kca(MYSECONDFTYPE &sumCurrents, MYFTYPE &sumConductivity, float v,float &n,float gbar_kca,float caix_kca,float Ra_kca,float Rb_kca, float cai) {
gk=tadj_kca*gbar_kca*n;
ik=(1e-4)*gk*(v-ek);
sumCurrents+= ik;
sumConductivity+= gk;
};

