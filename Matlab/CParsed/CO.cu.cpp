#include "hh.h"
#include <math.h>

__device__ void Curates_CO(float v,float gbar_CO,float a12_CO,float a21_CO,float z12_CO,float z21_CO,float &k12,float &k21);

__device__ void CuInitModel_CO(float v,float &c1,float &o,float gbar_CO,float a12_CO,float a21_CO,float z12_CO,float z21_CO) {
;
}

void rates_CO(float v,float gbar_CO,float a12_CO,float a21_CO,float z12_CO,float z21_CO) {
      k12 = a12_CO*exp(z12_CO*v);
      k21 = a21_CO*exp(-z21_CO*v);
     ;
};



void BreakpointModel_CO(MYSECONDFTYPE &sumCurrents, MYFTYPE &sumConductivity, float v,float &c1,float &o,float gbar_CO,float a12_CO,float a21_CO,float z12_CO,float z21_CO) {
g=gbar_CO*o;
ik=(1e-4)*g*(v-ek);
sumCurrents+= ik;
};

void KineticModel_CO(,float &c1,float &o,float gbar_CO,float a12_CO,float a21_CO,float z12_CO,float z21_CO) {
 double b_flux, f_flux, _term; int _i;
 {int _i; for(_i=0;_i<2;_i++) _p[_dlist1[_i]] = 0.0;}
 rates_CO (  v ,gbar_CO,a12_CO,a21_CO,z12_CO,z21_CO) ;
 /* ~ c1 <-> o ( k12 , k21 )*/
 f_flux =  k12 * c1 ;
 b_flux =  k21 * o ;
 Dc1 -= (f_flux - b_flux);
 Do += (f_flux - b_flux);
 
 /*REACTION*/
   /* c1 + o = 1.0 */
 /*CONSERVATION*/
   } return _reset;
 }
 

