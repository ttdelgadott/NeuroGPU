#ifndef __UTIL__
#define __UTIL__

#define MYFTYPE float
#define MYSECONDFTYPE double	
#define MYTHIRDFTYPE double
#define MYDTYPE unsigned short
#define STIMFROMFILE 1
#define NKERNEL 30
#define DEBUG 1
#define BKSUB1
#define HH
#define MUL32 13
#define ILP13
#ifdef HH
#define NSTIM 1
#define EPS_V 0.001
//#include "hh.h"
#include "AllModels.h"
#endif
#ifdef PAS
#include "pas.h"
#endif
#define PASLOOP 0


#define TIMES_FN "..\\..\\..\\Data2\\RunTimes.dat"
#define VHOT_OUT_FN "..\\..\\..\\Data2\\VHotC.dat"
#define VHOT_OUT_FN_P "..\\..\\..\\Data2\\VHotP.dat"
#define NERUON_DEBUG "..\\..\\..\\Data2\\StatesForC.dat"
#define RHS_DEBUG "..\\..\\..\\Data2\\rhsFromNeuron.dat"
#define Param_DEBUG "..\\..\\..\\Data2\\Param_DEBUG.dat"
#define D_DEBUG "..\\..\\..\\Data2\\DFromNeuron.dat"
#define V_DEBUG "..\\..\\..\\Data2\\VForC.dat"
#define DEBUG_FN "..\\..\\..\\Data2\\Debug.dat"
#define AllParams_FN "..\\..\\..\\Data2\\AllParams.dat"
#ifdef HH
#define BasicConst_FN "..\\..\\..\\Data2\\BasicConst"
#define BasicConstP_FN "..\\..\\..\\Data2\\BasicConst"
#define ParamsMat_FN "..\\..\\..\\Data2\\ParamsM"

#define Stim_FN "..\\..\\..\\Data2\\StimF.dat"
#define Sim_FN "..\\..\\..\\Data2\\Sim"
#endif

#define WARPSIZE 32
#define NNEURONS 1
#define MAX_GRID_PER_DIM 65534
#define LARGE_NUM  1e20
#include <math.h>
#include <stdlib.h>
#include <stdio.h>
#include <string.h>
#include <conio.h>
#include <time.h>
typedef struct {
	MYSECONDFTYPE *e;
	MYSECONDFTYPE *f;
	MYDTYPE N;
	// MYDTYPE NSegs;
	MYDTYPE *Ks;
	MYFTYPE *Cms;
	MYDTYPE NModels;
	MYDTYPE NComps;
	MYDTYPE *boolModel;
	// So far was for serial, now parallel
	MYDTYPE Depth;
	MYDTYPE LognDepth;
	MYDTYPE nFathers;
	MYDTYPE nCallForFather;
	MYDTYPE* Fathers;
	
	MYDTYPE* SonNoVec;
	
	MYDTYPE* RelStarts;
	MYDTYPE* RelEnds;
	MYDTYPE* RelVec;
	MYDTYPE* SegStartI;
	MYDTYPE* SegEndI;
	MYDTYPE* SegToComp;
	MYDTYPE* MidComps;
	#ifdef BKSUB1
		MYDTYPE* FIdxs;
	#endif
	
	MYDTYPE *CompByLevel32;
	MYDTYPE *CompByFLevel32;
	MYDTYPE nLRel;
	MYDTYPE *LRelStarts;
	MYDTYPE *LRelEnds;
	MYDTYPE nFLRel;
	MYDTYPE *FLRelStarts;
	MYDTYPE *FLRelEnds;
	
	#ifdef BKSUB2
		MYDTYPE *KsB;
	#endif
}HMat;

// stim = struct('t1',10,'t2',12,'amp',1e-2,'loc',10,'Tfin',50);
typedef struct {
	MYDTYPE NStimuli;
	MYDTYPE loc;
	MYDTYPE comp;
	MYDTYPE numofdts;
	MYFTYPE area;
	MYDTYPE* dtInds;
	MYFTYPE* amps;
	MYFTYPE* durs;
	MYFTYPE* dels;
	MYFTYPE Nt;
}Stim;



typedef struct {
	MYFTYPE* Vs;
	MYFTYPE dt;
	MYFTYPE TFinal;
	MYFTYPE Celsius;
	MYDTYPE NRecSites;
	MYDTYPE* RecSites;
}Sim;


void RunByModelSerial();
void RunByModelP();
//void SolveTriDiagonalHinesSerialCPU(const HMat &InMat, MYFTYPE* B, MYFTYPE* HX);
void solveByNeuron(const HMat &InMat,MYSECONDFTYPE* B,MYSECONDFTYPE* D);
MYFTYPE maxf(MYFTYPE a, MYFTYPE b);
MYFTYPE MaxAbsDiffVec(MYFTYPE* A,MYFTYPE *B, int n);

void CopyVec(MYFTYPE* A,MYFTYPE *B, int n);
void CopyVecTwoTypes(MYSECONDFTYPE *B,MYFTYPE* A, int n);
void FlipVec(MYFTYPE* A,MYFTYPE *B, int n);
void CompareArrays(const MYFTYPE* App, const MYFTYPE *Real, int n, char* Prefix);
double diffclock(clock_t clock1,clock_t clock2);
#ifdef  HH
//void stEfork2(Stim stim, const HHparams& InHHParams, HMat& InMat, MYFTYPE *&VHot);
//void stEfork2Init(Stim stim, const HHparams& InHHParams, HMat& InMat, MYDTYPE &Nt, MYFTYPE&dt, MYDTYPE &N, MYFTYPE *&Iapp, MYFTYPE &stimArea, MYFTYPE &Cm, MYFTYPE **&VHots, MYFTYPE *&V, MYFTYPE *&n, MYFTYPE *&m, MYFTYPE *&h, MYFTYPE *&dOrig, MYFTYPE *&d);
#endif
void ReadSerialNeuronData(const char* FN, HMat &TheMat);
void ReadParallelNeuronData(const char* FN, HMat &TheMat,MYDTYPE* CompDepth,MYDTYPE* CompFDepth);
void FreeSerialNeuronData(HMat &InMat);
void ReadStimData(const char* FN, Stim &stim,MYDTYPE Nx);
void CreateStimData(Stim &stim);
void ReadSimData(const char* FN,MYDTYPE N, Sim &sim);
void ReadStimFromFile(const char* FN,Stim &stim);
void FreeStimData(Stim &stim);
void FreeSimData(Sim &sim);

void SaveArrayToFile(const char* FN, const int N, const MYFTYPE* Arr);
void SaveVHots(const char* FN,MYFTYPE** VHotsHost,MYDTYPE Nt,MYDTYPE NStimuli);
void ReadDebugData(const char* FN,MYFTYPE** DebugData,MYDTYPE Nsegs,MYDTYPE Nt);
void ReadRHSData(const char* FN,MYFTYPE** DebugData,MYDTYPE Nsegs,MYDTYPE Nt);
void ReadDData(const char* FN,MYFTYPE** DebugData,MYDTYPE Nsegs,MYDTYPE Nt);
void SetStatesFromDebug(MYFTYPE** StatesM,MYFTYPE** DebugData,MYDTYPE i,MYDTYPE N);
void SetRHSFromNeuron(MYFTYPE* rhs,MYFTYPE** DebugData,MYDTYPE i,MYDTYPE N);
void SetDFromNeuron(MYFTYPE* D,MYFTYPE** DebugData,MYDTYPE i,MYDTYPE N);
void ReadVData(const char* FN,MYFTYPE** DebugData,MYDTYPE Nsegs,MYDTYPE Nt);
void SetVFromNeuron(MYFTYPE* vs,MYFTYPE** DebugData,MYDTYPE i,MYDTYPE N);
void debugPrintMYFTYPE (MYFTYPE* A,MYDTYPE N,FILE* fdebug);
void debugPrintMYSECONDFTYPE(MYSECONDFTYPE* A,MYDTYPE N,FILE* fdebug);
#endif
