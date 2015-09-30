#ifndef __pas__
#define __pas__

#define celsius 6.3
#define ena 56
#define ek -77

// g e 
#define NPARAMS 2
#define NSTATES 0

void BreakpointModel_pas(MYSECONDFTYPE &sumCurrents, MYFTYPE &sumConductivity, float v,float g_pas,float e_pas) ;
void DerivModel_pas(float dt, float v,float g_pas,float e_pas) ;
void InitModel_pas(float v,float g_pas,float e_pas) ;

#define CALL_TO_INIT_STATES  InitModel_pas(V[seg],ParamsM[28][comp],ParamsM[29][comp]);

#define CALL_TO_DERIV  DerivModel_pas(dt, V[seg],ParamsM[28][comp],ParamsM[29][comp]);

#define CALL_TO_BREAK BreakpointModel_pas(sumCurrents, sumConductivity, V[seg],ParamsM[28][comp],ParamsM[29][comp]);

#define CALL_TO_BREAK_DV BreakpointModel_pas(sumCurrentsDv, sumConductivityDv, V[seg]+0.001,ParamsM[28][comp],ParamsM[29][comp]);


#endif