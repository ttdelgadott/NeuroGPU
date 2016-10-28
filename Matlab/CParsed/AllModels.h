// Automatically generated H for C:\Users\bensr\Documents\GitHub\NeuroGPU\URapNeuron\Markov2st\runModel.hoc

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
void DerivModel_CO(float dt, float v,float &c1,float &o,float gbar_CO,float a12_CO,float a21_CO,float z12_CO,float z21_CO) ;
void InitModel_CO(float v,float &c1,float &o,float gbar_CO,float a12_CO,float a21_CO,float z12_CO,float z21_CO) ;

#define CALL_TO_INIT_STATES   if(TheMMat.boolModel[seg+0*TheMMat.N]){InitModel_CO(V[seg],StatesM[0][seg] ,StatesM[1][seg] ,ParamsMSerial[0][comp],ParamsMSerial[1][comp],ParamsMSerial[2][comp],ParamsMSerial[3][comp],ParamsMSerial[4][comp]);}

#define CALL_TO_DERIV   if(TheMMat.boolModel[seg+0*TheMMat.N]){DerivModel_CO(dt, V[seg],StatesM[0][seg] ,StatesM[1][seg] ,ParamsMSerial[0][comp],ParamsMSerial[1][comp],ParamsMSerial[2][comp],ParamsMSerial[3][comp],ParamsMSerial[4][comp]);}

#define CALL_TO_BREAK  if(TheMMat.boolModel[seg+0*TheMMat.N]){BreakpointModel_CO(sumCurrents, sumConductivity, V[seg],StatesM[0][seg] ,StatesM[1][seg] ,ParamsMSerial[0][comp],ParamsMSerial[1][comp],ParamsMSerial[2][comp],ParamsMSerial[3][comp],ParamsMSerial[4][comp]);}

#define CALL_TO_BREAK_DV  if(TheMMat.boolModel[seg+0*TheMMat.N]){BreakpointModel_CO(sumCurrentsDv, sumConductivityDv, V[seg]+0.001,StatesM[0][seg] ,StatesM[1][seg] ,ParamsMSerial[0][comp],ParamsMSerial[1][comp],ParamsMSerial[2][comp],ParamsMSerial[3][comp],ParamsMSerial[4][comp]);}


#endif