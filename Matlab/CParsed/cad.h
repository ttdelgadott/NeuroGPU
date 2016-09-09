#ifndef __cad__
#define __cad__

#define celsius 6.3
#define ena 56
#define ek -77

// depth taur cainf 
#define NPARAMS 3
#define NSTATES 1

void BreakpointModel_cad(MYSECONDFTYPE &sumCurrents, MYFTYPE &sumConductivity, float v,float &ca, float ica, float &cai) ;
void DerivModel_cad(float dt, float v,float &ca, float ica, float &cai) ;
void InitModel_cad(float v,float &ca, float ica, float &cai) ;

#define CALL_TO_INIT_STATES  InitModel_cad(V[seg],StatesM[2][seg] ,StatesM[9][ seg ],StatesM[8][ seg ]);

#define CALL_TO_DERIV  DerivModel_cad(dt, V[seg],StatesM[2][seg] ,StatesM[9][ seg ],StatesM[8][ seg ]);

#define CALL_TO_BREAK BreakpointModel_cad(sumCurrents, sumConductivity, V[seg],StatesM[2][seg] ,StatesM[9][ seg ],StatesM[8][ seg ]);

#define CALL_TO_BREAK_DV BreakpointModel_cad(sumCurrentsDv, sumConductivityDv, V[seg]+0.001,StatesM[2][seg] ,StatesM[9][ seg ],StatesM[8][ seg ]);

#define CALL_TO_Kinetic 


#endif