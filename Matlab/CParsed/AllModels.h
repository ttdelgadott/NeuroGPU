
#ifndef __ALLMODELS__
#define __ALLMODELS__
#include "Util.h"

 #define NSTATES 10
#define NPARAMS 30
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

void BreakpointModel_pas(MYSECONDFTYPE &sumCurrents, MYFTYPE &sumConductivity, float v,float g_pas,float e_pas) ;

void InitModel_pas(float v,float g_pas,float e_pas) ;

#define CALL_TO_INIT_STATES  InitModel_ca(V[seg],StatesM[0][seg] ,StatesM[1][seg] ,ParamsM[0][comp],ParamsM[1][comp],StatesM[8][ seg ],StatesM[9][ seg ]);InitModel_cad(V[seg],StatesM[2][seg] ,StatesM[9][ seg ],StatesM[8][ seg ]);InitModel_kca(V[seg],StatesM[3][seg] ,ParamsM[2][comp],ParamsM[3][comp],ParamsM[4][comp],ParamsM[5][comp],StatesM[8][ seg ]);InitModel_km(V[seg],StatesM[4][seg] ,ParamsM[ 6][comp],ParamsM[ 7][comp],ParamsM[ 8][comp],ParamsM[ 9][comp],ParamsM[10][comp]);InitModel_kv(V[seg],StatesM[5][seg] ,ParamsM[11][comp],ParamsM[12][comp],ParamsM[13][comp],ParamsM[14][comp],ParamsM[15][comp]);InitModel_na(V[seg],StatesM[6][seg] ,StatesM[7][seg] ,ParamsM[16][comp],ParamsM[17][comp],ParamsM[18][comp],ParamsM[19][comp],ParamsM[20][comp],ParamsM[21][comp],ParamsM[22][comp],ParamsM[23][comp],ParamsM[24][comp],ParamsM[25][comp],ParamsM[26][comp],ParamsM[27][comp]);InitModel_pas(V[seg],ParamsM[28][comp],ParamsM[29][comp]);

#define CALL_TO_DERIV  DerivModel_ca(dt, V[seg],StatesM[0][seg] ,StatesM[1][seg] ,ParamsM[0][comp],ParamsM[1][comp],StatesM[8][ seg ],StatesM[9][ seg ]);DerivModel_cad(dt, V[seg],StatesM[2][seg] ,StatesM[9][ seg ],StatesM[8][ seg ]);DerivModel_kca(dt, V[seg],StatesM[3][seg] ,ParamsM[2][comp],ParamsM[3][comp],ParamsM[4][comp],ParamsM[5][comp],StatesM[8][ seg ]);DerivModel_km(dt, V[seg],StatesM[4][seg] ,ParamsM[ 6][comp],ParamsM[ 7][comp],ParamsM[ 8][comp],ParamsM[ 9][comp],ParamsM[10][comp]);DerivModel_kv(dt, V[seg],StatesM[5][seg] ,ParamsM[11][comp],ParamsM[12][comp],ParamsM[13][comp],ParamsM[14][comp],ParamsM[15][comp]);DerivModel_na(dt, V[seg],StatesM[6][seg] ,StatesM[7][seg] ,ParamsM[16][comp],ParamsM[17][comp],ParamsM[18][comp],ParamsM[19][comp],ParamsM[20][comp],ParamsM[21][comp],ParamsM[22][comp],ParamsM[23][comp],ParamsM[24][comp],ParamsM[25][comp],ParamsM[26][comp],ParamsM[27][comp]);

#define CALL_TO_BREAK BreakpointModel_ca(sumCurrents, sumConductivity, V[seg],StatesM[0][seg] ,StatesM[1][seg] ,ParamsM[0][comp],ParamsM[1][comp],StatesM[8][ seg ],StatesM[9][ seg ]);BreakpointModel_cad(sumCurrents, sumConductivity, V[seg],StatesM[2][seg] ,StatesM[9][ seg ],StatesM[8][ seg ]);BreakpointModel_kca(sumCurrents, sumConductivity, V[seg],StatesM[3][seg] ,ParamsM[2][comp],ParamsM[3][comp],ParamsM[4][comp],ParamsM[5][comp],StatesM[8][ seg ]);BreakpointModel_km(sumCurrents, sumConductivity, V[seg],StatesM[4][seg] ,ParamsM[ 6][comp],ParamsM[ 7][comp],ParamsM[ 8][comp],ParamsM[ 9][comp],ParamsM[10][comp]);BreakpointModel_kv(sumCurrents, sumConductivity, V[seg],StatesM[5][seg] ,ParamsM[11][comp],ParamsM[12][comp],ParamsM[13][comp],ParamsM[14][comp],ParamsM[15][comp]);BreakpointModel_na(sumCurrents, sumConductivity, V[seg],StatesM[6][seg] ,StatesM[7][seg] ,ParamsM[16][comp],ParamsM[17][comp],ParamsM[18][comp],ParamsM[19][comp],ParamsM[20][comp],ParamsM[21][comp],ParamsM[22][comp],ParamsM[23][comp],ParamsM[24][comp],ParamsM[25][comp],ParamsM[26][comp],ParamsM[27][comp]);BreakpointModel_pas(sumCurrents, sumConductivity, V[seg],ParamsM[28][comp],ParamsM[29][comp]);

#define CALL_TO_BREAK_DV BreakpointModel_ca(sumCurrentsDv, sumConductivityDv, V[seg]+0.001,StatesM[0][seg] ,StatesM[1][seg] ,ParamsM[0][comp],ParamsM[1][comp],StatesM[8][ seg ],StatesM[9][ seg ]);BreakpointModel_cad(sumCurrentsDv, sumConductivityDv, V[seg]+0.001,StatesM[2][seg] ,StatesM[9][ seg ],StatesM[8][ seg ]);BreakpointModel_kca(sumCurrentsDv, sumConductivityDv, V[seg]+0.001,StatesM[3][seg] ,ParamsM[2][comp],ParamsM[3][comp],ParamsM[4][comp],ParamsM[5][comp],StatesM[8][ seg ]);BreakpointModel_km(sumCurrentsDv, sumConductivityDv, V[seg]+0.001,StatesM[4][seg] ,ParamsM[ 6][comp],ParamsM[ 7][comp],ParamsM[ 8][comp],ParamsM[ 9][comp],ParamsM[10][comp]);BreakpointModel_kv(sumCurrentsDv, sumConductivityDv, V[seg]+0.001,StatesM[5][seg] ,ParamsM[11][comp],ParamsM[12][comp],ParamsM[13][comp],ParamsM[14][comp],ParamsM[15][comp]);BreakpointModel_na(sumCurrentsDv, sumConductivityDv, V[seg]+0.001,StatesM[6][seg] ,StatesM[7][seg] ,ParamsM[16][comp],ParamsM[17][comp],ParamsM[18][comp],ParamsM[19][comp],ParamsM[20][comp],ParamsM[21][comp],ParamsM[22][comp],ParamsM[23][comp],ParamsM[24][comp],ParamsM[25][comp],ParamsM[26][comp],ParamsM[27][comp]);BreakpointModel_pas(sumCurrentsDv, sumConductivityDv, V[seg]+0.001,ParamsM[28][comp],ParamsM[29][comp]);


#endif