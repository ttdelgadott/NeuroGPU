#ifndef __km__
#define __km__

#define celsius 6.3
#define ena 56
#define ek -77

// gbar tha qa Ra Rb temp q10 vmin vmax tadj 
#define NPARAMS 10
#define NSTATES 1

void BreakpointModel_km(MYSECONDFTYPE &sumCurrents, MYFTYPE &sumConductivity, float v,float &n,float gbar_km,float tha_km,float qa_km,float Ra_km,float Rb_km) ;
void DerivModel_km(float dt, float v,float &n,float gbar_km,float tha_km,float qa_km,float Ra_km,float Rb_km) ;
void InitModel_km(float v,float &n,float gbar_km,float tha_km,float qa_km,float Ra_km,float Rb_km) ;

#define CALL_TO_INIT_STATES  InitModel_km(V[seg],StatesM[4][seg] ,ParamsM[ 6][comp],ParamsM[ 7][comp],ParamsM[ 8][comp],ParamsM[ 9][comp],ParamsM[10][comp]);

#define CALL_TO_DERIV  DerivModel_km(dt, V[seg],StatesM[4][seg] ,ParamsM[ 6][comp],ParamsM[ 7][comp],ParamsM[ 8][comp],ParamsM[ 9][comp],ParamsM[10][comp]);

#define CALL_TO_BREAK BreakpointModel_km(sumCurrents, sumConductivity, V[seg],StatesM[4][seg] ,ParamsM[ 6][comp],ParamsM[ 7][comp],ParamsM[ 8][comp],ParamsM[ 9][comp],ParamsM[10][comp]);

#define CALL_TO_BREAK_DV BreakpointModel_km(sumCurrentsDv, sumConductivityDv, V[seg]+0.001,StatesM[4][seg] ,ParamsM[ 6][comp],ParamsM[ 7][comp],ParamsM[ 8][comp],ParamsM[ 9][comp],ParamsM[10][comp]);


#endif