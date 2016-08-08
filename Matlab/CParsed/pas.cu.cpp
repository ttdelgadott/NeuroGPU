#include "hh.h"
#include <math.h>


__device__ void CuInitModel_pas(float v,float g_pas,float e_pas) {
	g_pas = .001	(S/cm2)	<0,1e9>;
	e_pas = -70	;
};



void BreakpointModel_pas(MYSECONDFTYPE &sumCurrents, MYFTYPE &sumConductivity, float v,float g_pas,float e_pas) {
i=g_pas*(v-e_pas);
sumConductivity+= g_pas;
};

