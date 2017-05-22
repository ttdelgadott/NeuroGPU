// Automatically generated H for C:\Users\rben.KECK-CENTER\Documents\GitHub\NeuroGPU\URapNeuron\Mainen\runModel.hoc

#ifndef __ALLMODELS__
#define __ALLMODELS__
#include "Util.h"

#define NSTATES 10
#define NPARAMS 28

// GGlobals
#define celsius (37)
#define stoprun (0)
#define clamp_resist (0.001)
#define secondorder (0)

void BreakpointModel_ca(MYSECONDFTYPE &sumCurrents, MYFTYPE &sumConductivity, float v,float &m,float &h,float gbar_ca,float cao_ca, float cai, float &ica) ;
void DerivModel_ca(float dt, float v,float &m,float &h,float gbar_ca,float cao_ca, float cai, float &ica) ;
void InitModel_ca(float v,float &m,float &h,float gbar_ca,float cao_ca, float cai, float &ica) ;

void BreakpointModel_cad(MYSECONDFTYPE &sumCurrents, MYFTYPE &sumConductivity, float v,float &ca, float ica, float &cai) ;
void DerivModel_cad(float dt, float v,float &ca, float ica, float &cai) ;
void InitModel_cad(float v,float &ca, float ica, float &cai) ;

void BreakpointModel_kca(MYSECONDFTYPE &sumCurrents, MYFTYPE &sumConductivity, float v,float &n,float gbar_kca,float caix_kca,float Ra_kca,float Rb_kca, float cai) ;
void DerivModel_kca(float dt, float v,float &n,float gbar_kca,float caix_kca,float Ra_kca,float Rb_kca, float cai) ;
void InitModel_kca(float v,float &n,float gbar_kca,float caix_kca,float Ra_kca,float Rb_kca, float cai) ;

void BreakpointModel_km(MYSECONDFTYPE &sumCurrents, MYFTYPE &sumConductivity, float v,float &n,float gbar_km,float tha_km,float qa_km,float Ra_km,float Rb_km) ;
void DerivModel_km(float dt, float v,float &n,float gbar_km,float tha_km,float qa_km,float Ra_km,float Rb_km) ;
void InitModel_km(float v,float &n,float gbar_km,float tha_km,float qa_km,float Ra_km,float Rb_km) ;

void BreakpointModel_kv(MYSECONDFTYPE &sumCurrents, MYFTYPE &sumConductivity, float v,float &n,float gbar_kv,float tha_kv,float qa_kv,float Ra_kv,float Rb_kv) ;
void DerivModel_kv(float dt, float v,float &n,float gbar_kv,float tha_kv,float qa_kv,float Ra_kv,float Rb_kv) ;
void InitModel_kv(float v,float &n,float gbar_kv,float tha_kv,float qa_kv,float Ra_kv,float Rb_kv) ;

void BreakpointModel_na(MYSECONDFTYPE &sumCurrents, MYFTYPE &sumConductivity, float v,float &m,float &h,float gbar_na,float tha_na,float qa_na,float Ra_na,float Rb_na,float thi1_na,float thi2_na,float qi_na,float thinf_na,float qinf_na,float Rg_na,float Rd_na) ;
void DerivModel_na(float dt, float v,float &m,float &h,float gbar_na,float tha_na,float qa_na,float Ra_na,float Rb_na,float thi1_na,float thi2_na,float qi_na,float thinf_na,float qinf_na,float Rg_na,float Rd_na) ;
void InitModel_na(float v,float &m,float &h,float gbar_na,float tha_na,float qa_na,float Ra_na,float Rb_na,float thi1_na,float thi2_na,float qi_na,float thinf_na,float qinf_na,float Rg_na,float Rd_na) ;

#define CALL_TO_INIT_STATES   if(TheMMat.boolModel[seg+0*TheMMat.N]){InitModel_ca(V[seg],StatesM[0][seg] ,StatesM[1][seg] ,ParamsMSerial[0][comp],ParamsMSerial[1][comp],StatesM[8][ seg ],StatesM[9][ seg ]);} if(TheMMat.boolModel[seg+1*TheMMat.N]){InitModel_cad(V[seg],StatesM[2][seg] ,StatesM[9][ seg ],StatesM[8][ seg ]);} if(TheMMat.boolModel[seg+2*TheMMat.N]){InitModel_kca(V[seg],StatesM[3][seg] ,ParamsMSerial[2][comp],ParamsMSerial[3][comp],ParamsMSerial[4][comp],ParamsMSerial[5][comp],StatesM[8][ seg ]);} if(TheMMat.boolModel[seg+3*TheMMat.N]){InitModel_km(V[seg],StatesM[4][seg] ,ParamsMSerial[ 6][comp],ParamsMSerial[ 7][comp],ParamsMSerial[ 8][comp],ParamsMSerial[ 9][comp],ParamsMSerial[10][comp]);} if(TheMMat.boolModel[seg+4*TheMMat.N]){InitModel_kv(V[seg],StatesM[5][seg] ,ParamsMSerial[11][comp],ParamsMSerial[12][comp],ParamsMSerial[13][comp],ParamsMSerial[14][comp],ParamsMSerial[15][comp]);} if(TheMMat.boolModel[seg+5*TheMMat.N]){InitModel_na(V[seg],StatesM[6][seg] ,StatesM[7][seg] ,ParamsMSerial[16][comp],ParamsMSerial[17][comp],ParamsMSerial[18][comp],ParamsMSerial[19][comp],ParamsMSerial[20][comp],ParamsMSerial[21][comp],ParamsMSerial[22][comp],ParamsMSerial[23][comp],ParamsMSerial[24][comp],ParamsMSerial[25][comp],ParamsMSerial[26][comp],ParamsMSerial[27][comp]);}

#define CALL_TO_DERIV   if(TheMMat.boolModel[seg+0*TheMMat.N]){DerivModel_ca(dt, V[seg],StatesM[0][seg] ,StatesM[1][seg] ,ParamsMSerial[0][comp],ParamsMSerial[1][comp],StatesM[8][ seg ],StatesM[9][ seg ]);} if(TheMMat.boolModel[seg+1*TheMMat.N]){DerivModel_cad(dt, V[seg],StatesM[2][seg] ,StatesM[9][ seg ],StatesM[8][ seg ]);} if(TheMMat.boolModel[seg+2*TheMMat.N]){DerivModel_kca(dt, V[seg],StatesM[3][seg] ,ParamsMSerial[2][comp],ParamsMSerial[3][comp],ParamsMSerial[4][comp],ParamsMSerial[5][comp],StatesM[8][ seg ]);} if(TheMMat.boolModel[seg+3*TheMMat.N]){DerivModel_km(dt, V[seg],StatesM[4][seg] ,ParamsMSerial[ 6][comp],ParamsMSerial[ 7][comp],ParamsMSerial[ 8][comp],ParamsMSerial[ 9][comp],ParamsMSerial[10][comp]);} if(TheMMat.boolModel[seg+4*TheMMat.N]){DerivModel_kv(dt, V[seg],StatesM[5][seg] ,ParamsMSerial[11][comp],ParamsMSerial[12][comp],ParamsMSerial[13][comp],ParamsMSerial[14][comp],ParamsMSerial[15][comp]);} if(TheMMat.boolModel[seg+5*TheMMat.N]){DerivModel_na(dt, V[seg],StatesM[6][seg] ,StatesM[7][seg] ,ParamsMSerial[16][comp],ParamsMSerial[17][comp],ParamsMSerial[18][comp],ParamsMSerial[19][comp],ParamsMSerial[20][comp],ParamsMSerial[21][comp],ParamsMSerial[22][comp],ParamsMSerial[23][comp],ParamsMSerial[24][comp],ParamsMSerial[25][comp],ParamsMSerial[26][comp],ParamsMSerial[27][comp]);}

#define CALL_TO_BREAK  if(TheMMat.boolModel[seg+0*TheMMat.N]){BreakpointModel_ca(sumCurrents, sumConductivity, V[seg],StatesM[0][seg] ,StatesM[1][seg] ,ParamsMSerial[0][comp],ParamsMSerial[1][comp],StatesM[8][ seg ],StatesM[9][ seg ]);} if(TheMMat.boolModel[seg+1*TheMMat.N]){BreakpointModel_cad(sumCurrents, sumConductivity, V[seg],StatesM[2][seg] ,StatesM[9][ seg ],StatesM[8][ seg ]);} if(TheMMat.boolModel[seg+2*TheMMat.N]){BreakpointModel_kca(sumCurrents, sumConductivity, V[seg],StatesM[3][seg] ,ParamsMSerial[2][comp],ParamsMSerial[3][comp],ParamsMSerial[4][comp],ParamsMSerial[5][comp],StatesM[8][ seg ]);} if(TheMMat.boolModel[seg+3*TheMMat.N]){BreakpointModel_km(sumCurrents, sumConductivity, V[seg],StatesM[4][seg] ,ParamsMSerial[ 6][comp],ParamsMSerial[ 7][comp],ParamsMSerial[ 8][comp],ParamsMSerial[ 9][comp],ParamsMSerial[10][comp]);} if(TheMMat.boolModel[seg+4*TheMMat.N]){BreakpointModel_kv(sumCurrents, sumConductivity, V[seg],StatesM[5][seg] ,ParamsMSerial[11][comp],ParamsMSerial[12][comp],ParamsMSerial[13][comp],ParamsMSerial[14][comp],ParamsMSerial[15][comp]);} if(TheMMat.boolModel[seg+5*TheMMat.N]){BreakpointModel_na(sumCurrents, sumConductivity, V[seg],StatesM[6][seg] ,StatesM[7][seg] ,ParamsMSerial[16][comp],ParamsMSerial[17][comp],ParamsMSerial[18][comp],ParamsMSerial[19][comp],ParamsMSerial[20][comp],ParamsMSerial[21][comp],ParamsMSerial[22][comp],ParamsMSerial[23][comp],ParamsMSerial[24][comp],ParamsMSerial[25][comp],ParamsMSerial[26][comp],ParamsMSerial[27][comp]);}

#define CALL_TO_BREAK_DV  if(TheMMat.boolModel[seg+0*TheMMat.N]){BreakpointModel_ca(sumCurrentsDv, sumConductivityDv, V[seg]+0.001,StatesM[0][seg] ,StatesM[1][seg] ,ParamsMSerial[0][comp],ParamsMSerial[1][comp],StatesM[8][ seg ],StatesM[9][ seg ]);} if(TheMMat.boolModel[seg+1*TheMMat.N]){BreakpointModel_cad(sumCurrentsDv, sumConductivityDv, V[seg]+0.001,StatesM[2][seg] ,StatesM[9][ seg ],StatesM[8][ seg ]);} if(TheMMat.boolModel[seg+2*TheMMat.N]){BreakpointModel_kca(sumCurrentsDv, sumConductivityDv, V[seg]+0.001,StatesM[3][seg] ,ParamsMSerial[2][comp],ParamsMSerial[3][comp],ParamsMSerial[4][comp],ParamsMSerial[5][comp],StatesM[8][ seg ]);} if(TheMMat.boolModel[seg+3*TheMMat.N]){BreakpointModel_km(sumCurrentsDv, sumConductivityDv, V[seg]+0.001,StatesM[4][seg] ,ParamsMSerial[ 6][comp],ParamsMSerial[ 7][comp],ParamsMSerial[ 8][comp],ParamsMSerial[ 9][comp],ParamsMSerial[10][comp]);} if(TheMMat.boolModel[seg+4*TheMMat.N]){BreakpointModel_kv(sumCurrentsDv, sumConductivityDv, V[seg]+0.001,StatesM[5][seg] ,ParamsMSerial[11][comp],ParamsMSerial[12][comp],ParamsMSerial[13][comp],ParamsMSerial[14][comp],ParamsMSerial[15][comp]);} if(TheMMat.boolModel[seg+5*TheMMat.N]){BreakpointModel_na(sumCurrentsDv, sumConductivityDv, V[seg]+0.001,StatesM[6][seg] ,StatesM[7][seg] ,ParamsMSerial[16][comp],ParamsMSerial[17][comp],ParamsMSerial[18][comp],ParamsMSerial[19][comp],ParamsMSerial[20][comp],ParamsMSerial[21][comp],ParamsMSerial[22][comp],ParamsMSerial[23][comp],ParamsMSerial[24][comp],ParamsMSerial[25][comp],ParamsMSerial[26][comp],ParamsMSerial[27][comp]);}


#endif