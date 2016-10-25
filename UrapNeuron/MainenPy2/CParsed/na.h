#ifndef __na__
#define __na__

#define celsius 6.3
#define ena 56
#define ek -77

// gbar vshift tha qa Ra Rb thi1 thi2 qi thinf qinf Rg Rd temp q10 vmin vmax tadj 
#define NPARAMS 18
#define NSTATES 2
void BreakpointModel_na(MYSECONDFTYPE &sumCurrents, MYFTYPE &sumConductivity, float v,float &m,float &h,float gbar_na,float tha_na,float qa_na,float Ra_na,float Rb_na,float thi1_na,float thi2_na,float qi_na,float thinf_na,float qinf_na,float Rg_na,float Rd_na) {;
void DerivModel_na(float dt, float v,float &m,float &h,float gbar_na,float tha_na,float qa_na,float Ra_na,float Rb_na,float thi1_na,float thi2_na,float qi_na,float thinf_na,float qinf_na,float Rg_na,float Rd_na);
void InitModel_na(float v,float &m,float &h,float gbar_na,float tha_na,float qa_na,float Ra_na,float Rb_na,float thi1_na,float thi2_na,float qi_na,float thinf_na,float qinf_na,float Rg_na,float Rd_na);
#define CALL_TO_INIT_STATES InitModel_na(V[seg],StatesM[0][seg] ,StatesM[1][seg] ,ParamsM[0][comp],ParamsM[1][comp],ParamsM[2][comp],ParamsM[3][comp],ParamsM[4][comp],ParamsM[5][comp],ParamsM[6][comp],ParamsM[7][comp],ParamsM[8][comp],ParamsM[9][comp],ParamsM[10][comp],ParamsM[11][comp]);

#define CALL_TO_DERIV DerivModel_na(dt, V[seg],StatesM[0][seg] ,StatesM[1][seg] ,ParamsM[0][comp],ParamsM[1][comp],ParamsM[2][comp],ParamsM[3][comp],ParamsM[4][comp],ParamsM[5][comp],ParamsM[6][comp],ParamsM[7][comp],ParamsM[8][comp],ParamsM[9][comp],ParamsM[10][comp],ParamsM[11][comp]);

#define CALL_TO_BREAK BreakpointModel_na(sumCurrents, sumConductivity, V[seg],StatesM[0][seg] ,StatesM[1][seg] ,ParamsM[0][comp],ParamsM[1][comp],ParamsM[2][comp],ParamsM[3][comp],ParamsM[4][comp],ParamsM[5][comp],ParamsM[6][comp],ParamsM[7][comp],ParamsM[8][comp],ParamsM[9][comp],ParamsM[10][comp],ParamsM[11][comp]);

#define CALL_TO_BREAK_DV BreakpointModel_na(sumCurrentsDv, sumConductivityDv,  V[seg]+0.001,StatesM[0][seg] ,StatesM[1][seg] ,ParamsM[0][comp],ParamsM[1][comp],ParamsM[2][comp],ParamsM[3][comp],ParamsM[4][comp],ParamsM[5][comp],ParamsM[6][comp],ParamsM[7][comp],ParamsM[8][comp],ParamsM[9][comp],ParamsM[10][comp],ParamsM[11][comp]);


#endif
