#include "pas.h"
#include <math.h>



void InitModel_pas(float v,float g_pas,float e_pas) {
};

void DerivModel_pas(float dt, float v,float g_pas,float e_pas) {
}

void BreakpointModel_pas(MYSECONDFTYPE &sumCurrents, MYFTYPE &sumConductivity, float v,float g_pas,float e_pas) {
i=g_pas*(v-e_pas);
sumCurrents+= i;
sumConductivity+= g_pas;
};

