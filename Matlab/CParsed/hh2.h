#ifndef __hh2__
#define __hh2__

#define celsius 6.3
#define ena 56
#define ek -77

// gnabar gkbar gl el hinf htau minf mtau ninf ntau 
#define NPARAMS 10
#define NSTATES 3

void BreakpointModel_hh2(float &sumCurrents, float &sumConductivity, float v,float &m,float &h,float &n,float gnabar_hh2,float gkbar_hh2,float gl_hh2,float el_hh2) ;
void DerivModel_hh2(float dt, float v,float &m,float &h,float &n,float gnabar_hh2,float gkbar_hh2,float gl_hh2,float el_hh2) ;
void InitModel_hh2(float v,float &m,float &h,float &n,float gnabar_hh2,float gkbar_hh2,float gl_hh2,float el_hh2) ;

#define CALL_TO_INIT_STATES  InitModel_hh2(V[seg],StatesM[0][seg],StatesM[1][seg],StatesM[2][seg],ParamsM[0][seg],ParamsM[1][seg],ParamsM[2][seg],ParamsM[3][seg]);

#define CALL_TO_DERIV  DerivModel_hh2(dt, V[seg],StatesM[0][seg],StatesM[1][seg],StatesM[2][seg],ParamsM[0][seg],ParamsM[1][seg],ParamsM[2][seg],ParamsM[3][seg]);

#define CALL_TO_BREAK BreakpointModel_hh2(sumCurrents, sumConductivity, V[seg],StatesM[0][seg],StatesM[1][seg],StatesM[2][seg],ParamsM[0][seg],ParamsM[1][seg],ParamsM[2][seg],ParamsM[3][seg]);


#endif