#include "CO.h"
#include <math.h>

float k12,k21;

void rates_CO(float v,float gbar_CO,float a12_CO,float a21_CO,float z12_CO,float z21_CO) ;

void InitModel_CO(float v,float &c1,float &o,float gbar_CO,float a12_CO,float a21_CO,float z12_CO,float z21_CO) {

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

