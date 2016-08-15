// Automatically generated C for C:\Users\bensr\Documents\GitHub\NeuroGPU\URapNeuron\HodgkinHuxley\runModel.hoc
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
#define ek (-77.00000f)
#define ena (50.00000f)

// Locals:
float gk,gna,il;

// Ion currents as Locals:
float ik,ina;

// NGlobals:
#define minf_hh2 (0.052932)
#define hinf_hh2 (0.59612)
#define ninf_hh2 (0.31768)
#define mtau_hh2 (0.23677)
#define htau_hh2 (8.516)
#define ntau_hh2 (5.4586)

// Declarations:
void rates_hh2(float v,float gnabar_hh2,float gkbar_hh2,float gl_hh2,float el_hh2) ;
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
float vtrap_hh2(float x,float y) {
        if (fabs(x/y) < 1e-6) {;
                return  y*(1 - x/y/2);
        }else{;
                return  x/(exp(x/y) - 1);
        };
};

// Inits:
void InitModel_hh2(float v,float &m,float &h,float &n,float gnabar_hh2,float gkbar_hh2,float gl_hh2,float el_hh2) {
	rates_hh2(v,gnabar_hh2,gkbar_hh2,gl_hh2,el_hh2);
	m = minf_hh2;
	h = hinf_hh2;
	n = ninf_hh2;
;};

// Procedures:
void rates_hh2(float v,float gnabar_hh2,float gkbar_hh2,float gl_hh2,float el_hh2) {
float  alpha, beta, sum, q10;
                      ;
        q10 =pow((MYFTYPE) 3,(MYFTYPE)((celsius - 6.3)/10));
                ;
        alpha = .1 * vtrap_hh2(-(v+40),10);
        beta =  4 * exp(-(v+65)/18);
        sum = alpha + beta;
/* removed mtau_hh2 recalculation */
       /* removed minf_hh2 recalculation */
                ;
        alpha = .07 * exp(-(v+65)/20);
        beta = 1 / (exp(-(v+35)/10) + 1);
        sum = alpha + beta;
/* removed htau_hh2 recalculation */
       /* removed hinf_hh2 recalculation */
                ;
        alpha = .01*vtrap_hh2(-(v+55),10) ;
        beta = .125*exp(-(v+65)/80);
	sum = alpha + beta;
       /* removed ntau_hh2 recalculation */
       /* removed ninf_hh2 recalculation */
;};

// Derivs:
void DerivModel_hh2(float dt, float v,float &m,float &h,float &n,float gnabar_hh2,float gkbar_hh2,float gl_hh2,float el_hh2) {
   rates_hh2 (  v ,gnabar_hh2,gkbar_hh2,gl_hh2,el_hh2) ;
    m = m + (1. - exp(dt*(( ( ( - 1.0 ) ) ) / mtau_hh2)))*(- ( ( ( minf_hh2 ) ) / mtau_hh2 ) / ( ( ( ( - 1.0) ) ) / mtau_hh2 ) - m) ;
    h = h + (1. - exp(dt*(( ( ( - 1.0 ) ) ) / htau_hh2)))*(- ( ( ( hinf_hh2 ) ) / htau_hh2 ) / ( ( ( ( - 1.0) ) ) / htau_hh2 ) - h) ;
    n = n + (1. - exp(dt*(( ( ( - 1.0 ) ) ) / ntau_hh2)))*(- ( ( ( ninf_hh2 ) ) / ntau_hh2 ) / ( ( ( ( - 1.0) ) ) / ntau_hh2 ) - n) ;
   ;}

// Breakpoints:
void BreakpointModel_hh2(MYSECONDFTYPE &sumCurrents, MYFTYPE &sumConductivity, float v,float &m,float &h,float &n,float gnabar_hh2,float gkbar_hh2,float gl_hh2,float el_hh2) {
gna=gnabar_hh2*m*m*m*h;
ina=gna*(v-ena);
gk=gkbar_hh2*n*n*n*n;
ik=gk*(v-ek);
il=gl_hh2*(v-el_hh2);
sumCurrents+= ik;
sumConductivity+= gk;
;};
