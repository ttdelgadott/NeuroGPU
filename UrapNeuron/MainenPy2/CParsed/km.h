#ifndef __km__
#define __km__

#define celsius 6.3
#define ena 56
#define ek -77

// gbar tha qa Ra Rb temp q10 vmin vmax tadj 
#define NPARAMS 10
#define NSTATES 1
void BreakpointModel_km(MYSECONDFTYPE &sumCurrents, MYFTYPE &sumConductivity, float v,float &n,float gbar_km,float tha_km,float qa_km,float Ra_km,float Rb_km) {;
void DerivModel_km(float dt, float v,float &n,float gbar_km,float tha_km,float qa_km,float Ra_km,float Rb_km);
void InitModel_km(float v,float &n,float gbar_km,float tha_km,float qa_km,float Ra_km,float Rb_km);
#define CALL_TO_INIT_STATES InitModel_km(V[seg],StatesM[0][seg] ,ParamsM[0][comp],ParamsM[1][comp],ParamsM[2][comp],ParamsM[3][comp],ParamsM[4][comp]);

#define CALL_TO_DERIV DerivModel_km(dt, V[seg],StatesM[0][seg] ,ParamsM[0][comp],ParamsM[1][comp],ParamsM[2][comp],ParamsM[3][comp],ParamsM[4][comp]);

#define CALL_TO_BREAK BreakpointModel_km(sumCurrents, sumConductivity, V[seg],StatesM[0][seg] ,ParamsM[0][comp],ParamsM[1][comp],ParamsM[2][comp],ParamsM[3][comp],ParamsM[4][comp]);

#define CALL_TO_BREAK_DV BreakpointModel_km(sumCurrentsDv, sumConductivityDv,  V[seg]+0.001,StatesM[0][seg] ,ParamsM[0][comp],ParamsM[1][comp],ParamsM[2][comp],ParamsM[3][comp],ParamsM[4][comp]);


#endif
