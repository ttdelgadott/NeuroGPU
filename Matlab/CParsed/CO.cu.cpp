#include "hh.h"
#include <math.h>

__device__ void Curates_CO(float v,float gbar_CO,float a12_CO,float a21_CO,float z12_CO,float z21_CO,float &k12,float &k21);

__device__ void CuInitModel_CO(float v,float &c1,float &o,float gbar_CO,float a12_CO,float a21_CO,float z12_CO,float z21_CO) {
float k12,k21;
double sum = 0;
        Curates_CO(v,gbar_CO,a12_CO,a21_CO,z12_CO,z21_CO,k12,k21);
//matq[0][1] =k12;
//matq[1][0] =k21;
for (int i = 0; i <2; i++) {
sum = 0 ;
for (int j = 0; j <2; j++) {
if (i != j) {
//sum +=matq[i][j];
}
}
//matq[i][i] = -sum;
}
}

void rates_CO(float v,float gbar_CO,float a12_CO,float a21_CO,float z12_CO,float z21_CO) {
      k12 = a12_CO*exp(z12_CO*v);
      k21 = a21_CO*exp(-z21_CO*v);
     ;
};

__device__ int CuDerivModel_CO(float dt, float v,float &c1,float &o,float gbar_CO,float a12_CO,float a21_CO,float z12_CO,float z21_CO) {
float k12,k21;
float rhs[2];
float y[2];
float matq[2][2];
y[0] =c1;
y[1] =o;
 {int _reset=0;
 {
   double b_flux, f_flux, _term; int _i;
 {int _i; double _dt1 = 1.0/dt;
for(_i=1;_i<2;_i++){
  	_RHS1(_i) = 0;
	_MATELM1(_i, _i) = _dt1;
      
} }
 Curates_CO (  v ,gbar_CO,a12_CO,a21_CO,z12_CO,z21_CO,k12,k21);
   /* ~ c1 <-> o ( k12 , k21 )*/
 f_flux =  k12 * c1 ;
 b_flux =  k21 * o ;
 _RHS1( 1) -= (f_flux - b_flux);
 
 _term =  k12 ;
 _MATELM1( 1 ,1)  += _term;
 _term =  k21 ;
 _MATELM1( 1 ,0)  -= _term;
 /*REACTION*/
   /* c1 + o = 1.0 */
 _RHS1(0) =  1.0;
 _MATELM1(0, 0) = 1;
 _RHS1(0) -= o ;
 _MATELM1(0, 1) = 1;
 _RHS1(0) -= c1 ;
 backwards_euler(dt,3,2,rhs,y,matq);
   } 
 }
 
}

void BreakpointModel_CO(MYSECONDFTYPE &sumCurrents, MYFTYPE &sumConductivity, float v,float &c1,float &o,float gbar_CO,float a12_CO,float a21_CO,float z12_CO,float z21_CO) {
g=gbar_CO*o;
ik=(1e-4)*g*(v-ek);
sumCurrents+= ik;
};

