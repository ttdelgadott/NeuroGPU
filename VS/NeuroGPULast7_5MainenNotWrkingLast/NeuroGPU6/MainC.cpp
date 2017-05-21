
#include "Util.h"
#include <math.h>
#include "CudaStuff.cuh"
#include "AllModels.h"

#define Rev_seg TheMMat.N-seg

// Params from MainStruct
HMat TheMMat;
Stim stim;
Sim sim;
char debugFN[]="Debug.dat";
FILE *fdebug,*fdebug2,*fdebug3;
MYFTYPE **ParamsMSerial;
MYFTYPE *ParamsM;
MYDTYPE NSets;
MYDTYPE FParams;
MYDTYPE comp;
MYFTYPE *V;

MYSECONDFTYPE *VV;
MYFTYPE **StatesM;
void Init(){
	
	ReadSimData(Sim_FN,TheMMat.N,sim);
#ifndef  STIMFROMFILE 
	ReadStimData(Stim_FN, stim,TheMMat.N);
#endif // !STIMFROMFIL
#ifdef  STIMFROMFILE 
	ReadStimFromFile(Stim_FN, stim);
#endif // STIMFROMFILE
	
	//CreateStimData(stim);
	V = (MYFTYPE*) malloc(TheMMat.N*sizeof(MYFTYPE));
	VV = (MYSECONDFTYPE*) malloc(TheMMat.N*sizeof(MYSECONDFTYPE));
	CopyVec(V,sim.Vs,TheMMat.N);
	CopyVecTwoTypes(VV,sim.Vs,TheMMat.N);
	ParamsMSerial=(MYFTYPE **)malloc( NPARAMS * sizeof(MYFTYPE ));
	StatesM=(MYFTYPE **)malloc(NSTATES*sizeof(MYFTYPE *));
	for(int i=0;i<NSTATES;i++) {
		StatesM[i]=(MYFTYPE *)calloc((TheMMat.N),sizeof(MYFTYPE ));
	}
	
	//ReadParamsMat(ParamsMat_FN,ParamsMSerial,NPARAMS,TheMMat.NComps);
	
	//ReadParamsMatX(ParamsMat_FN,ParamsM,NPARAMS,TheMMat.NComps);
	MYDTYPE tempNsets;
	tempNsets = TheMMat.NComps;
	printf(" ntempnsets%d\n",tempNsets);
	
	ParamsM = ReadAllParams(AllParams_FN,NPARAMS,tempNsets,tempNsets);
	//fdebug3 = fopen(Param_DEBUG,"wb");
	//debugPrintMYFTYPE(ParamsM,tempNsets* TheMMat.NComps * NPARAMS,fdebug3);
	//fclose(fdebug3);
	NSets = tempNsets;
};
#ifdef RUN_SERIAL

void RunByModelSerial() {

	MYDTYPE CompDepth,CompFDepth;
	//ReadSerialNeuronData(BasicConst_FN, TheMMat);//Since the serial is just for debugging no real reason not to have just the parallel
	
	ReadParallelNeuronData(BasicConstP_FN, TheMMat,&CompDepth,&CompFDepth);

	Init();
	int N=TheMMat.N;
	MYFTYPE* Vmid = (MYFTYPE*) malloc(N*sizeof(MYFTYPE));
	MYSECONDFTYPE* rhs = (MYSECONDFTYPE*) malloc(N*sizeof(MYSECONDFTYPE));
	MYFTYPE* dgs = (MYFTYPE*) malloc(N*sizeof(MYFTYPE));
	MYFTYPE* dvs = (MYFTYPE*) calloc(N,sizeof(MYFTYPE));
	MYFTYPE* Rrhs = (MYFTYPE*) calloc(N,sizeof(MYFTYPE));
	MYFTYPE* RVmid = (MYFTYPE*) malloc(N*sizeof(MYFTYPE));
	MYSECONDFTYPE* D = (MYSECONDFTYPE*) malloc(N*sizeof(MYSECONDFTYPE));
	MYFTYPE* RD = (MYFTYPE*) malloc(N*sizeof(MYFTYPE));
	MYFTYPE* rhsStim; 
	MYDTYPE Nt,parentIndex;
	MYFTYPE curr_dg,curr_rhs,current;
#ifndef STIMFROMFILE
	Nt = ceil(sim.TFinal/sim.dt);
#endif // !STIMFROMFILE
#ifdef STIMFROMFILE
	Nt = stim.Nt;
#endif // STIMFROMFILE

	
	MYFTYPE** DebugData =(MYFTYPE **)malloc( NSTATES * sizeof(MYFTYPE ));
	MYFTYPE** RHSData =(MYFTYPE **)malloc( Nt* sizeof(MYFTYPE ));
	MYFTYPE** DData =(MYFTYPE **)malloc( Nt* sizeof(MYFTYPE ));
	MYFTYPE** VData =(MYFTYPE **)malloc( Nt* sizeof(MYFTYPE ));
	MYFTYPE* origV = (MYFTYPE*)malloc(N*sizeof(MYFTYPE));
	//If we use debug this is essential
	/*ReadDebugData(NERUON_DEBUG,DebugData,N,150);
	ReadDData(D_DEBUG,DData,N,200);
	ReadRHSData(RHS_DEBUG,RHSData,N,200);
	ReadVData(V_DEBUG,VData,N,200);
	ReadDData(D_DEBUG,DData,N,150);
	ReadVData(V_DEBUG,VData,N,150);
	ReadRHSData(RHS_DEBUG,RHSData,N,200);
	ReadVData(V_DEBUG,VData,N,200);
	ReadDData(D_DEBUG,DData,N,200);*/
	if(DEBUG){
		fdebug= fopen(debugFN, "wb");
		if (!fdebug) {
			printf("Failed to open debug file\n");
			return;
		}
		rhsStim = (MYFTYPE*) malloc(Nt*sizeof(MYFTYPE));
	}
	MYFTYPE  *VHot = (MYFTYPE*)calloc(Nt*stim.NStimuli, sizeof(MYFTYPE));
	MYSECONDFTYPE  sumCurrentsDv=0,sumCurrents=0;
	MYFTYPE sumConductivity=0,sumConductivityDv=0;
	MYFTYPE t =0; 
	MYSECONDFTYPE  dv;
	MYDTYPE dtCounter=0;
	MYFTYPE  dt = sim.dt;
	for (MYDTYPE stimInd=0;stimInd<stim.NStimuli;stimInd++){
		for(int seg=0;seg<TheMMat.N;seg++) {
			V[seg] = sim.Vs[seg];
			comp = TheMMat.SegToComp[seg];
				CALL_TO_INIT_STATES
		}

		dtCounter=0;
		for(int i=0;i<Nt;i++) {	
			if(i==stim.dtInds[dtCounter]){
				dt = stim.durs[dtCounter];
				if (dtCounter != stim.numofdts-1){
					dtCounter++;

				}
			}
			t+=0.5*dt;
			
			// Output
			VHot[stimInd*Nt +i] = V[stim.loc];
			for(int seg=0;seg<N;seg++) {
				rhs[seg]=0;//is rhs_ command 17
				D[seg] = 0;//is D command 17
				dgs[seg] = 0;//is gModel command 20

			}
			// Before matrix
			for(int seg=1;seg<N;seg++) {
				comp = TheMMat.SegToComp[seg];
				sumCurrents = 0; //command 17
				sumCurrentsDv = 0;//command 17
				sumConductivity=0;
				sumConductivityDv=0; 
				current=0;
				//RBS THIS WAS CHANGEDfirst stim then other mechanisms
#ifndef STIMFROMFILE
				if(t>=stim.dels[0] && t<(stim.dels[0]+stim.durs[0]) && (stim.loc == seg)){
					current = 100*stim.amps[0]/stim.area;//command 23 current is stimCurrent

				}
#endif // !STIMFROMFILE
#ifdef STIMFROMFILE
				current=0;
				if(stim.loc == seg){
					current = 100*stim.amps[Nt*stimInd + i]/stim.area;//command 23 current is stimCurrent
				}	else{
					current=0;
				}
#endif // STIMFROMFILE

			 
				//RBS THIS WAS CHANGED (first dv then regular!!)
				CALL_TO_BREAK_DV//command 19
				CALL_TO_BREAK//command 20
					//curr_dg=0; //was command 20 but probably not necessary
					dgs[seg] = (sumCurrentsDv-sumCurrents)/EPS_V;//command 21 
				rhs[seg] = current- sumCurrents;//command 22
			}
			//fdebug2 = fopen(DEBUG_FN,"wb");
			//debugPrintMYSECONDFTYPE (rhs,96,fdebug2);
			//	fclose(fdebug2);
		
			//CopyVec(V,origV,TheMMat.N); for debug puproses
			for(int seg=1;seg<N;seg++) {
				parentIndex =  TheMMat.N-TheMMat.Ks[Rev_seg];//command 15
				//dv = V[parentIndex]-V[seg];//command 25
				dv = VV[parentIndex]-VV[seg];//command 25
				dv = dvs[seg];
				rhs[seg] -=  TheMMat.f[Rev_seg-1]*dv;//command 25
				rhs[parentIndex]+=TheMMat.e[Rev_seg]*dv;// not command 25

			}
			for(int seg=1;seg<N;seg++) {
				D[seg]=dgs[seg]+TheMMat.Cms[seg]/(dt*1000);//This is commandhere24
			}
			//command 26 moves rhs and Ds to bhp and uhp respectively
		/*	fdebug2 = fopen(DEBUG_FN,"wb");
			debugPrintMYSECONDFTYPE (D,96,fdebug2);
				fclose(fdebug2);*/
			for(int seg=1;seg<N;seg++) {
				//Taking care of the Diam
				parentIndex =  TheMMat.N-TheMMat.Ks[Rev_seg];//command 15
				dv = VV[parentIndex]-VV[seg];
			
				dv = dvs[seg];
				D[seg]-=TheMMat.f[Rev_seg-1];//This is commandhere24
				D[parentIndex]-=TheMMat.e[Rev_seg];

			}
			/*debug purposes
			if(i<150){
			//SetRHSFromNeuron(rhs,RHSData,i,N);
			//SetDFromNeuron(D,DData,i,N);
			}
			*/
			if(i<150){
			//SetRHSFromNeuron(rhs,RHSData,i,N);
			//SetDFromNeuron(D,DData,i,N);
			}
			if(DEBUG){
		/*		fdebug2 = fopen(DEBUG_FN,"wb");
				debugPrintMYSECONDFTYPE (D,96,fdebug2);
				fclose(fdebug2);*/
				/*fdebug2 = fopen("parents.txt","wb");
				for(int seg=0;seg<TheMMat.N;seg++){
				  printf("%d,%d\n",seg,TheMMat.N-TheMMat.Ks[TheMMat.N-seg]);
				}
				fclose(fdebug2);*/
				rhsStim[i]=rhs[stim.loc];
			}
			//FlipVec(Rrhs,rhs,TheMMat.N);
			//FlipVec(RD,D,TheMMat.N);
		/*	fdebug2 = fopen(DEBUG_FN,"wb");
				debugPrintMYSECONDFTYPE (D,96,fdebug2);
				fclose(fdebug2);
	*/
			//Not sure what is this
			// for(int seg=0;seg<N;seg++) { Rrhs[seg]=rhs[N-1-seg]; 	RD[seg]=D[N-1-seg];	}
			//SolveTriDiagonalHinesSerialCPU(TheMMat, Rrhs, RVmid); // Vmid = B\(2*Cm*V/dt + f);
			solveByNeuron(TheMMat,rhs,D);
			//CopyVecTwoTypes(Vmid,rhs,TheMMat.N);
			//Not sure what is this
			//for(int seg=0;seg<N;seg++) { Vmid[seg]=rhs[seg]; 		}
			//debugPrintMYFTYPE (Vmid,TheMMat.N,fdebug);
			// After matrix - V = 2*Vmid - V;
			for(int seg=0;seg<N;seg++) {
				V[seg]+=rhs[seg];
				VV[seg]+=rhs[seg];

				parentIndex =  TheMMat.N-TheMMat.Ks[Rev_seg];//command 15
				if(seg>1){
					dvs[seg] +=rhs[parentIndex]-rhs[seg];
				}
				else{
					dvs[seg]=0;
				}

			}
			t+=0.5*dt;
			//Debug purposes
			//CopyVec(origV,V,TheMMat.N);
			/*if(i>0)
			SetStatesFromDebug(StatesM,DebugData,i-1,N);*/
			//if(i<150 && i>1)
			//SetVFromNeuron(V,VData,i,N);

			for(int seg=0;seg<N;seg++) {
				comp = TheMMat.SegToComp[seg];
					CALL_TO_DERIV
			
			}
		}
	}
	SaveArrayToFile(VHOT_OUT_FN,Nt*stim.NStimuli,VHot);
	if(DEBUG){
		debugPrintMYFTYPE (rhsStim,Nt,fdebug);
		fclose(fdebug);
	}

}
#endif

void InitP(){ // YYY add void
}

void RunByModelP() { // YYY add void
	MYDTYPE CompDepth,CompFDepth;
	
	ReadParallelNeuronData(BasicConstP_FN, TheMMat,&CompDepth,&CompFDepth);
	Init();
	printf("reading file %s", BasicConstP_FN);
	stEfork2Main(stim,sim, ParamsM, TheMMat, V,CompDepth,CompFDepth,NSets);
	
}
