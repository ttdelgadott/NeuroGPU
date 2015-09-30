#ifndef __na16__
#define __na16__

#define celsius 6.3
#define ena 56
#define ek -77

// gbar vshift tha qa Ra Rb thi1 thi2 qi thinf qinf Rg Rd temp q10 vmin vmax tadj 
#define NPARAMS 18
#define NSTATES 2

void BreakpointModel_na16(MYSECONDFTYPE &sumCurrents, MYFTYPE &sumConductivity, float v,float &m,float &h,float gbar_na16,float vshift_na16,float tha_na16,float qa_na16,float Ra_na16,float Rb_na16,float thi1_na16,float thi2_na16,float qi_na16,float thinf_na16,float qinf_na16,float Rg_na16,float Rd_na16) ;
void DerivModel_na16(float dt, float v,float &m,float &h,float gbar_na16,float vshift_na16,float tha_na16,float qa_na16,float Ra_na16,float Rb_na16,float thi1_na16,float thi2_na16,float qi_na16,float thinf_na16,float qinf_na16,float Rg_na16,float Rd_na16) ;
void InitModel_na16(float v,float &m,float &h,float gbar_na16,float vshift_na16,float tha_na16,float qa_na16,float Ra_na16,float Rb_na16,float thi1_na16,float thi2_na16,float qi_na16,float thinf_na16,float qinf_na16,float Rg_na16,float Rd_na16) ;

#define CALL_TO_INIT_STATES  InitModel_na16(V[seg],StatesM[13][seg] ,StatesM[14][seg] ,ParamsM[58][comp],ParamsM[59][comp],ParamsM[60][comp],ParamsM[61][comp],ParamsM[62][comp],ParamsM[63][comp],ParamsM[64][comp],ParamsM[65][comp],ParamsM[66][comp],ParamsM[67][comp],ParamsM[68][comp],ParamsM[69][comp],ParamsM[70][comp]);

#define CALL_TO_DERIV  DerivModel_na16(dt, V[seg],StatesM[13][seg] ,StatesM[14][seg] ,ParamsM[58][comp],ParamsM[59][comp],ParamsM[60][comp],ParamsM[61][comp],ParamsM[62][comp],ParamsM[63][comp],ParamsM[64][comp],ParamsM[65][comp],ParamsM[66][comp],ParamsM[67][comp],ParamsM[68][comp],ParamsM[69][comp],ParamsM[70][comp]);

#define CALL_TO_BREAK BreakpointModel_na16(sumCurrents, sumConductivity, V[seg],StatesM[13][seg] ,StatesM[14][seg] ,ParamsM[58][comp],ParamsM[59][comp],ParamsM[60][comp],ParamsM[61][comp],ParamsM[62][comp],ParamsM[63][comp],ParamsM[64][comp],ParamsM[65][comp],ParamsM[66][comp],ParamsM[67][comp],ParamsM[68][comp],ParamsM[69][comp],ParamsM[70][comp]);

#define CALL_TO_BREAK_DV BreakpointModel_na16(sumCurrentsDv, sumConductivityDv, V[seg]+0.001,StatesM[13][seg] ,StatesM[14][seg] ,ParamsM[58][comp],ParamsM[59][comp],ParamsM[60][comp],ParamsM[61][comp],ParamsM[62][comp],ParamsM[63][comp],ParamsM[64][comp],ParamsM[65][comp],ParamsM[66][comp],ParamsM[67][comp],ParamsM[68][comp],ParamsM[69][comp],ParamsM[70][comp]);


#endif