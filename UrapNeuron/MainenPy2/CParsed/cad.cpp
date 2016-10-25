#include "cad.h"
#include <math.h>

float depth_cad	= .1;
float taur_cad	= 200;
float cainf_cad	= 100e-6;

float ;

void InitModel_cad(float v,float &ca, float ica, float &cai){
	ca = cainf_cad;
	cai = ca;
};


void DerivModel_cad(float dt, float v,float &ca, float ica, float &cai){
}

void BreakpointModel_cad(MYSECONDFTYPE &sumCurrents, MYFTYPE &sumConductivity, float v,float &ca, float ica, float &cai) {
sumConductivity+= gca;
};
;


