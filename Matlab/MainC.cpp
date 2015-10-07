#include "hh.h"
#include "Util.h"
#include "CudaStuff.cuh"

// Params from MainStruct
HMat TheMMat;
char MatFN[]="TreeData.x";
char ParamsFN[]="Params.x";

float **ParamsM;
float *V;
float **StatesM;

void ReadParamsMat() {
    FILE *fl = fopen(ParamsFN, "rb");
    if (!fl) {
        printf("Failed to read TreeData.x\n");
        return;
    }
    ParamsM=(float**)malloc(NPARAMS*sizeof(float*));
    for(int i=0;i<NPARAMS;i++) {
        ParamsM[i]=(float*)malloc((TheMMat.N)*sizeof(float));
    }
    fclose(fl);
}

void Init(){ // YYY add void
    TheMMat=ReadSerialNeuronData(MatFN);
    ReadParamsMat();
    V=getInitialConditions(TheMMat.N);
    
    StatesM=(float**)malloc(NSTATES*sizeof(float*));
    for(int i=0;i<NSTATES;i++) {
        StatesM[i]=(float*)malloc((TheMMat.N)*sizeof(float));
    }
    
    for(int seg=0;seg<TheMMat.N;seg++) {
        CALL_TO_INIT_STATES
    }
    
};

void RunByModel() {
    Init();
    Stim stim;
    stim.t1=10;
    stim.t2=12;
    stim.amp=0.01;
    stim.loc=10;
    
    int N=TheMMat.N;
    MYFTYPE* Vmid = (MYFTYPE*) malloc(N*sizeof(MYFTYPE));
    MYFTYPE* TmpVec2 = (MYFTYPE*) malloc(N*sizeof(MYFTYPE));
    float TFinal=TheMMat.N*1;
    float Cm = 1;
    float dt=TEST_DT;
    float stimArea=3.1416/10000000;
    MYDTYPE Nt;
    // V=getInitialConditions(N); YYY
    MYFTYPE *Iapp = (MYFTYPE*)calloc(N, sizeof(MYFTYPE));
    Iapp[stim.loc] = stim.amp/stimArea;
    Nt = ceil(TFinal/dt);
    float *VHot = (MYFTYPE*)calloc(Nt, sizeof(MYFTYPE)); // Vhot = zeros(Nt,1);
    VHot[0] = V[stim.loc]; //Vhot(1) = V(eloc);
    float sumCurrents, sumConductivity;
    MYFTYPE* dOrig = (MYFTYPE*) malloc(N*sizeof(MYFTYPE));
    CopyVec(dOrig, TheMMat.d, N);
    float t;
    for(int i=0;i<Nt;i++) {
        t=i*dt;
        // Before matrix
        for(int seg=0;seg<N;seg++) {
            CALL_TO_DERIV
            CALL_TO_BREAK
            TmpVec2[seg]=sumCurrents;
            
            if(seg==stim.loc && t>stim.t1 && t<stim.t2) {
                TmpVec2[seg]+=stim.amp/stimArea;
            }
            
            TheMMat.d[seg]=dOrig[seg]+sumConductivity+ 2*Cm/dt;
        }
        
        SolveTriDiagonalHinesSerialCPU(TheMMat, TmpVec2, Vmid); // Vmid = B\(2*Cm*V/dt + f);
        
        // After matrix - V = 2*Vmid - V;
        for(int seg=0;seg<N;seg++) {
            V[seg]=2*Vmid[seg]-V[seg];
        }
        
        // Output
        VHot[i] = V[stim.loc];
    }
}