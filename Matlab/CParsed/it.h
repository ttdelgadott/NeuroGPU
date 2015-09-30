#ifndef __it__
#define __it__

#define celsius 6.3
#define ena 56
#define ek -77

// gbar vshift cao vmin vmax v12m v12h vwm vwh am ah vm1 vm2 vh1 vh2 wm1 wm2 wh1 wh2 
#define NPARAMS 19
#define NSTATES 2

void BreakpointModel_it(MYSECONDFTYPE &sumCurrents, MYFTYPE &sumConductivity, float v,float &m,float &h,float gbar_it,float cao_it, float &ica) ;
void DerivModel_it(float dt, float v,float &m,float &h,float gbar_it,float cao_it, float &ica) ;
void InitModel_it(float v,float &m,float &h,float gbar_it,float cao_it, float &ica) ;

#define CALL_TO_INIT_STATES  InitModel_it(V[seg],StatesM[3][seg] ,StatesM[4][seg] ,ParamsM[3][comp],ParamsM[4][comp],StatesM[16][ seg ]);

#define CALL_TO_DERIV  DerivModel_it(dt, V[seg],StatesM[3][seg] ,StatesM[4][seg] ,ParamsM[3][comp],ParamsM[4][comp],StatesM[16][ seg ]);

#define CALL_TO_BREAK BreakpointModel_it(sumCurrents, sumConductivity, V[seg],StatesM[3][seg] ,StatesM[4][seg] ,ParamsM[3][comp],ParamsM[4][comp],StatesM[16][ seg ]);

#define CALL_TO_BREAK_DV BreakpointModel_it(sumCurrentsDv, sumConductivityDv, V[seg]+0.001,StatesM[3][seg] ,StatesM[4][seg] ,ParamsM[3][comp],ParamsM[4][comp],StatesM[16][ seg ]);


#endif