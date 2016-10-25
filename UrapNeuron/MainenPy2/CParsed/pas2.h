#ifndef __pas2__
#define __pas2__

#define celsius 6.3
#define ena 56
#define ek -77

// g e 
#define NPARAMS 2
#define NSTATES 0
void BreakpointModel_pas2(MYSECONDFTYPE &sumCurrents, MYFTYPE &sumConductivity, float v,float g_pas2,float e_pas2) {;
void InitModel_pas2(float v,float g_pas2,float e_pas2);
#define CALL_TO_INIT_STATES InitModel_pas2(V[seg],ParamsM[0][comp],ParamsM[1][comp]);

#define CALL_TO_DERIV 

#define CALL_TO_BREAK BreakpointModel_pas2(sumCurrents, sumConductivity, V[seg],ParamsM[0][comp],ParamsM[1][comp]);

#define CALL_TO_BREAK_DV BreakpointModel_pas2(sumCurrentsDv, sumConductivityDv,  V[seg]+0.001,ParamsM[0][comp],ParamsM[1][comp]);


#endif
