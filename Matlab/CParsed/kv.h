#ifndef __kv__
#define __kv__

#define celsius 6.3
#define ena 56
#define ek -77

// gbar tha qa Ra Rb temp q10 vmin vmax tadj 
#define NPARAMS 10
#define NSTATES 1

void BreakpointModel_kv(MYSECONDFTYPE &sumCurrents, MYFTYPE &sumConductivity, float v,float &n,float gbar_kv,float tha_kv,float qa_kv,float Ra_kv,float Rb_kv) ;
void DerivModel_kv(float dt, float v,float &n,float gbar_kv,float tha_kv,float qa_kv,float Ra_kv,float Rb_kv) ;
void InitModel_kv(float v,float &n,float gbar_kv,float tha_kv,float qa_kv,float Ra_kv,float Rb_kv) ;

#define CALL_TO_INIT_STATES  InitModel_kv(V[seg],StatesM[5][seg] ,ParamsM[11][comp],ParamsM[12][comp],ParamsM[13][comp],ParamsM[14][comp],ParamsM[15][comp]);

#define CALL_TO_DERIV  DerivModel_kv(dt, V[seg],StatesM[5][seg] ,ParamsM[11][comp],ParamsM[12][comp],ParamsM[13][comp],ParamsM[14][comp],ParamsM[15][comp]);

#define CALL_TO_BREAK BreakpointModel_kv(sumCurrents, sumConductivity, V[seg],StatesM[5][seg] ,ParamsM[11][comp],ParamsM[12][comp],ParamsM[13][comp],ParamsM[14][comp],ParamsM[15][comp]);

#define CALL_TO_BREAK_DV BreakpointModel_kv(sumCurrentsDv, sumConductivityDv, V[seg]+0.001,StatesM[5][seg] ,ParamsM[11][comp],ParamsM[12][comp],ParamsM[13][comp],ParamsM[14][comp],ParamsM[15][comp]);


#endif