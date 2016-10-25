#ifndef __pasx__
#define __pasx__

#define celsius 6.3
#define ena 56
#define ek -77

// g e 
#define NPARAMS 2
#define NSTATES 0
void BreakpointModel_pasx(MYSECONDFTYPE &sumCurrents, MYFTYPE &sumConductivity, float v,float g_pasx,float e_pasx) {;
void InitModel_pasx(float v,float g_pasx,float e_pasx);
#define CALL_TO_INIT_STATES InitModel_pasx(V[seg],ParamsM[0][comp],ParamsM[1][comp]);

#define CALL_TO_DERIV 

#define CALL_TO_BREAK BreakpointModel_pasx(sumCurrents, sumConductivity, V[seg],ParamsM[0][comp],ParamsM[1][comp]);

#define CALL_TO_BREAK_DV BreakpointModel_pasx(sumCurrentsDv, sumConductivityDv,  V[seg]+0.001,ParamsM[0][comp],ParamsM[1][comp]);


#endif
