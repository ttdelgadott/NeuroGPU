#ifndef __na12__
#define __na12__

#define celsius 6.3
#define ena 56
#define ek -77

// gbar vshift tha qa Ra Rb thi1 thi2 qi thinf qinf Rg Rd temp q10 vmin vmax tadj 
#define NPARAMS 18
#define NSTATES 2

void BreakpointModel_na12(MYSECONDFTYPE &sumCurrents, MYFTYPE &sumConductivity, float v,float &m,float &h,float gbar_na12,float vshift_na12,float tha_na12,float qa_na12,float Ra_na12,float Rb_na12,float thi1_na12,float thi2_na12,float qi_na12,float thinf_na12,float qinf_na12,float Rg_na12,float Rd_na12) ;
void DerivModel_na12(float dt, float v,float &m,float &h,float gbar_na12,float vshift_na12,float tha_na12,float qa_na12,float Ra_na12,float Rb_na12,float thi1_na12,float thi2_na12,float qi_na12,float thinf_na12,float qinf_na12,float Rg_na12,float Rd_na12) ;
void InitModel_na12(float v,float &m,float &h,float gbar_na12,float vshift_na12,float tha_na12,float qa_na12,float Ra_na12,float Rb_na12,float thi1_na12,float thi2_na12,float qi_na12,float thinf_na12,float qinf_na12,float Rg_na12,float Rd_na12) ;

#define CALL_TO_INIT_STATES  InitModel_na12(V[seg],StatesM[11][seg] ,StatesM[12][seg] ,ParamsM[45][comp],ParamsM[46][comp],ParamsM[47][comp],ParamsM[48][comp],ParamsM[49][comp],ParamsM[50][comp],ParamsM[51][comp],ParamsM[52][comp],ParamsM[53][comp],ParamsM[54][comp],ParamsM[55][comp],ParamsM[56][comp],ParamsM[57][comp]);

#define CALL_TO_DERIV  DerivModel_na12(dt, V[seg],StatesM[11][seg] ,StatesM[12][seg] ,ParamsM[45][comp],ParamsM[46][comp],ParamsM[47][comp],ParamsM[48][comp],ParamsM[49][comp],ParamsM[50][comp],ParamsM[51][comp],ParamsM[52][comp],ParamsM[53][comp],ParamsM[54][comp],ParamsM[55][comp],ParamsM[56][comp],ParamsM[57][comp]);

#define CALL_TO_BREAK BreakpointModel_na12(sumCurrents, sumConductivity, V[seg],StatesM[11][seg] ,StatesM[12][seg] ,ParamsM[45][comp],ParamsM[46][comp],ParamsM[47][comp],ParamsM[48][comp],ParamsM[49][comp],ParamsM[50][comp],ParamsM[51][comp],ParamsM[52][comp],ParamsM[53][comp],ParamsM[54][comp],ParamsM[55][comp],ParamsM[56][comp],ParamsM[57][comp]);

#define CALL_TO_BREAK_DV BreakpointModel_na12(sumCurrentsDv, sumConductivityDv, V[seg]+0.001,StatesM[11][seg] ,StatesM[12][seg] ,ParamsM[45][comp],ParamsM[46][comp],ParamsM[47][comp],ParamsM[48][comp],ParamsM[49][comp],ParamsM[50][comp],ParamsM[51][comp],ParamsM[52][comp],ParamsM[53][comp],ParamsM[54][comp],ParamsM[55][comp],ParamsM[56][comp],ParamsM[57][comp]);


#endif