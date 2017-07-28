// Automatically generated CUH for /home/devloop0/neuroGPU/UrapNeuron/MainenPy2./runModel.hoc

#ifndef __ALLMODELSCU__
#define __ALLMODELSCU__
#include "Util.h"

#include "cuda_runtime.h"
#include "device_launch_parameters.h"

#define NSEG 384
#define LOG_N_DEPTH 6
#define N_MODELS 6
#define N_FATHERS 99
#define N_CALL_FOR_FATHER 186
#define COMP_DEPTH 28
#define N_L_REL 24
#define N_F_L_REL 23
#define NSTATES 10
#define NPARAMS 28

__device__ float calc_determinant(float mat[NSTATES-1][NSTATES-1], int n);
__device__ void init_state_probs(float q[NSTATES][NSTATES], float y[NSTATES]);
__device__ float calc_prob(float q[NSTATES][NSTATES], int skip);
__device__ float rhs(float q[NSTATES][NSTATES], int index, float y[NSTATES]);
__device__ void Cubackwards_euler(double dt, int N, int nkinStates,float y[NSTATES],float matq[NSTATES][NSTATES]);

__device__ void CuInitModel_ca(float v,float &m,float &h,float gbar_ca,float cao_ca, float cai, float &ica);
__device__ void CuDerivModel_ca(float dt, float v,float &m,float &h,float gbar_ca,float cao_ca, float cai, float &ica);
__device__ void CuBreakpointModel_ca(MYSECONDFTYPE &sumCurrents, MYFTYPE &sumConductivity, float v,float &m,float &h,float gbar_ca,float cao_ca, float cai, float &ica) ;

__device__ void CuInitModel_cad(float v,float &	ca		, float ica, float &cai);
__device__ void CuDerivModel_cad(float dt, float v,float &	ca		, float ica, float &cai);
__device__ void CuBreakpointModel_cad(MYSECONDFTYPE &sumCurrents, MYFTYPE &sumConductivity, float v,float &	ca		, float ica, float &cai) ;

__device__ void CuInitModel_kca(float v,float &n,float gbar_kca,float caix_kca,float Ra_kca,float Rb_kca, float cai);
__device__ void CuDerivModel_kca(float dt, float v,float &n,float gbar_kca,float caix_kca,float Ra_kca,float Rb_kca, float cai);
__device__ void CuBreakpointModel_kca(MYSECONDFTYPE &sumCurrents, MYFTYPE &sumConductivity, float v,float &n,float gbar_kca,float caix_kca,float Ra_kca,float Rb_kca, float cai) ;

__device__ void CuInitModel_km(float v,float &n,float gbar_km,float tha_km,float qa_km,float Ra_km,float Rb_km);
__device__ void CuDerivModel_km(float dt, float v,float &n,float gbar_km,float tha_km,float qa_km,float Ra_km,float Rb_km);
__device__ void CuBreakpointModel_km(MYSECONDFTYPE &sumCurrents, MYFTYPE &sumConductivity, float v,float &n,float gbar_km,float tha_km,float qa_km,float Ra_km,float Rb_km) ;

__device__ void CuInitModel_kv(float v,float &n,float gbar_kv,float tha_kv,float qa_kv,float Ra_kv,float Rb_kv);
__device__ void CuDerivModel_kv(float dt, float v,float &n,float gbar_kv,float tha_kv,float qa_kv,float Ra_kv,float Rb_kv);
__device__ void CuBreakpointModel_kv(MYSECONDFTYPE &sumCurrents, MYFTYPE &sumConductivity, float v,float &n,float gbar_kv,float tha_kv,float qa_kv,float Ra_kv,float Rb_kv) ;

__device__ void CuInitModel_na(float v,float &m,float &h,float gbar_na,float tha_na,float qa_na,float Ra_na,float Rb_na,float thi1_na,float thi2_na,float qi_na,float thinf_na,float qinf_na,float Rg_na,float Rd_na);
__device__ void CuDerivModel_na(float dt, float v,float &m,float &h,float gbar_na,float tha_na,float qa_na,float Ra_na,float Rb_na,float thi1_na,float thi2_na,float qi_na,float thinf_na,float qinf_na,float Rg_na,float Rd_na);
__device__ void CuBreakpointModel_na(MYSECONDFTYPE &sumCurrents, MYFTYPE &sumConductivity, float v,float &m,float &h,float gbar_na,float tha_na,float qa_na,float Ra_na,float Rb_na,float thi1_na,float thi2_na,float qi_na,float thinf_na,float qinf_na,float Rg_na,float Rd_na) ;

#define   SET_PARAMS001(VARILP) MYFTYPE p0_ ## VARILP =ParamsM[NeuronID*perThreadMSize + 0*InMat.NComps+cSegToComp[PIdx_ ## VARILP] ];
#define   SET_PARAMS002(VARILP) MYFTYPE p1_ ## VARILP =ParamsM[NeuronID*perThreadMSize + 1*InMat.NComps+cSegToComp[PIdx_ ## VARILP] ];
#define   SET_PARAMS003(VARILP) MYFTYPE p2_ ## VARILP =ParamsM[NeuronID*perThreadMSize + 2*InMat.NComps+cSegToComp[PIdx_ ## VARILP] ];
#define   SET_PARAMS004(VARILP) MYFTYPE p3_ ## VARILP =ParamsM[NeuronID*perThreadMSize + 3*InMat.NComps+cSegToComp[PIdx_ ## VARILP] ];
#define   SET_PARAMS005(VARILP) MYFTYPE p4_ ## VARILP =ParamsM[NeuronID*perThreadMSize + 4*InMat.NComps+cSegToComp[PIdx_ ## VARILP] ];
#define   SET_PARAMS006(VARILP) MYFTYPE p5_ ## VARILP =ParamsM[NeuronID*perThreadMSize + 5*InMat.NComps+cSegToComp[PIdx_ ## VARILP] ];
#define   SET_PARAMS007(VARILP) MYFTYPE p6_ ## VARILP =ParamsM[NeuronID*perThreadMSize + 6*InMat.NComps+cSegToComp[PIdx_ ## VARILP] ];
#define   SET_PARAMS008(VARILP) MYFTYPE p7_ ## VARILP =ParamsM[NeuronID*perThreadMSize + 7*InMat.NComps+cSegToComp[PIdx_ ## VARILP] ];
#define   SET_PARAMS009(VARILP) MYFTYPE p8_ ## VARILP =ParamsM[NeuronID*perThreadMSize + 8*InMat.NComps+cSegToComp[PIdx_ ## VARILP] ];
#define   SET_PARAMS010(VARILP) MYFTYPE p9_ ## VARILP =ParamsM[NeuronID*perThreadMSize + 9*InMat.NComps+cSegToComp[PIdx_ ## VARILP] ];
#define   SET_PARAMS011(VARILP) MYFTYPE p10_ ## VARILP =ParamsM[NeuronID*perThreadMSize + 10*InMat.NComps+cSegToComp[PIdx_ ## VARILP] ];
#define   SET_PARAMS012(VARILP) MYFTYPE p11_ ## VARILP =ParamsM[NeuronID*perThreadMSize + 11*InMat.NComps+cSegToComp[PIdx_ ## VARILP] ];
#define   SET_PARAMS013(VARILP) MYFTYPE p12_ ## VARILP =ParamsM[NeuronID*perThreadMSize + 12*InMat.NComps+cSegToComp[PIdx_ ## VARILP] ];
#define   SET_PARAMS014(VARILP) MYFTYPE p13_ ## VARILP =ParamsM[NeuronID*perThreadMSize + 13*InMat.NComps+cSegToComp[PIdx_ ## VARILP] ];
#define   SET_PARAMS015(VARILP) MYFTYPE p14_ ## VARILP =ParamsM[NeuronID*perThreadMSize + 14*InMat.NComps+cSegToComp[PIdx_ ## VARILP] ];
#define   SET_PARAMS016(VARILP) MYFTYPE p15_ ## VARILP =ParamsM[NeuronID*perThreadMSize + 15*InMat.NComps+cSegToComp[PIdx_ ## VARILP] ];
#define   SET_PARAMS017(VARILP) MYFTYPE p16_ ## VARILP =ParamsM[NeuronID*perThreadMSize + 16*InMat.NComps+cSegToComp[PIdx_ ## VARILP] ];
#define   SET_PARAMS018(VARILP) MYFTYPE p17_ ## VARILP =ParamsM[NeuronID*perThreadMSize + 17*InMat.NComps+cSegToComp[PIdx_ ## VARILP] ];
#define   SET_PARAMS019(VARILP) MYFTYPE p18_ ## VARILP =ParamsM[NeuronID*perThreadMSize + 18*InMat.NComps+cSegToComp[PIdx_ ## VARILP] ];
#define   SET_PARAMS020(VARILP) MYFTYPE p19_ ## VARILP =ParamsM[NeuronID*perThreadMSize + 19*InMat.NComps+cSegToComp[PIdx_ ## VARILP] ];
#define   SET_PARAMS021(VARILP) MYFTYPE p20_ ## VARILP =ParamsM[NeuronID*perThreadMSize + 20*InMat.NComps+cSegToComp[PIdx_ ## VARILP] ];
#define   SET_PARAMS022(VARILP) MYFTYPE p21_ ## VARILP =ParamsM[NeuronID*perThreadMSize + 21*InMat.NComps+cSegToComp[PIdx_ ## VARILP] ];
#define   SET_PARAMS023(VARILP) MYFTYPE p22_ ## VARILP =ParamsM[NeuronID*perThreadMSize + 22*InMat.NComps+cSegToComp[PIdx_ ## VARILP] ];
#define   SET_PARAMS024(VARILP) MYFTYPE p23_ ## VARILP =ParamsM[NeuronID*perThreadMSize + 23*InMat.NComps+cSegToComp[PIdx_ ## VARILP] ];
#define   SET_PARAMS025(VARILP) MYFTYPE p24_ ## VARILP =ParamsM[NeuronID*perThreadMSize + 24*InMat.NComps+cSegToComp[PIdx_ ## VARILP] ];
#define   SET_PARAMS026(VARILP) MYFTYPE p25_ ## VARILP =ParamsM[NeuronID*perThreadMSize + 25*InMat.NComps+cSegToComp[PIdx_ ## VARILP] ];
#define   SET_PARAMS027(VARILP) MYFTYPE p26_ ## VARILP =ParamsM[NeuronID*perThreadMSize + 26*InMat.NComps+cSegToComp[PIdx_ ## VARILP] ];
#define   SET_PARAMS028(VARILP) MYFTYPE p27_ ## VARILP =ParamsM[NeuronID*perThreadMSize + 27*InMat.NComps+cSegToComp[PIdx_ ## VARILP] ];


#define CALL_TO_INIT_STATES_CU(VARILP) if(cBoolModel[PIdx_ ## VARILP +0*InMat.N]){CuInitModel_ca(v_ ## VARILP,ModelStates_ ## VARILP[0],ModelStates_ ## VARILP[1],ParamsM[0_ ## VARILP ,ParamsM[1_ ## VARILP , ModelStates_ ## VARILP[8] , ModelStates_ ## VARILP[9] );if(cBoolModel[PIdx_ ## VARILP +1*InMat.N]){CuInitModel_cad(v_ ## VARILP,ModelStates_ ## VARILP[2], ModelStates_ ## VARILP[9] , ModelStates_ ## VARILP[8] );if(cBoolModel[PIdx_ ## VARILP +2*InMat.N]){CuInitModel_kca(v_ ## VARILP,ModelStates_ ## VARILP[3],ParamsM[2_ ## VARILP ,ParamsM[3_ ## VARILP ,ParamsM[4_ ## VARILP ,ParamsM[5_ ## VARILP , ModelStates_ ## VARILP[8] );if(cBoolModel[PIdx_ ## VARILP +3*InMat.N]){CuInitModel_km(v_ ## VARILP,ModelStates_ ## VARILP[4],ParamsM[6_ ## VARILP ,ParamsM[7_ ## VARILP ,ParamsM[8_ ## VARILP ,ParamsM[9_ ## VARILP ,ParamsM[10_ ## VARILP );if(cBoolModel[PIdx_ ## VARILP +4*InMat.N]){CuInitModel_kv(v_ ## VARILP,ModelStates_ ## VARILP[5],ParamsM[11_ ## VARILP ,ParamsM[12_ ## VARILP ,ParamsM[13_ ## VARILP ,ParamsM[14_ ## VARILP ,ParamsM[15_ ## VARILP );if(cBoolModel[PIdx_ ## VARILP +5*InMat.N]){CuInitModel_na(v_ ## VARILP,ModelStates_ ## VARILP[6],ModelStates_ ## VARILP[7],ParamsM[16_ ## VARILP ,ParamsM[17_ ## VARILP ,ParamsM[18_ ## VARILP ,ParamsM[19_ ## VARILP ,ParamsM[20_ ## VARILP ,ParamsM[21_ ## VARILP ,ParamsM[22_ ## VARILP ,ParamsM[23_ ## VARILP ,ParamsM[24_ ## VARILP ,ParamsM[25_ ## VARILP ,ParamsM[26_ ## VARILP ,ParamsM[27_ ## VARILP );

#define CALL_TO_DERIV_STR_CU(VARILP)   if(cBoolModel[PIdx_ ## VARILP +0*InMat.N]){CuDerivModel_ca(dt, v_ ## VARILP,ModelStates_ ## VARILP[0],ModelStates_ ## VARILP[1],param_macro($1, PIdx_ ## VARILP) ,param_macro($1, PIdx_ ## VARILP) , ModelStates_ ## VARILP[8] , ModelStates_ ## VARILP[9] );if(cBoolModel[PIdx_ ## VARILP +1*InMat.N]){CuDerivModel_cad(dt, v_ ## VARILP,ModelStates_ ## VARILP[2], ModelStates_ ## VARILP[9] , ModelStates_ ## VARILP[8] );if(cBoolModel[PIdx_ ## VARILP +2*InMat.N]){CuDerivModel_kca(dt, v_ ## VARILP,ModelStates_ ## VARILP[3],param_macro($1, PIdx_ ## VARILP) ,param_macro($1, PIdx_ ## VARILP) ,param_macro($1, PIdx_ ## VARILP) ,param_macro($1, PIdx_ ## VARILP) , ModelStates_ ## VARILP[8] );if(cBoolModel[PIdx_ ## VARILP +3*InMat.N]){CuDerivModel_km(dt, v_ ## VARILP,ModelStates_ ## VARILP[4],param_macro($1, PIdx_ ## VARILP) ,param_macro($1, PIdx_ ## VARILP) ,param_macro($1, PIdx_ ## VARILP) ,param_macro($1, PIdx_ ## VARILP) ,param_macro($1, PIdx_ ## VARILP) );if(cBoolModel[PIdx_ ## VARILP +4*InMat.N]){CuDerivModel_kv(dt, v_ ## VARILP,ModelStates_ ## VARILP[5],param_macro($1, PIdx_ ## VARILP) ,param_macro($1, PIdx_ ## VARILP) ,param_macro($1, PIdx_ ## VARILP) ,param_macro($1, PIdx_ ## VARILP) ,param_macro($1, PIdx_ ## VARILP) );if(cBoolModel[PIdx_ ## VARILP +5*InMat.N]){CuDerivModel_na(dt, v_ ## VARILP,ModelStates_ ## VARILP[6],ModelStates_ ## VARILP[7],param_macro($1, PIdx_ ## VARILP) ,param_macro($1, PIdx_ ## VARILP) ,param_macro($1, PIdx_ ## VARILP) ,param_macro($1, PIdx_ ## VARILP) ,param_macro($1, PIdx_ ## VARILP) ,param_macro($1, PIdx_ ## VARILP) ,param_macro($1, PIdx_ ## VARILP) ,param_macro($1, PIdx_ ## VARILP) ,param_macro($1, PIdx_ ## VARILP) ,param_macro($1, PIdx_ ## VARILP) ,param_macro($1, PIdx_ ## VARILP) ,param_macro($1, PIdx_ ## VARILP) );

#define CALL_TO_BREAK_STR_CU(VARILP)   if(cBoolModel[PIdx_ ## VARILP +0*InMat.N]){CuBreakpointModel_ca(sumCurrents_ ## VARILP , sumConductivity_ ## VARILP,v_ ## VARILP ,ModelStates_ ## VARILP[0],ModelStates_ ## VARILP[1],param_macro($1, PIdx_ ## VARILP) ,param_macro($1, PIdx_ ## VARILP) , ModelStates_ ## VARILP[8] , ModelStates_ ## VARILP[9] );if(cBoolModel[PIdx_ ## VARILP +1*InMat.N]){CuBreakpointModel_cad(sumCurrents_ ## VARILP , sumConductivity_ ## VARILP,v_ ## VARILP ,ModelStates_ ## VARILP[2], ModelStates_ ## VARILP[9] , ModelStates_ ## VARILP[8] );if(cBoolModel[PIdx_ ## VARILP +2*InMat.N]){CuBreakpointModel_kca(sumCurrents_ ## VARILP , sumConductivity_ ## VARILP,v_ ## VARILP ,ModelStates_ ## VARILP[3],param_macro($1, PIdx_ ## VARILP) ,param_macro($1, PIdx_ ## VARILP) ,param_macro($1, PIdx_ ## VARILP) ,param_macro($1, PIdx_ ## VARILP) , ModelStates_ ## VARILP[8] );if(cBoolModel[PIdx_ ## VARILP +3*InMat.N]){CuBreakpointModel_km(sumCurrents_ ## VARILP , sumConductivity_ ## VARILP,v_ ## VARILP ,ModelStates_ ## VARILP[4],param_macro($1, PIdx_ ## VARILP) ,param_macro($1, PIdx_ ## VARILP) ,param_macro($1, PIdx_ ## VARILP) ,param_macro($1, PIdx_ ## VARILP) ,param_macro($1, PIdx_ ## VARILP) );if(cBoolModel[PIdx_ ## VARILP +4*InMat.N]){CuBreakpointModel_kv(sumCurrents_ ## VARILP , sumConductivity_ ## VARILP,v_ ## VARILP ,ModelStates_ ## VARILP[5],param_macro($1, PIdx_ ## VARILP) ,param_macro($1, PIdx_ ## VARILP) ,param_macro($1, PIdx_ ## VARILP) ,param_macro($1, PIdx_ ## VARILP) ,param_macro($1, PIdx_ ## VARILP) );if(cBoolModel[PIdx_ ## VARILP +5*InMat.N]){CuBreakpointModel_na(sumCurrents_ ## VARILP , sumConductivity_ ## VARILP,v_ ## VARILP ,ModelStates_ ## VARILP[6],ModelStates_ ## VARILP[7],param_macro($1, PIdx_ ## VARILP) ,param_macro($1, PIdx_ ## VARILP) ,param_macro($1, PIdx_ ## VARILP) ,param_macro($1, PIdx_ ## VARILP) ,param_macro($1, PIdx_ ## VARILP) ,param_macro($1, PIdx_ ## VARILP) ,param_macro($1, PIdx_ ## VARILP) ,param_macro($1, PIdx_ ## VARILP) ,param_macro($1, PIdx_ ## VARILP) ,param_macro($1, PIdx_ ## VARILP) ,param_macro($1, PIdx_ ## VARILP) ,param_macro($1, PIdx_ ## VARILP) );

#define CALL_TO_BREAK_DV_STR_CU(VARILP)    if(cBoolModel[PIdx_ ## VARILP +0*InMat.N]){CuBreakpointModel_ca(sumCurrentsDv, sumConductivityDv,  V[seg]+0.001,ModelStates_ ## VARILP[0],ModelStates_ ## VARILP[1],param_macro($1, PIdx_ ## VARILP) ,param_macro($1, PIdx_ ## VARILP) , ModelStates_ ## VARILP[8] , ModelStates_ ## VARILP[9] );if(cBoolModel[PIdx_ ## VARILP +1*InMat.N]){CuBreakpointModel_cad(sumCurrentsDv, sumConductivityDv,  V[seg]+0.001,ModelStates_ ## VARILP[2], ModelStates_ ## VARILP[9] , ModelStates_ ## VARILP[8] );if(cBoolModel[PIdx_ ## VARILP +2*InMat.N]){CuBreakpointModel_kca(sumCurrentsDv, sumConductivityDv,  V[seg]+0.001,ModelStates_ ## VARILP[3],param_macro($1, PIdx_ ## VARILP) ,param_macro($1, PIdx_ ## VARILP) ,param_macro($1, PIdx_ ## VARILP) ,param_macro($1, PIdx_ ## VARILP) , ModelStates_ ## VARILP[8] );if(cBoolModel[PIdx_ ## VARILP +3*InMat.N]){CuBreakpointModel_km(sumCurrentsDv, sumConductivityDv,  V[seg]+0.001,ModelStates_ ## VARILP[4],param_macro($1, PIdx_ ## VARILP) ,param_macro($1, PIdx_ ## VARILP) ,param_macro($1, PIdx_ ## VARILP) ,param_macro($1, PIdx_ ## VARILP) ,param_macro($1, PIdx_ ## VARILP) );if(cBoolModel[PIdx_ ## VARILP +4*InMat.N]){CuBreakpointModel_kv(sumCurrentsDv, sumConductivityDv,  V[seg]+0.001,ModelStates_ ## VARILP[5],param_macro($1, PIdx_ ## VARILP) ,param_macro($1, PIdx_ ## VARILP) ,param_macro($1, PIdx_ ## VARILP) ,param_macro($1, PIdx_ ## VARILP) ,param_macro($1, PIdx_ ## VARILP) );if(cBoolModel[PIdx_ ## VARILP +5*InMat.N]){CuBreakpointModel_na(sumCurrentsDv, sumConductivityDv,  V[seg]+0.001,ModelStates_ ## VARILP[6],ModelStates_ ## VARILP[7],param_macro($1, PIdx_ ## VARILP) ,param_macro($1, PIdx_ ## VARILP) ,param_macro($1, PIdx_ ## VARILP) ,param_macro($1, PIdx_ ## VARILP) ,param_macro($1, PIdx_ ## VARILP) ,param_macro($1, PIdx_ ## VARILP) ,param_macro($1, PIdx_ ## VARILP) ,param_macro($1, PIdx_ ## VARILP) ,param_macro($1, PIdx_ ## VARILP) ,param_macro($1, PIdx_ ## VARILP) ,param_macro($1, PIdx_ ## VARILP) ,param_macro($1, PIdx_ ## VARILP) );


#endif