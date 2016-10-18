#include "CudaStuff.cuh"
#include "Util.h"
#include "hh.h"


__device__ void BeforeLU(HMat InMat, MYFTYPE* uHP, MYFTYPE* bHP, MYDTYPE Depth)
{
	MYDTYPE PIdx=threadIdx.x;
	MYDTYPE i,j,CurJ,CurB,t, CurLevel;
	MYDTYPE JumctionI;

	for(CurLevel=0;CurLevel<=Depth;CurLevel++) {
		JumctionI=InMat.CompByLevel32[CurLevel*WARPSIZE+PIdx]-1;
		
		for(i=InMat.SegStartI[JumctionI]-1;i<InMat.SegEndI[JumctionI];i++) {
			MYFTYPE uHPm1=uHP[i-1];
			
			uHP[i]=uHP[i]-InMat.e[i]*(InMat.f[i-1]/uHPm1); // So far same as paper parallel
			uHPm1=uHP[i-1];
			MYFTYPE bHPm1=bHP[i-1];
			bHP[i]=bHP[i]-bHPm1*InMat.e[i]/uHPm1; // bH is y
		}
		if(CurLevel<Depth) {
			CurB=InMat.CompByFLevel32[(CurLevel)*WARPSIZE+PIdx]-1;//RBS i inserted another  -1 into the index RBS 2 i removed the-1 from the curlevel 
			CurJ=InMat.Fathers[CurB]-1;
			MYDTYPE St=InMat.RelStarts[CurB];
			MYDTYPE En=InMat.RelEnds[CurB];
			for(j=St;j<=En;j++) {
				t=InMat.RelVec[j-1]-1;
				MYFTYPE uHPm1=uHP[t-1];
				uHP[CurJ]-=InMat.e[t]*(InMat.f[t-1]/uHPm1); 
				uHPm1=uHP[t-1];
				MYFTYPE bHPm1=bHP[t-1];
				bHP[CurJ]-=bHPm1*InMat.e[t]/uHPm1; 
			}
		}	
	}
}
/*__device__ void BkSubB(HMat InMat, MYFTYPE* uHP, MYFTYPE* bHP, MYDTYPE Depth)
{
	MYDTYPE PIdx=threadIdx.x;
	MYDTYPE PIdx_2=threadIdx.x+WARPSIZE;
#ifdef ILP3
	MYDTYPE PIdx_3=threadIdx.x+(WARPSIZE*2);
#endif
#ifdef ILP4
	MYDTYPE PIdx_4=threadIdx.x+(WARPSIZE*3);
#endif
	MYDTYPE i,j,CurJ,CurB,t, CurLevel;
	MYDTYPE JumctionI;

	// get KsB from MATLAB (this comes instead of FIdxsX)
	// KsB=Ks; // do in matlab

	// bPX=zeros(1,N); // might be useless?
	bHP[PIdx]=0; // might be useless?
	bHP[PIdx_2]=0; // might be useless?
#ifdef ILP3
	bHP[PIdx_3]=0; // might be useless?
#endif
#ifdef ILP4
	bHP[PIdx_4]=0; // might be useless?
#endif

	// for CurLevel=Depth:-1:0
	for(CurLevel=Depth;CurLevel>=0;CurLevel--) {
		//     Run all independent set for this level, in parallel
		// for JumctionI=find(Level==CurLevel) % in parallel
		JumctionI=InMat.CompByLevel32[CurLevel*WARPSIZE+PIdx]-1;
		// for i=(SegEndI(JumctionI)):-1:(SegStartI(JumctionI)-1)
		for(i=InMat.SegEndI[JumctionI]-2;i>=InMat.SegStartI[JumctionI]-2;i--) {
			// k=KsB(i+1);
			MYFTYPE k=KsB[i+1];
			// bPX(i)=(bH(i)-bPX(k)*f(i))/uH(i);
			bHP[i]=(uHP[i]-bHP[k]*InMat.[i])/uHP[i];
		}
	}
}
*/
__device__ void BkSub(HMat InMat, MYFTYPE* PX, MYFTYPE* PF,MYFTYPE* uHP, MYFTYPE* bHP, MYDTYPE LognDepth)
{
	MYDTYPE PIdx=threadIdx.x;
	MYDTYPE PIdx_2=threadIdx.x+WARPSIZE;
#ifdef ILP3
	MYDTYPE PIdx_3=threadIdx.x+(WARPSIZE*2);
#endif
#ifdef ILP4
	MYDTYPE PIdx_4=threadIdx.x+(WARPSIZE*3);
#endif
	MYDTYPE i;
	MYDTYPE NextID;
	MYDTYPE NextID_2;
#ifdef ILP3
	MYDTYPE NextID_3;
#endif
#ifdef ILP4
	MYDTYPE NextID_4;
#endif
	
	PX=bHP;
	PF=uHP;
	PX[PIdx]=PX[PIdx]/PF[PIdx];
	PX[PIdx_2]=PX[PIdx_2]/PF[PIdx_2];
#ifdef ILP3
	PX[PIdx_3]=PX[PIdx_3]/PF[PIdx_3];
#endif
#ifdef ILP4
	PX[PIdx_4]=PX[PIdx_4]/PF[PIdx_4];
#endif
	PF[PIdx]=-InMat.f[PIdx]/PF[PIdx];
	PF[PIdx_2]=-InMat.f[PIdx_2]/PF[PIdx_2];
#ifdef ILP3
	PF[PIdx_3]=-InMat.f[PIdx_3]/PF[PIdx_3];
#endif
#ifdef ILP4
	PF[PIdx_4]=-InMat.f[PIdx_4]/PF[PIdx_4];
#endif

	PX[InMat.N]=0;
	PF[InMat.N]=1;
	for(i=0;i<LognDepth;i++) {	
		NextID=InMat.FIdxs[i*InMat.N+PIdx]-1;
		NextID_2=InMat.FIdxs[i*InMat.N+PIdx_2]-1;
#ifdef ILP3
		NextID_3=InMat.FIdxs[i*InMat.N+PIdx_3]-1;
#endif
#ifdef ILP4
		NextID_4=InMat.FIdxs[i*InMat.N+PIdx_4]-1;
#endif
		MYFTYPE OldPXj=PX[PIdx];
		MYFTYPE OldPXj_2=PX[PIdx_2];
#ifdef ILP3
		MYFTYPE OldPXj_3=PX[PIdx_3];
#endif
#ifdef ILP4
		MYFTYPE OldPXj_4=PX[PIdx_4];
#endif
		MYFTYPE OldPXNextID=PX[NextID];
		MYFTYPE OldPXNextID_2=PX[NextID_2];
#ifdef ILP3
		MYFTYPE OldPXNextID_3=PX[NextID_3];
#endif
#ifdef ILP4
		MYFTYPE OldPXNextID_4=PX[NextID_4];
#endif
		PX[PIdx]=OldPXj+OldPXNextID*PF[PIdx];
		PX[PIdx_2]=OldPXj_2+OldPXNextID_2*PF[PIdx_2];
#ifdef ILP3
		PX[PIdx_3]=OldPXj_3+OldPXNextID_3*PF[PIdx_3];
#endif
#ifdef ILP4
		PX[PIdx_4]=OldPXj_4+OldPXNextID_4*PF[PIdx_4];
#endif
		// PX[j]=PX[j]+PX[NextID]*PF[j];
		MYFTYPE OldPFj=PF[PIdx];
		MYFTYPE OldPFj_2=PF[PIdx_2];
#ifdef ILP3
		MYFTYPE OldPFj_3=PF[PIdx_3];
#endif
#ifdef ILP4
		MYFTYPE OldPFj_4=PF[PIdx_4];
#endif
		MYFTYPE OldPFNextID=PF[NextID];
		MYFTYPE OldPFNextID_2=PF[NextID_2];
#ifdef ILP3
		MYFTYPE OldPFNextID_3=PF[NextID_3];
#endif
#ifdef ILP4
		MYFTYPE OldPFNextID_4=PF[NextID_4];
#endif
		// PF[j]=PF[j]*PF[NextID];
		PF[PIdx]=OldPFj*OldPFNextID;
		PF[PIdx_2]=OldPFj_2*OldPFNextID_2;
#ifdef ILP3
		PF[PIdx_3]=OldPFj_3*OldPFNextID_3;
#endif
#ifdef ILP4
		PF[PIdx_4]=OldPFj_4*OldPFNextID_4;
#endif
	}
}

int testCode(MYFTYPE* orig, MYFTYPE* sim,int N){
	int i=0,iErr,iRel;
	MYFTYPE absErr,relErr,currErr,currRel;
	absErr = abs(orig[0]-sim[0]);
	relErr = absErr/abs(orig[0]);
	for(i=0;i<N;i++) {
		currErr = abs(orig[i]-sim[i]);
		currRel = currErr/abs(orig[i]);
		if (currErr>absErr){
			absErr=currErr;
			iErr=i;
		}
		if (currRel>relErr){
			relErr=currRel;
			iRel=i;

		}
	}
	printf("Absolute Error is %g at the %d index and Relative Error is %g at the %d index\n",absErr,iErr,relErr,iRel);
	return 1;
}
__device__ MYFTYPE Kvtrap(MYFTYPE x, MYFTYPE y) {
	if (fabs(x/y) < 1e-6) {;
	return y*(1 - x/y/2);
	}
	else
	{;
	return x/(exp(x/y) - 1);
	};
};

__device__ void Krates(MYFTYPE v, MYFTYPE &hinf,MYFTYPE &htau,MYFTYPE &minf,MYFTYPE &mtau,MYFTYPE &ninf,MYFTYPE &ntau) {
	MYFTYPE  alpha, beta, sum, q10;
	;
	// q10=3^((celsius - 6.3)/10); YYY CHANGE THIS to pow
	q10=pow(3,((celsius - 6.3)/10));
	;
	alpha=.1 * Kvtrap(-(v+40),10);
	beta=4 * exp(-(v+65)/18);
	sum=alpha + beta;
	mtau=1/(q10*sum);
	minf=alpha/sum;
	;
	alpha=.07 * exp(-(v+65)/20);
	beta=1 / (exp(-(v+35)/10) + 1);
	sum=alpha + beta;
	htau=1/(q10*sum);
	hinf=alpha/sum;
	;
	alpha=.01*Kvtrap(-(v+55),10) ;
	beta=.125*exp(-(v+65)/80);
	sum=alpha + beta;
	ntau=1/(q10*sum);
	ninf=alpha/sum;
}

__device__ void KInitModel(MYFTYPE v,MYFTYPE &m,MYFTYPE &h,MYFTYPE &n) {
	MYFTYPE hinf,htau,minf,mtau,ninf,ntau;
	Krates(v, hinf,htau,minf,mtau,ninf,ntau);
	m=minf;
	h=hinf;
	n=ninf;
}

__device__ void KDerivModel(MYFTYPE dt, MYFTYPE v, MYFTYPE &m,MYFTYPE &h,MYFTYPE &n) {
	MYFTYPE hinf,htau,minf,mtau,ninf,ntau;
	Krates(v, hinf,htau,minf,mtau,ninf,ntau);
	m = m + (1. - exp(dt*(( ( ( - 1.0 ) ) ) / mtau)))*(- ( ( ( minf ) ) / mtau ) / ( ( ( ( - 1.0) ) ) / mtau ) - m) ;
	h = h + (1. - exp(dt*(( ( ( - 1.0 ) ) ) / htau)))*(- ( ( ( hinf ) ) / htau ) / ( ( ( ( - 1.0) ) ) / htau ) - h) ;
	n = n + (1. - exp(dt*(( ( ( - 1.0 ) ) ) / ntau)))*(- ( ( ( ninf ) ) / ntau ) / ( ( ( ( - 1.0) ) ) / ntau ) - n) ;
};

// YYY add sum conductivity float BreakpointModel(float &m,float &h,float &n,float gnabar,float gkbar,float gl,float el) {
// YYY add float v
// YYY change to void function
__device__ void KBreakpointModel(MYFTYPE &sumCurrents, MYFTYPE &sumConductivity, MYFTYPE v, MYFTYPE m,MYFTYPE h,MYFTYPE n,MYFTYPE gnabar,MYFTYPE gkbar,MYFTYPE gl,MYFTYPE ena,MYFTYPE ek,MYFTYPE el) {
	float gk,gna;
	float ina,ik,il;
	gna=gnabar*m*m*m*h;
	ina=gna*(v-ena);
	gk=gkbar*n*n*n*n;
	ik=gk*(v-(ek));
	il=gl*(v-el);
	sumCurrents= ina+ik+il;
	sumConductivity= gl+gk+gna;
}



// RRR
__global__ void stEfork2TimeLoopGPUKernel(Stim stim, MYFTYPE* ParamsM, Sim sim, HMat InMat, MYFTYPE *V,MYFTYPE* VHotGlobal)
{
	
	MYDTYPE StimID=threadIdx.y;
	MYFTYPE stimDel = stim.dels[StimID];
	MYFTYPE stimDur = stim.durs[StimID];
	MYFTYPE stimAmp = stim.amps[StimID];
	MYDTYPE stimLoc = stim.loc;
	MYFTYPE stimArea = stim.area;
	MYDTYPE PIdx=threadIdx.x;
	MYDTYPE PIdx_2=threadIdx.x+WARPSIZE;
#ifdef ILP3
	MYDTYPE PIdx_3=threadIdx.x+(WARPSIZE*2);
#endif
#ifdef ILP4
	MYDTYPE PIdx_4=threadIdx.x+(WARPSIZE*3);
#endif
	cudaError cudaStatus;
	// for model RRR
	MYFTYPE t;
	MYFTYPE isModel,dVec, Vmid;
	MYFTYPE isModel_2, dVec_2, Vmid_2;
#ifdef ILP3
	MYFTYPE isModel_3, dVec_3, Vmid_3;
#endif
#ifdef ILP4
	MYFTYPE isModel_4, dVec_4, Vmid_4;
#endif
	MYFTYPE ModelStates[NSTATES];
	MYFTYPE ModelStates_2[NSTATES];
#ifdef ILP3
	MYFTYPE ModelStates_3[NSTATES];
#endif
#ifdef ILP4
	MYFTYPE ModelStates_4[NSTATES];
#endif
	MYFTYPE v=V[PIdx]; // RRR -65?
	MYFTYPE v_2=V[PIdx_2]; // RRR -65?
#ifdef ILP3
	MYFTYPE v_3=V[PIdx_3]; // RRR -65?
#endif
#ifdef ILP4
	MYFTYPE v_4=V[PIdx_4]; // RRR -65?
#endif
	
		
	HMat SMemMat;
	SMemMat.N=InMat.N;
	SMemMat.Depth=InMat.Depth;
	SMemMat.LognDepth=InMat.LognDepth;
	SMemMat.nFathers=InMat.nFathers;
	SMemMat.nCallForFather=InMat.nCallForFather;
	MYFTYPE p1,p2,p3,p4,p5,p6;
	MYFTYPE p1_2,p2_2,p3_2,p4_2,p5_2,p6_2;
#ifdef ILP3
	MYFTYPE p1_3,p2_3,p3_3,p4_3,p5_3,p6_3;
#endif
#ifdef ILP4
	MYFTYPE p1_4,p2_4,p3_4,p4_4,p5_4,p6_4;
#endif
	p1=ParamsM[0*SMemMat.N+PIdx];
	p1_2=ParamsM[0*SMemMat.N+PIdx_2];
#ifdef ILP3
	p1_3=ParamsM[0*SMemMat.N+PIdx_3];
#endif
#ifdef ILP4
	p1_4=ParamsM[0*SMemMat.N+PIdx_4];
#endif
	p2=ParamsM[1*SMemMat.N+PIdx];
	p2_2=ParamsM[1*SMemMat.N+PIdx_2];
#ifdef ILP3
	p2_3=ParamsM[1*SMemMat.N+PIdx_3];
#endif
#ifdef ILP4
	p2_4=ParamsM[1*SMemMat.N+PIdx_4];
#endif
	p3=ParamsM[2*SMemMat.N+PIdx];
	p3_2=ParamsM[2*SMemMat.N+PIdx_2];
#ifdef ILP3
	p3_3=ParamsM[2*SMemMat.N+PIdx_3];
#endif
#ifdef ILP4
	p3_4=ParamsM[2*SMemMat.N+PIdx_4];
#endif
	p4=ParamsM[3*SMemMat.N+PIdx];
	p4_2=ParamsM[3*SMemMat.N+PIdx_2];
#ifdef ILP3
	p4_3=ParamsM[3*SMemMat.N+PIdx_3];
#endif
#ifdef ILP4
	p4_4=ParamsM[3*SMemMat.N+PIdx_4];
#endif
	p5=ParamsM[4*SMemMat.N+PIdx];
	p5_2=ParamsM[4*SMemMat.N+PIdx_2];
#ifdef ILP3
	p5_3=ParamsM[4*SMemMat.N+PIdx_3];
#endif
#ifdef ILP4
	p5_4=ParamsM[4*SMemMat.N+PIdx_4];
#endif
	p6=ParamsM[5*SMemMat.N+PIdx];
	p6_2=ParamsM[5*SMemMat.N+PIdx_2];
#ifdef ILP3
	p6_3=ParamsM[5*SMemMat.N+PIdx_3];
#endif
#ifdef ILP4
	p6_4=ParamsM[5*SMemMat.N+PIdx_4];
#endif

	
	KInitModel(v,ModelStates[0],ModelStates[1],ModelStates[2]);
	KInitModel(v_2,ModelStates_2[0],ModelStates_2[1],ModelStates_2[2]);
#ifdef ILP3
	KInitModel(v_3,ModelStates_3[0],ModelStates_3[1],ModelStates_3[2]);
#endif
#ifdef ILP4
	KInitModel(v_4,ModelStates_4[0],ModelStates_4[1],ModelStates_4[2]);
#endif
	
	MYFTYPE sumCurrents, sumConductivity;
	MYFTYPE sumCurrents_2, sumConductivity_2;
#ifdef ILP3
	MYFTYPE sumCurrents_3, sumConductivity_3;
#endif
#ifdef ILP4
	MYFTYPE sumCurrents_4, sumConductivity_4;
#endif
	MYFTYPE sumCurrentsDv, sumConductivityDv;
	MYFTYPE sumCurrentsDv_2, sumConductivityDv_2;
#ifdef ILP3
	MYFTYPE sumCurrentsDv_3, sumConductivityDv_3;
#endif
#ifdef ILP4
	MYFTYPE sumCurrentsDv_4, sumConductivityDv_4;
#endif
	// end for model in init

	MYDTYPE offset=0;
	// CONSTANTS
	// floats
	MYFTYPE *Olde,*Oldf;
	Olde=InMat.e;
	Oldf=InMat.f;
	SMemMat.e = (MYFTYPE*) &smem[offset];
	offset+=InMat.N*sizeof(MYFTYPE);
	SMemMat.f = (MYFTYPE*) &smem[offset];
	offset+=InMat.N*sizeof(MYFTYPE);
	SMemMat.e[PIdx]=InMat.e[PIdx];
	SMemMat.e[PIdx_2]=InMat.e[PIdx_2];
#ifdef ILP3
	SMemMat.e[PIdx_3]=InMat.e[PIdx_3];
#endif
#ifdef ILP4
	SMemMat.e[PIdx_4]=InMat.e[PIdx_4];
#endif
	SMemMat.f[PIdx]=InMat.f[PIdx];
	SMemMat.f[PIdx_2]=InMat.f[PIdx_2];
#ifdef ILP3
	SMemMat.f[PIdx_3]=InMat.f[PIdx_3];
#endif
#ifdef ILP4
	SMemMat.f[PIdx_4]=InMat.f[PIdx_4];
#endif
	InMat.e=SMemMat.e;
	InMat.f=SMemMat.f;
	SMemMat.Cms = (MYFTYPE*) &smem[offset];
	offset+=InMat.N*sizeof(MYFTYPE);
	SMemMat.Cms[PIdx]=InMat.Cms[PIdx];
	SMemMat.Cms[PIdx_2]=InMat.Cms[PIdx_2];
#ifdef ILP3
	SMemMat.Cms[PIdx_3]=InMat.Cms[PIdx_3];
#endif
#ifdef ILP4
	SMemMat.Cms[PIdx_4]=InMat.Cms[PIdx_4];
#endif
	// 1

	// discrete
	SMemMat.FIdxs = (MYDTYPE*) &smem[offset];
	offset+=InMat.N*SMemMat.LognDepth*sizeof(MYDTYPE);
	for(int i=0;i<SMemMat.LognDepth;i++) {
		SMemMat.FIdxs[i*InMat.N+PIdx]=InMat.FIdxs[i*InMat.N+PIdx];
		SMemMat.FIdxs[i*InMat.N+PIdx_2]=InMat.FIdxs[i*InMat.N+PIdx_2];
#ifdef ILP3
		SMemMat.FIdxs[i*InMat.N+PIdx_3]=InMat.FIdxs[i*InMat.N+PIdx_3];
#endif
#ifdef ILP4
		SMemMat.FIdxs[i*InMat.N+PIdx_4]=InMat.FIdxs[i*InMat.N+PIdx_4];
#endif
	}
	
	SMemMat.Ks = (MYDTYPE*) &smem[offset];
	offset+=InMat.N*sizeof(MYDTYPE);
	SMemMat.Ks[PIdx]=InMat.Ks[PIdx];
	SMemMat.Ks[PIdx_2]=InMat.Ks[PIdx_2];
#ifdef ILP3
	SMemMat.Ks[PIdx_3]=InMat.Ks[PIdx_3];
#endif
#ifdef ILP4
	SMemMat.Ks[PIdx_4]=InMat.Ks[PIdx_4];
#endif
	
	SMemMat.boolModel= (MYDTYPE*) &smem[offset];
	offset+=InMat.N*sizeof(MYDTYPE);
	SMemMat.boolModel[PIdx]=InMat.boolModel[PIdx];
	SMemMat.boolModel[PIdx_2]=InMat.boolModel[PIdx_2];
#ifdef ILP3
	SMemMat.boolModel[PIdx_3]=InMat.boolModel[PIdx_3];
#endif
#ifdef ILP4
	SMemMat.boolModel[PIdx_4]=InMat.boolModel[PIdx_4];
#endif
	// 2
	MYDTYPE SonNo=InMat.SonNoVec[PIdx];
	MYDTYPE SonNo_2=InMat.SonNoVec[PIdx_2];
#ifdef ILP3
	MYDTYPE SonNo_3=InMat.SonNoVec[PIdx_3];
#endif
#ifdef ILP4
	MYDTYPE SonNo_4=InMat.SonNoVec[PIdx_4];
#endif
	
	SMemMat.RelStarts = (MYDTYPE*) &smem[offset];
	offset+=InMat.nFathers*sizeof(MYDTYPE);
	SMemMat.RelEnds = (MYDTYPE*) &smem[offset];
	offset+=InMat.nFathers*sizeof(MYDTYPE);
	SMemMat.RelVec = (MYDTYPE*) &smem[offset];
	offset+=InMat.nCallForFather*sizeof(MYDTYPE);
	SMemMat.SegStartI = (MYDTYPE*) &smem[offset];
	offset+=(InMat.nCallForFather+1)*sizeof(MYDTYPE);
	SMemMat.SegEndI = (MYDTYPE*) &smem[offset];
	offset+=(InMat.nCallForFather+1)*sizeof(MYDTYPE);

	SMemMat.Fathers= (MYDTYPE*) &smem[offset];
	offset+=InMat.nFathers*sizeof(MYDTYPE);
	// 3
	SMemMat.CompByLevel32 = (MYDTYPE*) &smem[offset]; // WARPSIZE*(Depth+1)
	offset+=WARPSIZE*(SMemMat.Depth+1)*sizeof(MYDTYPE);
	SMemMat.CompByFLevel32 = (MYDTYPE*) &smem[offset]; // WARPSIZE*(Depth+1)
	offset+=WARPSIZE*(SMemMat.Depth)*sizeof(MYDTYPE);
	
	// Moving back to floats - make sure that the address is good for float (is modulu 4).
	offset=ceilf(float(offset)/sizeof(MYFTYPE))*sizeof(MYFTYPE);
	MYDTYPE ConstantMemSize=offset;
	
	if(PIdx<InMat.nFathers) { // up to 32 !!!
		SMemMat.RelStarts[PIdx]=InMat.RelStarts[PIdx];
		SMemMat.RelEnds[PIdx]=InMat.RelEnds[PIdx];
		SMemMat.Fathers[PIdx]=InMat.Fathers[PIdx];
	}
	if(PIdx<InMat.nCallForFather) { // up to 32 !!!
		SMemMat.RelVec[PIdx]=InMat.RelVec[PIdx];
	}
	if(PIdx<InMat.nCallForFather+1) { // up to 32 !!!
		SMemMat.SegStartI[PIdx]=InMat.SegStartI[PIdx];
		SMemMat.SegEndI[PIdx]=InMat.SegEndI[PIdx];
	}
	syncthreads();
	
	for(int i=0;i<=SMemMat.Depth;i++) {
		SMemMat.CompByLevel32[WARPSIZE*i+PIdx]=InMat.CompByLevel32[WARPSIZE*i+PIdx];
	}
	for(int i=0;i<SMemMat.Depth;i++) {
		SMemMat.CompByFLevel32[WARPSIZE*i+PIdx]=InMat.CompByFLevel32[WARPSIZE*i+PIdx];
	}

	// Per STIMULUS
	// floats
	int Nt=ceil(sim.TFinal/sim.dt);
	// For solving the matrix
	MYDTYPE PerStimulus=((InMat.N+2)*2+InMat.N+WARPSIZE)*sizeof(MYFTYPE);
	offset+=PerStimulus*threadIdx.y;
	MYFTYPE *uHP,*bHP,*PX,*PF, *Vs;
	uHP = (MYFTYPE*) &smem[offset];
	offset+=(InMat.N+2)*sizeof(MYFTYPE);
	bHP = (MYFTYPE*) &smem[offset];
	offset+=(InMat.N+2)*sizeof(MYFTYPE);
	Vs = (MYFTYPE*) &smem[offset];
	offset+=InMat.N*sizeof(MYFTYPE);
	Vs[PIdx]=V[PIdx];
	Vs[PIdx_2]=V[PIdx_2];
#ifdef ILP3
	Vs[PIdx_3]=V[PIdx_3];
#endif
#ifdef ILP4
	Vs[PIdx_4]=V[PIdx_4];
#endif

	PX=bHP;
	PF=uHP;
	MYFTYPE *SMemVHot;
	
	SMemVHot = (MYFTYPE*) &smem[offset];
	offset+=WARPSIZE*sizeof(MYFTYPE);

	MYDTYPE parentIndex;
	MYDTYPE parentIndex_2;
#ifdef ILP3
	MYDTYPE parentIndex_3;
#endif
#ifdef ILP4
	MYDTYPE parentIndex_4;
#endif
	MYDTYPE Eidx;
	MYDTYPE Eidx_2;
#ifdef ILP3
	MYDTYPE Eidx_3;
#endif
#ifdef ILP4
	MYDTYPE Eidx_4;
#endif
	Eidx = SMemMat.N-PIdx;
	Eidx_2 = SMemMat.N-PIdx_2;
#ifdef ILP3
	Eidx_3 = SMemMat.N-PIdx_3;
#endif
#ifdef ILP4
	Eidx_4 = SMemMat.N-PIdx_4;
#endif
	if(Eidx>SMemMat.N-1){
		Eidx=SMemMat.N-1;
	}
	if(PIdx==0) {
		parentIndex=0; }
	else {
		parentIndex =SMemMat.N-SMemMat.Ks[SMemMat.N-PIdx];
	}
	
	parentIndex_2 =SMemMat.N-SMemMat.Ks[SMemMat.N-PIdx_2];
#ifdef ILP3
	parentIndex_3 =SMemMat.N-SMemMat.Ks[SMemMat.N-PIdx_3];
#endif
#ifdef ILP4
	parentIndex_4 =SMemMat.N-SMemMat.Ks[SMemMat.N-PIdx_4];
#endif

	float rhs,D,gModel,StimCurrent,dv;
	float rhs_2,D_2,gModel_2,StimCurrent_2,dv_2;
#ifdef ILP3
	float rhs_3,D_3,gModel_3,StimCurrent_3,dv_3;
#endif
#ifdef ILP4
	float rhs_4,D_4,gModel_4,StimCurrent_4,dv_4;
#endif
	for(int i=0;i<Nt;i++) {
		t = i*sim.dt;

		// Output
		rhs=0;
		rhs_2=0;
#ifdef ILP3
		rhs_3=0;
#endif
#ifdef ILP4
		rhs_4=0;
#endif
		D=0;
		D_2=0;
#ifdef ILP3
		D_3=0;
#endif
#ifdef ILP4
		D_4=0;
#endif

		// Before matrix

		//RRR here some work - this should do it    
		// CALL_TO_KERNEL_BREAK
		// CALL_TO_KERNEL_BREAK_dV

		KBreakpointModel(sumCurrents, sumConductivity,v,ModelStates[0],ModelStates[1],ModelStates[2],p1,p2,p3,p4,p5,p6);
		KBreakpointModel(sumCurrents_2, sumConductivity_2,v_2,ModelStates_2[0],ModelStates_2[1],ModelStates_2[2],p1_2,p2_2,p3_2,p4_2,p5_2,p6_2);
#ifdef ILP3
		KBreakpointModel(sumCurrents_3, sumConductivity_3,v_3,ModelStates_3[0],ModelStates_3[1],ModelStates_3[2],p1_3,p2_3,p3_3,p4_3,p5_3,p6_3);
#endif
#ifdef ILP4
		KBreakpointModel(sumCurrents_4, sumConductivity_4,v_4,ModelStates_4[0],ModelStates_4[1],ModelStates_4[2],p1_4,p2_4,p3_4,p4_4,p5_4,p6_4);
#endif
		KBreakpointModel(sumCurrentsDv, sumConductivityDv,v+0.001,ModelStates[0],ModelStates[1],ModelStates[2],p1,p2,p3,p4,p5,p6);
		KBreakpointModel(sumCurrentsDv_2, sumConductivityDv_2,v_2+0.001,ModelStates_2[0],ModelStates_2[1],ModelStates_2[2],p1_2,p2_2,p3_2,p4_2,p5_2,p6_2);
#ifdef ILP3
		KBreakpointModel(sumCurrentsDv_3, sumConductivityDv_3,v_3+0.001,ModelStates_3[0],ModelStates_3[1],ModelStates_3[2],p1_3,p2_3,p3_3,p4_3,p5_3,p6_3);
#endif
#ifdef ILP4
		KBreakpointModel(sumCurrentsDv_4, sumConductivityDv_4,v_4+0.001,ModelStates_4[0],ModelStates_4[1],ModelStates_4[2],p1_4,p2_4,p3_4,p4_4,p5_4,p6_4);
#endif

		gModel=0;
		gModel_2=0;
#ifdef ILP3
		gModel_3=0;
#endif
#ifdef ILP4
		gModel_4=0;
#endif
		if(SMemMat.boolModel[PIdx]==1) {
			gModel = (sumCurrentsDv-sumCurrents)/0.001; }
		else {
			sumConductivity=0;
			sumConductivityDv=0;
			sumCurrents=0;
			sumCurrentsDv=0;
		}
		if(SMemMat.boolModel[PIdx_2]==1) {gModel_2 = (sumCurrentsDv_2-sumCurrents_2)/0.001; }else {sumConductivity_2=0;sumConductivityDv_2=0;sumCurrents_2=0;sumCurrentsDv_2=0;}
#ifdef ILP3
		if(SMemMat.boolModel[PIdx_3]==1) {gModel_3 = (sumCurrentsDv_3-sumCurrents_3)/0.001; }else {sumConductivity_3=0;sumConductivityDv_3=0;sumCurrents_3=0;sumCurrentsDv_3=0;}
#endif
#ifdef ILP4
		if(SMemMat.boolModel[PIdx_4]==1) {gModel_4 = (sumCurrentsDv_4-sumCurrents_4)/0.001; }else {sumConductivity_4=0;sumConductivityDv_4=0;sumCurrents_4=0;sumCurrentsDv_4=0;}
#endif
		StimCurrent=0;
		StimCurrent_2=0;
#ifdef ILP3
		StimCurrent_3=0;
#endif
#ifdef ILP4
		StimCurrent_4=0;
#endif

		if(t>=stimDel && t<stimDel+stimDur && PIdx == stimLoc){
			StimCurrent = 100*stimAmp/stimArea;
		}
		if(t>=stimDel && t<stimDel+stimDur && PIdx_2 == stimLoc){StimCurrent_2 = 100*stimAmp/stimArea;}
#ifdef ILP3
		if(t>=stimDel && t<stimDel+stimDur && PIdx_3 == stimLoc){StimCurrent_3 = 100*stimAmp/stimArea;}
#endif
#ifdef ILP4
		if(t>=stimDel && t<stimDel+stimDur && PIdx_4 == stimLoc){StimCurrent_4 = 100*stimAmp/stimArea;}
#endif
		
		
		rhs=StimCurrent-sumCurrents;
		rhs_2=StimCurrent_2-sumCurrents_2;
#ifdef ILP3
		rhs_3=StimCurrent_3-sumCurrents_3;
#endif
#ifdef ILP4
		rhs_4=StimCurrent_4-sumCurrents_4;
#endif


		dv=Vs[parentIndex]-Vs[PIdx];
		dv_2=Vs[parentIndex_2]-Vs[PIdx_2];
#ifdef ILP3
		dv_3=Vs[parentIndex_3]-Vs[PIdx_3];
#endif
#ifdef ILP4
		dv_4=Vs[parentIndex_4]-Vs[PIdx_4];
#endif

		rhs-=SMemMat.f[SMemMat.N-PIdx-1]*dv;
		rhs_2-=SMemMat.f[SMemMat.N-PIdx_2-1]*dv_2;
#ifdef ILP3
		rhs_3-=SMemMat.f[SMemMat.N-PIdx_3-1]*dv_3;
#endif
#ifdef ILP4
		rhs_4-=SMemMat.f[SMemMat.N-PIdx_4-1]*dv_4;
#endif

		D=sumConductivity+SMemMat.Cms[PIdx]/(sim.dt*1000);
		D_2=sumConductivity_2+SMemMat.Cms[PIdx_2]/(sim.dt*1000);
#ifdef ILP3
		D_3=sumConductivity_3+SMemMat.Cms[PIdx_3]/(sim.dt*1000);
#endif
#ifdef ILP4
		D_4=sumConductivity_4+SMemMat.Cms[PIdx_4]/(sim.dt*1000);
#endif

		D-=SMemMat.f[SMemMat.N-PIdx-1];
		D_2-=SMemMat.f[SMemMat.N-PIdx_2-1];
#ifdef ILP3
		D_3-=SMemMat.f[SMemMat.N-PIdx_3-1];
#endif
#ifdef ILP4
		D_4-=SMemMat.f[SMemMat.N-PIdx_4-1];
#endif
		if(PIdx==0){
			rhs=0;
			D=0;
		}

		bHP[SMemMat.N-PIdx-1]=rhs;
		bHP[SMemMat.N-PIdx_2-1]=rhs_2;
#ifdef ILP3
		bHP[SMemMat.N-PIdx_3-1]=rhs_3;
#endif
#ifdef ILP4
		bHP[SMemMat.N-PIdx_4-1]=rhs_4;
#endif
		uHP[SMemMat.N-PIdx-1]=D;
		uHP[SMemMat.N-PIdx_2-1]=D_2;
#ifdef ILP3
		uHP[SMemMat.N-PIdx_3-1]=D_3;
#endif
#ifdef ILP4
		uHP[SMemMat.N-PIdx_4-1]=D_4;
#endif
		
		syncthreads();
		
		if(SonNo==1) {
		
			bHP[SMemMat.N-parentIndex-1]+=SMemMat.e[Eidx]*dv;
		
			uHP[SMemMat.N-parentIndex-1]-=SMemMat.e[Eidx];
		}
		if(SonNo_2==1) {bHP[SMemMat.N-parentIndex_2-1]+=SMemMat.e[Eidx_2]*dv_2;uHP[SMemMat.N-parentIndex_2-1]-=SMemMat.e[Eidx_2];}
#ifdef ILP3
		if(SonNo_3==1) {bHP[SMemMat.N-parentIndex_3-1]+=SMemMat.e[Eidx_3]*dv_3;uHP[SMemMat.N-parentIndex_3-1]-=SMemMat.e[Eidx_3];}
#endif
#ifdef ILP4
		if(SonNo_4==1) {bHP[SMemMat.N-parentIndex_4-1]+=SMemMat.e[Eidx_4]*dv_4;uHP[SMemMat.N-parentIndex_4-1]-=SMemMat.e[Eidx_4];}
#endif

		if(SonNo==2) {bHP[SMemMat.N-parentIndex-1]+=SMemMat.e[Eidx]*dv;uHP[SMemMat.N-parentIndex-1]-=SMemMat.e[Eidx];}
		if(SonNo_2==2) {bHP[SMemMat.N-parentIndex_2-1]+=SMemMat.e[Eidx_2]*dv_2;uHP[SMemMat.N-parentIndex_2-1]-=SMemMat.e[Eidx_2];}
#ifdef ILP3
		if(SonNo_3==2) {bHP[SMemMat.N-parentIndex_3-1]+=SMemMat.e[Eidx_3]*dv_3;uHP[SMemMat.N-parentIndex_3-1]-=SMemMat.e[Eidx_3];}
#endif
#ifdef ILP4
		if(SonNo_4==2) {bHP[SMemMat.N-parentIndex_4-1]+=SMemMat.e[Eidx_4]*dv_4;uHP[SMemMat.N-parentIndex_4-1]-=SMemMat.e[Eidx_4];}
#endif

		
		BeforeLU(SMemMat,uHP,bHP,SMemMat.Depth);
		BkSub(SMemMat, PX,PF,uHP,bHP,SMemMat.LognDepth);
		Vmid=PX[SMemMat.N-PIdx-1];
		Vmid_2=PX[SMemMat.N-PIdx_2-1];
#ifdef ILP3
		Vmid_3=PX[SMemMat.N-PIdx_3-1];
#endif
#ifdef ILP4
		Vmid_4=PX[SMemMat.N-PIdx_4-1];
#endif

		v+=Vmid;
		v_2+=Vmid_2;
#ifdef ILP3
		v_3+=Vmid_3;
#endif
#ifdef ILP4
		v_4+=Vmid_4;
#endif
		Vs[PIdx]+=Vmid;
		Vs[PIdx_2]+=Vmid_2;
#ifdef ILP3
		Vs[PIdx_3]+=Vmid_3;
#endif
#ifdef ILP4
		Vs[PIdx_4]+=Vmid_4;
#endif

		if(SMemMat.boolModel[PIdx]==1) {KDerivModel(sim.dt, Vs[PIdx], ModelStates[0],ModelStates[1],ModelStates[2]);}
		if(SMemMat.boolModel[PIdx_2]==1) {KDerivModel(sim.dt, Vs[PIdx_2], ModelStates_2[0],ModelStates_2[1],ModelStates_2[2]); 		}		
#ifdef ILP3
		if(SMemMat.boolModel[PIdx_3]==1) {KDerivModel(sim.dt, Vs[PIdx_3], ModelStates_3[0],ModelStates_3[1],ModelStates_3[2]); 		}		
#endif
#ifdef ILP4
		if(SMemMat.boolModel[PIdx_4]==1) {KDerivModel(sim.dt, Vs[PIdx_4], ModelStates_4[0],ModelStates_4[1],ModelStates_4[2]); 		}		
#endif
		
		if((i%(WARPSIZE)==0)&&i>0){
			VHotGlobal[threadIdx.y*Nt+(i-WARPSIZE)+PIdx]=SMemVHot[PIdx];
		}
		SMemVHot[i%(WARPSIZE)]=Vs[stimLoc];
	}

}

void ReadParamsMatX(const char* FN,MYFTYPE* ParamsM,MYDTYPE NParams,MYDTYPE Nx) {
	FILE *fl = fopen(FN, "rb"); // YYY add FILE*
	if (!fl) {
		printf("Failed to read TreeData.x\n");
		return;
	}
	fread(ParamsM, sizeof(MYFTYPE), Nx*NParams, fl);
	fclose(fl);
}

__constant__ MYDTYPE* constKs;

cudaError_t stEfork2TimeLoopGPU(Stim stim, Sim sim, MYFTYPE* ParamsM, HMat& InMat, float* V) { 
	cudaError_t cudaStatus;
	MYFTYPE *VHotsGlobal,*VHotsHost;
	MYDTYPE Nt=ceil(sim.TFinal/sim.dt);
	VHotsHost=(float*)malloc(stim.NStimuli*Nt*sizeof(float));
	
	int i,j,t;
	// For matrix -
	MYFTYPE *PXOut_d,*PFOut_d;
	MYFTYPE *uHPOut_d, *bHPOut_d;
	HMat Mat_d;
	Mat_d.N=InMat.N;
	Mat_d.Depth=InMat.Depth;
	Mat_d.LognDepth=InMat.LognDepth;
	Mat_d.nFathers=InMat.nFathers;
	Mat_d.nCallForFather=InMat.nCallForFather;
	
	Stim stim_d;
	stim_d.NStimuli = stim.NStimuli;
	stim_d.comp = stim.comp;
	stim_d.area = stim.area;
	stim_d.loc = stim.loc;
	cudaStatus = cudaMalloc((void**)&stim_d.dels, stim_d.NStimuli * sizeof(MYFTYPE));
	cudaStatus = cudaMalloc((void**)&stim_d.durs, stim_d.NStimuli * sizeof(MYFTYPE));
	cudaStatus = cudaMalloc((void**)&stim_d.amps, stim_d.NStimuli * sizeof(MYFTYPE));
	
	


	cudaStatus = cudaMalloc((void**)&Mat_d.e, InMat.N * sizeof(MYFTYPE));
	cudaStatus = cudaMalloc((void**)&Mat_d.f, InMat.N * sizeof(MYFTYPE));
	cudaStatus = cudaMalloc((void**)&Mat_d.Ks, InMat.N * sizeof(MYDTYPE));
	cudaStatus = cudaMalloc((void**)&Mat_d.boolModel, InMat.N * sizeof(MYDTYPE));
	cudaStatus = cudaMalloc((void**)&Mat_d.Cms, InMat.N * sizeof(MYFTYPE));
	cudaStatus = cudaMalloc((void**)&Mat_d.SonNoVec, InMat.N* sizeof(MYDTYPE));
	
	cudaStatus = cudaMalloc((void**)&Mat_d.Fathers, InMat.nFathers * sizeof(MYDTYPE));
	
	cudaStatus = cudaMalloc((void**)&Mat_d.RelStarts, InMat.nFathers * sizeof(MYDTYPE));
	cudaStatus = cudaMalloc((void**)&Mat_d.RelEnds, (InMat.nFathers) * sizeof(MYDTYPE));
	cudaStatus = cudaMalloc((void**)&Mat_d.RelVec, InMat.nCallForFather * sizeof(MYDTYPE));
	cudaStatus = cudaMalloc((void**)&Mat_d.SegStartI, (InMat.nCallForFather+1) * sizeof(MYDTYPE));
	cudaStatus = cudaMalloc((void**)&Mat_d.SegEndI, (InMat.nCallForFather+1) * sizeof(MYDTYPE));
	cudaStatus = cudaMalloc((void**)&VHotsGlobal, Nt *stim.NStimuli* sizeof(MYFTYPE));
	// 32 data
	cudaStatus = cudaMalloc((void**)&Mat_d.FIdxs, InMat.LognDepth*InMat.N* sizeof(MYDTYPE));
	cudaStatus = cudaMalloc((void**)&Mat_d.CompByLevel32, (Mat_d.Depth+1)*WARPSIZE* sizeof(MYDTYPE));
	cudaStatus = cudaMalloc((void**)&Mat_d.CompByFLevel32, (Mat_d.Depth)*WARPSIZE* sizeof(MYDTYPE));

	if (cudaStatus != cudaSuccess) {
		fprintf(stderr, "cudaMalloc failed!");
		return cudaStatus;  
	}

	cudaStatus = cudaMemcpy(stim_d.dels, stim.dels, stim.NStimuli * sizeof(MYFTYPE), cudaMemcpyHostToDevice);
	cudaStatus = cudaMemcpy(stim_d.durs, stim.durs, stim.NStimuli * sizeof(MYFTYPE), cudaMemcpyHostToDevice);
	cudaStatus = cudaMemcpy(stim_d.amps, stim.amps, stim.NStimuli * sizeof(MYFTYPE), cudaMemcpyHostToDevice);


	cudaStatus = cudaMalloc((void**)&Mat_d.Fathers, InMat.nFathers * sizeof(MYDTYPE));
	cudaStatus = cudaMemcpy(Mat_d.e, InMat.e, InMat.N * sizeof(MYFTYPE), cudaMemcpyHostToDevice);
	cudaStatus = cudaMemcpy(Mat_d.f, InMat.f, InMat.N * sizeof(MYFTYPE), cudaMemcpyHostToDevice);
	cudaStatus = cudaMemcpy(Mat_d.Ks, InMat.Ks, InMat.N * sizeof(MYDTYPE), cudaMemcpyHostToDevice);
	cudaStatus = cudaMemcpy(Mat_d.boolModel, InMat.boolModel, InMat.N * sizeof(MYDTYPE), cudaMemcpyHostToDevice);
	cudaStatus = cudaMemcpy(Mat_d.Cms, InMat.Cms, InMat.N * sizeof(MYFTYPE), cudaMemcpyHostToDevice);
	cudaStatus = cudaMemcpy(Mat_d.SonNoVec, InMat.SonNoVec, InMat.N * sizeof(MYDTYPE), cudaMemcpyHostToDevice);
	
	cudaStatus = cudaMemcpy(Mat_d.Fathers, InMat.Fathers, InMat.nFathers * sizeof(MYDTYPE), cudaMemcpyHostToDevice);
	
	cudaStatus = cudaMemcpy(Mat_d.RelStarts, InMat.RelStarts, InMat.nFathers * sizeof(MYDTYPE), cudaMemcpyHostToDevice);
	cudaStatus = cudaMemcpy(Mat_d.RelEnds, InMat.RelEnds, InMat.nFathers * sizeof(MYDTYPE), cudaMemcpyHostToDevice);
	cudaStatus = cudaMemcpy(Mat_d.RelVec, InMat.RelVec, InMat.nCallForFather* sizeof(MYDTYPE), cudaMemcpyHostToDevice);
	cudaStatus = cudaMemcpy(Mat_d.SegStartI, InMat.SegStartI, (InMat.nCallForFather+1) * sizeof(MYDTYPE), cudaMemcpyHostToDevice);
	cudaStatus = cudaMemcpy(Mat_d.SegEndI, InMat.SegEndI, (InMat.nCallForFather+1)* sizeof(MYDTYPE), cudaMemcpyHostToDevice);

	
	
	// 32 data
	cudaStatus = cudaMemcpy(Mat_d.FIdxs, InMat.FIdxs, InMat.LognDepth*InMat.N* sizeof(MYDTYPE), cudaMemcpyHostToDevice);
	cudaStatus = cudaMemcpy(Mat_d.CompByLevel32, InMat.CompByLevel32, (Mat_d.Depth+1)*WARPSIZE*sizeof(MYDTYPE), cudaMemcpyHostToDevice);
	cudaStatus = cudaMemcpy(Mat_d.CompByFLevel32, InMat.CompByFLevel32, (Mat_d.Depth)*WARPSIZE*sizeof(MYDTYPE), cudaMemcpyHostToDevice);

	if (cudaStatus != cudaSuccess) {
		fprintf(stderr, "cudaMemcpyToDevice failed!");
		return cudaStatus;  
	}

	cudaStatus = cudaMalloc((void**)&PXOut_d, (InMat.N+1) * sizeof(MYFTYPE));
	cudaStatus = cudaMalloc((void**)&PFOut_d, (InMat.N+1) * sizeof(MYFTYPE));
	cudaStatus = cudaThreadSynchronize();
	if (cudaStatus != cudaSuccess) {
		fprintf(stderr, "cudaDeviceSynchronize returned error code %d after launching stEfork2TimeLoopGPU!\n", cudaStatus);
		return cudaStatus;
	}

	// A bit more
	/*MYFTYPE *d_d,*Iapp_d,*VHots_d,*dOrig_d,*V_d;

	cudaStatus = cudaMalloc((void**)&d_d, InMat.N * sizeof(MYFTYPE));
	cudaStatus = cudaMalloc((void**)&VHots_d, sim.Nt*NSTIMULI * sizeof(MYFTYPE*));
	cudaStatus = cudaMalloc((void**)&dOrig_d, InMat.N * sizeof(MYFTYPE));
	cudaStatus = cudaMalloc((void**)&V_d, InMat.N * sizeof(MYFTYPE));
	if (cudaStatus != cudaSuccess) {
		fprintf(stderr, "cudaMalloc failed!");
		return cudaStatus;  
	}*/
	MYFTYPE *V_d;
	cudaStatus = cudaMalloc((void**)&V_d, InMat.N * sizeof(MYFTYPE));

	//RRR  For model
	// allocation
	MYFTYPE *d_modelParams;
	cudaStatus = cudaMalloc((void**)&d_modelParams, NPARAMS * InMat.N * sizeof(MYFTYPE));
	if (cudaStatus != cudaSuccess) {
		fprintf(stderr, "cudaMalloc failed!");
		return cudaStatus;  
	}
	// copying
	MYFTYPE* ParamsForCuda;
	ParamsForCuda=(float*)malloc(InMat.N * NPARAMS *  sizeof(float));
	ReadParamsMatX(ParamsMat_FN,ParamsForCuda,NPARAMS,InMat.N);
	cudaStatus = cudaMemcpy(d_modelParams, ParamsForCuda, NPARAMS * InMat.N * sizeof(MYFTYPE), cudaMemcpyHostToDevice);
	
	cudaStatus = cudaMemcpy(V_d, V, InMat.N * sizeof(MYFTYPE), cudaMemcpyHostToDevice);
	if (cudaStatus != cudaSuccess) {
		fprintf(stderr, "cudaMemcpyToDevice failed!");
		return cudaStatus;  
	}

	dim3 blockDim(WARPSIZE,stim.NStimuli);
	dim3 gridDim(1,NNEURONS);

	MYDTYPE offset=0;
	offset+=InMat.N*sizeof(MYFTYPE);
	offset+=InMat.N*sizeof(MYFTYPE);
	offset+=InMat.N*sizeof(MYFTYPE);
	// 1 - e,f,Cms
	offset+=InMat.N*InMat.LognDepth*sizeof(MYDTYPE);
	offset+=InMat.N*sizeof(MYDTYPE);
	offset+=InMat.N*sizeof(MYDTYPE);
	// 2 FIdxs, Ks, boolModel
	offset+=InMat.nFathers*sizeof(MYDTYPE); // RelStarts
	offset+=InMat.nFathers*sizeof(MYDTYPE); // RelEnds
	offset+=InMat.nCallForFather*sizeof(MYDTYPE); // RelVec
	offset+=(InMat.nCallForFather+1)*sizeof(MYDTYPE); // SegStartI
	offset+=(InMat.nCallForFather+1)*sizeof(MYDTYPE); // SegEndI
	offset+=InMat.nFathers*sizeof(MYDTYPE); // Fathers
	// 3 RelStarts RelEnds RelVec SegStartI SegEndI Fathers
	offset+=WARPSIZE*(InMat.Depth+1)*sizeof(MYDTYPE);
	offset+=WARPSIZE*(InMat.Depth)*sizeof(MYDTYPE);
	// 4 CompByLevel32 CompByFLevel32
	
	offset=ceilf(float(offset)/sizeof(MYFTYPE))*sizeof(MYFTYPE);
	MYDTYPE FrameworkMemSize=offset;

	offset+=(InMat.N+2)*sizeof(MYFTYPE);  // uHP (Diag)
	offset+=(InMat.N+2)*sizeof(MYFTYPE); // bHP (rhs)
	offset+=InMat.N*sizeof(MYFTYPE); // Vs
	offset+=Nt*sizeof(MYFTYPE);//SMemVHot
	MYDTYPE PerStimulus=offset-FrameworkMemSize;
	
	MYDTYPE TotalSMem=FrameworkMemSize+PerStimulus*stim.NStimuli;
	printf("Asking %d bytes, %d+%d*%d\n",TotalSMem,FrameworkMemSize,PerStimulus,stim.NStimuli);
	stEfork2TimeLoopGPUKernel<<<gridDim, blockDim,TotalSMem>>>(stim_d, d_modelParams, sim, Mat_d, V_d,VHotsGlobal); // RRR

	cudaStatus = cudaThreadSynchronize();
	if (cudaStatus != cudaSuccess) {
		fprintf(stderr, "cudaDeviceSynchronize returned error code %d after launching stEfork2TimeLoopGPUKernel!\n", cudaStatus);
		return cudaStatus;
	}

	cudaStatus = cudaMemcpy(VHotsHost, VHotsGlobal, Nt * stim.NStimuli* sizeof(float), cudaMemcpyDeviceToHost); 

	if (cudaStatus != cudaSuccess) {
		fprintf(stderr, "cudaMemcpyDeviceToHost failed!");
		return cudaStatus;  
	}
	SaveArrayToFile(VHOT_OUT_FN_P,Nt*stim.NStimuli,VHotsHost);
	
	return cudaStatus;
}

cudaError_t stEfork2Main(Stim stim, Sim sim, MYFTYPE* ParamsM, HMat& InMat, float* V) {
	cudaError_t cudaStatus;

	clock_t begin,end;
	
	begin=clock();
	stEfork2TimeLoopGPU(stim, sim, ParamsM, InMat, V); //RRR sim
	end=clock();
	printf("stEfork2TimeLoopGPU took %g seconds\n",double(diffclock(end,begin)));
	


	return cudaStatus;
}
