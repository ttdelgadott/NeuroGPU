#include "CO.h"
#include <math.h>

float k12,k21;

void rates_CO(float v,float gbar_CO,float a12_CO,float a21_CO,float z12_CO,float z21_CO) ;

void InitModel_CO(float v,float &c1,float &o,float gbar_CO,float a12_CO,float a21_CO,float z12_CO,float z21_CO) {
o=0};

void rates_CO(float v,float gbar_CO,float a12_CO,float a21_CO,float z12_CO,float z21_CO) {
      k12 = a12_CO*exp(z12_CO*v);
      k21 = a21_CO*exp(-z21_CO*v);
     ;
};

void DerivModel_CO(float dt, float v,float &c1,float &o,float gbar_CO,float a12_CO,float a21_CO,float z12_CO,float z21_CO) {
 {int _reset=0;
 {
   double b_flux, f_flux, _term; int _i;
 {int _i; double _dt1 = 1.0/dt;
for(_i=1;_i<2;_i++){
  	_RHS1(_i) = 0;
	_MATELM1(_i, _i) = _dt1;
      
} }
 rates_CO (  v ,gbar_CO,a12_CO,a21_CO,z12_CO,z21_CO,k12,k21) ;
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


