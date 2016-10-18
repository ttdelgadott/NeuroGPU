
#ifndef __ALLMODELS__
#define __ALLMODELS__
#include "Util.h"

 #define NSTATES 3
#define NPARAMS 4
// GGlobals
#define celsius (6.3)
#define stoprun (0)
#define clamp_resist (0.001)
#define secondorder (0)

void BreakpointModel_hh2(MYSECONDFTYPE &sumCurrents, MYFTYPE &sumConductivity, float v,float &m,float &h,float &n,float gnabar_hh2,float gkbar_hh2,float gl_hh2,float el_hh2) ;
void DerivModel_hh2(float dt, float v,float &m,float &h,float &n,float gnabar_hh2,float gkbar_hh2,float gl_hh2,float el_hh2) ;
void InitModel_hh2(float v,float &m,float &h,float &n,float gnabar_hh2,float gkbar_hh2,float gl_hh2,float el_hh2) ;


#define CALL_TO_INIT_STATES  InitModel_hh2(V[seg],StatesM[0][seg] ,StatesM[1][seg] ,StatesM[2][seg] ,ParamsM[0][comp],ParamsM[1][comp],ParamsM[2][comp],ParamsM[3][comp]);

#define CALL_TO_DERIV  DerivModel_hh2(dt, V[seg],StatesM[0][seg] ,StatesM[1][seg] ,StatesM[2][seg] ,ParamsM[0][comp],ParamsM[1][comp],ParamsM[2][comp],ParamsM[3][comp]);

#define CALL_TO_BREAK BreakpointModel_hh2(sumCurrents, sumConductivity, V[seg],StatesM[0][seg] ,StatesM[1][seg] ,StatesM[2][seg] ,ParamsM[0][comp],ParamsM[1][comp],ParamsM[2][comp],ParamsM[3][comp]);

#define CALL_TO_BREAK_DV BreakpointModel_hh2(sumCurrentsDv, sumConductivityDv, V[seg]+0.001,StatesM[0][seg] ,StatesM[1][seg] ,StatesM[2][seg] ,ParamsM[0][comp],ParamsM[1][comp],ParamsM[2][comp],ParamsM[3][comp]);

#define CALL_TO_KINETIC 


#endif