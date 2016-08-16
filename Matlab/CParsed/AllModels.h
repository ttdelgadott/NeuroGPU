
#ifndef __ALLMODELS__
#define __ALLMODELS__
#include "Util.h"

 #define NSTATES 2
#define NPARAMS 5
// GGlobals
#define celsius (6.3)
#define stoprun (0)
#define clamp_resist (0.001)
#define secondorder (0)

void BreakpointModel_CO(MYSECONDFTYPE &sumCurrents, MYFTYPE &sumConductivity, float v,float &c1,float &o,float gbar_CO,float a12_CO,float a21_CO,float z12_CO,float z21_CO) ;

void InitModel_CO(float v,float &c1,float &o,float gbar_CO,float a12_CO,float a21_CO,float z12_CO,float z21_CO) ;

#define CALL_TO_INIT_STATES  InitModel_CO(V[seg],StatesM[0][seg] ,StatesM[1][seg] ,ParamsM[0][comp],ParamsM[1][comp],ParamsM[2][comp],ParamsM[3][comp],ParamsM[4][comp]);

#define CALL_TO_DERIV  

#define CALL_TO_BREAK BreakpointModel_CO(sumCurrents, sumConductivity, V[seg],StatesM[0][seg] ,StatesM[1][seg] ,ParamsM[0][comp],ParamsM[1][comp],ParamsM[2][comp],ParamsM[3][comp],ParamsM[4][comp]);

#define CALL_TO_BREAK_DV BreakpointModel_CO(sumCurrentsDv, sumConductivityDv, V[seg]+0.001,StatesM[0][seg] ,StatesM[1][seg] ,ParamsM[0][comp],ParamsM[1][comp],ParamsM[2][comp],ParamsM[3][comp],ParamsM[4][comp]);


#endif