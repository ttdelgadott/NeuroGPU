#ifndef __kca__
#define __kca__

#define celsius 6.3
#define ena 56
#define ek -77

// gbar caix Ra Rb temp q10 vmin vmax tadj 
#define NPARAMS 9
#define NSTATES 1

void BreakpointModel_kca(MYSECONDFTYPE &sumCurrents, MYFTYPE &sumConductivity, float v,float &n,float gbar_kca,float caix_kca,float Ra_kca,float Rb_kca, float cai) ;
void DerivModel_kca(float dt, float v,float &n,float gbar_kca,float caix_kca,float Ra_kca,float Rb_kca, float cai) ;
void InitModel_kca(float v,float &n,float gbar_kca,float caix_kca,float Ra_kca,float Rb_kca, float cai) ;

#define CALL_TO_INIT_STATES  InitModel_kca(V[seg],StatesM[3][seg] ,ParamsM[2][comp],ParamsM[3][comp],ParamsM[4][comp],ParamsM[5][comp],StatesM[8][ seg ]);

#define CALL_TO_DERIV  DerivModel_kca(dt, V[seg],StatesM[3][seg] ,ParamsM[2][comp],ParamsM[3][comp],ParamsM[4][comp],ParamsM[5][comp],StatesM[8][ seg ]);

#define CALL_TO_BREAK BreakpointModel_kca(sumCurrents, sumConductivity, V[seg],StatesM[3][seg] ,ParamsM[2][comp],ParamsM[3][comp],ParamsM[4][comp],ParamsM[5][comp],StatesM[8][ seg ]);

#define CALL_TO_BREAK_DV BreakpointModel_kca(sumCurrentsDv, sumConductivityDv, V[seg]+0.001,StatesM[3][seg] ,ParamsM[2][comp],ParamsM[3][comp],ParamsM[4][comp],ParamsM[5][comp],StatesM[8][ seg ]);

#define CALL_TO_Kinetic 


#endif