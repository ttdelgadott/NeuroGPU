#include "hh.h"
#include <math.h>


__device__ void CuInitModel_pas(float v,float g_pas,float e_pas) {
};

__device__ void CuDerivModel_pas(float dt, float v,float g_pas,float e_pas) {
float i;
}

void BreakpointModel_pas(MYSECONDFTYPE &sumCurrents, MYFTYPE &sumConductivity, float v,float g_pas,float e_pas) {
i=g_pas*(v-e_pas);
sumCurrents+= i;
sumConductivity+= g_pas;
};

