#ifndef __HH__
#define __HH__

// YYY add these
//#define ena 56
//#define ek -77
#define NIons 3//gnabar_hh2,gkbar_hh2,gl_hh2,
			   //ena,ek,el_hh2)

// gnabar gkbar gl el 
#define celsius 25
#define NPARAMS 6

// YYY add this line!
#define NSTATES 3
// YYY add this
void RunByModelSerial();
void RunByModelP();

// YYY add declarations!
void BreakpointModelHH(float &sumCurrents, float &sumConductivity, float v, float m,float h,float n,float gnabar,float gkbar,float gl,float el);
void DerivModelHH(float dt, float v, float &m,float &h,float &n);
void InitModelHH(float v,float &m,float &h,float &n);

#define CALL_TO_INIT_STATES  InitModel(V[seg],StatesM[0][seg],StatesM[1][seg],StatesM[2][seg]);//ZZZ change to 0 1 2
#define CALL_TO_KERNEL_INIT_STATES  KInitModel(v,ModelStates[0],ModelStates[1],ModelStates[2]);KInitModel(v_2,ModelStates_2[0],ModelStates_2[1],ModelStates_2[2]);

#define CALL_TO_DERIV  DerivModel(sim.dt, V[seg], StatesM[0][seg],StatesM[1][seg],StatesM[2][seg]);//ZZZ change to 0 1 2
#define CALL_TO_KERNEL_DERIV  KDerivModel(sim.dt, v, ModelStates[0],ModelStates[1],ModelStates[2]);KDerivModel(sim.dt, v_2, ModelStates_2[0],ModelStates_2[1],ModelStates_2[2]);

// YYY remove float & #define CALL_TO_BREAK BreakpointModel(float &sumCurrents, float &sumConductivity,StatesM[1][seg],StatesM[2][seg],StatesM[3][seg],ParamsM[1][seg],ParamsM[2][seg],ParamsM[3][seg],ParamsM[4][seg]);
// YYY add V[seg],

//#define CALL_TO_BREAK BreakpointModel(sumCurrents, sumConductivity,V[seg],StatesM[0][seg],StatesM[1][seg],StatesM[2][seg],ParamsM[0],ParamsM[1],ParamsM[2],ParamsM[3]);//ZZZ change to 0 1 2
////#define CALL_TO_BREAK_dV BreakpointModel(sumCurrentsDv, sumConductivityDv,V[seg]+0.001,StatesM[0][seg],StatesM[1][seg],StatesM[2][seg],ParamsM[0],ParamsM[1],ParamsM[2],ParamsM[3]);//ZZZ change to 0 1 2/
//#define CALL_TO_KERNEL_BREAK KBreakpointModel(sumCurrents, sumConductivity,v,ModelStates[0],ModelStates[1],ModelStates[2],ParamsM[0],ParamsM[1],ParamsM[2],ParamsM[3]);KBreakpointModel(sumCurrents_2, sumConductivity_2,v_2,ModelStates_2[0],ModelStates_2[1],ModelStates_2[2],ParamsM[0],ParamsM[1],ParamsM[2],ParamsM[3]);
//#define CALL_TO_KERNEL_BREAK_dV KBreakpointModel(sumCurrentsDv, sumConductivityDv,v+0.001,ModelStates[0],ModelStates[1],ModelStates[2],ParamsM[0],ParamsM[1],ParamsM[2],ParamsM[3]);KBreakpointModel(sumCurrentsDv_2, sumConductivityDv_2,v_2+0.001,ModelStates_2[0],ModelStates_2[1],ModelStates_2[2],ParamsM[0],ParamsM[1],ParamsM[2],ParamsM[3]);

#endif