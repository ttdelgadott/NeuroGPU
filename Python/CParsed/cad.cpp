#include "cad.h"
#include <math.h>

float taur_cad;
float depth_cad;
float cainf_cad;

float ;

void InitModel_cad(float v,float &ca,float depth_cad	_cad,float taur_cad	_cad,float cainf_cad	_cad, float ica, float &cai){
	ca = cainf_cad;
	cai = ca;
};


void DerivModel_cad(float dt, float v,float &ca,float depth_cad	_cad,float taur_cad	_cad,float cainf_cad	_cad, float ica, float &cai){
}

void BreakpointModel_cad(MYSECONDFTYPE &sumCurrents, MYFTYPE &sumConductivity, float v,float &ca,float depth_cad	_cad,float taur_cad	_cad,float cainf_cad	_cad, float ica, float &cai) {
sumConductivity+= gca;
};
;


