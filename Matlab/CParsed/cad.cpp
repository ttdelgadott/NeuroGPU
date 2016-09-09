#include "cad.h"
#include <math.h>

float depth_cad=.1;
float taur_cad=200;
float cainf_cad=100e-6;


void InitModel_cad(float v,float &ca, float ica, float &cai) {
	ca = cainf_cad;
	cai = ca;
};

void DerivModel_cad(float dt, float v,float &ca, float ica, float &cai) {
   drive_channel = - ( 10000.0 ) * ica / ( 2.0 * FARADAY * depth_cad ) ;
   if ( drive_channel <= 0. ) {
     drive_channel = 0. ;
     }
    ca = ca + (1. - exp(dt*(( ( ( - 1.0 ) ) ) / taur_cad)))*(- ( drive_channel + ( ( cainf_cad ) ) / taur_cad ) / ( ( ( ( - 1.0) ) ) / taur_cad ) - ca) ;
   cai = ca ;
   }

void BreakpointModel_cad(MYSECONDFTYPE &sumCurrents, MYFTYPE &sumConductivity, float v,float &ca, float ica, float &cai) {
};



