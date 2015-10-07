#ifndef __HH__
#define __HH__

#define celsius 6.3
#define ena 56
#define ek -77

// gnabar gkbar gl el 
#define NPARAMS 4
#define NSTATES 3

void BreakpointModel(float &sumCurrents, float &sumConductivity, float v,float &m,float &h,float &n,float gnabar,float gkbar,float gl,float el) ;
void DerivModel(float dt, float v, float &m,float &h,float &n) ;
void InitModel(float v,float &m,float &h,float &n) ;

#define CALL_TO_INIT_STATES  InitModel(V[seg],StatesM[1][seg],StatesM[2][seg],StatesM[3][seg]);

#define CALL_TO_DERIV  DerivModel(dt, V[seg], StatesM[1][seg],StatesM[2][seg],StatesM[3][seg]);

#define CALL_TO_BREAK BreakpointModel(sumCurrents, sumConductivity, V[seg],StatesM[1][seg],StatesM[2][seg],StatesM[3][seg],ParamsM[1][seg],ParamsM[2][seg],ParamsM[3][seg],ParamsM[4][seg]);


#endif