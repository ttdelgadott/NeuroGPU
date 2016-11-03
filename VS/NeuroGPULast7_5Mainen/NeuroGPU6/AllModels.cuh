// Automatically generated CUH for C:\Users\rben.KECK-CENTER\Documents\GitHub\NeuroGPU\URapNeuron\Markov2st\runModel.hoc

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
#define COMP_DEPTH 5
#define N_L_REL 24
#define N_F_L_REL 23
__device__ void CuInitModel_CO(float v,float &c1,float &o,float gbar_CO,float a12_CO,float a21_CO,float z12_CO,float z21_CO) ;
__device__ int CuDerivModel_CO(float dt, float v,float &c1,float &o,float gbar_CO,float a12_CO,float a21_CO,float z12_CO,float z21_CO) ;
__device__ void CuBreakpointModel_CO(MYSECONDFTYPE &sumCurrents, MYFTYPE &sumConductivity, float v,float &c1,float &o,float gbar_CO,float a12_CO,float a21_CO,float z12_CO,float z21_CO) ;


#define  SET_STATES(VARILP) ModelStates_ ## VARILP [0]=0;ModelStates_ ## VARILP [1]=0;;
#define  SET_PARAMS001(VARILP) MYFTYPE p0_ ## VARILP =ParamsM[NeuronID*perThreadParamMSize + 0*InMat.NComps+cSegToComp[PIdx_ ## VARILP] ];
#define  SET_PARAMS002(VARILP) MYFTYPE p1_ ## VARILP =ParamsM[NeuronID*perThreadParamMSize + 1*InMat.NComps+cSegToComp[PIdx_ ## VARILP] ];
#define  SET_PARAMS003(VARILP) MYFTYPE p2_ ## VARILP =ParamsM[NeuronID*perThreadParamMSize + 2*InMat.NComps+cSegToComp[PIdx_ ## VARILP] ];
#define  SET_PARAMS004(VARILP) MYFTYPE p3_ ## VARILP =ParamsM[NeuronID*perThreadParamMSize + 3*InMat.NComps+cSegToComp[PIdx_ ## VARILP] ];
#define  SET_PARAMS005(VARILP) MYFTYPE p4_ ## VARILP =ParamsM[NeuronID*perThreadParamMSize + 4*InMat.NComps+cSegToComp[PIdx_ ## VARILP] ];


#define CALL_TO_INIT_STATES_CU(VARILP)   if(cBoolModel[PIdx_ ## VARILP +0*InMat.N]){CuInitModel_CO(v_ ## VARILP,ModelStates_ ## VARILP[0],ModelStates_ ## VARILP[1],param_macro(0,PIdx_ ## VARILP) ,param_macro(1,PIdx_ ## VARILP) ,param_macro(2,PIdx_ ## VARILP) ,param_macro(3,PIdx_ ## VARILP) ,param_macro(4,PIdx_ ## VARILP) );}

#define CALL_TO_DERIV_CU(VARILP)   if(cBoolModel[PIdx_ ## VARILP +0*InMat.N]){CuDerivModel_CO(dt, v_ ## VARILP,ModelStates_ ## VARILP[0],ModelStates_ ## VARILP[1],param_macro(0,PIdx_ ## VARILP) ,param_macro(1,PIdx_ ## VARILP) ,param_macro(2,PIdx_ ## VARILP) ,param_macro(3,PIdx_ ## VARILP) ,param_macro(4,PIdx_ ## VARILP) );}

#define CALL_TO_BREAK_CU(VARILP)  if(cBoolModel[PIdx_ ## VARILP +0*InMat.N]){CuBreakpointModel_CO(sumCurrents_ ## VARILP , sumConductivity_ ## VARILP,v_ ## VARILP ,ModelStates_ ## VARILP[0],ModelStates_ ## VARILP[1],param_macro(0,PIdx_ ## VARILP) ,param_macro(1,PIdx_ ## VARILP) ,param_macro(2,PIdx_ ## VARILP) ,param_macro(3,PIdx_ ## VARILP) ,param_macro(4,PIdx_ ## VARILP) );}

#define CALL_TO_BREAK_DV_CU(VARILP)  if(cBoolModel[PIdx_ ## VARILP +0*InMat.N]){CuBreakpointModel_CO(sumCurrentsDv_ ## VARILP , sumConductivityDv_ ## VARILP ,v_ ## VARILP +0.001,ModelStates_ ## VARILP[0],ModelStates_ ## VARILP[1],param_macro(0,PIdx_ ## VARILP) ,param_macro(1,PIdx_ ## VARILP) ,param_macro(2,PIdx_ ## VARILP) ,param_macro(3,PIdx_ ## VARILP) ,param_macro(4,PIdx_ ## VARILP) );}


#endif