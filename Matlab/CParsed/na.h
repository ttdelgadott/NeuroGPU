#ifndef __na__
#define __na__

#define celsius 6.3
#define ena 56
#define ek -77

// gbar vshift tha qa Ra Rb thi1 thi2 qi thinf qinf Rg Rd temp q10 vmin vmax tadj 
#define NPARAMS 18
#define NSTATES 2

void BreakpointModel_na(MYSECONDFTYPE &sumCurrents, MYFTYPE &sumConductivity, float v,float &m,float &h,float gbar_na,float tha_na,float qa_na,float Ra_na,float Rb_na,float thi1_na,float thi2_na,float qi_na,float thinf_na,float qinf_na,float Rg_na,float Rd_na) ;
void DerivModel_na(float dt, float v,float &m,float &h,float gbar_na,float tha_na,float qa_na,float Ra_na,float Rb_na,float thi1_na,float thi2_na,float qi_na,float thinf_na,float qinf_na,float Rg_na,float Rd_na) ;
void InitModel_na(float v,float &m,float &h,float gbar_na,float tha_na,float qa_na,float Ra_na,float Rb_na,float thi1_na,float thi2_na,float qi_na,float thinf_na,float qinf_na,float Rg_na,float Rd_na) ;

#define CALL_TO_INIT_STATES  InitModel_na(V[seg],StatesM[6][seg] ,StatesM[7][seg] ,ParamsM[16][comp],ParamsM[17][comp],ParamsM[18][comp],ParamsM[19][comp],ParamsM[20][comp],ParamsM[21][comp],ParamsM[22][comp],ParamsM[23][comp],ParamsM[24][comp],ParamsM[25][comp],ParamsM[26][comp],ParamsM[27][comp]);

#define CALL_TO_DERIV  DerivModel_na(dt, V[seg],StatesM[6][seg] ,StatesM[7][seg] ,ParamsM[16][comp],ParamsM[17][comp],ParamsM[18][comp],ParamsM[19][comp],ParamsM[20][comp],ParamsM[21][comp],ParamsM[22][comp],ParamsM[23][comp],ParamsM[24][comp],ParamsM[25][comp],ParamsM[26][comp],ParamsM[27][comp]);

#define CALL_TO_BREAK BreakpointModel_na(sumCurrents, sumConductivity, V[seg],StatesM[6][seg] ,StatesM[7][seg] ,ParamsM[16][comp],ParamsM[17][comp],ParamsM[18][comp],ParamsM[19][comp],ParamsM[20][comp],ParamsM[21][comp],ParamsM[22][comp],ParamsM[23][comp],ParamsM[24][comp],ParamsM[25][comp],ParamsM[26][comp],ParamsM[27][comp]);

#define CALL_TO_BREAK_DV BreakpointModel_na(sumCurrentsDv, sumConductivityDv, V[seg]+0.001,StatesM[6][seg] ,StatesM[7][seg] ,ParamsM[16][comp],ParamsM[17][comp],ParamsM[18][comp],ParamsM[19][comp],ParamsM[20][comp],ParamsM[21][comp],ParamsM[22][comp],ParamsM[23][comp],ParamsM[24][comp],ParamsM[25][comp],ParamsM[26][comp],ParamsM[27][comp]);


#endif