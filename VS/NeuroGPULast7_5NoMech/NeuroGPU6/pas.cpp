#include "pas.h"
#include <math.h> // YYY add this line



void InitModel() { // YYY add rates declataion before
};



void DerivModel() {
};

// YYY add sum conductivity float BreakpointModel(float &m,float &h,float &n,float gnabar,float gkbar,float gl,float el) {
// YYY add float v
// YYY change to void function
void BreakpointModel(float &sumCurrents, float &sumConductivity, float v, float g, float e) {
	sumCurrents = g*(v-e);
	sumConductivity =g;
};

