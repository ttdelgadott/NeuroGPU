#ifndef __ca__
#define __ca__

#define celsius 6.3
#define ena 56
#define ek -77

// gbar vshift cao temp q10 vmin vmax tadj 
#define NPARAMS 8
#define NSTATES 2

void BreakpointModel_ca(MYSECONDFTYPE &sumCurrents, MYFTYPE &sumConductivity, float v,float &m,float &h,float gbar_ca,float cao_ca, float cai, float &ica) ;
void DerivModel_ca(float dt, float v,float &m,float &h,float gbar_ca,float cao_ca, float cai, float &ica) ;
void InitModel_ca(float v,float &m,float &h,float gbar_ca,float cao_ca, float cai, float &ica) ;

#define CALL_TO_INIT_STATES  InitModel_ca(V[seg],StatesM[0][seg] ,StatesM[1][seg] ,ParamsM[0][comp],ParamsM[1][comp],StatesM[8][ seg ],StatesM[9][ seg ]);

#define CALL_TO_DERIV  DerivModel_ca(dt, V[seg],StatesM[0][seg] ,StatesM[1][seg] ,ParamsM[0][comp],ParamsM[1][comp],StatesM[8][ seg ],StatesM[9][ seg ]);

#define CALL_TO_BREAK BreakpointModel_ca(sumCurrents, sumConductivity, V[seg],StatesM[0][seg] ,StatesM[1][seg] ,ParamsM[0][comp],ParamsM[1][comp],StatesM[8][ seg ],StatesM[9][ seg ]);

#define CALL_TO_BREAK_DV BreakpointModel_ca(sumCurrentsDv, sumConductivityDv, V[seg]+0.001,StatesM[0][seg] ,StatesM[1][seg] ,ParamsM[0][comp],ParamsM[1][comp],StatesM[8][ seg ],StatesM[9][ seg ]);


#endif