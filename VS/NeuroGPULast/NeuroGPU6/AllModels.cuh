// Automatically generated CUH for C:\Users\bensr\Documents\GitHub\NeuroGPU\URapNeuron\HodgkinHuxley\runModel.hoc

#ifndef __ALLMODELSCU__
#define __ALLMODELSCU__
#include "Util.h"

#include "cuda_runtime.h"
#include "device_launch_parameters.h"

#define NSEG 416
#define LOG_N_DEPTH 7
#define N_MODELS 1
#define N_FATHERS 99
#define N_CALL_FOR_FATHER 186
#define COMP_DEPTH 4
#define N_L_REL 24
#define N_F_L_REL 23
__device__ void CuInitModel_hh2(float v,float &m,float &h,float &n,float gnabar_hh2,float gkbar_hh2,float gl_hh2,float el_hh2) ;
__device__ void CuDerivModel_hh2(float dt, float v,float &m,float &h,float &n,float gnabar_hh2,float gkbar_hh2,float gl_hh2,float el_hh2) ;
__device__ void CuBreakpointModel_hh2(MYSECONDFTYPE &sumCurrents, MYFTYPE &sumConductivity, float v,float &m,float &h,float &n,float gnabar_hh2,float gkbar_hh2,float gl_hh2,float el_hh2) ;


#define  SET_STATES(VARILP) ModelStates_ ## VARILP [0]=0;ModelStates_ ## VARILP [1]=0;ModelStates_ ## VARILP [2]=0;;
#define  SET_PARAMS001(VARILP) MYFTYPE p0_ ## VARILP =ParamsM[NeuronID*perThreadParamMSize + 0*InMat.NComps+cSegToComp[PIdx_ ## VARILP] ];
#define  SET_PARAMS002(VARILP) MYFTYPE p1_ ## VARILP =ParamsM[NeuronID*perThreadParamMSize + 1*InMat.NComps+cSegToComp[PIdx_ ## VARILP] ];
#define  SET_PARAMS003(VARILP) MYFTYPE p2_ ## VARILP =ParamsM[NeuronID*perThreadParamMSize + 2*InMat.NComps+cSegToComp[PIdx_ ## VARILP] ];
#define  SET_PARAMS004(VARILP) MYFTYPE p3_ ## VARILP =ParamsM[NeuronID*perThreadParamMSize + 3*InMat.NComps+cSegToComp[PIdx_ ## VARILP] ];


#define CALL_TO_INIT_STATES_CU(VARILP)   if(cBoolModel[PIdx_ ## VARILP +0*InMat.N]){CuInitModel_hh2(v_ ## VARILP,ModelStates_ ## VARILP[0],ModelStates_ ## VARILP[1],ModelStates_ ## VARILP[2],param_macro(0,PIdx_ ## VARILP) ,param_macro(1,PIdx_ ## VARILP) ,param_macro(2,PIdx_ ## VARILP) ,param_macro(3,PIdx_ ## VARILP) );}

#define CALL_TO_DERIV_CU(VARILP)   if(cBoolModel[PIdx_ ## VARILP +0*InMat.N]){CuDerivModel_hh2(dt, v_ ## VARILP,ModelStates_ ## VARILP[0],ModelStates_ ## VARILP[1],ModelStates_ ## VARILP[2],param_macro(0,PIdx_ ## VARILP) ,param_macro(1,PIdx_ ## VARILP) ,param_macro(2,PIdx_ ## VARILP) ,param_macro(3,PIdx_ ## VARILP) );}

#define CALL_TO_BREAK_CU(VARILP)  if(cBoolModel[PIdx_ ## VARILP +0*InMat.N]){CuBreakpointModel_hh2(sumCurrents_ ## VARILP , sumConductivity_ ## VARILP,v_ ## VARILP ,ModelStates_ ## VARILP[0],ModelStates_ ## VARILP[1],ModelStates_ ## VARILP[2],param_macro(0,PIdx_ ## VARILP) ,param_macro(1,PIdx_ ## VARILP) ,param_macro(2,PIdx_ ## VARILP) ,param_macro(3,PIdx_ ## VARILP) );}

#define CALL_TO_BREAK_DV_CU(VARILP)  if(cBoolModel[PIdx_ ## VARILP +0*InMat.N]){CuBreakpointModel_hh2(sumCurrentsDv_ ## VARILP , sumConductivityDv_ ## VARILP ,v_ ## VARILP +0.001,ModelStates_ ## VARILP[0],ModelStates_ ## VARILP[1],ModelStates_ ## VARILP[2],param_macro(0,PIdx_ ## VARILP) ,param_macro(1,PIdx_ ## VARILP) ,param_macro(2,PIdx_ ## VARILP) ,param_macro(3,PIdx_ ## VARILP) );}


#endif