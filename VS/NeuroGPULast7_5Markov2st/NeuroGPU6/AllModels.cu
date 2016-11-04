// Automatically generated CU for C:\Users\rben.KECK-CENTER\Documents\GitHub\NeuroGPU\URapNeuron\Markov2st\runModel.hoc
#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include "cuda_runtime.h"
#include "device_launch_parameters.h"
#include "AllModels.cuh"

// Universals:
#define PI (3.1415927f)
#define R (8.31441f)
#define FARADAY (96485.309f)
#define ktf (1000.*8.3134*(celsius + 273.15)/FARADAY)

#define _RHS1(arg) rhs[arg]
#define _MATELM1(i, j) matq[i][j]


// GGlobals
#define celsius (6.30000)
#define stoprun (0.00000)
#define clamp_resist (0.00100)
#define secondorder (0.00000)

// NGlobals:
#define _RHS1(arg) rhs[arg]
#define _MATELM1(i, j) matq[i][j]



// Reversals:
#define ek (-77.00000f)

// Declarations:
__device__ void Curates_CO(float v,float gbar_CO,float a12_CO,float a21_CO,float z12_CO,float z21_CO,float &k12,float &k21);
float Cunernst(float ci,float co, float z) {
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

// Kinetic Code:
__device__ void Cubackwards_euler( double h, int N, int nkinStates,float* rhs,float* y,float matq[2][2]){
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

// Functions:

// Procedures:
__device__ void Curates_CO(float v,float gbar_CO,float a12_CO,float a21_CO,float z12_CO,float z21_CO,float &k12,float &k21) {
      k12 = a12_CO*exp(z12_CO*v);
      k21 = a21_CO*exp(-z21_CO*v);
     ;
;};

// Inits:
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
;}
;}
//matq[i][i] = -sum;
;}
;}

// Derivs:
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
      
;} ;}
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
 Cubackwards_euler(dt,3,2,rhs,y,matq);
   ;} return _reset;
 ;}
 
;}

// Breakpoints:
__device__ void CuBreakpointModel_CO(MYSECONDFTYPE &sumCurrents, MYFTYPE &sumConductivity, float v,float &c1,float &o,float gbar_CO,float a12_CO,float a21_CO,float z12_CO,float z21_CO) {
float g,gk;
float ik;
g=gbar_CO*o;
ik=(1e-4)*g*(v-ek);
sumCurrents+= ik;
;};
