// Automatically generated C for C:\Users\rben.KECK-CENTER\Documents\GitHub\NeuroGPU\URapNeuron\Markov2st\runModel.hoc
#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include "AllModels.h"

// Universals:
#define PI (3.1415927f)
#define R (8.31441f)
#define FARADAY (96485.309f)
#define ktf (1000.*8.3134*(celsius + 273.15)/FARADAY)

// Reversals:
#define ek (-77.00000000f)

// Locals:
float g,k12,k21;

// Ion currents as Locals:
float ik;
#define _RHS1(arg) rhs[arg]
#define _MATELM1(i, j) matq[i][j]

// NGlobals:
 void backwards_euler(double h, int N, int nkinStates, float* rhs, float* y, float matq[2][2]){
	for (int i = 0; i < nkinStates; i++) {
		double w0 = y[i];
		for (int j = 0; j < N; j++) {
			double top = w0 - y[i] - h * rhs[i];
			double bottom = 1 - h * matq[i][i];
			double dw = top / bottom;
			w0 = w0 - dw;
		}
		y[i] = w0;
	}
}
// Declarations:
void rates_CO(float v,float gbar_CO,float a12_CO,float a21_CO,float z12_CO,float z21_CO) ;
float nernst(float ci,float co, float z) {
	if (z == 0) {
		return 0.;
	}
	if (ci <= 0.) {
		return 1e6;
	}else if (co <= 0.) {
		return -1e6;
	}else{
		return ktf/z*log(co/ci);
	}	
}

// Functions:

// Inits:
void InitModel_CO(float v,float &c1,float &o,float gbar_CO,float a12_CO,float a21_CO,float z12_CO,float z21_CO) {
double sum = 0;
rates_CO(v, gbar_CO, a12_CO, a21_CO, z12_CO, z21_CO);
//matq[0][1] =k12;
//matq[1][0] =k21;
for (int i = 0; i <2; i++) {
sum = 0 ;
for (int j = 0; j <2; j++) {
if (i != j) {
//sum +=matq[i][j];
;}
;}
//matq[i][i] = -sum;
;}
;}

// Procedures:
void rates_CO(float v,float gbar_CO,float a12_CO,float a21_CO,float z12_CO,float z21_CO) {
      k12 = a12_CO*exp(z12_CO*v);
      k21 = a21_CO*exp(-z21_CO*v);
     ;
;};

// Derivs:
void DerivModel_CO(float dt, float v,float &c1,float &o,float gbar_CO,float a12_CO,float a21_CO,float z12_CO,float z21_CO) {
 {int _reset=0;
 {
   double b_flux, f_flux, _term; int _i;
   float y[2];
   float rhs[2];
   float matq[2][2];
 {int _i; double _dt1 = 1.0/dt;
for(_i=1;_i<2;_i++){
  	_RHS1(_i) = 0;
	_MATELM1(_i, _i) = _dt1;
      
;} ;}
 rates_CO (  v ,gbar_CO,a12_CO,a21_CO,z12_CO,z21_CO) ;
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
   ;} 
 ;}
 
;}

// Breakpoints:
void BreakpointModel_CO(MYSECONDFTYPE &sumCurrents, MYFTYPE &sumConductivity, float v,float &c1,float &o,float gbar_CO,float a12_CO,float a21_CO,float z12_CO,float z21_CO) {
g=gbar_CO*o;
ik=(1e-4)*g*(v-ek);
sumCurrents+= ik;
;};
