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
#ifdef ILP5
	MYDTYPE PIdx_5=threadIdx.x+(WARPSIZE*4);
#endif
#ifdef ILP6
	MYDTYPE PIdx_6=threadIdx.x+(WARPSIZE*5);
#endif
#ifdef ILP7
	MYDTYPE PIdx_7=threadIdx.x+(WARPSIZE*6);
#endif
#ifdef ILP8
	MYDTYPE PIdx_8=threadIdx.x+(WARPSIZE*7);
#endif
#ifdef ILP9
	MYDTYPE PIdx_9=threadIdx.x+(WARPSIZE*8);
#endif
#ifdef ILP10
	MYDTYPE PIdx_10=threadIdx.x+(WARPSIZE*9);
#endif
#ifdef ILP11
	MYDTYPE PIdx_11=threadIdx.x+(WARPSIZE*10);
#endif
#ifdef ILP12
	MYDTYPE PIdx_12=threadIdx.x+(WARPSIZE*11);
#endif
#ifdef ILP13
	MYDTYPE PIdx_13=threadIdx.x+(WARPSIZE*12);
#endif
#ifdef ILP14
	MYDTYPE PIdx_14=threadIdx.x+(WARPSIZE*13);
#endif
#ifdef ILP15
	MYDTYPE PIdx_15=threadIdx.x+(WARPSIZE*14);
#endif
#ifdef ILP16
	MYDTYPE PIdx_16=threadIdx.x+(WARPSIZE*15);
#endif
#ifdef ILP17
	MYDTYPE PIdx_17=threadIdx.x+(WARPSIZE*16);
#endif
#ifdef ILP18
	MYDTYPE PIdx_18=threadIdx.x+(WARPSIZE*17);
#endif
#ifdef ILP19
	MYDTYPE PIdx_19=threadIdx.x+(WARPSIZE*18);
#endif
#ifdef ILP20
	MYDTYPE PIdx_20=threadIdx.x+(WARPSIZE*19);
#endif
#ifdef ILP21
	MYDTYPE PIdx_21=threadIdx.x+(WARPSIZE*20);
#endif
#ifdef ILP22
	MYDTYPE PIdx_22=threadIdx.x+(WARPSIZE*21);
#endif
#ifdef ILP23
	MYDTYPE PIdx_23=threadIdx.x+(WARPSIZE*22);
#endif
#ifdef ILP24
	MYDTYPE PIdx_24=threadIdx.x+(WARPSIZE*23);
#endif
#ifdef ILP25
	MYDTYPE PIdx_25=threadIdx.x+(WARPSIZE*24);
#endif
#ifdef ILP26
	MYDTYPE PIdx_26=threadIdx.x+(WARPSIZE*25);
#endif
#ifdef ILP27
	MYDTYPE PIdx_27=threadIdx.x+(WARPSIZE*26);
#endif
#ifdef ILP28
	MYDTYPE PIdx_28=threadIdx.x+(WARPSIZE*27);
#endif
#ifdef ILP29
	MYDTYPE PIdx_29=threadIdx.x+(WARPSIZE*28);
#endif
#ifdef ILP30
	MYDTYPE PIdx_30=threadIdx.x+(WARPSIZE*29);
#endif
#ifdef ILP31
	MYDTYPE PIdx_31=threadIdx.x+(WARPSIZE*30);
#endif
#ifdef ILP32
	MYDTYPE PIdx_32=threadIdx.x+(WARPSIZE*31);
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
#ifdef ILP5
	bHP[PIdx_5]=0; // might be useless?
#endif
#ifdef ILP6
	bHP[PIdx_6]=0; // might be useless?
#endif
#ifdef ILP7
	bHP[PIdx_7]=0; // might be useless?
#endif
#ifdef ILP8
	bHP[PIdx_8]=0; // might be useless?
#endif
#ifdef ILP9
	bHP[PIdx_9]=0; // might be useless?
#endif
#ifdef ILP10
	bHP[PIdx_10]=0; // might be useless?
#endif
#ifdef ILP11
	bHP[PIdx_11]=0; // might be useless?
#endif
#ifdef ILP12
	bHP[PIdx_12]=0; // might be useless?
#endif
#ifdef ILP13
	bHP[PIdx_13]=0; // might be useless?
#endif
#ifdef ILP14
	bHP[PIdx_14]=0; // might be useless?
#endif
#ifdef ILP15
	bHP[PIdx_15]=0; // might be useless?
#endif
#ifdef ILP16
	bHP[PIdx_16]=0; // might be useless?
#endif
#ifdef ILP17
	bHP[PIdx_17]=0; // might be useless?
#endif
#ifdef ILP18
	bHP[PIdx_18]=0; // might be useless?
#endif
#ifdef ILP19
	bHP[PIdx_19]=0; // might be useless?
#endif
#ifdef ILP20
	bHP[PIdx_20]=0; // might be useless?
#endif
#ifdef ILP21
	bHP[PIdx_21]=0; // might be useless?
#endif
#ifdef ILP22
	bHP[PIdx_22]=0; // might be useless?
#endif
#ifdef ILP23
	bHP[PIdx_23]=0; // might be useless?
#endif
#ifdef ILP24
	bHP[PIdx_24]=0; // might be useless?
#endif
#ifdef ILP25
	bHP[PIdx_25]=0; // might be useless?
#endif
#ifdef ILP26
	bHP[PIdx_26]=0; // might be useless?
#endif
#ifdef ILP27
	bHP[PIdx_27]=0; // might be useless?
#endif
#ifdef ILP28
	bHP[PIdx_28]=0; // might be useless?
#endif
#ifdef ILP29
	bHP[PIdx_29]=0; // might be useless?
#endif
#ifdef ILP30
	bHP[PIdx_30]=0; // might be useless?
#endif
#ifdef ILP31
	bHP[PIdx_31]=0; // might be useless?
#endif
#ifdef ILP32
	bHP[PIdx_32]=0; // might be useless?
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
#ifdef ILP5
	MYDTYPE PIdx_5=threadIdx.x+(WARPSIZE*4);
#endif
#ifdef ILP6
	MYDTYPE PIdx_6=threadIdx.x+(WARPSIZE*5);
#endif
#ifdef ILP7
	MYDTYPE PIdx_7=threadIdx.x+(WARPSIZE*6);
#endif
#ifdef ILP8
	MYDTYPE PIdx_8=threadIdx.x+(WARPSIZE*7);
#endif
#ifdef ILP9
	MYDTYPE PIdx_9=threadIdx.x+(WARPSIZE*8);
#endif
#ifdef ILP10
	MYDTYPE PIdx_10=threadIdx.x+(WARPSIZE*9);
#endif
#ifdef ILP11
	MYDTYPE PIdx_11=threadIdx.x+(WARPSIZE*10);
#endif
#ifdef ILP12
	MYDTYPE PIdx_12=threadIdx.x+(WARPSIZE*11);
#endif
#ifdef ILP13
	MYDTYPE PIdx_13=threadIdx.x+(WARPSIZE*12);
#endif
#ifdef ILP14
	MYDTYPE PIdx_14=threadIdx.x+(WARPSIZE*13);
#endif
#ifdef ILP15
	MYDTYPE PIdx_15=threadIdx.x+(WARPSIZE*14);
#endif
#ifdef ILP16
	MYDTYPE PIdx_16=threadIdx.x+(WARPSIZE*15);
#endif
#ifdef ILP17
	MYDTYPE PIdx_17=threadIdx.x+(WARPSIZE*16);
#endif
#ifdef ILP18
	MYDTYPE PIdx_18=threadIdx.x+(WARPSIZE*17);
#endif
#ifdef ILP19
	MYDTYPE PIdx_19=threadIdx.x+(WARPSIZE*18);
#endif
#ifdef ILP20
	MYDTYPE PIdx_20=threadIdx.x+(WARPSIZE*19);
#endif
#ifdef ILP21
	MYDTYPE PIdx_21=threadIdx.x+(WARPSIZE*20);
#endif
#ifdef ILP22
	MYDTYPE PIdx_22=threadIdx.x+(WARPSIZE*21);
#endif
#ifdef ILP23
	MYDTYPE PIdx_23=threadIdx.x+(WARPSIZE*22);
#endif
#ifdef ILP24
	MYDTYPE PIdx_24=threadIdx.x+(WARPSIZE*23);
#endif
#ifdef ILP25
	MYDTYPE PIdx_25=threadIdx.x+(WARPSIZE*24);
#endif
#ifdef ILP26
	MYDTYPE PIdx_26=threadIdx.x+(WARPSIZE*25);
#endif
#ifdef ILP27
	MYDTYPE PIdx_27=threadIdx.x+(WARPSIZE*26);
#endif
#ifdef ILP28
	MYDTYPE PIdx_28=threadIdx.x+(WARPSIZE*27);
#endif
#ifdef ILP29
	MYDTYPE PIdx_29=threadIdx.x+(WARPSIZE*28);
#endif
#ifdef ILP30
	MYDTYPE PIdx_30=threadIdx.x+(WARPSIZE*29);
#endif
#ifdef ILP31
	MYDTYPE PIdx_31=threadIdx.x+(WARPSIZE*30);
#endif
#ifdef ILP32
	MYDTYPE PIdx_32=threadIdx.x+(WARPSIZE*31);
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
#ifdef ILP5
	MYDTYPE NextID_5;
#endif
#ifdef ILP6
	MYDTYPE NextID_6;
#endif
#ifdef ILP7
	MYDTYPE NextID_7;
#endif
#ifdef ILP8
	MYDTYPE NextID_8;
#endif
#ifdef ILP9
	MYDTYPE NextID_9;
#endif
#ifdef ILP10
	MYDTYPE NextID_10;
#endif
#ifdef ILP11
	MYDTYPE NextID_11;
#endif
#ifdef ILP12
	MYDTYPE NextID_12;
#endif
#ifdef ILP13
	MYDTYPE NextID_13;
#endif
#ifdef ILP14
	MYDTYPE NextID_14;
#endif
#ifdef ILP15
	MYDTYPE NextID_15;
#endif
#ifdef ILP16
	MYDTYPE NextID_16;
#endif
#ifdef ILP17
	MYDTYPE NextID_17;
#endif
#ifdef ILP18
	MYDTYPE NextID_18;
#endif
#ifdef ILP19
	MYDTYPE NextID_19;
#endif
#ifdef ILP20
	MYDTYPE NextID_20;
#endif
#ifdef ILP21
	MYDTYPE NextID_21;
#endif
#ifdef ILP22
	MYDTYPE NextID_22;
#endif
#ifdef ILP23
	MYDTYPE NextID_23;
#endif
#ifdef ILP24
	MYDTYPE NextID_24;
#endif
#ifdef ILP25
	MYDTYPE NextID_25;
#endif
#ifdef ILP26
	MYDTYPE NextID_26;
#endif
#ifdef ILP27
	MYDTYPE NextID_27;
#endif
#ifdef ILP28
	MYDTYPE NextID_28;
#endif
#ifdef ILP29
	MYDTYPE NextID_29;
#endif
#ifdef ILP30
	MYDTYPE NextID_30;
#endif
#ifdef ILP31
	MYDTYPE NextID_31;
#endif
#ifdef ILP32
	MYDTYPE NextID_32;
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
#ifdef ILP5
	PX[PIdx_5]=PX[PIdx_5]/PF[PIdx_5];
#endif
#ifdef ILP6
	PX[PIdx_6]=PX[PIdx_6]/PF[PIdx_6];
#endif
#ifdef ILP7
	PX[PIdx_7]=PX[PIdx_7]/PF[PIdx_7];
#endif
#ifdef ILP8
	PX[PIdx_8]=PX[PIdx_8]/PF[PIdx_8];
#endif
#ifdef ILP9
	PX[PIdx_9]=PX[PIdx_9]/PF[PIdx_9];
#endif
#ifdef ILP10
	PX[PIdx_10]=PX[PIdx_10]/PF[PIdx_10];
#endif
#ifdef ILP11
	PX[PIdx_11]=PX[PIdx_11]/PF[PIdx_11];
#endif
#ifdef ILP12
	PX[PIdx_12]=PX[PIdx_12]/PF[PIdx_12];
#endif
#ifdef ILP13
	PX[PIdx_13]=PX[PIdx_13]/PF[PIdx_13];
#endif
#ifdef ILP14
	PX[PIdx_14]=PX[PIdx_14]/PF[PIdx_14];
#endif
#ifdef ILP15
	PX[PIdx_15]=PX[PIdx_15]/PF[PIdx_15];
#endif
#ifdef ILP16
	PX[PIdx_16]=PX[PIdx_16]/PF[PIdx_16];
#endif
#ifdef ILP17
	PX[PIdx_17]=PX[PIdx_17]/PF[PIdx_17];
#endif
#ifdef ILP18
	PX[PIdx_18]=PX[PIdx_18]/PF[PIdx_18];
#endif
#ifdef ILP19
	PX[PIdx_19]=PX[PIdx_19]/PF[PIdx_19];
#endif
#ifdef ILP20
	PX[PIdx_20]=PX[PIdx_20]/PF[PIdx_20];
#endif
#ifdef ILP21
	PX[PIdx_21]=PX[PIdx_21]/PF[PIdx_21];
#endif
#ifdef ILP22
	PX[PIdx_22]=PX[PIdx_22]/PF[PIdx_22];
#endif
#ifdef ILP23
	PX[PIdx_23]=PX[PIdx_23]/PF[PIdx_23];
#endif
#ifdef ILP24
	PX[PIdx_24]=PX[PIdx_24]/PF[PIdx_24];
#endif
#ifdef ILP25
	PX[PIdx_25]=PX[PIdx_25]/PF[PIdx_25];
#endif
#ifdef ILP26
	PX[PIdx_26]=PX[PIdx_26]/PF[PIdx_26];
#endif
#ifdef ILP27
	PX[PIdx_27]=PX[PIdx_27]/PF[PIdx_27];
#endif
#ifdef ILP28
	PX[PIdx_28]=PX[PIdx_28]/PF[PIdx_28];
#endif
#ifdef ILP29
	PX[PIdx_29]=PX[PIdx_29]/PF[PIdx_29];
#endif
#ifdef ILP30
	PX[PIdx_30]=PX[PIdx_30]/PF[PIdx_30];
#endif
#ifdef ILP31
	PX[PIdx_31]=PX[PIdx_31]/PF[PIdx_31];
#endif
#ifdef ILP32
	PX[PIdx_32]=PX[PIdx_32]/PF[PIdx_32];
#endif
	PF[PIdx]=-InMat.f[PIdx]/PF[PIdx];
	PF[PIdx_2]=-InMat.f[PIdx_2]/PF[PIdx_2];
#ifdef ILP3
	PF[PIdx_3]=-InMat.f[PIdx_3]/PF[PIdx_3];
#endif
#ifdef ILP4
	PF[PIdx_4]=-InMat.f[PIdx_4]/PF[PIdx_4];
#endif
#ifdef ILP5
	PF[PIdx_5]=-InMat.f[PIdx_5]/PF[PIdx_5];
#endif
#ifdef ILP6
	PF[PIdx_6]=-InMat.f[PIdx_6]/PF[PIdx_6];
#endif
#ifdef ILP7
	PF[PIdx_7]=-InMat.f[PIdx_7]/PF[PIdx_7];
#endif
#ifdef ILP8
	PF[PIdx_8]=-InMat.f[PIdx_8]/PF[PIdx_8];
#endif
#ifdef ILP9
	PF[PIdx_9]=-InMat.f[PIdx_9]/PF[PIdx_9];
#endif
#ifdef ILP10
	PF[PIdx_10]=-InMat.f[PIdx_10]/PF[PIdx_10];
#endif
#ifdef ILP11
	PF[PIdx_11]=-InMat.f[PIdx_11]/PF[PIdx_11];
#endif
#ifdef ILP12
	PF[PIdx_12]=-InMat.f[PIdx_12]/PF[PIdx_12];
#endif
#ifdef ILP13
	PF[PIdx_13]=-InMat.f[PIdx_13]/PF[PIdx_13];
#endif
#ifdef ILP14
	PF[PIdx_14]=-InMat.f[PIdx_14]/PF[PIdx_14];
#endif
#ifdef ILP15
	PF[PIdx_15]=-InMat.f[PIdx_15]/PF[PIdx_15];
#endif
#ifdef ILP16
	PF[PIdx_16]=-InMat.f[PIdx_16]/PF[PIdx_16];
#endif
#ifdef ILP17
	PF[PIdx_17]=-InMat.f[PIdx_17]/PF[PIdx_17];
#endif
#ifdef ILP18
	PF[PIdx_18]=-InMat.f[PIdx_18]/PF[PIdx_18];
#endif
#ifdef ILP19
	PF[PIdx_19]=-InMat.f[PIdx_19]/PF[PIdx_19];
#endif
#ifdef ILP20
	PF[PIdx_20]=-InMat.f[PIdx_20]/PF[PIdx_20];
#endif
#ifdef ILP21
	PF[PIdx_21]=-InMat.f[PIdx_21]/PF[PIdx_21];
#endif
#ifdef ILP22
	PF[PIdx_22]=-InMat.f[PIdx_22]/PF[PIdx_22];
#endif
#ifdef ILP23
	PF[PIdx_23]=-InMat.f[PIdx_23]/PF[PIdx_23];
#endif
#ifdef ILP24
	PF[PIdx_24]=-InMat.f[PIdx_24]/PF[PIdx_24];
#endif
#ifdef ILP25
	PF[PIdx_25]=-InMat.f[PIdx_25]/PF[PIdx_25];
#endif
#ifdef ILP26
	PF[PIdx_26]=-InMat.f[PIdx_26]/PF[PIdx_26];
#endif
#ifdef ILP27
	PF[PIdx_27]=-InMat.f[PIdx_27]/PF[PIdx_27];
#endif
#ifdef ILP28
	PF[PIdx_28]=-InMat.f[PIdx_28]/PF[PIdx_28];
#endif
#ifdef ILP29
	PF[PIdx_29]=-InMat.f[PIdx_29]/PF[PIdx_29];
#endif
#ifdef ILP30
	PF[PIdx_30]=-InMat.f[PIdx_30]/PF[PIdx_30];
#endif
#ifdef ILP31
	PF[PIdx_31]=-InMat.f[PIdx_31]/PF[PIdx_31];
#endif
#ifdef ILP32
	PF[PIdx_32]=-InMat.f[PIdx_32]/PF[PIdx_32];
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
#ifdef ILP5
		NextID_5=InMat.FIdxs[i*InMat.N+PIdx_5]-1;
#endif
#ifdef ILP6
		NextID_6=InMat.FIdxs[i*InMat.N+PIdx_6]-1;
#endif
#ifdef ILP7
		NextID_7=InMat.FIdxs[i*InMat.N+PIdx_7]-1;
#endif
#ifdef ILP8
		NextID_8=InMat.FIdxs[i*InMat.N+PIdx_8]-1;
#endif
#ifdef ILP9
		NextID_9=InMat.FIdxs[i*InMat.N+PIdx_9]-1;
#endif
#ifdef ILP10
		NextID_10=InMat.FIdxs[i*InMat.N+PIdx_10]-1;
#endif
#ifdef ILP11
		NextID_11=InMat.FIdxs[i*InMat.N+PIdx_11]-1;
#endif
#ifdef ILP12
		NextID_12=InMat.FIdxs[i*InMat.N+PIdx_12]-1;
#endif
#ifdef ILP13
		NextID_13=InMat.FIdxs[i*InMat.N+PIdx_13]-1;
#endif
#ifdef ILP14
		NextID_14=InMat.FIdxs[i*InMat.N+PIdx_14]-1;
#endif
#ifdef ILP15
		NextID_15=InMat.FIdxs[i*InMat.N+PIdx_15]-1;
#endif
#ifdef ILP16
		NextID_16=InMat.FIdxs[i*InMat.N+PIdx_16]-1;
#endif
#ifdef ILP17
		NextID_17=InMat.FIdxs[i*InMat.N+PIdx_17]-1;
#endif
#ifdef ILP18
		NextID_18=InMat.FIdxs[i*InMat.N+PIdx_18]-1;
#endif
#ifdef ILP19
		NextID_19=InMat.FIdxs[i*InMat.N+PIdx_19]-1;
#endif
#ifdef ILP20
		NextID_20=InMat.FIdxs[i*InMat.N+PIdx_20]-1;
#endif
#ifdef ILP21
		NextID_21=InMat.FIdxs[i*InMat.N+PIdx_21]-1;
#endif
#ifdef ILP22
		NextID_22=InMat.FIdxs[i*InMat.N+PIdx_22]-1;
#endif
#ifdef ILP23
		NextID_23=InMat.FIdxs[i*InMat.N+PIdx_23]-1;
#endif
#ifdef ILP24
		NextID_24=InMat.FIdxs[i*InMat.N+PIdx_24]-1;
#endif
#ifdef ILP25
		NextID_25=InMat.FIdxs[i*InMat.N+PIdx_25]-1;
#endif
#ifdef ILP26
		NextID_26=InMat.FIdxs[i*InMat.N+PIdx_26]-1;
#endif
#ifdef ILP27
		NextID_27=InMat.FIdxs[i*InMat.N+PIdx_27]-1;
#endif
#ifdef ILP28
		NextID_28=InMat.FIdxs[i*InMat.N+PIdx_28]-1;
#endif
#ifdef ILP29
		NextID_29=InMat.FIdxs[i*InMat.N+PIdx_29]-1;
#endif
#ifdef ILP30
		NextID_30=InMat.FIdxs[i*InMat.N+PIdx_30]-1;
#endif
#ifdef ILP31
		NextID_31=InMat.FIdxs[i*InMat.N+PIdx_31]-1;
#endif
#ifdef ILP32
		NextID_32=InMat.FIdxs[i*InMat.N+PIdx_32]-1;
#endif
		MYFTYPE OldPXj=PX[PIdx];
		MYFTYPE OldPXj_2=PX[PIdx_2];
#ifdef ILP3
		MYFTYPE OldPXj_3=PX[PIdx_3];
#endif
#ifdef ILP4
		MYFTYPE OldPXj_4=PX[PIdx_4];
#endif
#ifdef ILP5
		MYFTYPE OldPXj_5=PX[PIdx_5];
#endif
#ifdef ILP6
		MYFTYPE OldPXj_6=PX[PIdx_6];
#endif
#ifdef ILP7
		MYFTYPE OldPXj_7=PX[PIdx_7];
#endif
#ifdef ILP8
		MYFTYPE OldPXj_8=PX[PIdx_8];
#endif
#ifdef ILP9
		MYFTYPE OldPXj_9=PX[PIdx_9];
#endif
#ifdef ILP10
		MYFTYPE OldPXj_10=PX[PIdx_10];
#endif
#ifdef ILP11
		MYFTYPE OldPXj_11=PX[PIdx_11];
#endif
#ifdef ILP12
		MYFTYPE OldPXj_12=PX[PIdx_12];
#endif
#ifdef ILP13
		MYFTYPE OldPXj_13=PX[PIdx_13];
#endif
#ifdef ILP14
		MYFTYPE OldPXj_14=PX[PIdx_14];
#endif
#ifdef ILP15
		MYFTYPE OldPXj_15=PX[PIdx_15];
#endif
#ifdef ILP16
		MYFTYPE OldPXj_16=PX[PIdx_16];
#endif
#ifdef ILP17
		MYFTYPE OldPXj_17=PX[PIdx_17];
#endif
#ifdef ILP18
		MYFTYPE OldPXj_18=PX[PIdx_18];
#endif
#ifdef ILP19
		MYFTYPE OldPXj_19=PX[PIdx_19];
#endif
#ifdef ILP20
		MYFTYPE OldPXj_20=PX[PIdx_20];
#endif
#ifdef ILP21
		MYFTYPE OldPXj_21=PX[PIdx_21];
#endif
#ifdef ILP22
		MYFTYPE OldPXj_22=PX[PIdx_22];
#endif
#ifdef ILP23
		MYFTYPE OldPXj_23=PX[PIdx_23];
#endif
#ifdef ILP24
		MYFTYPE OldPXj_24=PX[PIdx_24];
#endif
#ifdef ILP25
		MYFTYPE OldPXj_25=PX[PIdx_25];
#endif
#ifdef ILP26
		MYFTYPE OldPXj_26=PX[PIdx_26];
#endif
#ifdef ILP27
		MYFTYPE OldPXj_27=PX[PIdx_27];
#endif
#ifdef ILP28
		MYFTYPE OldPXj_28=PX[PIdx_28];
#endif
#ifdef ILP29
		MYFTYPE OldPXj_29=PX[PIdx_29];
#endif
#ifdef ILP30
		MYFTYPE OldPXj_30=PX[PIdx_30];
#endif
#ifdef ILP31
		MYFTYPE OldPXj_31=PX[PIdx_31];
#endif
#ifdef ILP32
		MYFTYPE OldPXj_32=PX[PIdx_32];
#endif
		MYFTYPE OldPXNextID=PX[NextID];
		MYFTYPE OldPXNextID_2=PX[NextID_2];
#ifdef ILP3
		MYFTYPE OldPXNextID_3=PX[NextID_3];
#endif
#ifdef ILP4
		MYFTYPE OldPXNextID_4=PX[NextID_4];
#endif
#ifdef ILP5
		MYFTYPE OldPXNextID_5=PX[NextID_5];
#endif
#ifdef ILP6
		MYFTYPE OldPXNextID_6=PX[NextID_6];
#endif
#ifdef ILP7
		MYFTYPE OldPXNextID_7=PX[NextID_7];
#endif
#ifdef ILP8
		MYFTYPE OldPXNextID_8=PX[NextID_8];
#endif
#ifdef ILP9
		MYFTYPE OldPXNextID_9=PX[NextID_9];
#endif
#ifdef ILP10
		MYFTYPE OldPXNextID_10=PX[NextID_10];
#endif
#ifdef ILP11
		MYFTYPE OldPXNextID_11=PX[NextID_11];
#endif
#ifdef ILP12
		MYFTYPE OldPXNextID_12=PX[NextID_12];
#endif
#ifdef ILP13
		MYFTYPE OldPXNextID_13=PX[NextID_13];
#endif
#ifdef ILP14
		MYFTYPE OldPXNextID_14=PX[NextID_14];
#endif
#ifdef ILP15
		MYFTYPE OldPXNextID_15=PX[NextID_15];
#endif
#ifdef ILP16
		MYFTYPE OldPXNextID_16=PX[NextID_16];
#endif
#ifdef ILP17
		MYFTYPE OldPXNextID_17=PX[NextID_17];
#endif
#ifdef ILP18
		MYFTYPE OldPXNextID_18=PX[NextID_18];
#endif
#ifdef ILP19
		MYFTYPE OldPXNextID_19=PX[NextID_19];
#endif
#ifdef ILP20
		MYFTYPE OldPXNextID_20=PX[NextID_20];
#endif
#ifdef ILP21
		MYFTYPE OldPXNextID_21=PX[NextID_21];
#endif
#ifdef ILP22
		MYFTYPE OldPXNextID_22=PX[NextID_22];
#endif
#ifdef ILP23
		MYFTYPE OldPXNextID_23=PX[NextID_23];
#endif
#ifdef ILP24
		MYFTYPE OldPXNextID_24=PX[NextID_24];
#endif
#ifdef ILP25
		MYFTYPE OldPXNextID_25=PX[NextID_25];
#endif
#ifdef ILP26
		MYFTYPE OldPXNextID_26=PX[NextID_26];
#endif
#ifdef ILP27
		MYFTYPE OldPXNextID_27=PX[NextID_27];
#endif
#ifdef ILP28
		MYFTYPE OldPXNextID_28=PX[NextID_28];
#endif
#ifdef ILP29
		MYFTYPE OldPXNextID_29=PX[NextID_29];
#endif
#ifdef ILP30
		MYFTYPE OldPXNextID_30=PX[NextID_30];
#endif
#ifdef ILP31
		MYFTYPE OldPXNextID_31=PX[NextID_31];
#endif
#ifdef ILP32
		MYFTYPE OldPXNextID_32=PX[NextID_32];
#endif
		PX[PIdx]=OldPXj+OldPXNextID*PF[PIdx];
		PX[PIdx_2]=OldPXj_2+OldPXNextID_2*PF[PIdx_2];
#ifdef ILP3
		PX[PIdx_3]=OldPXj_3+OldPXNextID_3*PF[PIdx_3];
#endif
#ifdef ILP4
		PX[PIdx_4]=OldPXj_4+OldPXNextID_4*PF[PIdx_4];
#endif
#ifdef ILP5
		PX[PIdx_5]=OldPXj_5+OldPXNextID_5*PF[PIdx_5];
#endif
#ifdef ILP6
		PX[PIdx_6]=OldPXj_6+OldPXNextID_6*PF[PIdx_6];
#endif
#ifdef ILP7
		PX[PIdx_7]=OldPXj_7+OldPXNextID_7*PF[PIdx_7];
#endif
#ifdef ILP8
		PX[PIdx_8]=OldPXj_8+OldPXNextID_8*PF[PIdx_8];
#endif
#ifdef ILP9
		PX[PIdx_9]=OldPXj_9+OldPXNextID_9*PF[PIdx_9];
#endif
#ifdef ILP10
		PX[PIdx_10]=OldPXj_10+OldPXNextID_10*PF[PIdx_10];
#endif
#ifdef ILP11
		PX[PIdx_11]=OldPXj_11+OldPXNextID_11*PF[PIdx_11];
#endif
#ifdef ILP12
		PX[PIdx_12]=OldPXj_12+OldPXNextID_12*PF[PIdx_12];
#endif
#ifdef ILP13
		PX[PIdx_13]=OldPXj_13+OldPXNextID_13*PF[PIdx_13];
#endif
#ifdef ILP14
		PX[PIdx_14]=OldPXj_14+OldPXNextID_14*PF[PIdx_14];
#endif
#ifdef ILP15
		PX[PIdx_15]=OldPXj_15+OldPXNextID_15*PF[PIdx_15];
#endif
#ifdef ILP16
		PX[PIdx_16]=OldPXj_16+OldPXNextID_16*PF[PIdx_16];
#endif
#ifdef ILP17
		PX[PIdx_17]=OldPXj_17+OldPXNextID_17*PF[PIdx_17];
#endif
#ifdef ILP18
		PX[PIdx_18]=OldPXj_18+OldPXNextID_18*PF[PIdx_18];
#endif
#ifdef ILP19
		PX[PIdx_19]=OldPXj_19+OldPXNextID_19*PF[PIdx_19];
#endif
#ifdef ILP20
		PX[PIdx_20]=OldPXj_20+OldPXNextID_20*PF[PIdx_20];
#endif
#ifdef ILP21
		PX[PIdx_21]=OldPXj_21+OldPXNextID_21*PF[PIdx_21];
#endif
#ifdef ILP22
		PX[PIdx_22]=OldPXj_22+OldPXNextID_22*PF[PIdx_22];
#endif
#ifdef ILP23
		PX[PIdx_23]=OldPXj_23+OldPXNextID_23*PF[PIdx_23];
#endif
#ifdef ILP24
		PX[PIdx_24]=OldPXj_24+OldPXNextID_24*PF[PIdx_24];
#endif
#ifdef ILP25
		PX[PIdx_25]=OldPXj_25+OldPXNextID_25*PF[PIdx_25];
#endif
#ifdef ILP26
		PX[PIdx_26]=OldPXj_26+OldPXNextID_26*PF[PIdx_26];
#endif
#ifdef ILP27
		PX[PIdx_27]=OldPXj_27+OldPXNextID_27*PF[PIdx_27];
#endif
#ifdef ILP28
		PX[PIdx_28]=OldPXj_28+OldPXNextID_28*PF[PIdx_28];
#endif
#ifdef ILP29
		PX[PIdx_29]=OldPXj_29+OldPXNextID_29*PF[PIdx_29];
#endif
#ifdef ILP30
		PX[PIdx_30]=OldPXj_30+OldPXNextID_30*PF[PIdx_30];
#endif
#ifdef ILP31
		PX[PIdx_31]=OldPXj_31+OldPXNextID_31*PF[PIdx_31];
#endif
#ifdef ILP32
		PX[PIdx_32]=OldPXj_32+OldPXNextID_32*PF[PIdx_32];
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
#ifdef ILP5
		MYFTYPE OldPFj_5=PF[PIdx_5];
#endif
#ifdef ILP6
		MYFTYPE OldPFj_6=PF[PIdx_6];
#endif
#ifdef ILP7
		MYFTYPE OldPFj_7=PF[PIdx_7];
#endif
#ifdef ILP8
		MYFTYPE OldPFj_8=PF[PIdx_8];
#endif
#ifdef ILP9
		MYFTYPE OldPFj_9=PF[PIdx_9];
#endif
#ifdef ILP10
		MYFTYPE OldPFj_10=PF[PIdx_10];
#endif
#ifdef ILP11
		MYFTYPE OldPFj_11=PF[PIdx_11];
#endif
#ifdef ILP12
		MYFTYPE OldPFj_12=PF[PIdx_12];
#endif
#ifdef ILP13
		MYFTYPE OldPFj_13=PF[PIdx_13];
#endif
#ifdef ILP14
		MYFTYPE OldPFj_14=PF[PIdx_14];
#endif
#ifdef ILP15
		MYFTYPE OldPFj_15=PF[PIdx_15];
#endif
#ifdef ILP16
		MYFTYPE OldPFj_16=PF[PIdx_16];
#endif
#ifdef ILP17
		MYFTYPE OldPFj_17=PF[PIdx_17];
#endif
#ifdef ILP18
		MYFTYPE OldPFj_18=PF[PIdx_18];
#endif
#ifdef ILP19
		MYFTYPE OldPFj_19=PF[PIdx_19];
#endif
#ifdef ILP20
		MYFTYPE OldPFj_20=PF[PIdx_20];
#endif
#ifdef ILP21
		MYFTYPE OldPFj_21=PF[PIdx_21];
#endif
#ifdef ILP22
		MYFTYPE OldPFj_22=PF[PIdx_22];
#endif
#ifdef ILP23
		MYFTYPE OldPFj_23=PF[PIdx_23];
#endif
#ifdef ILP24
		MYFTYPE OldPFj_24=PF[PIdx_24];
#endif
#ifdef ILP25
		MYFTYPE OldPFj_25=PF[PIdx_25];
#endif
#ifdef ILP26
		MYFTYPE OldPFj_26=PF[PIdx_26];
#endif
#ifdef ILP27
		MYFTYPE OldPFj_27=PF[PIdx_27];
#endif
#ifdef ILP28
		MYFTYPE OldPFj_28=PF[PIdx_28];
#endif
#ifdef ILP29
		MYFTYPE OldPFj_29=PF[PIdx_29];
#endif
#ifdef ILP30
		MYFTYPE OldPFj_30=PF[PIdx_30];
#endif
#ifdef ILP31
		MYFTYPE OldPFj_31=PF[PIdx_31];
#endif
#ifdef ILP32
		MYFTYPE OldPFj_32=PF[PIdx_32];
#endif
		MYFTYPE OldPFNextID=PF[NextID];
		MYFTYPE OldPFNextID_2=PF[NextID_2];
#ifdef ILP3
		MYFTYPE OldPFNextID_3=PF[NextID_3];
#endif
#ifdef ILP4
		MYFTYPE OldPFNextID_4=PF[NextID_4];
#endif
#ifdef ILP5
		MYFTYPE OldPFNextID_5=PF[NextID_5];
#endif
#ifdef ILP6
		MYFTYPE OldPFNextID_6=PF[NextID_6];
#endif
#ifdef ILP7
		MYFTYPE OldPFNextID_7=PF[NextID_7];
#endif
#ifdef ILP8
		MYFTYPE OldPFNextID_8=PF[NextID_8];
#endif
#ifdef ILP9
		MYFTYPE OldPFNextID_9=PF[NextID_9];
#endif
#ifdef ILP10
		MYFTYPE OldPFNextID_10=PF[NextID_10];
#endif
#ifdef ILP11
		MYFTYPE OldPFNextID_11=PF[NextID_11];
#endif
#ifdef ILP12
		MYFTYPE OldPFNextID_12=PF[NextID_12];
#endif
#ifdef ILP13
		MYFTYPE OldPFNextID_13=PF[NextID_13];
#endif
#ifdef ILP14
		MYFTYPE OldPFNextID_14=PF[NextID_14];
#endif
#ifdef ILP15
		MYFTYPE OldPFNextID_15=PF[NextID_15];
#endif
#ifdef ILP16
		MYFTYPE OldPFNextID_16=PF[NextID_16];
#endif
#ifdef ILP17
		MYFTYPE OldPFNextID_17=PF[NextID_17];
#endif
#ifdef ILP18
		MYFTYPE OldPFNextID_18=PF[NextID_18];
#endif
#ifdef ILP19
		MYFTYPE OldPFNextID_19=PF[NextID_19];
#endif
#ifdef ILP20
		MYFTYPE OldPFNextID_20=PF[NextID_20];
#endif
#ifdef ILP21
		MYFTYPE OldPFNextID_21=PF[NextID_21];
#endif
#ifdef ILP22
		MYFTYPE OldPFNextID_22=PF[NextID_22];
#endif
#ifdef ILP23
		MYFTYPE OldPFNextID_23=PF[NextID_23];
#endif
#ifdef ILP24
		MYFTYPE OldPFNextID_24=PF[NextID_24];
#endif
#ifdef ILP25
		MYFTYPE OldPFNextID_25=PF[NextID_25];
#endif
#ifdef ILP26
		MYFTYPE OldPFNextID_26=PF[NextID_26];
#endif
#ifdef ILP27
		MYFTYPE OldPFNextID_27=PF[NextID_27];
#endif
#ifdef ILP28
		MYFTYPE OldPFNextID_28=PF[NextID_28];
#endif
#ifdef ILP29
		MYFTYPE OldPFNextID_29=PF[NextID_29];
#endif
#ifdef ILP30
		MYFTYPE OldPFNextID_30=PF[NextID_30];
#endif
#ifdef ILP31
		MYFTYPE OldPFNextID_31=PF[NextID_31];
#endif
#ifdef ILP32
		MYFTYPE OldPFNextID_32=PF[NextID_32];
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
#ifdef ILP5
		PF[PIdx_5]=OldPFj_5*OldPFNextID_5;
#endif
#ifdef ILP6
		PF[PIdx_6]=OldPFj_6*OldPFNextID_6;
#endif
#ifdef ILP7
		PF[PIdx_7]=OldPFj_7*OldPFNextID_7;
#endif
#ifdef ILP8
		PF[PIdx_8]=OldPFj_8*OldPFNextID_8;
#endif
#ifdef ILP9
		PF[PIdx_9]=OldPFj_9*OldPFNextID_9;
#endif
#ifdef ILP10
		PF[PIdx_10]=OldPFj_10*OldPFNextID_10;
#endif
#ifdef ILP11
		PF[PIdx_11]=OldPFj_11*OldPFNextID_11;
#endif
#ifdef ILP12
		PF[PIdx_12]=OldPFj_12*OldPFNextID_12;
#endif
#ifdef ILP13
		PF[PIdx_13]=OldPFj_13*OldPFNextID_13;
#endif
#ifdef ILP14
		PF[PIdx_14]=OldPFj_14*OldPFNextID_14;
#endif
#ifdef ILP15
		PF[PIdx_15]=OldPFj_15*OldPFNextID_15;
#endif
#ifdef ILP16
		PF[PIdx_16]=OldPFj_16*OldPFNextID_16;
#endif
#ifdef ILP17
		PF[PIdx_17]=OldPFj_17*OldPFNextID_17;
#endif
#ifdef ILP18
		PF[PIdx_18]=OldPFj_18*OldPFNextID_18;
#endif
#ifdef ILP19
		PF[PIdx_19]=OldPFj_19*OldPFNextID_19;
#endif
#ifdef ILP20
		PF[PIdx_20]=OldPFj_20*OldPFNextID_20;
#endif
#ifdef ILP21
		PF[PIdx_21]=OldPFj_21*OldPFNextID_21;
#endif
#ifdef ILP22
		PF[PIdx_22]=OldPFj_22*OldPFNextID_22;
#endif
#ifdef ILP23
		PF[PIdx_23]=OldPFj_23*OldPFNextID_23;
#endif
#ifdef ILP24
		PF[PIdx_24]=OldPFj_24*OldPFNextID_24;
#endif
#ifdef ILP25
		PF[PIdx_25]=OldPFj_25*OldPFNextID_25;
#endif
#ifdef ILP26
		PF[PIdx_26]=OldPFj_26*OldPFNextID_26;
#endif
#ifdef ILP27
		PF[PIdx_27]=OldPFj_27*OldPFNextID_27;
#endif
#ifdef ILP28
		PF[PIdx_28]=OldPFj_28*OldPFNextID_28;
#endif
#ifdef ILP29
		PF[PIdx_29]=OldPFj_29*OldPFNextID_29;
#endif
#ifdef ILP30
		PF[PIdx_30]=OldPFj_30*OldPFNextID_30;
#endif
#ifdef ILP31
		PF[PIdx_31]=OldPFj_31*OldPFNextID_31;
#endif
#ifdef ILP32
		PF[PIdx_32]=OldPFj_32*OldPFNextID_32;
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
#ifdef ILP5
	MYDTYPE PIdx_5=threadIdx.x+(WARPSIZE*4);
#endif
#ifdef ILP6
	MYDTYPE PIdx_6=threadIdx.x+(WARPSIZE*5);
#endif
#ifdef ILP7
	MYDTYPE PIdx_7=threadIdx.x+(WARPSIZE*6);
#endif
#ifdef ILP8
	MYDTYPE PIdx_8=threadIdx.x+(WARPSIZE*7);
#endif
#ifdef ILP9
	MYDTYPE PIdx_9=threadIdx.x+(WARPSIZE*8);
#endif
#ifdef ILP10
	MYDTYPE PIdx_10=threadIdx.x+(WARPSIZE*9);
#endif
#ifdef ILP11
	MYDTYPE PIdx_11=threadIdx.x+(WARPSIZE*10);
#endif
#ifdef ILP12
	MYDTYPE PIdx_12=threadIdx.x+(WARPSIZE*11);
#endif
#ifdef ILP13
	MYDTYPE PIdx_13=threadIdx.x+(WARPSIZE*12);
#endif
#ifdef ILP14
	MYDTYPE PIdx_14=threadIdx.x+(WARPSIZE*13);
#endif
#ifdef ILP15
	MYDTYPE PIdx_15=threadIdx.x+(WARPSIZE*14);
#endif
#ifdef ILP16
	MYDTYPE PIdx_16=threadIdx.x+(WARPSIZE*15);
#endif
#ifdef ILP17
	MYDTYPE PIdx_17=threadIdx.x+(WARPSIZE*16);
#endif
#ifdef ILP18
	MYDTYPE PIdx_18=threadIdx.x+(WARPSIZE*17);
#endif
#ifdef ILP19
	MYDTYPE PIdx_19=threadIdx.x+(WARPSIZE*18);
#endif
#ifdef ILP20
	MYDTYPE PIdx_20=threadIdx.x+(WARPSIZE*19);
#endif
#ifdef ILP21
	MYDTYPE PIdx_21=threadIdx.x+(WARPSIZE*20);
#endif
#ifdef ILP22
	MYDTYPE PIdx_22=threadIdx.x+(WARPSIZE*21);
#endif
#ifdef ILP23
	MYDTYPE PIdx_23=threadIdx.x+(WARPSIZE*22);
#endif
#ifdef ILP24
	MYDTYPE PIdx_24=threadIdx.x+(WARPSIZE*23);
#endif
#ifdef ILP25
	MYDTYPE PIdx_25=threadIdx.x+(WARPSIZE*24);
#endif
#ifdef ILP26
	MYDTYPE PIdx_26=threadIdx.x+(WARPSIZE*25);
#endif
#ifdef ILP27
	MYDTYPE PIdx_27=threadIdx.x+(WARPSIZE*26);
#endif
#ifdef ILP28
	MYDTYPE PIdx_28=threadIdx.x+(WARPSIZE*27);
#endif
#ifdef ILP29
	MYDTYPE PIdx_29=threadIdx.x+(WARPSIZE*28);
#endif
#ifdef ILP30
	MYDTYPE PIdx_30=threadIdx.x+(WARPSIZE*29);
#endif
#ifdef ILP31
	MYDTYPE PIdx_31=threadIdx.x+(WARPSIZE*30);
#endif
#ifdef ILP32
	MYDTYPE PIdx_32=threadIdx.x+(WARPSIZE*31);
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
#ifdef ILP5
	MYFTYPE isModel_5, dVec_5, Vmid_5;
#endif
#ifdef ILP6
	MYFTYPE isModel_6, dVec_6, Vmid_6;
#endif
#ifdef ILP7
	MYFTYPE isModel_7, dVec_7, Vmid_7;
#endif
#ifdef ILP8
	MYFTYPE isModel_8, dVec_8, Vmid_8;
#endif
#ifdef ILP9
	MYFTYPE isModel_9, dVec_9, Vmid_9;
#endif
#ifdef ILP10
	MYFTYPE isModel_10, dVec_10, Vmid_10;
#endif
#ifdef ILP11
	MYFTYPE isModel_11, dVec_11, Vmid_11;
#endif
#ifdef ILP12
	MYFTYPE isModel_12, dVec_12, Vmid_12;
#endif
#ifdef ILP13
	MYFTYPE isModel_13, dVec_13, Vmid_13;
#endif
#ifdef ILP14
	MYFTYPE isModel_14, dVec_14, Vmid_14;
#endif
#ifdef ILP15
	MYFTYPE isModel_15, dVec_15, Vmid_15;
#endif
#ifdef ILP16
	MYFTYPE isModel_16, dVec_16, Vmid_16;
#endif
#ifdef ILP17
	MYFTYPE isModel_17, dVec_17, Vmid_17;
#endif
#ifdef ILP18
	MYFTYPE isModel_18, dVec_18, Vmid_18;
#endif
#ifdef ILP19
	MYFTYPE isModel_19, dVec_19, Vmid_19;
#endif
#ifdef ILP20
	MYFTYPE isModel_20, dVec_20, Vmid_20;
#endif
#ifdef ILP21
	MYFTYPE isModel_21, dVec_21, Vmid_21;
#endif
#ifdef ILP22
	MYFTYPE isModel_22, dVec_22, Vmid_22;
#endif
#ifdef ILP23
	MYFTYPE isModel_23, dVec_23, Vmid_23;
#endif
#ifdef ILP24
	MYFTYPE isModel_24, dVec_24, Vmid_24;
#endif
#ifdef ILP25
	MYFTYPE isModel_25, dVec_25, Vmid_25;
#endif
#ifdef ILP26
	MYFTYPE isModel_26, dVec_26, Vmid_26;
#endif
#ifdef ILP27
	MYFTYPE isModel_27, dVec_27, Vmid_27;
#endif
#ifdef ILP28
	MYFTYPE isModel_28, dVec_28, Vmid_28;
#endif
#ifdef ILP29
	MYFTYPE isModel_29, dVec_29, Vmid_29;
#endif
#ifdef ILP30
	MYFTYPE isModel_30, dVec_30, Vmid_30;
#endif
#ifdef ILP31
	MYFTYPE isModel_31, dVec_31, Vmid_31;
#endif
#ifdef ILP32
	MYFTYPE isModel_32, dVec_32, Vmid_32;
#endif
	MYFTYPE ModelStates[NSTATES];
	MYFTYPE ModelStates_2[NSTATES];
#ifdef ILP3
	MYFTYPE ModelStates_3[NSTATES];
#endif
#ifdef ILP4
	MYFTYPE ModelStates_4[NSTATES];
#endif
#ifdef ILP5
	MYFTYPE ModelStates_5[NSTATES];
#endif
#ifdef ILP6
	MYFTYPE ModelStates_6[NSTATES];
#endif
#ifdef ILP7
	MYFTYPE ModelStates_7[NSTATES];
#endif
#ifdef ILP8
	MYFTYPE ModelStates_8[NSTATES];
#endif
#ifdef ILP9
	MYFTYPE ModelStates_9[NSTATES];
#endif
#ifdef ILP10
	MYFTYPE ModelStates_10[NSTATES];
#endif
#ifdef ILP11
	MYFTYPE ModelStates_11[NSTATES];
#endif
#ifdef ILP12
	MYFTYPE ModelStates_12[NSTATES];
#endif
#ifdef ILP13
	MYFTYPE ModelStates_13[NSTATES];
#endif
#ifdef ILP14
	MYFTYPE ModelStates_14[NSTATES];
#endif
#ifdef ILP15
	MYFTYPE ModelStates_15[NSTATES];
#endif
#ifdef ILP16
	MYFTYPE ModelStates_16[NSTATES];
#endif
#ifdef ILP17
	MYFTYPE ModelStates_17[NSTATES];
#endif
#ifdef ILP18
	MYFTYPE ModelStates_18[NSTATES];
#endif
#ifdef ILP19
	MYFTYPE ModelStates_19[NSTATES];
#endif
#ifdef ILP20
	MYFTYPE ModelStates_20[NSTATES];
#endif
#ifdef ILP21
	MYFTYPE ModelStates_21[NSTATES];
#endif
#ifdef ILP22
	MYFTYPE ModelStates_22[NSTATES];
#endif
#ifdef ILP23
	MYFTYPE ModelStates_23[NSTATES];
#endif
#ifdef ILP24
	MYFTYPE ModelStates_24[NSTATES];
#endif
#ifdef ILP25
	MYFTYPE ModelStates_25[NSTATES];
#endif
#ifdef ILP26
	MYFTYPE ModelStates_26[NSTATES];
#endif
#ifdef ILP27
	MYFTYPE ModelStates_27[NSTATES];
#endif
#ifdef ILP28
	MYFTYPE ModelStates_28[NSTATES];
#endif
#ifdef ILP29
	MYFTYPE ModelStates_29[NSTATES];
#endif
#ifdef ILP30
	MYFTYPE ModelStates_30[NSTATES];
#endif
#ifdef ILP31
	MYFTYPE ModelStates_31[NSTATES];
#endif
#ifdef ILP32
	MYFTYPE ModelStates_32[NSTATES];
#endif
	MYFTYPE v=V[PIdx]; // RRR -65?
	MYFTYPE v_2=V[PIdx_2]; // RRR -65?
#ifdef ILP3
	MYFTYPE v_3=V[PIdx_3]; // RRR -65?
#endif
#ifdef ILP4
	MYFTYPE v_4=V[PIdx_4]; // RRR -65?
#endif
#ifdef ILP5
	MYFTYPE v_5=V[PIdx_5]; // RRR -65?
#endif
#ifdef ILP6
	MYFTYPE v_6=V[PIdx_6]; // RRR -65?
#endif
#ifdef ILP7
	MYFTYPE v_7=V[PIdx_7]; // RRR -65?
#endif
#ifdef ILP8
	MYFTYPE v_8=V[PIdx_8]; // RRR -65?
#endif
#ifdef ILP9
	MYFTYPE v_9=V[PIdx_9]; // RRR -65?
#endif
#ifdef ILP10
	MYFTYPE v_10=V[PIdx_10]; // RRR -65?
#endif
#ifdef ILP11
	MYFTYPE v_11=V[PIdx_11]; // RRR -65?
#endif
#ifdef ILP12
	MYFTYPE v_12=V[PIdx_12]; // RRR -65?
#endif
#ifdef ILP13
	MYFTYPE v_13=V[PIdx_13]; // RRR -65?
#endif
#ifdef ILP14
	MYFTYPE v_14=V[PIdx_14]; // RRR -65?
#endif
#ifdef ILP15
	MYFTYPE v_15=V[PIdx_15]; // RRR -65?
#endif
#ifdef ILP16
	MYFTYPE v_16=V[PIdx_16]; // RRR -65?
#endif
#ifdef ILP17
	MYFTYPE v_17=V[PIdx_17]; // RRR -65?
#endif
#ifdef ILP18
	MYFTYPE v_18=V[PIdx_18]; // RRR -65?
#endif
#ifdef ILP19
	MYFTYPE v_19=V[PIdx_19]; // RRR -65?
#endif
#ifdef ILP20
	MYFTYPE v_20=V[PIdx_20]; // RRR -65?
#endif
#ifdef ILP21
	MYFTYPE v_21=V[PIdx_21]; // RRR -65?
#endif
#ifdef ILP22
	MYFTYPE v_22=V[PIdx_22]; // RRR -65?
#endif
#ifdef ILP23
	MYFTYPE v_23=V[PIdx_23]; // RRR -65?
#endif
#ifdef ILP24
	MYFTYPE v_24=V[PIdx_24]; // RRR -65?
#endif
#ifdef ILP25
	MYFTYPE v_25=V[PIdx_25]; // RRR -65?
#endif
#ifdef ILP26
	MYFTYPE v_26=V[PIdx_26]; // RRR -65?
#endif
#ifdef ILP27
	MYFTYPE v_27=V[PIdx_27]; // RRR -65?
#endif
#ifdef ILP28
	MYFTYPE v_28=V[PIdx_28]; // RRR -65?
#endif
#ifdef ILP29
	MYFTYPE v_29=V[PIdx_29]; // RRR -65?
#endif
#ifdef ILP30
	MYFTYPE v_30=V[PIdx_30]; // RRR -65?
#endif
#ifdef ILP31
	MYFTYPE v_31=V[PIdx_31]; // RRR -65?
#endif
#ifdef ILP32
	MYFTYPE v_32=V[PIdx_32]; // RRR -65?
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
#ifdef ILP5
	MYFTYPE p1_5,p2_5,p3_5,p4_5,p5_5,p6_5;
#endif
#ifdef ILP6
	MYFTYPE p1_6,p2_6,p3_6,p4_6,p5_6,p6_6;
#endif
#ifdef ILP7
	MYFTYPE p1_7,p2_7,p3_7,p4_7,p5_7,p6_7;
#endif
#ifdef ILP8
	MYFTYPE p1_8,p2_8,p3_8,p4_8,p5_8,p6_8;
#endif
#ifdef ILP9
	MYFTYPE p1_9,p2_9,p3_9,p4_9,p5_9,p6_9;
#endif
#ifdef ILP10
	MYFTYPE p1_10,p2_10,p3_10,p4_10,p5_10,p6_10;
#endif
#ifdef ILP11
	MYFTYPE p1_11,p2_11,p3_11,p4_11,p5_11,p6_11;
#endif
#ifdef ILP12
	MYFTYPE p1_12,p2_12,p3_12,p4_12,p5_12,p6_12;
#endif
#ifdef ILP13
	MYFTYPE p1_13,p2_13,p3_13,p4_13,p5_13,p6_13;
#endif
#ifdef ILP14
	MYFTYPE p1_14,p2_14,p3_14,p4_14,p5_14,p6_14;
#endif
#ifdef ILP15
	MYFTYPE p1_15,p2_15,p3_15,p4_15,p5_15,p6_15;
#endif
#ifdef ILP16
	MYFTYPE p1_16,p2_16,p3_16,p4_16,p5_16,p6_16;
#endif
#ifdef ILP17
	MYFTYPE p1_17,p2_17,p3_17,p4_17,p5_17,p6_17;
#endif
#ifdef ILP18
	MYFTYPE p1_18,p2_18,p3_18,p4_18,p5_18,p6_18;
#endif
#ifdef ILP19
	MYFTYPE p1_19,p2_19,p3_19,p4_19,p5_19,p6_19;
#endif
#ifdef ILP20
	MYFTYPE p1_20,p2_20,p3_20,p4_20,p5_20,p6_20;
#endif
#ifdef ILP21
	MYFTYPE p1_21,p2_21,p3_21,p4_21,p5_21,p6_21;
#endif
#ifdef ILP22
	MYFTYPE p1_22,p2_22,p3_22,p4_22,p5_22,p6_22;
#endif
#ifdef ILP23
	MYFTYPE p1_23,p2_23,p3_23,p4_23,p5_23,p6_23;
#endif
#ifdef ILP24
	MYFTYPE p1_24,p2_24,p3_24,p4_24,p5_24,p6_24;
#endif
#ifdef ILP25
	MYFTYPE p1_25,p2_25,p3_25,p4_25,p5_25,p6_25;
#endif
#ifdef ILP26
	MYFTYPE p1_26,p2_26,p3_26,p4_26,p5_26,p6_26;
#endif
#ifdef ILP27
	MYFTYPE p1_27,p2_27,p3_27,p4_27,p5_27,p6_27;
#endif
#ifdef ILP28
	MYFTYPE p1_28,p2_28,p3_28,p4_28,p5_28,p6_28;
#endif
#ifdef ILP29
	MYFTYPE p1_29,p2_29,p3_29,p4_29,p5_29,p6_29;
#endif
#ifdef ILP30
	MYFTYPE p1_30,p2_30,p3_30,p4_30,p5_30,p6_30;
#endif
#ifdef ILP31
	MYFTYPE p1_31,p2_31,p3_31,p4_31,p5_31,p6_31;
#endif
#ifdef ILP32
	MYFTYPE p1_32,p2_32,p3_32,p4_32,p5_32,p6_32;
#endif
	p1=ParamsM[0*SMemMat.N+PIdx];
	p1_2=ParamsM[0*SMemMat.N+PIdx_2];
#ifdef ILP3
	p1_3=ParamsM[0*SMemMat.N+PIdx_3];
#endif
#ifdef ILP4
	p1_4=ParamsM[0*SMemMat.N+PIdx_4];
#endif
#ifdef ILP5
	p1_5=ParamsM[0*SMemMat.N+PIdx_5];
#endif
#ifdef ILP6
	p1_6=ParamsM[0*SMemMat.N+PIdx_6];
#endif
#ifdef ILP7
	p1_7=ParamsM[0*SMemMat.N+PIdx_7];
#endif
#ifdef ILP8
	p1_8=ParamsM[0*SMemMat.N+PIdx_8];
#endif
#ifdef ILP9
	p1_9=ParamsM[0*SMemMat.N+PIdx_9];
#endif
#ifdef ILP10
	p1_10=ParamsM[0*SMemMat.N+PIdx_10];
#endif
#ifdef ILP11
	p1_11=ParamsM[0*SMemMat.N+PIdx_11];
#endif
#ifdef ILP12
	p1_12=ParamsM[0*SMemMat.N+PIdx_12];
#endif
#ifdef ILP13
	p1_13=ParamsM[0*SMemMat.N+PIdx_13];
#endif
#ifdef ILP14
	p1_14=ParamsM[0*SMemMat.N+PIdx_14];
#endif
#ifdef ILP15
	p1_15=ParamsM[0*SMemMat.N+PIdx_15];
#endif
#ifdef ILP16
	p1_16=ParamsM[0*SMemMat.N+PIdx_16];
#endif
#ifdef ILP17
	p1_17=ParamsM[0*SMemMat.N+PIdx_17];
#endif
#ifdef ILP18
	p1_18=ParamsM[0*SMemMat.N+PIdx_18];
#endif
#ifdef ILP19
	p1_19=ParamsM[0*SMemMat.N+PIdx_19];
#endif
#ifdef ILP20
	p1_20=ParamsM[0*SMemMat.N+PIdx_20];
#endif
#ifdef ILP21
	p1_21=ParamsM[0*SMemMat.N+PIdx_21];
#endif
#ifdef ILP22
	p1_22=ParamsM[0*SMemMat.N+PIdx_22];
#endif
#ifdef ILP23
	p1_23=ParamsM[0*SMemMat.N+PIdx_23];
#endif
#ifdef ILP24
	p1_24=ParamsM[0*SMemMat.N+PIdx_24];
#endif
#ifdef ILP25
	p1_25=ParamsM[0*SMemMat.N+PIdx_25];
#endif
#ifdef ILP26
	p1_26=ParamsM[0*SMemMat.N+PIdx_26];
#endif
#ifdef ILP27
	p1_27=ParamsM[0*SMemMat.N+PIdx_27];
#endif
#ifdef ILP28
	p1_28=ParamsM[0*SMemMat.N+PIdx_28];
#endif
#ifdef ILP29
	p1_29=ParamsM[0*SMemMat.N+PIdx_29];
#endif
#ifdef ILP30
	p1_30=ParamsM[0*SMemMat.N+PIdx_30];
#endif
#ifdef ILP31
	p1_31=ParamsM[0*SMemMat.N+PIdx_31];
#endif
#ifdef ILP32
	p1_32=ParamsM[0*SMemMat.N+PIdx_32];
#endif
	p2=ParamsM[1*SMemMat.N+PIdx];
	p2_2=ParamsM[1*SMemMat.N+PIdx_2];
#ifdef ILP3
	p2_3=ParamsM[1*SMemMat.N+PIdx_3];
#endif
#ifdef ILP4
	p2_4=ParamsM[1*SMemMat.N+PIdx_4];
#endif
#ifdef ILP5
	p2_5=ParamsM[1*SMemMat.N+PIdx_5];
#endif
#ifdef ILP6
	p2_6=ParamsM[1*SMemMat.N+PIdx_6];
#endif
#ifdef ILP7
	p2_7=ParamsM[1*SMemMat.N+PIdx_7];
#endif
#ifdef ILP8
	p2_8=ParamsM[1*SMemMat.N+PIdx_8];
#endif
#ifdef ILP9
	p2_9=ParamsM[1*SMemMat.N+PIdx_9];
#endif
#ifdef ILP10
	p2_10=ParamsM[1*SMemMat.N+PIdx_10];
#endif
#ifdef ILP11
	p2_11=ParamsM[1*SMemMat.N+PIdx_11];
#endif
#ifdef ILP12
	p2_12=ParamsM[1*SMemMat.N+PIdx_12];
#endif
#ifdef ILP13
	p2_13=ParamsM[1*SMemMat.N+PIdx_13];
#endif
#ifdef ILP14
	p2_14=ParamsM[1*SMemMat.N+PIdx_14];
#endif
#ifdef ILP15
	p2_15=ParamsM[1*SMemMat.N+PIdx_15];
#endif
#ifdef ILP16
	p2_16=ParamsM[1*SMemMat.N+PIdx_16];
#endif
#ifdef ILP17
	p2_17=ParamsM[1*SMemMat.N+PIdx_17];
#endif
#ifdef ILP18
	p2_18=ParamsM[1*SMemMat.N+PIdx_18];
#endif
#ifdef ILP19
	p2_19=ParamsM[1*SMemMat.N+PIdx_19];
#endif
#ifdef ILP20
	p2_20=ParamsM[1*SMemMat.N+PIdx_20];
#endif
#ifdef ILP21
	p2_21=ParamsM[1*SMemMat.N+PIdx_21];
#endif
#ifdef ILP22
	p2_22=ParamsM[1*SMemMat.N+PIdx_22];
#endif
#ifdef ILP23
	p2_23=ParamsM[1*SMemMat.N+PIdx_23];
#endif
#ifdef ILP24
	p2_24=ParamsM[1*SMemMat.N+PIdx_24];
#endif
#ifdef ILP25
	p2_25=ParamsM[1*SMemMat.N+PIdx_25];
#endif
#ifdef ILP26
	p2_26=ParamsM[1*SMemMat.N+PIdx_26];
#endif
#ifdef ILP27
	p2_27=ParamsM[1*SMemMat.N+PIdx_27];
#endif
#ifdef ILP28
	p2_28=ParamsM[1*SMemMat.N+PIdx_28];
#endif
#ifdef ILP29
	p2_29=ParamsM[1*SMemMat.N+PIdx_29];
#endif
#ifdef ILP30
	p2_30=ParamsM[1*SMemMat.N+PIdx_30];
#endif
#ifdef ILP31
	p2_31=ParamsM[1*SMemMat.N+PIdx_31];
#endif
#ifdef ILP32
	p2_32=ParamsM[1*SMemMat.N+PIdx_32];
#endif
	p3=ParamsM[2*SMemMat.N+PIdx];
	p3_2=ParamsM[2*SMemMat.N+PIdx_2];
#ifdef ILP3
	p3_3=ParamsM[2*SMemMat.N+PIdx_3];
#endif
#ifdef ILP4
	p3_4=ParamsM[2*SMemMat.N+PIdx_4];
#endif
#ifdef ILP5
	p3_5=ParamsM[2*SMemMat.N+PIdx_5];
#endif
#ifdef ILP6
	p3_6=ParamsM[2*SMemMat.N+PIdx_6];
#endif
#ifdef ILP7
	p3_7=ParamsM[2*SMemMat.N+PIdx_7];
#endif
#ifdef ILP8
	p3_8=ParamsM[2*SMemMat.N+PIdx_8];
#endif
#ifdef ILP9
	p3_9=ParamsM[2*SMemMat.N+PIdx_9];
#endif
#ifdef ILP10
	p3_10=ParamsM[2*SMemMat.N+PIdx_10];
#endif
#ifdef ILP11
	p3_11=ParamsM[2*SMemMat.N+PIdx_11];
#endif
#ifdef ILP12
	p3_12=ParamsM[2*SMemMat.N+PIdx_12];
#endif
#ifdef ILP13
	p3_13=ParamsM[2*SMemMat.N+PIdx_13];
#endif
#ifdef ILP14
	p3_14=ParamsM[2*SMemMat.N+PIdx_14];
#endif
#ifdef ILP15
	p3_15=ParamsM[2*SMemMat.N+PIdx_15];
#endif
#ifdef ILP16
	p3_16=ParamsM[2*SMemMat.N+PIdx_16];
#endif
#ifdef ILP17
	p3_17=ParamsM[2*SMemMat.N+PIdx_17];
#endif
#ifdef ILP18
	p3_18=ParamsM[2*SMemMat.N+PIdx_18];
#endif
#ifdef ILP19
	p3_19=ParamsM[2*SMemMat.N+PIdx_19];
#endif
#ifdef ILP20
	p3_20=ParamsM[2*SMemMat.N+PIdx_20];
#endif
#ifdef ILP21
	p3_21=ParamsM[2*SMemMat.N+PIdx_21];
#endif
#ifdef ILP22
	p3_22=ParamsM[2*SMemMat.N+PIdx_22];
#endif
#ifdef ILP23
	p3_23=ParamsM[2*SMemMat.N+PIdx_23];
#endif
#ifdef ILP24
	p3_24=ParamsM[2*SMemMat.N+PIdx_24];
#endif
#ifdef ILP25
	p3_25=ParamsM[2*SMemMat.N+PIdx_25];
#endif
#ifdef ILP26
	p3_26=ParamsM[2*SMemMat.N+PIdx_26];
#endif
#ifdef ILP27
	p3_27=ParamsM[2*SMemMat.N+PIdx_27];
#endif
#ifdef ILP28
	p3_28=ParamsM[2*SMemMat.N+PIdx_28];
#endif
#ifdef ILP29
	p3_29=ParamsM[2*SMemMat.N+PIdx_29];
#endif
#ifdef ILP30
	p3_30=ParamsM[2*SMemMat.N+PIdx_30];
#endif
#ifdef ILP31
	p3_31=ParamsM[2*SMemMat.N+PIdx_31];
#endif
#ifdef ILP32
	p3_32=ParamsM[2*SMemMat.N+PIdx_32];
#endif
	p4=ParamsM[3*SMemMat.N+PIdx];
	p4_2=ParamsM[3*SMemMat.N+PIdx_2];
#ifdef ILP3
	p4_3=ParamsM[3*SMemMat.N+PIdx_3];
#endif
#ifdef ILP4
	p4_4=ParamsM[3*SMemMat.N+PIdx_4];
#endif
#ifdef ILP5
	p4_5=ParamsM[3*SMemMat.N+PIdx_5];
#endif
#ifdef ILP6
	p4_6=ParamsM[3*SMemMat.N+PIdx_6];
#endif
#ifdef ILP7
	p4_7=ParamsM[3*SMemMat.N+PIdx_7];
#endif
#ifdef ILP8
	p4_8=ParamsM[3*SMemMat.N+PIdx_8];
#endif
#ifdef ILP9
	p4_9=ParamsM[3*SMemMat.N+PIdx_9];
#endif
#ifdef ILP10
	p4_10=ParamsM[3*SMemMat.N+PIdx_10];
#endif
#ifdef ILP11
	p4_11=ParamsM[3*SMemMat.N+PIdx_11];
#endif
#ifdef ILP12
	p4_12=ParamsM[3*SMemMat.N+PIdx_12];
#endif
#ifdef ILP13
	p4_13=ParamsM[3*SMemMat.N+PIdx_13];
#endif
#ifdef ILP14
	p4_14=ParamsM[3*SMemMat.N+PIdx_14];
#endif
#ifdef ILP15
	p4_15=ParamsM[3*SMemMat.N+PIdx_15];
#endif
#ifdef ILP16
	p4_16=ParamsM[3*SMemMat.N+PIdx_16];
#endif
#ifdef ILP17
	p4_17=ParamsM[3*SMemMat.N+PIdx_17];
#endif
#ifdef ILP18
	p4_18=ParamsM[3*SMemMat.N+PIdx_18];
#endif
#ifdef ILP19
	p4_19=ParamsM[3*SMemMat.N+PIdx_19];
#endif
#ifdef ILP20
	p4_20=ParamsM[3*SMemMat.N+PIdx_20];
#endif
#ifdef ILP21
	p4_21=ParamsM[3*SMemMat.N+PIdx_21];
#endif
#ifdef ILP22
	p4_22=ParamsM[3*SMemMat.N+PIdx_22];
#endif
#ifdef ILP23
	p4_23=ParamsM[3*SMemMat.N+PIdx_23];
#endif
#ifdef ILP24
	p4_24=ParamsM[3*SMemMat.N+PIdx_24];
#endif
#ifdef ILP25
	p4_25=ParamsM[3*SMemMat.N+PIdx_25];
#endif
#ifdef ILP26
	p4_26=ParamsM[3*SMemMat.N+PIdx_26];
#endif
#ifdef ILP27
	p4_27=ParamsM[3*SMemMat.N+PIdx_27];
#endif
#ifdef ILP28
	p4_28=ParamsM[3*SMemMat.N+PIdx_28];
#endif
#ifdef ILP29
	p4_29=ParamsM[3*SMemMat.N+PIdx_29];
#endif
#ifdef ILP30
	p4_30=ParamsM[3*SMemMat.N+PIdx_30];
#endif
#ifdef ILP31
	p4_31=ParamsM[3*SMemMat.N+PIdx_31];
#endif
#ifdef ILP32
	p4_32=ParamsM[3*SMemMat.N+PIdx_32];
#endif
	p5=ParamsM[4*SMemMat.N+PIdx];
	p5_2=ParamsM[4*SMemMat.N+PIdx_2];
#ifdef ILP3
	p5_3=ParamsM[4*SMemMat.N+PIdx_3];
#endif
#ifdef ILP4
	p5_4=ParamsM[4*SMemMat.N+PIdx_4];
#endif
#ifdef ILP5
	p5_5=ParamsM[4*SMemMat.N+PIdx_5];
#endif
#ifdef ILP6
	p5_6=ParamsM[4*SMemMat.N+PIdx_6];
#endif
#ifdef ILP7
	p5_7=ParamsM[4*SMemMat.N+PIdx_7];
#endif
#ifdef ILP8
	p5_8=ParamsM[4*SMemMat.N+PIdx_8];
#endif
#ifdef ILP9
	p5_9=ParamsM[4*SMemMat.N+PIdx_9];
#endif
#ifdef ILP10
	p5_10=ParamsM[4*SMemMat.N+PIdx_10];
#endif
#ifdef ILP11
	p5_11=ParamsM[4*SMemMat.N+PIdx_11];
#endif
#ifdef ILP12
	p5_12=ParamsM[4*SMemMat.N+PIdx_12];
#endif
#ifdef ILP13
	p5_13=ParamsM[4*SMemMat.N+PIdx_13];
#endif
#ifdef ILP14
	p5_14=ParamsM[4*SMemMat.N+PIdx_14];
#endif
#ifdef ILP15
	p5_15=ParamsM[4*SMemMat.N+PIdx_15];
#endif
#ifdef ILP16
	p5_16=ParamsM[4*SMemMat.N+PIdx_16];
#endif
#ifdef ILP17
	p5_17=ParamsM[4*SMemMat.N+PIdx_17];
#endif
#ifdef ILP18
	p5_18=ParamsM[4*SMemMat.N+PIdx_18];
#endif
#ifdef ILP19
	p5_19=ParamsM[4*SMemMat.N+PIdx_19];
#endif
#ifdef ILP20
	p5_20=ParamsM[4*SMemMat.N+PIdx_20];
#endif
#ifdef ILP21
	p5_21=ParamsM[4*SMemMat.N+PIdx_21];
#endif
#ifdef ILP22
	p5_22=ParamsM[4*SMemMat.N+PIdx_22];
#endif
#ifdef ILP23
	p5_23=ParamsM[4*SMemMat.N+PIdx_23];
#endif
#ifdef ILP24
	p5_24=ParamsM[4*SMemMat.N+PIdx_24];
#endif
#ifdef ILP25
	p5_25=ParamsM[4*SMemMat.N+PIdx_25];
#endif
#ifdef ILP26
	p5_26=ParamsM[4*SMemMat.N+PIdx_26];
#endif
#ifdef ILP27
	p5_27=ParamsM[4*SMemMat.N+PIdx_27];
#endif
#ifdef ILP28
	p5_28=ParamsM[4*SMemMat.N+PIdx_28];
#endif
#ifdef ILP29
	p5_29=ParamsM[4*SMemMat.N+PIdx_29];
#endif
#ifdef ILP30
	p5_30=ParamsM[4*SMemMat.N+PIdx_30];
#endif
#ifdef ILP31
	p5_31=ParamsM[4*SMemMat.N+PIdx_31];
#endif
#ifdef ILP32
	p5_32=ParamsM[4*SMemMat.N+PIdx_32];
#endif
	p6=ParamsM[5*SMemMat.N+PIdx];
	p6_2=ParamsM[5*SMemMat.N+PIdx_2];
#ifdef ILP3
	p6_3=ParamsM[5*SMemMat.N+PIdx_3];
#endif
#ifdef ILP4
	p6_4=ParamsM[5*SMemMat.N+PIdx_4];
#endif
#ifdef ILP5
	p6_5=ParamsM[5*SMemMat.N+PIdx_5];
#endif
#ifdef ILP6
	p6_6=ParamsM[5*SMemMat.N+PIdx_6];
#endif
#ifdef ILP7
	p6_7=ParamsM[5*SMemMat.N+PIdx_7];
#endif
#ifdef ILP8
	p6_8=ParamsM[5*SMemMat.N+PIdx_8];
#endif
#ifdef ILP9
	p6_9=ParamsM[5*SMemMat.N+PIdx_9];
#endif
#ifdef ILP10
	p6_10=ParamsM[5*SMemMat.N+PIdx_10];
#endif
#ifdef ILP11
	p6_11=ParamsM[5*SMemMat.N+PIdx_11];
#endif
#ifdef ILP12
	p6_12=ParamsM[5*SMemMat.N+PIdx_12];
#endif
#ifdef ILP13
	p6_13=ParamsM[5*SMemMat.N+PIdx_13];
#endif
#ifdef ILP14
	p6_14=ParamsM[5*SMemMat.N+PIdx_14];
#endif
#ifdef ILP15
	p6_15=ParamsM[5*SMemMat.N+PIdx_15];
#endif
#ifdef ILP16
	p6_16=ParamsM[5*SMemMat.N+PIdx_16];
#endif
#ifdef ILP17
	p6_17=ParamsM[5*SMemMat.N+PIdx_17];
#endif
#ifdef ILP18
	p6_18=ParamsM[5*SMemMat.N+PIdx_18];
#endif
#ifdef ILP19
	p6_19=ParamsM[5*SMemMat.N+PIdx_19];
#endif
#ifdef ILP20
	p6_20=ParamsM[5*SMemMat.N+PIdx_20];
#endif
#ifdef ILP21
	p6_21=ParamsM[5*SMemMat.N+PIdx_21];
#endif
#ifdef ILP22
	p6_22=ParamsM[5*SMemMat.N+PIdx_22];
#endif
#ifdef ILP23
	p6_23=ParamsM[5*SMemMat.N+PIdx_23];
#endif
#ifdef ILP24
	p6_24=ParamsM[5*SMemMat.N+PIdx_24];
#endif
#ifdef ILP25
	p6_25=ParamsM[5*SMemMat.N+PIdx_25];
#endif
#ifdef ILP26
	p6_26=ParamsM[5*SMemMat.N+PIdx_26];
#endif
#ifdef ILP27
	p6_27=ParamsM[5*SMemMat.N+PIdx_27];
#endif
#ifdef ILP28
	p6_28=ParamsM[5*SMemMat.N+PIdx_28];
#endif
#ifdef ILP29
	p6_29=ParamsM[5*SMemMat.N+PIdx_29];
#endif
#ifdef ILP30
	p6_30=ParamsM[5*SMemMat.N+PIdx_30];
#endif
#ifdef ILP31
	p6_31=ParamsM[5*SMemMat.N+PIdx_31];
#endif
#ifdef ILP32
	p6_32=ParamsM[5*SMemMat.N+PIdx_32];
#endif

	
	KInitModel(v,ModelStates[0],ModelStates[1],ModelStates[2]);
	KInitModel(v_2,ModelStates_2[0],ModelStates_2[1],ModelStates_2[2]);
#ifdef ILP3
	KInitModel(v_3,ModelStates_3[0],ModelStates_3[1],ModelStates_3[2]);
#endif
#ifdef ILP4
	KInitModel(v_4,ModelStates_4[0],ModelStates_4[1],ModelStates_4[2]);
#endif
#ifdef ILP5
	KInitModel(v_5,ModelStates_5[0],ModelStates_5[1],ModelStates_5[2]);
#endif
#ifdef ILP6
	KInitModel(v_6,ModelStates_6[0],ModelStates_6[1],ModelStates_6[2]);
#endif
#ifdef ILP7
	KInitModel(v_7,ModelStates_7[0],ModelStates_7[1],ModelStates_7[2]);
#endif
#ifdef ILP8
	KInitModel(v_8,ModelStates_8[0],ModelStates_8[1],ModelStates_8[2]);
#endif
#ifdef ILP9
	KInitModel(v_9,ModelStates_9[0],ModelStates_9[1],ModelStates_9[2]);
#endif
#ifdef ILP10
	KInitModel(v_10,ModelStates_10[0],ModelStates_10[1],ModelStates_10[2]);
#endif
#ifdef ILP11
	KInitModel(v_11,ModelStates_11[0],ModelStates_11[1],ModelStates_11[2]);
#endif
#ifdef ILP12
	KInitModel(v_12,ModelStates_12[0],ModelStates_12[1],ModelStates_12[2]);
#endif
#ifdef ILP13
	KInitModel(v_13,ModelStates_13[0],ModelStates_13[1],ModelStates_13[2]);
#endif
#ifdef ILP14
	KInitModel(v_14,ModelStates_14[0],ModelStates_14[1],ModelStates_14[2]);
#endif
#ifdef ILP15
	KInitModel(v_15,ModelStates_15[0],ModelStates_15[1],ModelStates_15[2]);
#endif
#ifdef ILP16
	KInitModel(v_16,ModelStates_16[0],ModelStates_16[1],ModelStates_16[2]);
#endif
#ifdef ILP17
	KInitModel(v_17,ModelStates_17[0],ModelStates_17[1],ModelStates_17[2]);
#endif
#ifdef ILP18
	KInitModel(v_18,ModelStates_18[0],ModelStates_18[1],ModelStates_18[2]);
#endif
#ifdef ILP19
	KInitModel(v_19,ModelStates_19[0],ModelStates_19[1],ModelStates_19[2]);
#endif
#ifdef ILP20
	KInitModel(v_20,ModelStates_20[0],ModelStates_20[1],ModelStates_20[2]);
#endif
#ifdef ILP21
	KInitModel(v_21,ModelStates_21[0],ModelStates_21[1],ModelStates_21[2]);
#endif
#ifdef ILP22
	KInitModel(v_22,ModelStates_22[0],ModelStates_22[1],ModelStates_22[2]);
#endif
#ifdef ILP23
	KInitModel(v_23,ModelStates_23[0],ModelStates_23[1],ModelStates_23[2]);
#endif
#ifdef ILP24
	KInitModel(v_24,ModelStates_24[0],ModelStates_24[1],ModelStates_24[2]);
#endif
#ifdef ILP25
	KInitModel(v_25,ModelStates_25[0],ModelStates_25[1],ModelStates_25[2]);
#endif
#ifdef ILP26
	KInitModel(v_26,ModelStates_26[0],ModelStates_26[1],ModelStates_26[2]);
#endif
#ifdef ILP27
	KInitModel(v_27,ModelStates_27[0],ModelStates_27[1],ModelStates_27[2]);
#endif
#ifdef ILP28
	KInitModel(v_28,ModelStates_28[0],ModelStates_28[1],ModelStates_28[2]);
#endif
#ifdef ILP29
	KInitModel(v_29,ModelStates_29[0],ModelStates_29[1],ModelStates_29[2]);
#endif
#ifdef ILP30
	KInitModel(v_30,ModelStates_30[0],ModelStates_30[1],ModelStates_30[2]);
#endif
#ifdef ILP31
	KInitModel(v_31,ModelStates_31[0],ModelStates_31[1],ModelStates_31[2]);
#endif
#ifdef ILP32
	KInitModel(v_32,ModelStates_32[0],ModelStates_32[1],ModelStates_32[2]);
#endif
	
	MYFTYPE sumCurrents, sumConductivity;
	MYFTYPE sumCurrents_2, sumConductivity_2;
#ifdef ILP3
	MYFTYPE sumCurrents_3, sumConductivity_3;
#endif
#ifdef ILP4
	MYFTYPE sumCurrents_4, sumConductivity_4;
#endif
#ifdef ILP5
	MYFTYPE sumCurrents_5, sumConductivity_5;
#endif
#ifdef ILP6
	MYFTYPE sumCurrents_6, sumConductivity_6;
#endif
#ifdef ILP7
	MYFTYPE sumCurrents_7, sumConductivity_7;
#endif
#ifdef ILP8
	MYFTYPE sumCurrents_8, sumConductivity_8;
#endif
#ifdef ILP9
	MYFTYPE sumCurrents_9, sumConductivity_9;
#endif
#ifdef ILP10
	MYFTYPE sumCurrents_10, sumConductivity_10;
#endif
#ifdef ILP11
	MYFTYPE sumCurrents_11, sumConductivity_11;
#endif
#ifdef ILP12
	MYFTYPE sumCurrents_12, sumConductivity_12;
#endif
#ifdef ILP13
	MYFTYPE sumCurrents_13, sumConductivity_13;
#endif
#ifdef ILP14
	MYFTYPE sumCurrents_14, sumConductivity_14;
#endif
#ifdef ILP15
	MYFTYPE sumCurrents_15, sumConductivity_15;
#endif
#ifdef ILP16
	MYFTYPE sumCurrents_16, sumConductivity_16;
#endif
#ifdef ILP17
	MYFTYPE sumCurrents_17, sumConductivity_17;
#endif
#ifdef ILP18
	MYFTYPE sumCurrents_18, sumConductivity_18;
#endif
#ifdef ILP19
	MYFTYPE sumCurrents_19, sumConductivity_19;
#endif
#ifdef ILP20
	MYFTYPE sumCurrents_20, sumConductivity_20;
#endif
#ifdef ILP21
	MYFTYPE sumCurrents_21, sumConductivity_21;
#endif
#ifdef ILP22
	MYFTYPE sumCurrents_22, sumConductivity_22;
#endif
#ifdef ILP23
	MYFTYPE sumCurrents_23, sumConductivity_23;
#endif
#ifdef ILP24
	MYFTYPE sumCurrents_24, sumConductivity_24;
#endif
#ifdef ILP25
	MYFTYPE sumCurrents_25, sumConductivity_25;
#endif
#ifdef ILP26
	MYFTYPE sumCurrents_26, sumConductivity_26;
#endif
#ifdef ILP27
	MYFTYPE sumCurrents_27, sumConductivity_27;
#endif
#ifdef ILP28
	MYFTYPE sumCurrents_28, sumConductivity_28;
#endif
#ifdef ILP29
	MYFTYPE sumCurrents_29, sumConductivity_29;
#endif
#ifdef ILP30
	MYFTYPE sumCurrents_30, sumConductivity_30;
#endif
#ifdef ILP31
	MYFTYPE sumCurrents_31, sumConductivity_31;
#endif
#ifdef ILP32
	MYFTYPE sumCurrents_32, sumConductivity_32;
#endif
	MYFTYPE sumCurrentsDv, sumConductivityDv;
	MYFTYPE sumCurrentsDv_2, sumConductivityDv_2;
#ifdef ILP3
	MYFTYPE sumCurrentsDv_3, sumConductivityDv_3;
#endif
#ifdef ILP4
	MYFTYPE sumCurrentsDv_4, sumConductivityDv_4;
#endif
#ifdef ILP5
	MYFTYPE sumCurrentsDv_5, sumConductivityDv_5;
#endif
#ifdef ILP6
	MYFTYPE sumCurrentsDv_6, sumConductivityDv_6;
#endif
#ifdef ILP7
	MYFTYPE sumCurrentsDv_7, sumConductivityDv_7;
#endif
#ifdef ILP8
	MYFTYPE sumCurrentsDv_8, sumConductivityDv_8;
#endif
#ifdef ILP9
	MYFTYPE sumCurrentsDv_9, sumConductivityDv_9;
#endif
#ifdef ILP10
	MYFTYPE sumCurrentsDv_10, sumConductivityDv_10;
#endif
#ifdef ILP11
	MYFTYPE sumCurrentsDv_11, sumConductivityDv_11;
#endif
#ifdef ILP12
	MYFTYPE sumCurrentsDv_12, sumConductivityDv_12;
#endif
#ifdef ILP13
	MYFTYPE sumCurrentsDv_13, sumConductivityDv_13;
#endif
#ifdef ILP14
	MYFTYPE sumCurrentsDv_14, sumConductivityDv_14;
#endif
#ifdef ILP15
	MYFTYPE sumCurrentsDv_15, sumConductivityDv_15;
#endif
#ifdef ILP16
	MYFTYPE sumCurrentsDv_16, sumConductivityDv_16;
#endif
#ifdef ILP17
	MYFTYPE sumCurrentsDv_17, sumConductivityDv_17;
#endif
#ifdef ILP18
	MYFTYPE sumCurrentsDv_18, sumConductivityDv_18;
#endif
#ifdef ILP19
	MYFTYPE sumCurrentsDv_19, sumConductivityDv_19;
#endif
#ifdef ILP20
	MYFTYPE sumCurrentsDv_20, sumConductivityDv_20;
#endif
#ifdef ILP21
	MYFTYPE sumCurrentsDv_21, sumConductivityDv_21;
#endif
#ifdef ILP22
	MYFTYPE sumCurrentsDv_22, sumConductivityDv_22;
#endif
#ifdef ILP23
	MYFTYPE sumCurrentsDv_23, sumConductivityDv_23;
#endif
#ifdef ILP24
	MYFTYPE sumCurrentsDv_24, sumConductivityDv_24;
#endif
#ifdef ILP25
	MYFTYPE sumCurrentsDv_25, sumConductivityDv_25;
#endif
#ifdef ILP26
	MYFTYPE sumCurrentsDv_26, sumConductivityDv_26;
#endif
#ifdef ILP27
	MYFTYPE sumCurrentsDv_27, sumConductivityDv_27;
#endif
#ifdef ILP28
	MYFTYPE sumCurrentsDv_28, sumConductivityDv_28;
#endif
#ifdef ILP29
	MYFTYPE sumCurrentsDv_29, sumConductivityDv_29;
#endif
#ifdef ILP30
	MYFTYPE sumCurrentsDv_30, sumConductivityDv_30;
#endif
#ifdef ILP31
	MYFTYPE sumCurrentsDv_31, sumConductivityDv_31;
#endif
#ifdef ILP32
	MYFTYPE sumCurrentsDv_32, sumConductivityDv_32;
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
#ifdef ILP5
	SMemMat.e[PIdx_5]=InMat.e[PIdx_5];
#endif
#ifdef ILP6
	SMemMat.e[PIdx_6]=InMat.e[PIdx_6];
#endif
#ifdef ILP7
	SMemMat.e[PIdx_7]=InMat.e[PIdx_7];
#endif
#ifdef ILP8
	SMemMat.e[PIdx_8]=InMat.e[PIdx_8];
#endif
#ifdef ILP9
	SMemMat.e[PIdx_9]=InMat.e[PIdx_9];
#endif
#ifdef ILP10
	SMemMat.e[PIdx_10]=InMat.e[PIdx_10];
#endif
#ifdef ILP11
	SMemMat.e[PIdx_11]=InMat.e[PIdx_11];
#endif
#ifdef ILP12
	SMemMat.e[PIdx_12]=InMat.e[PIdx_12];
#endif
#ifdef ILP13
	SMemMat.e[PIdx_13]=InMat.e[PIdx_13];
#endif
#ifdef ILP14
	SMemMat.e[PIdx_14]=InMat.e[PIdx_14];
#endif
#ifdef ILP15
	SMemMat.e[PIdx_15]=InMat.e[PIdx_15];
#endif
#ifdef ILP16
	SMemMat.e[PIdx_16]=InMat.e[PIdx_16];
#endif
#ifdef ILP17
	SMemMat.e[PIdx_17]=InMat.e[PIdx_17];
#endif
#ifdef ILP18
	SMemMat.e[PIdx_18]=InMat.e[PIdx_18];
#endif
#ifdef ILP19
	SMemMat.e[PIdx_19]=InMat.e[PIdx_19];
#endif
#ifdef ILP20
	SMemMat.e[PIdx_20]=InMat.e[PIdx_20];
#endif
#ifdef ILP21
	SMemMat.e[PIdx_21]=InMat.e[PIdx_21];
#endif
#ifdef ILP22
	SMemMat.e[PIdx_22]=InMat.e[PIdx_22];
#endif
#ifdef ILP23
	SMemMat.e[PIdx_23]=InMat.e[PIdx_23];
#endif
#ifdef ILP24
	SMemMat.e[PIdx_24]=InMat.e[PIdx_24];
#endif
#ifdef ILP25
	SMemMat.e[PIdx_25]=InMat.e[PIdx_25];
#endif
#ifdef ILP26
	SMemMat.e[PIdx_26]=InMat.e[PIdx_26];
#endif
#ifdef ILP27
	SMemMat.e[PIdx_27]=InMat.e[PIdx_27];
#endif
#ifdef ILP28
	SMemMat.e[PIdx_28]=InMat.e[PIdx_28];
#endif
#ifdef ILP29
	SMemMat.e[PIdx_29]=InMat.e[PIdx_29];
#endif
#ifdef ILP30
	SMemMat.e[PIdx_30]=InMat.e[PIdx_30];
#endif
#ifdef ILP31
	SMemMat.e[PIdx_31]=InMat.e[PIdx_31];
#endif
#ifdef ILP32
	SMemMat.e[PIdx_32]=InMat.e[PIdx_32];
#endif
	SMemMat.f[PIdx]=InMat.f[PIdx];
	SMemMat.f[PIdx_2]=InMat.f[PIdx_2];
#ifdef ILP3
	SMemMat.f[PIdx_3]=InMat.f[PIdx_3];
#endif
#ifdef ILP4
	SMemMat.f[PIdx_4]=InMat.f[PIdx_4];
#endif
#ifdef ILP5
	SMemMat.f[PIdx_5]=InMat.f[PIdx_5];
#endif
#ifdef ILP6
	SMemMat.f[PIdx_6]=InMat.f[PIdx_6];
#endif
#ifdef ILP7
	SMemMat.f[PIdx_7]=InMat.f[PIdx_7];
#endif
#ifdef ILP8
	SMemMat.f[PIdx_8]=InMat.f[PIdx_8];
#endif
#ifdef ILP9
	SMemMat.f[PIdx_9]=InMat.f[PIdx_9];
#endif
#ifdef ILP10
	SMemMat.f[PIdx_10]=InMat.f[PIdx_10];
#endif
#ifdef ILP11
	SMemMat.f[PIdx_11]=InMat.f[PIdx_11];
#endif
#ifdef ILP12
	SMemMat.f[PIdx_12]=InMat.f[PIdx_12];
#endif
#ifdef ILP13
	SMemMat.f[PIdx_13]=InMat.f[PIdx_13];
#endif
#ifdef ILP14
	SMemMat.f[PIdx_14]=InMat.f[PIdx_14];
#endif
#ifdef ILP15
	SMemMat.f[PIdx_15]=InMat.f[PIdx_15];
#endif
#ifdef ILP16
	SMemMat.f[PIdx_16]=InMat.f[PIdx_16];
#endif
#ifdef ILP17
	SMemMat.f[PIdx_17]=InMat.f[PIdx_17];
#endif
#ifdef ILP18
	SMemMat.f[PIdx_18]=InMat.f[PIdx_18];
#endif
#ifdef ILP19
	SMemMat.f[PIdx_19]=InMat.f[PIdx_19];
#endif
#ifdef ILP20
	SMemMat.f[PIdx_20]=InMat.f[PIdx_20];
#endif
#ifdef ILP21
	SMemMat.f[PIdx_21]=InMat.f[PIdx_21];
#endif
#ifdef ILP22
	SMemMat.f[PIdx_22]=InMat.f[PIdx_22];
#endif
#ifdef ILP23
	SMemMat.f[PIdx_23]=InMat.f[PIdx_23];
#endif
#ifdef ILP24
	SMemMat.f[PIdx_24]=InMat.f[PIdx_24];
#endif
#ifdef ILP25
	SMemMat.f[PIdx_25]=InMat.f[PIdx_25];
#endif
#ifdef ILP26
	SMemMat.f[PIdx_26]=InMat.f[PIdx_26];
#endif
#ifdef ILP27
	SMemMat.f[PIdx_27]=InMat.f[PIdx_27];
#endif
#ifdef ILP28
	SMemMat.f[PIdx_28]=InMat.f[PIdx_28];
#endif
#ifdef ILP29
	SMemMat.f[PIdx_29]=InMat.f[PIdx_29];
#endif
#ifdef ILP30
	SMemMat.f[PIdx_30]=InMat.f[PIdx_30];
#endif
#ifdef ILP31
	SMemMat.f[PIdx_31]=InMat.f[PIdx_31];
#endif
#ifdef ILP32
	SMemMat.f[PIdx_32]=InMat.f[PIdx_32];
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
#ifdef ILP5
	SMemMat.Cms[PIdx_5]=InMat.Cms[PIdx_5];
#endif
#ifdef ILP6
	SMemMat.Cms[PIdx_6]=InMat.Cms[PIdx_6];
#endif
#ifdef ILP7
	SMemMat.Cms[PIdx_7]=InMat.Cms[PIdx_7];
#endif
#ifdef ILP8
	SMemMat.Cms[PIdx_8]=InMat.Cms[PIdx_8];
#endif
#ifdef ILP9
	SMemMat.Cms[PIdx_9]=InMat.Cms[PIdx_9];
#endif
#ifdef ILP10
	SMemMat.Cms[PIdx_10]=InMat.Cms[PIdx_10];
#endif
#ifdef ILP11
	SMemMat.Cms[PIdx_11]=InMat.Cms[PIdx_11];
#endif
#ifdef ILP12
	SMemMat.Cms[PIdx_12]=InMat.Cms[PIdx_12];
#endif
#ifdef ILP13
	SMemMat.Cms[PIdx_13]=InMat.Cms[PIdx_13];
#endif
#ifdef ILP14
	SMemMat.Cms[PIdx_14]=InMat.Cms[PIdx_14];
#endif
#ifdef ILP15
	SMemMat.Cms[PIdx_15]=InMat.Cms[PIdx_15];
#endif
#ifdef ILP16
	SMemMat.Cms[PIdx_16]=InMat.Cms[PIdx_16];
#endif
#ifdef ILP17
	SMemMat.Cms[PIdx_17]=InMat.Cms[PIdx_17];
#endif
#ifdef ILP18
	SMemMat.Cms[PIdx_18]=InMat.Cms[PIdx_18];
#endif
#ifdef ILP19
	SMemMat.Cms[PIdx_19]=InMat.Cms[PIdx_19];
#endif
#ifdef ILP20
	SMemMat.Cms[PIdx_20]=InMat.Cms[PIdx_20];
#endif
#ifdef ILP21
	SMemMat.Cms[PIdx_21]=InMat.Cms[PIdx_21];
#endif
#ifdef ILP22
	SMemMat.Cms[PIdx_22]=InMat.Cms[PIdx_22];
#endif
#ifdef ILP23
	SMemMat.Cms[PIdx_23]=InMat.Cms[PIdx_23];
#endif
#ifdef ILP24
	SMemMat.Cms[PIdx_24]=InMat.Cms[PIdx_24];
#endif
#ifdef ILP25
	SMemMat.Cms[PIdx_25]=InMat.Cms[PIdx_25];
#endif
#ifdef ILP26
	SMemMat.Cms[PIdx_26]=InMat.Cms[PIdx_26];
#endif
#ifdef ILP27
	SMemMat.Cms[PIdx_27]=InMat.Cms[PIdx_27];
#endif
#ifdef ILP28
	SMemMat.Cms[PIdx_28]=InMat.Cms[PIdx_28];
#endif
#ifdef ILP29
	SMemMat.Cms[PIdx_29]=InMat.Cms[PIdx_29];
#endif
#ifdef ILP30
	SMemMat.Cms[PIdx_30]=InMat.Cms[PIdx_30];
#endif
#ifdef ILP31
	SMemMat.Cms[PIdx_31]=InMat.Cms[PIdx_31];
#endif
#ifdef ILP32
	SMemMat.Cms[PIdx_32]=InMat.Cms[PIdx_32];
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
#ifdef ILP5
		SMemMat.FIdxs[i*InMat.N+PIdx_5]=InMat.FIdxs[i*InMat.N+PIdx_5];
#endif
#ifdef ILP6
		SMemMat.FIdxs[i*InMat.N+PIdx_6]=InMat.FIdxs[i*InMat.N+PIdx_6];
#endif
#ifdef ILP7
		SMemMat.FIdxs[i*InMat.N+PIdx_7]=InMat.FIdxs[i*InMat.N+PIdx_7];
#endif
#ifdef ILP8
		SMemMat.FIdxs[i*InMat.N+PIdx_8]=InMat.FIdxs[i*InMat.N+PIdx_8];
#endif
#ifdef ILP9
		SMemMat.FIdxs[i*InMat.N+PIdx_9]=InMat.FIdxs[i*InMat.N+PIdx_9];
#endif
#ifdef ILP10
		SMemMat.FIdxs[i*InMat.N+PIdx_10]=InMat.FIdxs[i*InMat.N+PIdx_10];
#endif
#ifdef ILP11
		SMemMat.FIdxs[i*InMat.N+PIdx_11]=InMat.FIdxs[i*InMat.N+PIdx_11];
#endif
#ifdef ILP12
		SMemMat.FIdxs[i*InMat.N+PIdx_12]=InMat.FIdxs[i*InMat.N+PIdx_12];
#endif
#ifdef ILP13
		SMemMat.FIdxs[i*InMat.N+PIdx_13]=InMat.FIdxs[i*InMat.N+PIdx_13];
#endif
#ifdef ILP14
		SMemMat.FIdxs[i*InMat.N+PIdx_14]=InMat.FIdxs[i*InMat.N+PIdx_14];
#endif
#ifdef ILP15
		SMemMat.FIdxs[i*InMat.N+PIdx_15]=InMat.FIdxs[i*InMat.N+PIdx_15];
#endif
#ifdef ILP16
		SMemMat.FIdxs[i*InMat.N+PIdx_16]=InMat.FIdxs[i*InMat.N+PIdx_16];
#endif
#ifdef ILP17
		SMemMat.FIdxs[i*InMat.N+PIdx_17]=InMat.FIdxs[i*InMat.N+PIdx_17];
#endif
#ifdef ILP18
		SMemMat.FIdxs[i*InMat.N+PIdx_18]=InMat.FIdxs[i*InMat.N+PIdx_18];
#endif
#ifdef ILP19
		SMemMat.FIdxs[i*InMat.N+PIdx_19]=InMat.FIdxs[i*InMat.N+PIdx_19];
#endif
#ifdef ILP20
		SMemMat.FIdxs[i*InMat.N+PIdx_20]=InMat.FIdxs[i*InMat.N+PIdx_20];
#endif
#ifdef ILP21
		SMemMat.FIdxs[i*InMat.N+PIdx_21]=InMat.FIdxs[i*InMat.N+PIdx_21];
#endif
#ifdef ILP22
		SMemMat.FIdxs[i*InMat.N+PIdx_22]=InMat.FIdxs[i*InMat.N+PIdx_22];
#endif
#ifdef ILP23
		SMemMat.FIdxs[i*InMat.N+PIdx_23]=InMat.FIdxs[i*InMat.N+PIdx_23];
#endif
#ifdef ILP24
		SMemMat.FIdxs[i*InMat.N+PIdx_24]=InMat.FIdxs[i*InMat.N+PIdx_24];
#endif
#ifdef ILP25
		SMemMat.FIdxs[i*InMat.N+PIdx_25]=InMat.FIdxs[i*InMat.N+PIdx_25];
#endif
#ifdef ILP26
		SMemMat.FIdxs[i*InMat.N+PIdx_26]=InMat.FIdxs[i*InMat.N+PIdx_26];
#endif
#ifdef ILP27
		SMemMat.FIdxs[i*InMat.N+PIdx_27]=InMat.FIdxs[i*InMat.N+PIdx_27];
#endif
#ifdef ILP28
		SMemMat.FIdxs[i*InMat.N+PIdx_28]=InMat.FIdxs[i*InMat.N+PIdx_28];
#endif
#ifdef ILP29
		SMemMat.FIdxs[i*InMat.N+PIdx_29]=InMat.FIdxs[i*InMat.N+PIdx_29];
#endif
#ifdef ILP30
		SMemMat.FIdxs[i*InMat.N+PIdx_30]=InMat.FIdxs[i*InMat.N+PIdx_30];
#endif
#ifdef ILP31
		SMemMat.FIdxs[i*InMat.N+PIdx_31]=InMat.FIdxs[i*InMat.N+PIdx_31];
#endif
#ifdef ILP32
		SMemMat.FIdxs[i*InMat.N+PIdx_32]=InMat.FIdxs[i*InMat.N+PIdx_32];
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
#ifdef ILP5
	SMemMat.Ks[PIdx_5]=InMat.Ks[PIdx_5];
#endif
#ifdef ILP6
	SMemMat.Ks[PIdx_6]=InMat.Ks[PIdx_6];
#endif
#ifdef ILP7
	SMemMat.Ks[PIdx_7]=InMat.Ks[PIdx_7];
#endif
#ifdef ILP8
	SMemMat.Ks[PIdx_8]=InMat.Ks[PIdx_8];
#endif
#ifdef ILP9
	SMemMat.Ks[PIdx_9]=InMat.Ks[PIdx_9];
#endif
#ifdef ILP10
	SMemMat.Ks[PIdx_10]=InMat.Ks[PIdx_10];
#endif
#ifdef ILP11
	SMemMat.Ks[PIdx_11]=InMat.Ks[PIdx_11];
#endif
#ifdef ILP12
	SMemMat.Ks[PIdx_12]=InMat.Ks[PIdx_12];
#endif
#ifdef ILP13
	SMemMat.Ks[PIdx_13]=InMat.Ks[PIdx_13];
#endif
#ifdef ILP14
	SMemMat.Ks[PIdx_14]=InMat.Ks[PIdx_14];
#endif
#ifdef ILP15
	SMemMat.Ks[PIdx_15]=InMat.Ks[PIdx_15];
#endif
#ifdef ILP16
	SMemMat.Ks[PIdx_16]=InMat.Ks[PIdx_16];
#endif
#ifdef ILP17
	SMemMat.Ks[PIdx_17]=InMat.Ks[PIdx_17];
#endif
#ifdef ILP18
	SMemMat.Ks[PIdx_18]=InMat.Ks[PIdx_18];
#endif
#ifdef ILP19
	SMemMat.Ks[PIdx_19]=InMat.Ks[PIdx_19];
#endif
#ifdef ILP20
	SMemMat.Ks[PIdx_20]=InMat.Ks[PIdx_20];
#endif
#ifdef ILP21
	SMemMat.Ks[PIdx_21]=InMat.Ks[PIdx_21];
#endif
#ifdef ILP22
	SMemMat.Ks[PIdx_22]=InMat.Ks[PIdx_22];
#endif
#ifdef ILP23
	SMemMat.Ks[PIdx_23]=InMat.Ks[PIdx_23];
#endif
#ifdef ILP24
	SMemMat.Ks[PIdx_24]=InMat.Ks[PIdx_24];
#endif
#ifdef ILP25
	SMemMat.Ks[PIdx_25]=InMat.Ks[PIdx_25];
#endif
#ifdef ILP26
	SMemMat.Ks[PIdx_26]=InMat.Ks[PIdx_26];
#endif
#ifdef ILP27
	SMemMat.Ks[PIdx_27]=InMat.Ks[PIdx_27];
#endif
#ifdef ILP28
	SMemMat.Ks[PIdx_28]=InMat.Ks[PIdx_28];
#endif
#ifdef ILP29
	SMemMat.Ks[PIdx_29]=InMat.Ks[PIdx_29];
#endif
#ifdef ILP30
	SMemMat.Ks[PIdx_30]=InMat.Ks[PIdx_30];
#endif
#ifdef ILP31
	SMemMat.Ks[PIdx_31]=InMat.Ks[PIdx_31];
#endif
#ifdef ILP32
	SMemMat.Ks[PIdx_32]=InMat.Ks[PIdx_32];
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
#ifdef ILP5
	SMemMat.boolModel[PIdx_5]=InMat.boolModel[PIdx_5];
#endif
#ifdef ILP6
	SMemMat.boolModel[PIdx_6]=InMat.boolModel[PIdx_6];
#endif
#ifdef ILP7
	SMemMat.boolModel[PIdx_7]=InMat.boolModel[PIdx_7];
#endif
#ifdef ILP8
	SMemMat.boolModel[PIdx_8]=InMat.boolModel[PIdx_8];
#endif
#ifdef ILP9
	SMemMat.boolModel[PIdx_9]=InMat.boolModel[PIdx_9];
#endif
#ifdef ILP10
	SMemMat.boolModel[PIdx_10]=InMat.boolModel[PIdx_10];
#endif
#ifdef ILP11
	SMemMat.boolModel[PIdx_11]=InMat.boolModel[PIdx_11];
#endif
#ifdef ILP12
	SMemMat.boolModel[PIdx_12]=InMat.boolModel[PIdx_12];
#endif
#ifdef ILP13
	SMemMat.boolModel[PIdx_13]=InMat.boolModel[PIdx_13];
#endif
#ifdef ILP14
	SMemMat.boolModel[PIdx_14]=InMat.boolModel[PIdx_14];
#endif
#ifdef ILP15
	SMemMat.boolModel[PIdx_15]=InMat.boolModel[PIdx_15];
#endif
#ifdef ILP16
	SMemMat.boolModel[PIdx_16]=InMat.boolModel[PIdx_16];
#endif
#ifdef ILP17
	SMemMat.boolModel[PIdx_17]=InMat.boolModel[PIdx_17];
#endif
#ifdef ILP18
	SMemMat.boolModel[PIdx_18]=InMat.boolModel[PIdx_18];
#endif
#ifdef ILP19
	SMemMat.boolModel[PIdx_19]=InMat.boolModel[PIdx_19];
#endif
#ifdef ILP20
	SMemMat.boolModel[PIdx_20]=InMat.boolModel[PIdx_20];
#endif
#ifdef ILP21
	SMemMat.boolModel[PIdx_21]=InMat.boolModel[PIdx_21];
#endif
#ifdef ILP22
	SMemMat.boolModel[PIdx_22]=InMat.boolModel[PIdx_22];
#endif
#ifdef ILP23
	SMemMat.boolModel[PIdx_23]=InMat.boolModel[PIdx_23];
#endif
#ifdef ILP24
	SMemMat.boolModel[PIdx_24]=InMat.boolModel[PIdx_24];
#endif
#ifdef ILP25
	SMemMat.boolModel[PIdx_25]=InMat.boolModel[PIdx_25];
#endif
#ifdef ILP26
	SMemMat.boolModel[PIdx_26]=InMat.boolModel[PIdx_26];
#endif
#ifdef ILP27
	SMemMat.boolModel[PIdx_27]=InMat.boolModel[PIdx_27];
#endif
#ifdef ILP28
	SMemMat.boolModel[PIdx_28]=InMat.boolModel[PIdx_28];
#endif
#ifdef ILP29
	SMemMat.boolModel[PIdx_29]=InMat.boolModel[PIdx_29];
#endif
#ifdef ILP30
	SMemMat.boolModel[PIdx_30]=InMat.boolModel[PIdx_30];
#endif
#ifdef ILP31
	SMemMat.boolModel[PIdx_31]=InMat.boolModel[PIdx_31];
#endif
#ifdef ILP32
	SMemMat.boolModel[PIdx_32]=InMat.boolModel[PIdx_32];
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
#ifdef ILP5
	MYDTYPE SonNo_5=InMat.SonNoVec[PIdx_5];
#endif
#ifdef ILP6
	MYDTYPE SonNo_6=InMat.SonNoVec[PIdx_6];
#endif
#ifdef ILP7
	MYDTYPE SonNo_7=InMat.SonNoVec[PIdx_7];
#endif
#ifdef ILP8
	MYDTYPE SonNo_8=InMat.SonNoVec[PIdx_8];
#endif
#ifdef ILP9
	MYDTYPE SonNo_9=InMat.SonNoVec[PIdx_9];
#endif
#ifdef ILP10
	MYDTYPE SonNo_10=InMat.SonNoVec[PIdx_10];
#endif
#ifdef ILP11
	MYDTYPE SonNo_11=InMat.SonNoVec[PIdx_11];
#endif
#ifdef ILP12
	MYDTYPE SonNo_12=InMat.SonNoVec[PIdx_12];
#endif
#ifdef ILP13
	MYDTYPE SonNo_13=InMat.SonNoVec[PIdx_13];
#endif
#ifdef ILP14
	MYDTYPE SonNo_14=InMat.SonNoVec[PIdx_14];
#endif
#ifdef ILP15
	MYDTYPE SonNo_15=InMat.SonNoVec[PIdx_15];
#endif
#ifdef ILP16
	MYDTYPE SonNo_16=InMat.SonNoVec[PIdx_16];
#endif
#ifdef ILP17
	MYDTYPE SonNo_17=InMat.SonNoVec[PIdx_17];
#endif
#ifdef ILP18
	MYDTYPE SonNo_18=InMat.SonNoVec[PIdx_18];
#endif
#ifdef ILP19
	MYDTYPE SonNo_19=InMat.SonNoVec[PIdx_19];
#endif
#ifdef ILP20
	MYDTYPE SonNo_20=InMat.SonNoVec[PIdx_20];
#endif
#ifdef ILP21
	MYDTYPE SonNo_21=InMat.SonNoVec[PIdx_21];
#endif
#ifdef ILP22
	MYDTYPE SonNo_22=InMat.SonNoVec[PIdx_22];
#endif
#ifdef ILP23
	MYDTYPE SonNo_23=InMat.SonNoVec[PIdx_23];
#endif
#ifdef ILP24
	MYDTYPE SonNo_24=InMat.SonNoVec[PIdx_24];
#endif
#ifdef ILP25
	MYDTYPE SonNo_25=InMat.SonNoVec[PIdx_25];
#endif
#ifdef ILP26
	MYDTYPE SonNo_26=InMat.SonNoVec[PIdx_26];
#endif
#ifdef ILP27
	MYDTYPE SonNo_27=InMat.SonNoVec[PIdx_27];
#endif
#ifdef ILP28
	MYDTYPE SonNo_28=InMat.SonNoVec[PIdx_28];
#endif
#ifdef ILP29
	MYDTYPE SonNo_29=InMat.SonNoVec[PIdx_29];
#endif
#ifdef ILP30
	MYDTYPE SonNo_30=InMat.SonNoVec[PIdx_30];
#endif
#ifdef ILP31
	MYDTYPE SonNo_31=InMat.SonNoVec[PIdx_31];
#endif
#ifdef ILP32
	MYDTYPE SonNo_32=InMat.SonNoVec[PIdx_32];
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
#ifdef ILP5
	Vs[PIdx_5]=V[PIdx_5];
#endif
#ifdef ILP6
	Vs[PIdx_6]=V[PIdx_6];
#endif
#ifdef ILP7
	Vs[PIdx_7]=V[PIdx_7];
#endif
#ifdef ILP8
	Vs[PIdx_8]=V[PIdx_8];
#endif
#ifdef ILP9
	Vs[PIdx_9]=V[PIdx_9];
#endif
#ifdef ILP10
	Vs[PIdx_10]=V[PIdx_10];
#endif
#ifdef ILP11
	Vs[PIdx_11]=V[PIdx_11];
#endif
#ifdef ILP12
	Vs[PIdx_12]=V[PIdx_12];
#endif
#ifdef ILP13
	Vs[PIdx_13]=V[PIdx_13];
#endif
#ifdef ILP14
	Vs[PIdx_14]=V[PIdx_14];
#endif
#ifdef ILP15
	Vs[PIdx_15]=V[PIdx_15];
#endif
#ifdef ILP16
	Vs[PIdx_16]=V[PIdx_16];
#endif
#ifdef ILP17
	Vs[PIdx_17]=V[PIdx_17];
#endif
#ifdef ILP18
	Vs[PIdx_18]=V[PIdx_18];
#endif
#ifdef ILP19
	Vs[PIdx_19]=V[PIdx_19];
#endif
#ifdef ILP20
	Vs[PIdx_20]=V[PIdx_20];
#endif
#ifdef ILP21
	Vs[PIdx_21]=V[PIdx_21];
#endif
#ifdef ILP22
	Vs[PIdx_22]=V[PIdx_22];
#endif
#ifdef ILP23
	Vs[PIdx_23]=V[PIdx_23];
#endif
#ifdef ILP24
	Vs[PIdx_24]=V[PIdx_24];
#endif
#ifdef ILP25
	Vs[PIdx_25]=V[PIdx_25];
#endif
#ifdef ILP26
	Vs[PIdx_26]=V[PIdx_26];
#endif
#ifdef ILP27
	Vs[PIdx_27]=V[PIdx_27];
#endif
#ifdef ILP28
	Vs[PIdx_28]=V[PIdx_28];
#endif
#ifdef ILP29
	Vs[PIdx_29]=V[PIdx_29];
#endif
#ifdef ILP30
	Vs[PIdx_30]=V[PIdx_30];
#endif
#ifdef ILP31
	Vs[PIdx_31]=V[PIdx_31];
#endif
#ifdef ILP32
	Vs[PIdx_32]=V[PIdx_32];
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
#ifdef ILP5
	MYDTYPE parentIndex_5;
#endif
#ifdef ILP6
	MYDTYPE parentIndex_6;
#endif
#ifdef ILP7
	MYDTYPE parentIndex_7;
#endif
#ifdef ILP8
	MYDTYPE parentIndex_8;
#endif
#ifdef ILP9
	MYDTYPE parentIndex_9;
#endif
#ifdef ILP10
	MYDTYPE parentIndex_10;
#endif
#ifdef ILP11
	MYDTYPE parentIndex_11;
#endif
#ifdef ILP12
	MYDTYPE parentIndex_12;
#endif
#ifdef ILP13
	MYDTYPE parentIndex_13;
#endif
#ifdef ILP14
	MYDTYPE parentIndex_14;
#endif
#ifdef ILP15
	MYDTYPE parentIndex_15;
#endif
#ifdef ILP16
	MYDTYPE parentIndex_16;
#endif
#ifdef ILP17
	MYDTYPE parentIndex_17;
#endif
#ifdef ILP18
	MYDTYPE parentIndex_18;
#endif
#ifdef ILP19
	MYDTYPE parentIndex_19;
#endif
#ifdef ILP20
	MYDTYPE parentIndex_20;
#endif
#ifdef ILP21
	MYDTYPE parentIndex_21;
#endif
#ifdef ILP22
	MYDTYPE parentIndex_22;
#endif
#ifdef ILP23
	MYDTYPE parentIndex_23;
#endif
#ifdef ILP24
	MYDTYPE parentIndex_24;
#endif
#ifdef ILP25
	MYDTYPE parentIndex_25;
#endif
#ifdef ILP26
	MYDTYPE parentIndex_26;
#endif
#ifdef ILP27
	MYDTYPE parentIndex_27;
#endif
#ifdef ILP28
	MYDTYPE parentIndex_28;
#endif
#ifdef ILP29
	MYDTYPE parentIndex_29;
#endif
#ifdef ILP30
	MYDTYPE parentIndex_30;
#endif
#ifdef ILP31
	MYDTYPE parentIndex_31;
#endif
#ifdef ILP32
	MYDTYPE parentIndex_32;
#endif
	MYDTYPE Eidx;
	MYDTYPE Eidx_2;
#ifdef ILP3
	MYDTYPE Eidx_3;
#endif
#ifdef ILP4
	MYDTYPE Eidx_4;
#endif
#ifdef ILP5
	MYDTYPE Eidx_5;
#endif
#ifdef ILP6
	MYDTYPE Eidx_6;
#endif
#ifdef ILP7
	MYDTYPE Eidx_7;
#endif
#ifdef ILP8
	MYDTYPE Eidx_8;
#endif
#ifdef ILP9
	MYDTYPE Eidx_9;
#endif
#ifdef ILP10
	MYDTYPE Eidx_10;
#endif
#ifdef ILP11
	MYDTYPE Eidx_11;
#endif
#ifdef ILP12
	MYDTYPE Eidx_12;
#endif
#ifdef ILP13
	MYDTYPE Eidx_13;
#endif
#ifdef ILP14
	MYDTYPE Eidx_14;
#endif
#ifdef ILP15
	MYDTYPE Eidx_15;
#endif
#ifdef ILP16
	MYDTYPE Eidx_16;
#endif
#ifdef ILP17
	MYDTYPE Eidx_17;
#endif
#ifdef ILP18
	MYDTYPE Eidx_18;
#endif
#ifdef ILP19
	MYDTYPE Eidx_19;
#endif
#ifdef ILP20
	MYDTYPE Eidx_20;
#endif
#ifdef ILP21
	MYDTYPE Eidx_21;
#endif
#ifdef ILP22
	MYDTYPE Eidx_22;
#endif
#ifdef ILP23
	MYDTYPE Eidx_23;
#endif
#ifdef ILP24
	MYDTYPE Eidx_24;
#endif
#ifdef ILP25
	MYDTYPE Eidx_25;
#endif
#ifdef ILP26
	MYDTYPE Eidx_26;
#endif
#ifdef ILP27
	MYDTYPE Eidx_27;
#endif
#ifdef ILP28
	MYDTYPE Eidx_28;
#endif
#ifdef ILP29
	MYDTYPE Eidx_29;
#endif
#ifdef ILP30
	MYDTYPE Eidx_30;
#endif
#ifdef ILP31
	MYDTYPE Eidx_31;
#endif
#ifdef ILP32
	MYDTYPE Eidx_32;
#endif
	Eidx = SMemMat.N-PIdx;
	Eidx_2 = SMemMat.N-PIdx_2;
#ifdef ILP3
	Eidx_3 = SMemMat.N-PIdx_3;
#endif
#ifdef ILP4
	Eidx_4 = SMemMat.N-PIdx_4;
#endif
#ifdef ILP5
	Eidx_5 = SMemMat.N-PIdx_5;
#endif
#ifdef ILP6
	Eidx_6 = SMemMat.N-PIdx_6;
#endif
#ifdef ILP7
	Eidx_7 = SMemMat.N-PIdx_7;
#endif
#ifdef ILP8
	Eidx_8 = SMemMat.N-PIdx_8;
#endif
#ifdef ILP9
	Eidx_9 = SMemMat.N-PIdx_9;
#endif
#ifdef ILP10
	Eidx_10 = SMemMat.N-PIdx_10;
#endif
#ifdef ILP11
	Eidx_11 = SMemMat.N-PIdx_11;
#endif
#ifdef ILP12
	Eidx_12 = SMemMat.N-PIdx_12;
#endif
#ifdef ILP13
	Eidx_13 = SMemMat.N-PIdx_13;
#endif
#ifdef ILP14
	Eidx_14 = SMemMat.N-PIdx_14;
#endif
#ifdef ILP15
	Eidx_15 = SMemMat.N-PIdx_15;
#endif
#ifdef ILP16
	Eidx_16 = SMemMat.N-PIdx_16;
#endif
#ifdef ILP17
	Eidx_17 = SMemMat.N-PIdx_17;
#endif
#ifdef ILP18
	Eidx_18 = SMemMat.N-PIdx_18;
#endif
#ifdef ILP19
	Eidx_19 = SMemMat.N-PIdx_19;
#endif
#ifdef ILP20
	Eidx_20 = SMemMat.N-PIdx_20;
#endif
#ifdef ILP21
	Eidx_21 = SMemMat.N-PIdx_21;
#endif
#ifdef ILP22
	Eidx_22 = SMemMat.N-PIdx_22;
#endif
#ifdef ILP23
	Eidx_23 = SMemMat.N-PIdx_23;
#endif
#ifdef ILP24
	Eidx_24 = SMemMat.N-PIdx_24;
#endif
#ifdef ILP25
	Eidx_25 = SMemMat.N-PIdx_25;
#endif
#ifdef ILP26
	Eidx_26 = SMemMat.N-PIdx_26;
#endif
#ifdef ILP27
	Eidx_27 = SMemMat.N-PIdx_27;
#endif
#ifdef ILP28
	Eidx_28 = SMemMat.N-PIdx_28;
#endif
#ifdef ILP29
	Eidx_29 = SMemMat.N-PIdx_29;
#endif
#ifdef ILP30
	Eidx_30 = SMemMat.N-PIdx_30;
#endif
#ifdef ILP31
	Eidx_31 = SMemMat.N-PIdx_31;
#endif
#ifdef ILP32
	Eidx_32 = SMemMat.N-PIdx_32;
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
#ifdef ILP5
	parentIndex_5 =SMemMat.N-SMemMat.Ks[SMemMat.N-PIdx_5];
#endif
#ifdef ILP6
	parentIndex_6 =SMemMat.N-SMemMat.Ks[SMemMat.N-PIdx_6];
#endif
#ifdef ILP7
	parentIndex_7 =SMemMat.N-SMemMat.Ks[SMemMat.N-PIdx_7];
#endif
#ifdef ILP8
	parentIndex_8 =SMemMat.N-SMemMat.Ks[SMemMat.N-PIdx_8];
#endif
#ifdef ILP9
	parentIndex_9 =SMemMat.N-SMemMat.Ks[SMemMat.N-PIdx_9];
#endif
#ifdef ILP10
	parentIndex_10 =SMemMat.N-SMemMat.Ks[SMemMat.N-PIdx_10];
#endif
#ifdef ILP11
	parentIndex_11 =SMemMat.N-SMemMat.Ks[SMemMat.N-PIdx_11];
#endif
#ifdef ILP12
	parentIndex_12 =SMemMat.N-SMemMat.Ks[SMemMat.N-PIdx_12];
#endif
#ifdef ILP13
	parentIndex_13 =SMemMat.N-SMemMat.Ks[SMemMat.N-PIdx_13];
#endif
#ifdef ILP14
	parentIndex_14 =SMemMat.N-SMemMat.Ks[SMemMat.N-PIdx_14];
#endif
#ifdef ILP15
	parentIndex_15 =SMemMat.N-SMemMat.Ks[SMemMat.N-PIdx_15];
#endif
#ifdef ILP16
	parentIndex_16 =SMemMat.N-SMemMat.Ks[SMemMat.N-PIdx_16];
#endif
#ifdef ILP17
	parentIndex_17 =SMemMat.N-SMemMat.Ks[SMemMat.N-PIdx_17];
#endif
#ifdef ILP18
	parentIndex_18 =SMemMat.N-SMemMat.Ks[SMemMat.N-PIdx_18];
#endif
#ifdef ILP19
	parentIndex_19 =SMemMat.N-SMemMat.Ks[SMemMat.N-PIdx_19];
#endif
#ifdef ILP20
	parentIndex_20 =SMemMat.N-SMemMat.Ks[SMemMat.N-PIdx_20];
#endif
#ifdef ILP21
	parentIndex_21 =SMemMat.N-SMemMat.Ks[SMemMat.N-PIdx_21];
#endif
#ifdef ILP22
	parentIndex_22 =SMemMat.N-SMemMat.Ks[SMemMat.N-PIdx_22];
#endif
#ifdef ILP23
	parentIndex_23 =SMemMat.N-SMemMat.Ks[SMemMat.N-PIdx_23];
#endif
#ifdef ILP24
	parentIndex_24 =SMemMat.N-SMemMat.Ks[SMemMat.N-PIdx_24];
#endif
#ifdef ILP25
	parentIndex_25 =SMemMat.N-SMemMat.Ks[SMemMat.N-PIdx_25];
#endif
#ifdef ILP26
	parentIndex_26 =SMemMat.N-SMemMat.Ks[SMemMat.N-PIdx_26];
#endif
#ifdef ILP27
	parentIndex_27 =SMemMat.N-SMemMat.Ks[SMemMat.N-PIdx_27];
#endif
#ifdef ILP28
	parentIndex_28 =SMemMat.N-SMemMat.Ks[SMemMat.N-PIdx_28];
#endif
#ifdef ILP29
	parentIndex_29 =SMemMat.N-SMemMat.Ks[SMemMat.N-PIdx_29];
#endif
#ifdef ILP30
	parentIndex_30 =SMemMat.N-SMemMat.Ks[SMemMat.N-PIdx_30];
#endif
#ifdef ILP31
	parentIndex_31 =SMemMat.N-SMemMat.Ks[SMemMat.N-PIdx_31];
#endif
#ifdef ILP32
	parentIndex_32 =SMemMat.N-SMemMat.Ks[SMemMat.N-PIdx_32];
#endif

	float rhs,D,gModel,StimCurrent,dv;
	float rhs_2,D_2,gModel_2,StimCurrent_2,dv_2;
#ifdef ILP3
	float rhs_3,D_3,gModel_3,StimCurrent_3,dv_3;
#endif
#ifdef ILP4
	float rhs_4,D_4,gModel_4,StimCurrent_4,dv_4;
#endif
#ifdef ILP5
	float rhs_5,D_5,gModel_5,StimCurrent_5,dv_5;
#endif
#ifdef ILP6
	float rhs_6,D_6,gModel_6,StimCurrent_6,dv_6;
#endif
#ifdef ILP7
	float rhs_7,D_7,gModel_7,StimCurrent_7,dv_7;
#endif
#ifdef ILP8
	float rhs_8,D_8,gModel_8,StimCurrent_8,dv_8;
#endif
#ifdef ILP9
	float rhs_9,D_9,gModel_9,StimCurrent_9,dv_9;
#endif
#ifdef ILP10
	float rhs_10,D_10,gModel_10,StimCurrent_10,dv_10;
#endif
#ifdef ILP11
	float rhs_11,D_11,gModel_11,StimCurrent_11,dv_11;
#endif
#ifdef ILP12
	float rhs_12,D_12,gModel_12,StimCurrent_12,dv_12;
#endif
#ifdef ILP13
	float rhs_13,D_13,gModel_13,StimCurrent_13,dv_13;
#endif
#ifdef ILP14
	float rhs_14,D_14,gModel_14,StimCurrent_14,dv_14;
#endif
#ifdef ILP15
	float rhs_15,D_15,gModel_15,StimCurrent_15,dv_15;
#endif
#ifdef ILP16
	float rhs_16,D_16,gModel_16,StimCurrent_16,dv_16;
#endif
#ifdef ILP17
	float rhs_17,D_17,gModel_17,StimCurrent_17,dv_17;
#endif
#ifdef ILP18
	float rhs_18,D_18,gModel_18,StimCurrent_18,dv_18;
#endif
#ifdef ILP19
	float rhs_19,D_19,gModel_19,StimCurrent_19,dv_19;
#endif
#ifdef ILP20
	float rhs_20,D_20,gModel_20,StimCurrent_20,dv_20;
#endif
#ifdef ILP21
	float rhs_21,D_21,gModel_21,StimCurrent_21,dv_21;
#endif
#ifdef ILP22
	float rhs_22,D_22,gModel_22,StimCurrent_22,dv_22;
#endif
#ifdef ILP23
	float rhs_23,D_23,gModel_23,StimCurrent_23,dv_23;
#endif
#ifdef ILP24
	float rhs_24,D_24,gModel_24,StimCurrent_24,dv_24;
#endif
#ifdef ILP25
	float rhs_25,D_25,gModel_25,StimCurrent_25,dv_25;
#endif
#ifdef ILP26
	float rhs_26,D_26,gModel_26,StimCurrent_26,dv_26;
#endif
#ifdef ILP27
	float rhs_27,D_27,gModel_27,StimCurrent_27,dv_27;
#endif
#ifdef ILP28
	float rhs_28,D_28,gModel_28,StimCurrent_28,dv_28;
#endif
#ifdef ILP29
	float rhs_29,D_29,gModel_29,StimCurrent_29,dv_29;
#endif
#ifdef ILP30
	float rhs_30,D_30,gModel_30,StimCurrent_30,dv_30;
#endif
#ifdef ILP31
	float rhs_31,D_31,gModel_31,StimCurrent_31,dv_31;
#endif
#ifdef ILP32
	float rhs_32,D_32,gModel_32,StimCurrent_32,dv_32;
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
#ifdef ILP5
		rhs_5=0;
#endif
#ifdef ILP6
		rhs_6=0;
#endif
#ifdef ILP7
		rhs_7=0;
#endif
#ifdef ILP8
		rhs_8=0;
#endif
#ifdef ILP9
		rhs_9=0;
#endif
#ifdef ILP10
		rhs_10=0;
#endif
#ifdef ILP11
		rhs_11=0;
#endif
#ifdef ILP12
		rhs_12=0;
#endif
#ifdef ILP13
		rhs_13=0;
#endif
#ifdef ILP14
		rhs_14=0;
#endif
#ifdef ILP15
		rhs_15=0;
#endif
#ifdef ILP16
		rhs_16=0;
#endif
#ifdef ILP17
		rhs_17=0;
#endif
#ifdef ILP18
		rhs_18=0;
#endif
#ifdef ILP19
		rhs_19=0;
#endif
#ifdef ILP20
		rhs_20=0;
#endif
#ifdef ILP21
		rhs_21=0;
#endif
#ifdef ILP22
		rhs_22=0;
#endif
#ifdef ILP23
		rhs_23=0;
#endif
#ifdef ILP24
		rhs_24=0;
#endif
#ifdef ILP25
		rhs_25=0;
#endif
#ifdef ILP26
		rhs_26=0;
#endif
#ifdef ILP27
		rhs_27=0;
#endif
#ifdef ILP28
		rhs_28=0;
#endif
#ifdef ILP29
		rhs_29=0;
#endif
#ifdef ILP30
		rhs_30=0;
#endif
#ifdef ILP31
		rhs_31=0;
#endif
#ifdef ILP32
		rhs_32=0;
#endif
		D=0;
		D_2=0;
#ifdef ILP3
		D_3=0;
#endif
#ifdef ILP4
		D_4=0;
#endif
#ifdef ILP5
		D_5=0;
#endif
#ifdef ILP6
		D_6=0;
#endif
#ifdef ILP7
		D_7=0;
#endif
#ifdef ILP8
		D_8=0;
#endif
#ifdef ILP9
		D_9=0;
#endif
#ifdef ILP10
		D_10=0;
#endif
#ifdef ILP11
		D_11=0;
#endif
#ifdef ILP12
		D_12=0;
#endif
#ifdef ILP13
		D_13=0;
#endif
#ifdef ILP14
		D_14=0;
#endif
#ifdef ILP15
		D_15=0;
#endif
#ifdef ILP16
		D_16=0;
#endif
#ifdef ILP17
		D_17=0;
#endif
#ifdef ILP18
		D_18=0;
#endif
#ifdef ILP19
		D_19=0;
#endif
#ifdef ILP20
		D_20=0;
#endif
#ifdef ILP21
		D_21=0;
#endif
#ifdef ILP22
		D_22=0;
#endif
#ifdef ILP23
		D_23=0;
#endif
#ifdef ILP24
		D_24=0;
#endif
#ifdef ILP25
		D_25=0;
#endif
#ifdef ILP26
		D_26=0;
#endif
#ifdef ILP27
		D_27=0;
#endif
#ifdef ILP28
		D_28=0;
#endif
#ifdef ILP29
		D_29=0;
#endif
#ifdef ILP30
		D_30=0;
#endif
#ifdef ILP31
		D_31=0;
#endif
#ifdef ILP32
		D_32=0;
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
#ifdef ILP5
		KBreakpointModel(sumCurrents_5, sumConductivity_5,v_5,ModelStates_5[0],ModelStates_5[1],ModelStates_5[2],p1_5,p2_5,p3_5,p4_5,p5_5,p6_5);
#endif
#ifdef ILP6
		KBreakpointModel(sumCurrents_6, sumConductivity_6,v_6,ModelStates_6[0],ModelStates_6[1],ModelStates_6[2],p1_6,p2_6,p3_6,p4_6,p5_6,p6_6);
#endif
#ifdef ILP7
		KBreakpointModel(sumCurrents_7, sumConductivity_7,v_7,ModelStates_7[0],ModelStates_7[1],ModelStates_7[2],p1_7,p2_7,p3_7,p4_7,p5_7,p6_7);
#endif
#ifdef ILP8
		KBreakpointModel(sumCurrents_8, sumConductivity_8,v_8,ModelStates_8[0],ModelStates_8[1],ModelStates_8[2],p1_8,p2_8,p3_8,p4_8,p5_8,p6_8);
#endif
#ifdef ILP9
		KBreakpointModel(sumCurrents_9, sumConductivity_9,v_9,ModelStates_9[0],ModelStates_9[1],ModelStates_9[2],p1_9,p2_9,p3_9,p4_9,p5_9,p6_9);
#endif
#ifdef ILP10
		KBreakpointModel(sumCurrents_10, sumConductivity_10,v_10,ModelStates_10[0],ModelStates_10[1],ModelStates_10[2],p1_10,p2_10,p3_10,p4_10,p5_10,p6_10);
#endif
#ifdef ILP11
		KBreakpointModel(sumCurrents_11, sumConductivity_11,v_11,ModelStates_11[0],ModelStates_11[1],ModelStates_11[2],p1_11,p2_11,p3_11,p4_11,p5_11,p6_11);
#endif
#ifdef ILP12
		KBreakpointModel(sumCurrents_12, sumConductivity_12,v_12,ModelStates_12[0],ModelStates_12[1],ModelStates_12[2],p1_12,p2_12,p3_12,p4_12,p5_12,p6_12);
#endif
#ifdef ILP13
		KBreakpointModel(sumCurrents_13, sumConductivity_13,v_13,ModelStates_13[0],ModelStates_13[1],ModelStates_13[2],p1_13,p2_13,p3_13,p4_13,p5_13,p6_13);
#endif
#ifdef ILP14
		KBreakpointModel(sumCurrents_14, sumConductivity_14,v_14,ModelStates_14[0],ModelStates_14[1],ModelStates_14[2],p1_14,p2_14,p3_14,p4_14,p5_14,p6_14);
#endif
#ifdef ILP15
		KBreakpointModel(sumCurrents_15, sumConductivity_15,v_15,ModelStates_15[0],ModelStates_15[1],ModelStates_15[2],p1_15,p2_15,p3_15,p4_15,p5_15,p6_15);
#endif
#ifdef ILP16
		KBreakpointModel(sumCurrents_16, sumConductivity_16,v_16,ModelStates_16[0],ModelStates_16[1],ModelStates_16[2],p1_16,p2_16,p3_16,p4_16,p5_16,p6_16);
#endif
#ifdef ILP17
		KBreakpointModel(sumCurrents_17, sumConductivity_17,v_17,ModelStates_17[0],ModelStates_17[1],ModelStates_17[2],p1_17,p2_17,p3_17,p4_17,p5_17,p6_17);
#endif
#ifdef ILP18
		KBreakpointModel(sumCurrents_18, sumConductivity_18,v_18,ModelStates_18[0],ModelStates_18[1],ModelStates_18[2],p1_18,p2_18,p3_18,p4_18,p5_18,p6_18);
#endif
#ifdef ILP19
		KBreakpointModel(sumCurrents_19, sumConductivity_19,v_19,ModelStates_19[0],ModelStates_19[1],ModelStates_19[2],p1_19,p2_19,p3_19,p4_19,p5_19,p6_19);
#endif
#ifdef ILP20
		KBreakpointModel(sumCurrents_20, sumConductivity_20,v_20,ModelStates_20[0],ModelStates_20[1],ModelStates_20[2],p1_20,p2_20,p3_20,p4_20,p5_20,p6_20);
#endif
#ifdef ILP21
		KBreakpointModel(sumCurrents_21, sumConductivity_21,v_21,ModelStates_21[0],ModelStates_21[1],ModelStates_21[2],p1_21,p2_21,p3_21,p4_21,p5_21,p6_21);
#endif
#ifdef ILP22
		KBreakpointModel(sumCurrents_22, sumConductivity_22,v_22,ModelStates_22[0],ModelStates_22[1],ModelStates_22[2],p1_22,p2_22,p3_22,p4_22,p5_22,p6_22);
#endif
#ifdef ILP23
		KBreakpointModel(sumCurrents_23, sumConductivity_23,v_23,ModelStates_23[0],ModelStates_23[1],ModelStates_23[2],p1_23,p2_23,p3_23,p4_23,p5_23,p6_23);
#endif
#ifdef ILP24
		KBreakpointModel(sumCurrents_24, sumConductivity_24,v_24,ModelStates_24[0],ModelStates_24[1],ModelStates_24[2],p1_24,p2_24,p3_24,p4_24,p5_24,p6_24);
#endif
#ifdef ILP25
		KBreakpointModel(sumCurrents_25, sumConductivity_25,v_25,ModelStates_25[0],ModelStates_25[1],ModelStates_25[2],p1_25,p2_25,p3_25,p4_25,p5_25,p6_25);
#endif
#ifdef ILP26
		KBreakpointModel(sumCurrents_26, sumConductivity_26,v_26,ModelStates_26[0],ModelStates_26[1],ModelStates_26[2],p1_26,p2_26,p3_26,p4_26,p5_26,p6_26);
#endif
#ifdef ILP27
		KBreakpointModel(sumCurrents_27, sumConductivity_27,v_27,ModelStates_27[0],ModelStates_27[1],ModelStates_27[2],p1_27,p2_27,p3_27,p4_27,p5_27,p6_27);
#endif
#ifdef ILP28
		KBreakpointModel(sumCurrents_28, sumConductivity_28,v_28,ModelStates_28[0],ModelStates_28[1],ModelStates_28[2],p1_28,p2_28,p3_28,p4_28,p5_28,p6_28);
#endif
#ifdef ILP29
		KBreakpointModel(sumCurrents_29, sumConductivity_29,v_29,ModelStates_29[0],ModelStates_29[1],ModelStates_29[2],p1_29,p2_29,p3_29,p4_29,p5_29,p6_29);
#endif
#ifdef ILP30
		KBreakpointModel(sumCurrents_30, sumConductivity_30,v_30,ModelStates_30[0],ModelStates_30[1],ModelStates_30[2],p1_30,p2_30,p3_30,p4_30,p5_30,p6_30);
#endif
#ifdef ILP31
		KBreakpointModel(sumCurrents_31, sumConductivity_31,v_31,ModelStates_31[0],ModelStates_31[1],ModelStates_31[2],p1_31,p2_31,p3_31,p4_31,p5_31,p6_31);
#endif
#ifdef ILP32
		KBreakpointModel(sumCurrents_32, sumConductivity_32,v_32,ModelStates_32[0],ModelStates_32[1],ModelStates_32[2],p1_32,p2_32,p3_32,p4_32,p5_32,p6_32);
#endif
		KBreakpointModel(sumCurrentsDv, sumConductivityDv,v+0.001,ModelStates[0],ModelStates[1],ModelStates[2],p1,p2,p3,p4,p5,p6);
		KBreakpointModel(sumCurrentsDv_2, sumConductivityDv_2,v_2+0.001,ModelStates_2[0],ModelStates_2[1],ModelStates_2[2],p1_2,p2_2,p3_2,p4_2,p5_2,p6_2);
#ifdef ILP3
		KBreakpointModel(sumCurrentsDv_3, sumConductivityDv_3,v_3+0.001,ModelStates_3[0],ModelStates_3[1],ModelStates_3[2],p1_3,p2_3,p3_3,p4_3,p5_3,p6_3);
#endif
#ifdef ILP4
		KBreakpointModel(sumCurrentsDv_4, sumConductivityDv_4,v_4+0.001,ModelStates_4[0],ModelStates_4[1],ModelStates_4[2],p1_4,p2_4,p3_4,p4_4,p5_4,p6_4);
#endif
#ifdef ILP5
		KBreakpointModel(sumCurrentsDv_5, sumConductivityDv_5,v_5+0.001,ModelStates_5[0],ModelStates_5[1],ModelStates_5[2],p1_5,p2_5,p3_5,p4_5,p5_5,p6_5);
#endif
#ifdef ILP6
		KBreakpointModel(sumCurrentsDv_6, sumConductivityDv_6,v_6+0.001,ModelStates_6[0],ModelStates_6[1],ModelStates_6[2],p1_6,p2_6,p3_6,p4_6,p5_6,p6_6);
#endif
#ifdef ILP7
		KBreakpointModel(sumCurrentsDv_7, sumConductivityDv_7,v_7+0.001,ModelStates_7[0],ModelStates_7[1],ModelStates_7[2],p1_7,p2_7,p3_7,p4_7,p5_7,p6_7);
#endif
#ifdef ILP8
		KBreakpointModel(sumCurrentsDv_8, sumConductivityDv_8,v_8+0.001,ModelStates_8[0],ModelStates_8[1],ModelStates_8[2],p1_8,p2_8,p3_8,p4_8,p5_8,p6_8);
#endif
#ifdef ILP9
		KBreakpointModel(sumCurrentsDv_9, sumConductivityDv_9,v_9+0.001,ModelStates_9[0],ModelStates_9[1],ModelStates_9[2],p1_9,p2_9,p3_9,p4_9,p5_9,p6_9);
#endif
#ifdef ILP10
		KBreakpointModel(sumCurrentsDv_10, sumConductivityDv_10,v_10+0.001,ModelStates_10[0],ModelStates_10[1],ModelStates_10[2],p1_10,p2_10,p3_10,p4_10,p5_10,p6_10);
#endif
#ifdef ILP11
		KBreakpointModel(sumCurrentsDv_11, sumConductivityDv_11,v_11+0.001,ModelStates_11[0],ModelStates_11[1],ModelStates_11[2],p1_11,p2_11,p3_11,p4_11,p5_11,p6_11);
#endif
#ifdef ILP12
		KBreakpointModel(sumCurrentsDv_12, sumConductivityDv_12,v_12+0.001,ModelStates_12[0],ModelStates_12[1],ModelStates_12[2],p1_12,p2_12,p3_12,p4_12,p5_12,p6_12);
#endif
#ifdef ILP13
		KBreakpointModel(sumCurrentsDv_13, sumConductivityDv_13,v_13+0.001,ModelStates_13[0],ModelStates_13[1],ModelStates_13[2],p1_13,p2_13,p3_13,p4_13,p5_13,p6_13);
#endif
#ifdef ILP14
		KBreakpointModel(sumCurrentsDv_14, sumConductivityDv_14,v_14+0.001,ModelStates_14[0],ModelStates_14[1],ModelStates_14[2],p1_14,p2_14,p3_14,p4_14,p5_14,p6_14);
#endif
#ifdef ILP15
		KBreakpointModel(sumCurrentsDv_15, sumConductivityDv_15,v_15+0.001,ModelStates_15[0],ModelStates_15[1],ModelStates_15[2],p1_15,p2_15,p3_15,p4_15,p5_15,p6_15);
#endif
#ifdef ILP16
		KBreakpointModel(sumCurrentsDv_16, sumConductivityDv_16,v_16+0.001,ModelStates_16[0],ModelStates_16[1],ModelStates_16[2],p1_16,p2_16,p3_16,p4_16,p5_16,p6_16);
#endif
#ifdef ILP17
		KBreakpointModel(sumCurrentsDv_17, sumConductivityDv_17,v_17+0.001,ModelStates_17[0],ModelStates_17[1],ModelStates_17[2],p1_17,p2_17,p3_17,p4_17,p5_17,p6_17);
#endif
#ifdef ILP18
		KBreakpointModel(sumCurrentsDv_18, sumConductivityDv_18,v_18+0.001,ModelStates_18[0],ModelStates_18[1],ModelStates_18[2],p1_18,p2_18,p3_18,p4_18,p5_18,p6_18);
#endif
#ifdef ILP19
		KBreakpointModel(sumCurrentsDv_19, sumConductivityDv_19,v_19+0.001,ModelStates_19[0],ModelStates_19[1],ModelStates_19[2],p1_19,p2_19,p3_19,p4_19,p5_19,p6_19);
#endif
#ifdef ILP20
		KBreakpointModel(sumCurrentsDv_20, sumConductivityDv_20,v_20+0.001,ModelStates_20[0],ModelStates_20[1],ModelStates_20[2],p1_20,p2_20,p3_20,p4_20,p5_20,p6_20);
#endif
#ifdef ILP21
		KBreakpointModel(sumCurrentsDv_21, sumConductivityDv_21,v_21+0.001,ModelStates_21[0],ModelStates_21[1],ModelStates_21[2],p1_21,p2_21,p3_21,p4_21,p5_21,p6_21);
#endif
#ifdef ILP22
		KBreakpointModel(sumCurrentsDv_22, sumConductivityDv_22,v_22+0.001,ModelStates_22[0],ModelStates_22[1],ModelStates_22[2],p1_22,p2_22,p3_22,p4_22,p5_22,p6_22);
#endif
#ifdef ILP23
		KBreakpointModel(sumCurrentsDv_23, sumConductivityDv_23,v_23+0.001,ModelStates_23[0],ModelStates_23[1],ModelStates_23[2],p1_23,p2_23,p3_23,p4_23,p5_23,p6_23);
#endif
#ifdef ILP24
		KBreakpointModel(sumCurrentsDv_24, sumConductivityDv_24,v_24+0.001,ModelStates_24[0],ModelStates_24[1],ModelStates_24[2],p1_24,p2_24,p3_24,p4_24,p5_24,p6_24);
#endif
#ifdef ILP25
		KBreakpointModel(sumCurrentsDv_25, sumConductivityDv_25,v_25+0.001,ModelStates_25[0],ModelStates_25[1],ModelStates_25[2],p1_25,p2_25,p3_25,p4_25,p5_25,p6_25);
#endif
#ifdef ILP26
		KBreakpointModel(sumCurrentsDv_26, sumConductivityDv_26,v_26+0.001,ModelStates_26[0],ModelStates_26[1],ModelStates_26[2],p1_26,p2_26,p3_26,p4_26,p5_26,p6_26);
#endif
#ifdef ILP27
		KBreakpointModel(sumCurrentsDv_27, sumConductivityDv_27,v_27+0.001,ModelStates_27[0],ModelStates_27[1],ModelStates_27[2],p1_27,p2_27,p3_27,p4_27,p5_27,p6_27);
#endif
#ifdef ILP28
		KBreakpointModel(sumCurrentsDv_28, sumConductivityDv_28,v_28+0.001,ModelStates_28[0],ModelStates_28[1],ModelStates_28[2],p1_28,p2_28,p3_28,p4_28,p5_28,p6_28);
#endif
#ifdef ILP29
		KBreakpointModel(sumCurrentsDv_29, sumConductivityDv_29,v_29+0.001,ModelStates_29[0],ModelStates_29[1],ModelStates_29[2],p1_29,p2_29,p3_29,p4_29,p5_29,p6_29);
#endif
#ifdef ILP30
		KBreakpointModel(sumCurrentsDv_30, sumConductivityDv_30,v_30+0.001,ModelStates_30[0],ModelStates_30[1],ModelStates_30[2],p1_30,p2_30,p3_30,p4_30,p5_30,p6_30);
#endif
#ifdef ILP31
		KBreakpointModel(sumCurrentsDv_31, sumConductivityDv_31,v_31+0.001,ModelStates_31[0],ModelStates_31[1],ModelStates_31[2],p1_31,p2_31,p3_31,p4_31,p5_31,p6_31);
#endif
#ifdef ILP32
		KBreakpointModel(sumCurrentsDv_32, sumConductivityDv_32,v_32+0.001,ModelStates_32[0],ModelStates_32[1],ModelStates_32[2],p1_32,p2_32,p3_32,p4_32,p5_32,p6_32);
#endif

		gModel=0;
		gModel_2=0;
#ifdef ILP3
		gModel_3=0;
#endif
#ifdef ILP4
		gModel_4=0;
#endif
#ifdef ILP5
		gModel_5=0;
#endif
#ifdef ILP6
		gModel_6=0;
#endif
#ifdef ILP7
		gModel_7=0;
#endif
#ifdef ILP8
		gModel_8=0;
#endif
#ifdef ILP9
		gModel_9=0;
#endif
#ifdef ILP10
		gModel_10=0;
#endif
#ifdef ILP11
		gModel_11=0;
#endif
#ifdef ILP12
		gModel_12=0;
#endif
#ifdef ILP13
		gModel_13=0;
#endif
#ifdef ILP14
		gModel_14=0;
#endif
#ifdef ILP15
		gModel_15=0;
#endif
#ifdef ILP16
		gModel_16=0;
#endif
#ifdef ILP17
		gModel_17=0;
#endif
#ifdef ILP18
		gModel_18=0;
#endif
#ifdef ILP19
		gModel_19=0;
#endif
#ifdef ILP20
		gModel_20=0;
#endif
#ifdef ILP21
		gModel_21=0;
#endif
#ifdef ILP22
		gModel_22=0;
#endif
#ifdef ILP23
		gModel_23=0;
#endif
#ifdef ILP24
		gModel_24=0;
#endif
#ifdef ILP25
		gModel_25=0;
#endif
#ifdef ILP26
		gModel_26=0;
#endif
#ifdef ILP27
		gModel_27=0;
#endif
#ifdef ILP28
		gModel_28=0;
#endif
#ifdef ILP29
		gModel_29=0;
#endif
#ifdef ILP30
		gModel_30=0;
#endif
#ifdef ILP31
		gModel_31=0;
#endif
#ifdef ILP32
		gModel_32=0;
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
#ifdef ILP5
		if(SMemMat.boolModel[PIdx_5]==1) {gModel_5 = (sumCurrentsDv_5-sumCurrents_5)/0.001; }else {sumConductivity_5=0;sumConductivityDv_5=0;sumCurrents_5=0;sumCurrentsDv_5=0;}
#endif
#ifdef ILP6
		if(SMemMat.boolModel[PIdx_6]==1) {gModel_6 = (sumCurrentsDv_6-sumCurrents_6)/0.001; }else {sumConductivity_6=0;sumConductivityDv_6=0;sumCurrents_6=0;sumCurrentsDv_6=0;}
#endif
#ifdef ILP7
		if(SMemMat.boolModel[PIdx_7]==1) {gModel_7 = (sumCurrentsDv_7-sumCurrents_7)/0.001; }else {sumConductivity_7=0;sumConductivityDv_7=0;sumCurrents_7=0;sumCurrentsDv_7=0;}
#endif
#ifdef ILP8
		if(SMemMat.boolModel[PIdx_8]==1) {gModel_8 = (sumCurrentsDv_8-sumCurrents_8)/0.001; }else {sumConductivity_8=0;sumConductivityDv_8=0;sumCurrents_8=0;sumCurrentsDv_8=0;}
#endif
#ifdef ILP9
		if(SMemMat.boolModel[PIdx_9]==1) {gModel_9 = (sumCurrentsDv_9-sumCurrents_9)/0.001; }else {sumConductivity_9=0;sumConductivityDv_9=0;sumCurrents_9=0;sumCurrentsDv_9=0;}
#endif
#ifdef ILP10
		if(SMemMat.boolModel[PIdx_10]==1) {gModel_10 = (sumCurrentsDv_10-sumCurrents_10)/0.001; }else {sumConductivity_10=0;sumConductivityDv_10=0;sumCurrents_10=0;sumCurrentsDv_10=0;}
#endif
#ifdef ILP11
		if(SMemMat.boolModel[PIdx_11]==1) {gModel_11 = (sumCurrentsDv_11-sumCurrents_11)/0.001; }else {sumConductivity_11=0;sumConductivityDv_11=0;sumCurrents_11=0;sumCurrentsDv_11=0;}
#endif
#ifdef ILP12
		if(SMemMat.boolModel[PIdx_12]==1) {gModel_12 = (sumCurrentsDv_12-sumCurrents_12)/0.001; }else {sumConductivity_12=0;sumConductivityDv_12=0;sumCurrents_12=0;sumCurrentsDv_12=0;}
#endif
#ifdef ILP13
		if(SMemMat.boolModel[PIdx_13]==1) {gModel_13 = (sumCurrentsDv_13-sumCurrents_13)/0.001; }else {sumConductivity_13=0;sumConductivityDv_13=0;sumCurrents_13=0;sumCurrentsDv_13=0;}
#endif
#ifdef ILP14
		if(SMemMat.boolModel[PIdx_14]==1) {gModel_14 = (sumCurrentsDv_14-sumCurrents_14)/0.001; }else {sumConductivity_14=0;sumConductivityDv_14=0;sumCurrents_14=0;sumCurrentsDv_14=0;}
#endif
#ifdef ILP15
		if(SMemMat.boolModel[PIdx_15]==1) {gModel_15 = (sumCurrentsDv_15-sumCurrents_15)/0.001; }else {sumConductivity_15=0;sumConductivityDv_15=0;sumCurrents_15=0;sumCurrentsDv_15=0;}
#endif
#ifdef ILP16
		if(SMemMat.boolModel[PIdx_16]==1) {gModel_16 = (sumCurrentsDv_16-sumCurrents_16)/0.001; }else {sumConductivity_16=0;sumConductivityDv_16=0;sumCurrents_16=0;sumCurrentsDv_16=0;}
#endif
#ifdef ILP17
		if(SMemMat.boolModel[PIdx_17]==1) {gModel_17 = (sumCurrentsDv_17-sumCurrents_17)/0.001; }else {sumConductivity_17=0;sumConductivityDv_17=0;sumCurrents_17=0;sumCurrentsDv_17=0;}
#endif
#ifdef ILP18
		if(SMemMat.boolModel[PIdx_18]==1) {gModel_18 = (sumCurrentsDv_18-sumCurrents_18)/0.001; }else {sumConductivity_18=0;sumConductivityDv_18=0;sumCurrents_18=0;sumCurrentsDv_18=0;}
#endif
#ifdef ILP19
		if(SMemMat.boolModel[PIdx_19]==1) {gModel_19 = (sumCurrentsDv_19-sumCurrents_19)/0.001; }else {sumConductivity_19=0;sumConductivityDv_19=0;sumCurrents_19=0;sumCurrentsDv_19=0;}
#endif
#ifdef ILP20
		if(SMemMat.boolModel[PIdx_20]==1) {gModel_20 = (sumCurrentsDv_20-sumCurrents_20)/0.001; }else {sumConductivity_20=0;sumConductivityDv_20=0;sumCurrents_20=0;sumCurrentsDv_20=0;}
#endif
#ifdef ILP21
		if(SMemMat.boolModel[PIdx_21]==1) {gModel_21 = (sumCurrentsDv_21-sumCurrents_21)/0.001; }else {sumConductivity_21=0;sumConductivityDv_21=0;sumCurrents_21=0;sumCurrentsDv_21=0;}
#endif
#ifdef ILP22
		if(SMemMat.boolModel[PIdx_22]==1) {gModel_22 = (sumCurrentsDv_22-sumCurrents_22)/0.001; }else {sumConductivity_22=0;sumConductivityDv_22=0;sumCurrents_22=0;sumCurrentsDv_22=0;}
#endif
#ifdef ILP23
		if(SMemMat.boolModel[PIdx_23]==1) {gModel_23 = (sumCurrentsDv_23-sumCurrents_23)/0.001; }else {sumConductivity_23=0;sumConductivityDv_23=0;sumCurrents_23=0;sumCurrentsDv_23=0;}
#endif
#ifdef ILP24
		if(SMemMat.boolModel[PIdx_24]==1) {gModel_24 = (sumCurrentsDv_24-sumCurrents_24)/0.001; }else {sumConductivity_24=0;sumConductivityDv_24=0;sumCurrents_24=0;sumCurrentsDv_24=0;}
#endif
#ifdef ILP25
		if(SMemMat.boolModel[PIdx_25]==1) {gModel_25 = (sumCurrentsDv_25-sumCurrents_25)/0.001; }else {sumConductivity_25=0;sumConductivityDv_25=0;sumCurrents_25=0;sumCurrentsDv_25=0;}
#endif
#ifdef ILP26
		if(SMemMat.boolModel[PIdx_26]==1) {gModel_26 = (sumCurrentsDv_26-sumCurrents_26)/0.001; }else {sumConductivity_26=0;sumConductivityDv_26=0;sumCurrents_26=0;sumCurrentsDv_26=0;}
#endif
#ifdef ILP27
		if(SMemMat.boolModel[PIdx_27]==1) {gModel_27 = (sumCurrentsDv_27-sumCurrents_27)/0.001; }else {sumConductivity_27=0;sumConductivityDv_27=0;sumCurrents_27=0;sumCurrentsDv_27=0;}
#endif
#ifdef ILP28
		if(SMemMat.boolModel[PIdx_28]==1) {gModel_28 = (sumCurrentsDv_28-sumCurrents_28)/0.001; }else {sumConductivity_28=0;sumConductivityDv_28=0;sumCurrents_28=0;sumCurrentsDv_28=0;}
#endif
#ifdef ILP29
		if(SMemMat.boolModel[PIdx_29]==1) {gModel_29 = (sumCurrentsDv_29-sumCurrents_29)/0.001; }else {sumConductivity_29=0;sumConductivityDv_29=0;sumCurrents_29=0;sumCurrentsDv_29=0;}
#endif
#ifdef ILP30
		if(SMemMat.boolModel[PIdx_30]==1) {gModel_30 = (sumCurrentsDv_30-sumCurrents_30)/0.001; }else {sumConductivity_30=0;sumConductivityDv_30=0;sumCurrents_30=0;sumCurrentsDv_30=0;}
#endif
#ifdef ILP31
		if(SMemMat.boolModel[PIdx_31]==1) {gModel_31 = (sumCurrentsDv_31-sumCurrents_31)/0.001; }else {sumConductivity_31=0;sumConductivityDv_31=0;sumCurrents_31=0;sumCurrentsDv_31=0;}
#endif
#ifdef ILP32
		if(SMemMat.boolModel[PIdx_32]==1) {gModel_32 = (sumCurrentsDv_32-sumCurrents_32)/0.001; }else {sumConductivity_32=0;sumConductivityDv_32=0;sumCurrents_32=0;sumCurrentsDv_32=0;}
#endif
		StimCurrent=0;
		StimCurrent_2=0;
#ifdef ILP3
		StimCurrent_3=0;
#endif
#ifdef ILP4
		StimCurrent_4=0;
#endif
#ifdef ILP5
		StimCurrent_5=0;
#endif
#ifdef ILP6
		StimCurrent_6=0;
#endif
#ifdef ILP7
		StimCurrent_7=0;
#endif
#ifdef ILP8
		StimCurrent_8=0;
#endif
#ifdef ILP9
		StimCurrent_9=0;
#endif
#ifdef ILP10
		StimCurrent_10=0;
#endif
#ifdef ILP11
		StimCurrent_11=0;
#endif
#ifdef ILP12
		StimCurrent_12=0;
#endif
#ifdef ILP13
		StimCurrent_13=0;
#endif
#ifdef ILP14
		StimCurrent_14=0;
#endif
#ifdef ILP15
		StimCurrent_15=0;
#endif
#ifdef ILP16
		StimCurrent_16=0;
#endif
#ifdef ILP17
		StimCurrent_17=0;
#endif
#ifdef ILP18
		StimCurrent_18=0;
#endif
#ifdef ILP19
		StimCurrent_19=0;
#endif
#ifdef ILP20
		StimCurrent_20=0;
#endif
#ifdef ILP21
		StimCurrent_21=0;
#endif
#ifdef ILP22
		StimCurrent_22=0;
#endif
#ifdef ILP23
		StimCurrent_23=0;
#endif
#ifdef ILP24
		StimCurrent_24=0;
#endif
#ifdef ILP25
		StimCurrent_25=0;
#endif
#ifdef ILP26
		StimCurrent_26=0;
#endif
#ifdef ILP27
		StimCurrent_27=0;
#endif
#ifdef ILP28
		StimCurrent_28=0;
#endif
#ifdef ILP29
		StimCurrent_29=0;
#endif
#ifdef ILP30
		StimCurrent_30=0;
#endif
#ifdef ILP31
		StimCurrent_31=0;
#endif
#ifdef ILP32
		StimCurrent_32=0;
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
#ifdef ILP5
		if(t>=stimDel && t<stimDel+stimDur && PIdx_5 == stimLoc){StimCurrent_5 = 100*stimAmp/stimArea;}
#endif
#ifdef ILP6
		if(t>=stimDel && t<stimDel+stimDur && PIdx_6 == stimLoc){StimCurrent_6 = 100*stimAmp/stimArea;}
#endif
#ifdef ILP7
		if(t>=stimDel && t<stimDel+stimDur && PIdx_7 == stimLoc){StimCurrent_7 = 100*stimAmp/stimArea;}
#endif
#ifdef ILP8
		if(t>=stimDel && t<stimDel+stimDur && PIdx_8 == stimLoc){StimCurrent_8 = 100*stimAmp/stimArea;}
#endif
#ifdef ILP9
		if(t>=stimDel && t<stimDel+stimDur && PIdx_9 == stimLoc){StimCurrent_9 = 100*stimAmp/stimArea;}
#endif
#ifdef ILP10
		if(t>=stimDel && t<stimDel+stimDur && PIdx_10 == stimLoc){StimCurrent_10 = 100*stimAmp/stimArea;}
#endif
#ifdef ILP11
		if(t>=stimDel && t<stimDel+stimDur && PIdx_11 == stimLoc){StimCurrent_11 = 100*stimAmp/stimArea;}
#endif
#ifdef ILP12
		if(t>=stimDel && t<stimDel+stimDur && PIdx_12 == stimLoc){StimCurrent_12 = 100*stimAmp/stimArea;}
#endif
#ifdef ILP13
		if(t>=stimDel && t<stimDel+stimDur && PIdx_13 == stimLoc){StimCurrent_13 = 100*stimAmp/stimArea;}
#endif
#ifdef ILP14
		if(t>=stimDel && t<stimDel+stimDur && PIdx_14 == stimLoc){StimCurrent_14 = 100*stimAmp/stimArea;}
#endif
#ifdef ILP15
		if(t>=stimDel && t<stimDel+stimDur && PIdx_15 == stimLoc){StimCurrent_15 = 100*stimAmp/stimArea;}
#endif
#ifdef ILP16
		if(t>=stimDel && t<stimDel+stimDur && PIdx_16 == stimLoc){StimCurrent_16 = 100*stimAmp/stimArea;}
#endif
#ifdef ILP17
		if(t>=stimDel && t<stimDel+stimDur && PIdx_17 == stimLoc){StimCurrent_17 = 100*stimAmp/stimArea;}
#endif
#ifdef ILP18
		if(t>=stimDel && t<stimDel+stimDur && PIdx_18 == stimLoc){StimCurrent_18 = 100*stimAmp/stimArea;}
#endif
#ifdef ILP19
		if(t>=stimDel && t<stimDel+stimDur && PIdx_19 == stimLoc){StimCurrent_19 = 100*stimAmp/stimArea;}
#endif
#ifdef ILP20
		if(t>=stimDel && t<stimDel+stimDur && PIdx_20 == stimLoc){StimCurrent_20 = 100*stimAmp/stimArea;}
#endif
#ifdef ILP21
		if(t>=stimDel && t<stimDel+stimDur && PIdx_21 == stimLoc){StimCurrent_21 = 100*stimAmp/stimArea;}
#endif
#ifdef ILP22
		if(t>=stimDel && t<stimDel+stimDur && PIdx_22 == stimLoc){StimCurrent_22 = 100*stimAmp/stimArea;}
#endif
#ifdef ILP23
		if(t>=stimDel && t<stimDel+stimDur && PIdx_23 == stimLoc){StimCurrent_23 = 100*stimAmp/stimArea;}
#endif
#ifdef ILP24
		if(t>=stimDel && t<stimDel+stimDur && PIdx_24 == stimLoc){StimCurrent_24 = 100*stimAmp/stimArea;}
#endif
#ifdef ILP25
		if(t>=stimDel && t<stimDel+stimDur && PIdx_25 == stimLoc){StimCurrent_25 = 100*stimAmp/stimArea;}
#endif
#ifdef ILP26
		if(t>=stimDel && t<stimDel+stimDur && PIdx_26 == stimLoc){StimCurrent_26 = 100*stimAmp/stimArea;}
#endif
#ifdef ILP27
		if(t>=stimDel && t<stimDel+stimDur && PIdx_27 == stimLoc){StimCurrent_27 = 100*stimAmp/stimArea;}
#endif
#ifdef ILP28
		if(t>=stimDel && t<stimDel+stimDur && PIdx_28 == stimLoc){StimCurrent_28 = 100*stimAmp/stimArea;}
#endif
#ifdef ILP29
		if(t>=stimDel && t<stimDel+stimDur && PIdx_29 == stimLoc){StimCurrent_29 = 100*stimAmp/stimArea;}
#endif
#ifdef ILP30
		if(t>=stimDel && t<stimDel+stimDur && PIdx_30 == stimLoc){StimCurrent_30 = 100*stimAmp/stimArea;}
#endif
#ifdef ILP31
		if(t>=stimDel && t<stimDel+stimDur && PIdx_31 == stimLoc){StimCurrent_31 = 100*stimAmp/stimArea;}
#endif
#ifdef ILP32
		if(t>=stimDel && t<stimDel+stimDur && PIdx_32 == stimLoc){StimCurrent_32 = 100*stimAmp/stimArea;}
#endif
		
		
		rhs=StimCurrent-sumCurrents;
		rhs_2=StimCurrent_2-sumCurrents_2;
#ifdef ILP3
		rhs_3=StimCurrent_3-sumCurrents_3;
#endif
#ifdef ILP4
		rhs_4=StimCurrent_4-sumCurrents_4;
#endif
#ifdef ILP5
		rhs_5=StimCurrent_5-sumCurrents_5;
#endif
#ifdef ILP6
		rhs_6=StimCurrent_6-sumCurrents_6;
#endif
#ifdef ILP7
		rhs_7=StimCurrent_7-sumCurrents_7;
#endif
#ifdef ILP8
		rhs_8=StimCurrent_8-sumCurrents_8;
#endif
#ifdef ILP9
		rhs_9=StimCurrent_9-sumCurrents_9;
#endif
#ifdef ILP10
		rhs_10=StimCurrent_10-sumCurrents_10;
#endif
#ifdef ILP11
		rhs_11=StimCurrent_11-sumCurrents_11;
#endif
#ifdef ILP12
		rhs_12=StimCurrent_12-sumCurrents_12;
#endif
#ifdef ILP13
		rhs_13=StimCurrent_13-sumCurrents_13;
#endif
#ifdef ILP14
		rhs_14=StimCurrent_14-sumCurrents_14;
#endif
#ifdef ILP15
		rhs_15=StimCurrent_15-sumCurrents_15;
#endif
#ifdef ILP16
		rhs_16=StimCurrent_16-sumCurrents_16;
#endif
#ifdef ILP17
		rhs_17=StimCurrent_17-sumCurrents_17;
#endif
#ifdef ILP18
		rhs_18=StimCurrent_18-sumCurrents_18;
#endif
#ifdef ILP19
		rhs_19=StimCurrent_19-sumCurrents_19;
#endif
#ifdef ILP20
		rhs_20=StimCurrent_20-sumCurrents_20;
#endif
#ifdef ILP21
		rhs_21=StimCurrent_21-sumCurrents_21;
#endif
#ifdef ILP22
		rhs_22=StimCurrent_22-sumCurrents_22;
#endif
#ifdef ILP23
		rhs_23=StimCurrent_23-sumCurrents_23;
#endif
#ifdef ILP24
		rhs_24=StimCurrent_24-sumCurrents_24;
#endif
#ifdef ILP25
		rhs_25=StimCurrent_25-sumCurrents_25;
#endif
#ifdef ILP26
		rhs_26=StimCurrent_26-sumCurrents_26;
#endif
#ifdef ILP27
		rhs_27=StimCurrent_27-sumCurrents_27;
#endif
#ifdef ILP28
		rhs_28=StimCurrent_28-sumCurrents_28;
#endif
#ifdef ILP29
		rhs_29=StimCurrent_29-sumCurrents_29;
#endif
#ifdef ILP30
		rhs_30=StimCurrent_30-sumCurrents_30;
#endif
#ifdef ILP31
		rhs_31=StimCurrent_31-sumCurrents_31;
#endif
#ifdef ILP32
		rhs_32=StimCurrent_32-sumCurrents_32;
#endif


		dv=Vs[parentIndex]-Vs[PIdx];
		dv_2=Vs[parentIndex_2]-Vs[PIdx_2];
#ifdef ILP3
		dv_3=Vs[parentIndex_3]-Vs[PIdx_3];
#endif
#ifdef ILP4
		dv_4=Vs[parentIndex_4]-Vs[PIdx_4];
#endif
#ifdef ILP5
		dv_5=Vs[parentIndex_5]-Vs[PIdx_5];
#endif
#ifdef ILP6
		dv_6=Vs[parentIndex_6]-Vs[PIdx_6];
#endif
#ifdef ILP7
		dv_7=Vs[parentIndex_7]-Vs[PIdx_7];
#endif
#ifdef ILP8
		dv_8=Vs[parentIndex_8]-Vs[PIdx_8];
#endif
#ifdef ILP9
		dv_9=Vs[parentIndex_9]-Vs[PIdx_9];
#endif
#ifdef ILP10
		dv_10=Vs[parentIndex_10]-Vs[PIdx_10];
#endif
#ifdef ILP11
		dv_11=Vs[parentIndex_11]-Vs[PIdx_11];
#endif
#ifdef ILP12
		dv_12=Vs[parentIndex_12]-Vs[PIdx_12];
#endif
#ifdef ILP13
		dv_13=Vs[parentIndex_13]-Vs[PIdx_13];
#endif
#ifdef ILP14
		dv_14=Vs[parentIndex_14]-Vs[PIdx_14];
#endif
#ifdef ILP15
		dv_15=Vs[parentIndex_15]-Vs[PIdx_15];
#endif
#ifdef ILP16
		dv_16=Vs[parentIndex_16]-Vs[PIdx_16];
#endif
#ifdef ILP17
		dv_17=Vs[parentIndex_17]-Vs[PIdx_17];
#endif
#ifdef ILP18
		dv_18=Vs[parentIndex_18]-Vs[PIdx_18];
#endif
#ifdef ILP19
		dv_19=Vs[parentIndex_19]-Vs[PIdx_19];
#endif
#ifdef ILP20
		dv_20=Vs[parentIndex_20]-Vs[PIdx_20];
#endif
#ifdef ILP21
		dv_21=Vs[parentIndex_21]-Vs[PIdx_21];
#endif
#ifdef ILP22
		dv_22=Vs[parentIndex_22]-Vs[PIdx_22];
#endif
#ifdef ILP23
		dv_23=Vs[parentIndex_23]-Vs[PIdx_23];
#endif
#ifdef ILP24
		dv_24=Vs[parentIndex_24]-Vs[PIdx_24];
#endif
#ifdef ILP25
		dv_25=Vs[parentIndex_25]-Vs[PIdx_25];
#endif
#ifdef ILP26
		dv_26=Vs[parentIndex_26]-Vs[PIdx_26];
#endif
#ifdef ILP27
		dv_27=Vs[parentIndex_27]-Vs[PIdx_27];
#endif
#ifdef ILP28
		dv_28=Vs[parentIndex_28]-Vs[PIdx_28];
#endif
#ifdef ILP29
		dv_29=Vs[parentIndex_29]-Vs[PIdx_29];
#endif
#ifdef ILP30
		dv_30=Vs[parentIndex_30]-Vs[PIdx_30];
#endif
#ifdef ILP31
		dv_31=Vs[parentIndex_31]-Vs[PIdx_31];
#endif
#ifdef ILP32
		dv_32=Vs[parentIndex_32]-Vs[PIdx_32];
#endif

		rhs-=SMemMat.f[SMemMat.N-PIdx-1]*dv;
		rhs_2-=SMemMat.f[SMemMat.N-PIdx_2-1]*dv_2;
#ifdef ILP3
		rhs_3-=SMemMat.f[SMemMat.N-PIdx_3-1]*dv_3;
#endif
#ifdef ILP4
		rhs_4-=SMemMat.f[SMemMat.N-PIdx_4-1]*dv_4;
#endif
#ifdef ILP5
		rhs_5-=SMemMat.f[SMemMat.N-PIdx_5-1]*dv_5;
#endif
#ifdef ILP6
		rhs_6-=SMemMat.f[SMemMat.N-PIdx_6-1]*dv_6;
#endif
#ifdef ILP7
		rhs_7-=SMemMat.f[SMemMat.N-PIdx_7-1]*dv_7;
#endif
#ifdef ILP8
		rhs_8-=SMemMat.f[SMemMat.N-PIdx_8-1]*dv_8;
#endif
#ifdef ILP9
		rhs_9-=SMemMat.f[SMemMat.N-PIdx_9-1]*dv_9;
#endif
#ifdef ILP10
		rhs_10-=SMemMat.f[SMemMat.N-PIdx_10-1]*dv_10;
#endif
#ifdef ILP11
		rhs_11-=SMemMat.f[SMemMat.N-PIdx_11-1]*dv_11;
#endif
#ifdef ILP12
		rhs_12-=SMemMat.f[SMemMat.N-PIdx_12-1]*dv_12;
#endif
#ifdef ILP13
		rhs_13-=SMemMat.f[SMemMat.N-PIdx_13-1]*dv_13;
#endif
#ifdef ILP14
		rhs_14-=SMemMat.f[SMemMat.N-PIdx_14-1]*dv_14;
#endif
#ifdef ILP15
		rhs_15-=SMemMat.f[SMemMat.N-PIdx_15-1]*dv_15;
#endif
#ifdef ILP16
		rhs_16-=SMemMat.f[SMemMat.N-PIdx_16-1]*dv_16;
#endif
#ifdef ILP17
		rhs_17-=SMemMat.f[SMemMat.N-PIdx_17-1]*dv_17;
#endif
#ifdef ILP18
		rhs_18-=SMemMat.f[SMemMat.N-PIdx_18-1]*dv_18;
#endif
#ifdef ILP19
		rhs_19-=SMemMat.f[SMemMat.N-PIdx_19-1]*dv_19;
#endif
#ifdef ILP20
		rhs_20-=SMemMat.f[SMemMat.N-PIdx_20-1]*dv_20;
#endif
#ifdef ILP21
		rhs_21-=SMemMat.f[SMemMat.N-PIdx_21-1]*dv_21;
#endif
#ifdef ILP22
		rhs_22-=SMemMat.f[SMemMat.N-PIdx_22-1]*dv_22;
#endif
#ifdef ILP23
		rhs_23-=SMemMat.f[SMemMat.N-PIdx_23-1]*dv_23;
#endif
#ifdef ILP24
		rhs_24-=SMemMat.f[SMemMat.N-PIdx_24-1]*dv_24;
#endif
#ifdef ILP25
		rhs_25-=SMemMat.f[SMemMat.N-PIdx_25-1]*dv_25;
#endif
#ifdef ILP26
		rhs_26-=SMemMat.f[SMemMat.N-PIdx_26-1]*dv_26;
#endif
#ifdef ILP27
		rhs_27-=SMemMat.f[SMemMat.N-PIdx_27-1]*dv_27;
#endif
#ifdef ILP28
		rhs_28-=SMemMat.f[SMemMat.N-PIdx_28-1]*dv_28;
#endif
#ifdef ILP29
		rhs_29-=SMemMat.f[SMemMat.N-PIdx_29-1]*dv_29;
#endif
#ifdef ILP30
		rhs_30-=SMemMat.f[SMemMat.N-PIdx_30-1]*dv_30;
#endif
#ifdef ILP31
		rhs_31-=SMemMat.f[SMemMat.N-PIdx_31-1]*dv_31;
#endif
#ifdef ILP32
		rhs_32-=SMemMat.f[SMemMat.N-PIdx_32-1]*dv_32;
#endif

		D=sumConductivity+SMemMat.Cms[PIdx]/(sim.dt*1000);
		D_2=sumConductivity_2+SMemMat.Cms[PIdx_2]/(sim.dt*1000);
#ifdef ILP3
		D_3=sumConductivity_3+SMemMat.Cms[PIdx_3]/(sim.dt*1000);
#endif
#ifdef ILP4
		D_4=sumConductivity_4+SMemMat.Cms[PIdx_4]/(sim.dt*1000);
#endif
#ifdef ILP5
		D_5=sumConductivity_5+SMemMat.Cms[PIdx_5]/(sim.dt*1000);
#endif
#ifdef ILP6
		D_6=sumConductivity_6+SMemMat.Cms[PIdx_6]/(sim.dt*1000);
#endif
#ifdef ILP7
		D_7=sumConductivity_7+SMemMat.Cms[PIdx_7]/(sim.dt*1000);
#endif
#ifdef ILP8
		D_8=sumConductivity_8+SMemMat.Cms[PIdx_8]/(sim.dt*1000);
#endif
#ifdef ILP9
		D_9=sumConductivity_9+SMemMat.Cms[PIdx_9]/(sim.dt*1000);
#endif
#ifdef ILP10
		D_10=sumConductivity_10+SMemMat.Cms[PIdx_10]/(sim.dt*1000);
#endif
#ifdef ILP11
		D_11=sumConductivity_11+SMemMat.Cms[PIdx_11]/(sim.dt*1000);
#endif
#ifdef ILP12
		D_12=sumConductivity_12+SMemMat.Cms[PIdx_12]/(sim.dt*1000);
#endif
#ifdef ILP13
		D_13=sumConductivity_13+SMemMat.Cms[PIdx_13]/(sim.dt*1000);
#endif
#ifdef ILP14
		D_14=sumConductivity_14+SMemMat.Cms[PIdx_14]/(sim.dt*1000);
#endif
#ifdef ILP15
		D_15=sumConductivity_15+SMemMat.Cms[PIdx_15]/(sim.dt*1000);
#endif
#ifdef ILP16
		D_16=sumConductivity_16+SMemMat.Cms[PIdx_16]/(sim.dt*1000);
#endif
#ifdef ILP17
		D_17=sumConductivity_17+SMemMat.Cms[PIdx_17]/(sim.dt*1000);
#endif
#ifdef ILP18
		D_18=sumConductivity_18+SMemMat.Cms[PIdx_18]/(sim.dt*1000);
#endif
#ifdef ILP19
		D_19=sumConductivity_19+SMemMat.Cms[PIdx_19]/(sim.dt*1000);
#endif
#ifdef ILP20
		D_20=sumConductivity_20+SMemMat.Cms[PIdx_20]/(sim.dt*1000);
#endif
#ifdef ILP21
		D_21=sumConductivity_21+SMemMat.Cms[PIdx_21]/(sim.dt*1000);
#endif
#ifdef ILP22
		D_22=sumConductivity_22+SMemMat.Cms[PIdx_22]/(sim.dt*1000);
#endif
#ifdef ILP23
		D_23=sumConductivity_23+SMemMat.Cms[PIdx_23]/(sim.dt*1000);
#endif
#ifdef ILP24
		D_24=sumConductivity_24+SMemMat.Cms[PIdx_24]/(sim.dt*1000);
#endif
#ifdef ILP25
		D_25=sumConductivity_25+SMemMat.Cms[PIdx_25]/(sim.dt*1000);
#endif
#ifdef ILP26
		D_26=sumConductivity_26+SMemMat.Cms[PIdx_26]/(sim.dt*1000);
#endif
#ifdef ILP27
		D_27=sumConductivity_27+SMemMat.Cms[PIdx_27]/(sim.dt*1000);
#endif
#ifdef ILP28
		D_28=sumConductivity_28+SMemMat.Cms[PIdx_28]/(sim.dt*1000);
#endif
#ifdef ILP29
		D_29=sumConductivity_29+SMemMat.Cms[PIdx_29]/(sim.dt*1000);
#endif
#ifdef ILP30
		D_30=sumConductivity_30+SMemMat.Cms[PIdx_30]/(sim.dt*1000);
#endif
#ifdef ILP31
		D_31=sumConductivity_31+SMemMat.Cms[PIdx_31]/(sim.dt*1000);
#endif
#ifdef ILP32
		D_32=sumConductivity_32+SMemMat.Cms[PIdx_32]/(sim.dt*1000);
#endif

		D-=SMemMat.f[SMemMat.N-PIdx-1];
		D_2-=SMemMat.f[SMemMat.N-PIdx_2-1];
#ifdef ILP3
		D_3-=SMemMat.f[SMemMat.N-PIdx_3-1];
#endif
#ifdef ILP4
		D_4-=SMemMat.f[SMemMat.N-PIdx_4-1];
#endif
#ifdef ILP5
		D_5-=SMemMat.f[SMemMat.N-PIdx_5-1];
#endif
#ifdef ILP6
		D_6-=SMemMat.f[SMemMat.N-PIdx_6-1];
#endif
#ifdef ILP7
		D_7-=SMemMat.f[SMemMat.N-PIdx_7-1];
#endif
#ifdef ILP8
		D_8-=SMemMat.f[SMemMat.N-PIdx_8-1];
#endif
#ifdef ILP9
		D_9-=SMemMat.f[SMemMat.N-PIdx_9-1];
#endif
#ifdef ILP10
		D_10-=SMemMat.f[SMemMat.N-PIdx_10-1];
#endif
#ifdef ILP11
		D_11-=SMemMat.f[SMemMat.N-PIdx_11-1];
#endif
#ifdef ILP12
		D_12-=SMemMat.f[SMemMat.N-PIdx_12-1];
#endif
#ifdef ILP13
		D_13-=SMemMat.f[SMemMat.N-PIdx_13-1];
#endif
#ifdef ILP14
		D_14-=SMemMat.f[SMemMat.N-PIdx_14-1];
#endif
#ifdef ILP15
		D_15-=SMemMat.f[SMemMat.N-PIdx_15-1];
#endif
#ifdef ILP16
		D_16-=SMemMat.f[SMemMat.N-PIdx_16-1];
#endif
#ifdef ILP17
		D_17-=SMemMat.f[SMemMat.N-PIdx_17-1];
#endif
#ifdef ILP18
		D_18-=SMemMat.f[SMemMat.N-PIdx_18-1];
#endif
#ifdef ILP19
		D_19-=SMemMat.f[SMemMat.N-PIdx_19-1];
#endif
#ifdef ILP20
		D_20-=SMemMat.f[SMemMat.N-PIdx_20-1];
#endif
#ifdef ILP21
		D_21-=SMemMat.f[SMemMat.N-PIdx_21-1];
#endif
#ifdef ILP22
		D_22-=SMemMat.f[SMemMat.N-PIdx_22-1];
#endif
#ifdef ILP23
		D_23-=SMemMat.f[SMemMat.N-PIdx_23-1];
#endif
#ifdef ILP24
		D_24-=SMemMat.f[SMemMat.N-PIdx_24-1];
#endif
#ifdef ILP25
		D_25-=SMemMat.f[SMemMat.N-PIdx_25-1];
#endif
#ifdef ILP26
		D_26-=SMemMat.f[SMemMat.N-PIdx_26-1];
#endif
#ifdef ILP27
		D_27-=SMemMat.f[SMemMat.N-PIdx_27-1];
#endif
#ifdef ILP28
		D_28-=SMemMat.f[SMemMat.N-PIdx_28-1];
#endif
#ifdef ILP29
		D_29-=SMemMat.f[SMemMat.N-PIdx_29-1];
#endif
#ifdef ILP30
		D_30-=SMemMat.f[SMemMat.N-PIdx_30-1];
#endif
#ifdef ILP31
		D_31-=SMemMat.f[SMemMat.N-PIdx_31-1];
#endif
#ifdef ILP32
		D_32-=SMemMat.f[SMemMat.N-PIdx_32-1];
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
#ifdef ILP5
		bHP[SMemMat.N-PIdx_5-1]=rhs_5;
#endif
#ifdef ILP6
		bHP[SMemMat.N-PIdx_6-1]=rhs_6;
#endif
#ifdef ILP7
		bHP[SMemMat.N-PIdx_7-1]=rhs_7;
#endif
#ifdef ILP8
		bHP[SMemMat.N-PIdx_8-1]=rhs_8;
#endif
#ifdef ILP9
		bHP[SMemMat.N-PIdx_9-1]=rhs_9;
#endif
#ifdef ILP10
		bHP[SMemMat.N-PIdx_10-1]=rhs_10;
#endif
#ifdef ILP11
		bHP[SMemMat.N-PIdx_11-1]=rhs_11;
#endif
#ifdef ILP12
		bHP[SMemMat.N-PIdx_12-1]=rhs_12;
#endif
#ifdef ILP13
		bHP[SMemMat.N-PIdx_13-1]=rhs_13;
#endif
#ifdef ILP14
		bHP[SMemMat.N-PIdx_14-1]=rhs_14;
#endif
#ifdef ILP15
		bHP[SMemMat.N-PIdx_15-1]=rhs_15;
#endif
#ifdef ILP16
		bHP[SMemMat.N-PIdx_16-1]=rhs_16;
#endif
#ifdef ILP17
		bHP[SMemMat.N-PIdx_17-1]=rhs_17;
#endif
#ifdef ILP18
		bHP[SMemMat.N-PIdx_18-1]=rhs_18;
#endif
#ifdef ILP19
		bHP[SMemMat.N-PIdx_19-1]=rhs_19;
#endif
#ifdef ILP20
		bHP[SMemMat.N-PIdx_20-1]=rhs_20;
#endif
#ifdef ILP21
		bHP[SMemMat.N-PIdx_21-1]=rhs_21;
#endif
#ifdef ILP22
		bHP[SMemMat.N-PIdx_22-1]=rhs_22;
#endif
#ifdef ILP23
		bHP[SMemMat.N-PIdx_23-1]=rhs_23;
#endif
#ifdef ILP24
		bHP[SMemMat.N-PIdx_24-1]=rhs_24;
#endif
#ifdef ILP25
		bHP[SMemMat.N-PIdx_25-1]=rhs_25;
#endif
#ifdef ILP26
		bHP[SMemMat.N-PIdx_26-1]=rhs_26;
#endif
#ifdef ILP27
		bHP[SMemMat.N-PIdx_27-1]=rhs_27;
#endif
#ifdef ILP28
		bHP[SMemMat.N-PIdx_28-1]=rhs_28;
#endif
#ifdef ILP29
		bHP[SMemMat.N-PIdx_29-1]=rhs_29;
#endif
#ifdef ILP30
		bHP[SMemMat.N-PIdx_30-1]=rhs_30;
#endif
#ifdef ILP31
		bHP[SMemMat.N-PIdx_31-1]=rhs_31;
#endif
#ifdef ILP32
		bHP[SMemMat.N-PIdx_32-1]=rhs_32;
#endif
		uHP[SMemMat.N-PIdx-1]=D;
		uHP[SMemMat.N-PIdx_2-1]=D_2;
#ifdef ILP3
		uHP[SMemMat.N-PIdx_3-1]=D_3;
#endif
#ifdef ILP4
		uHP[SMemMat.N-PIdx_4-1]=D_4;
#endif
#ifdef ILP5
		uHP[SMemMat.N-PIdx_5-1]=D_5;
#endif
#ifdef ILP6
		uHP[SMemMat.N-PIdx_6-1]=D_6;
#endif
#ifdef ILP7
		uHP[SMemMat.N-PIdx_7-1]=D_7;
#endif
#ifdef ILP8
		uHP[SMemMat.N-PIdx_8-1]=D_8;
#endif
#ifdef ILP9
		uHP[SMemMat.N-PIdx_9-1]=D_9;
#endif
#ifdef ILP10
		uHP[SMemMat.N-PIdx_10-1]=D_10;
#endif
#ifdef ILP11
		uHP[SMemMat.N-PIdx_11-1]=D_11;
#endif
#ifdef ILP12
		uHP[SMemMat.N-PIdx_12-1]=D_12;
#endif
#ifdef ILP13
		uHP[SMemMat.N-PIdx_13-1]=D_13;
#endif
#ifdef ILP14
		uHP[SMemMat.N-PIdx_14-1]=D_14;
#endif
#ifdef ILP15
		uHP[SMemMat.N-PIdx_15-1]=D_15;
#endif
#ifdef ILP16
		uHP[SMemMat.N-PIdx_16-1]=D_16;
#endif
#ifdef ILP17
		uHP[SMemMat.N-PIdx_17-1]=D_17;
#endif
#ifdef ILP18
		uHP[SMemMat.N-PIdx_18-1]=D_18;
#endif
#ifdef ILP19
		uHP[SMemMat.N-PIdx_19-1]=D_19;
#endif
#ifdef ILP20
		uHP[SMemMat.N-PIdx_20-1]=D_20;
#endif
#ifdef ILP21
		uHP[SMemMat.N-PIdx_21-1]=D_21;
#endif
#ifdef ILP22
		uHP[SMemMat.N-PIdx_22-1]=D_22;
#endif
#ifdef ILP23
		uHP[SMemMat.N-PIdx_23-1]=D_23;
#endif
#ifdef ILP24
		uHP[SMemMat.N-PIdx_24-1]=D_24;
#endif
#ifdef ILP25
		uHP[SMemMat.N-PIdx_25-1]=D_25;
#endif
#ifdef ILP26
		uHP[SMemMat.N-PIdx_26-1]=D_26;
#endif
#ifdef ILP27
		uHP[SMemMat.N-PIdx_27-1]=D_27;
#endif
#ifdef ILP28
		uHP[SMemMat.N-PIdx_28-1]=D_28;
#endif
#ifdef ILP29
		uHP[SMemMat.N-PIdx_29-1]=D_29;
#endif
#ifdef ILP30
		uHP[SMemMat.N-PIdx_30-1]=D_30;
#endif
#ifdef ILP31
		uHP[SMemMat.N-PIdx_31-1]=D_31;
#endif
#ifdef ILP32
		uHP[SMemMat.N-PIdx_32-1]=D_32;
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
#ifdef ILP5
		if(SonNo_5==1) {bHP[SMemMat.N-parentIndex_5-1]+=SMemMat.e[Eidx_5]*dv_5;uHP[SMemMat.N-parentIndex_5-1]-=SMemMat.e[Eidx_5];}
#endif
#ifdef ILP6
		if(SonNo_6==1) {bHP[SMemMat.N-parentIndex_6-1]+=SMemMat.e[Eidx_6]*dv_6;uHP[SMemMat.N-parentIndex_6-1]-=SMemMat.e[Eidx_6];}
#endif
#ifdef ILP7
		if(SonNo_7==1) {bHP[SMemMat.N-parentIndex_7-1]+=SMemMat.e[Eidx_7]*dv_7;uHP[SMemMat.N-parentIndex_7-1]-=SMemMat.e[Eidx_7];}
#endif
#ifdef ILP8
		if(SonNo_8==1) {bHP[SMemMat.N-parentIndex_8-1]+=SMemMat.e[Eidx_8]*dv_8;uHP[SMemMat.N-parentIndex_8-1]-=SMemMat.e[Eidx_8];}
#endif
#ifdef ILP9
		if(SonNo_9==1) {bHP[SMemMat.N-parentIndex_9-1]+=SMemMat.e[Eidx_9]*dv_9;uHP[SMemMat.N-parentIndex_9-1]-=SMemMat.e[Eidx_9];}
#endif
#ifdef ILP10
		if(SonNo_10==1) {bHP[SMemMat.N-parentIndex_10-1]+=SMemMat.e[Eidx_10]*dv_10;uHP[SMemMat.N-parentIndex_10-1]-=SMemMat.e[Eidx_10];}
#endif
#ifdef ILP11
		if(SonNo_11==1) {bHP[SMemMat.N-parentIndex_11-1]+=SMemMat.e[Eidx_11]*dv_11;uHP[SMemMat.N-parentIndex_11-1]-=SMemMat.e[Eidx_11];}
#endif
#ifdef ILP12
		if(SonNo_12==1) {bHP[SMemMat.N-parentIndex_12-1]+=SMemMat.e[Eidx_12]*dv_12;uHP[SMemMat.N-parentIndex_12-1]-=SMemMat.e[Eidx_12];}
#endif
#ifdef ILP13
		if(SonNo_13==1) {bHP[SMemMat.N-parentIndex_13-1]+=SMemMat.e[Eidx_13]*dv_13;uHP[SMemMat.N-parentIndex_13-1]-=SMemMat.e[Eidx_13];}
#endif
#ifdef ILP14
		if(SonNo_14==1) {bHP[SMemMat.N-parentIndex_14-1]+=SMemMat.e[Eidx_14]*dv_14;uHP[SMemMat.N-parentIndex_14-1]-=SMemMat.e[Eidx_14];}
#endif
#ifdef ILP15
		if(SonNo_15==1) {bHP[SMemMat.N-parentIndex_15-1]+=SMemMat.e[Eidx_15]*dv_15;uHP[SMemMat.N-parentIndex_15-1]-=SMemMat.e[Eidx_15];}
#endif
#ifdef ILP16
		if(SonNo_16==1) {bHP[SMemMat.N-parentIndex_16-1]+=SMemMat.e[Eidx_16]*dv_16;uHP[SMemMat.N-parentIndex_16-1]-=SMemMat.e[Eidx_16];}
#endif
#ifdef ILP17
		if(SonNo_17==1) {bHP[SMemMat.N-parentIndex_17-1]+=SMemMat.e[Eidx_17]*dv_17;uHP[SMemMat.N-parentIndex_17-1]-=SMemMat.e[Eidx_17];}
#endif
#ifdef ILP18
		if(SonNo_18==1) {bHP[SMemMat.N-parentIndex_18-1]+=SMemMat.e[Eidx_18]*dv_18;uHP[SMemMat.N-parentIndex_18-1]-=SMemMat.e[Eidx_18];}
#endif
#ifdef ILP19
		if(SonNo_19==1) {bHP[SMemMat.N-parentIndex_19-1]+=SMemMat.e[Eidx_19]*dv_19;uHP[SMemMat.N-parentIndex_19-1]-=SMemMat.e[Eidx_19];}
#endif
#ifdef ILP20
		if(SonNo_20==1) {bHP[SMemMat.N-parentIndex_20-1]+=SMemMat.e[Eidx_20]*dv_20;uHP[SMemMat.N-parentIndex_20-1]-=SMemMat.e[Eidx_20];}
#endif
#ifdef ILP21
		if(SonNo_21==1) {bHP[SMemMat.N-parentIndex_21-1]+=SMemMat.e[Eidx_21]*dv_21;uHP[SMemMat.N-parentIndex_21-1]-=SMemMat.e[Eidx_21];}
#endif
#ifdef ILP22
		if(SonNo_22==1) {bHP[SMemMat.N-parentIndex_22-1]+=SMemMat.e[Eidx_22]*dv_22;uHP[SMemMat.N-parentIndex_22-1]-=SMemMat.e[Eidx_22];}
#endif
#ifdef ILP23
		if(SonNo_23==1) {bHP[SMemMat.N-parentIndex_23-1]+=SMemMat.e[Eidx_23]*dv_23;uHP[SMemMat.N-parentIndex_23-1]-=SMemMat.e[Eidx_23];}
#endif
#ifdef ILP24
		if(SonNo_24==1) {bHP[SMemMat.N-parentIndex_24-1]+=SMemMat.e[Eidx_24]*dv_24;uHP[SMemMat.N-parentIndex_24-1]-=SMemMat.e[Eidx_24];}
#endif
#ifdef ILP25
		if(SonNo_25==1) {bHP[SMemMat.N-parentIndex_25-1]+=SMemMat.e[Eidx_25]*dv_25;uHP[SMemMat.N-parentIndex_25-1]-=SMemMat.e[Eidx_25];}
#endif
#ifdef ILP26
		if(SonNo_26==1) {bHP[SMemMat.N-parentIndex_26-1]+=SMemMat.e[Eidx_26]*dv_26;uHP[SMemMat.N-parentIndex_26-1]-=SMemMat.e[Eidx_26];}
#endif
#ifdef ILP27
		if(SonNo_27==1) {bHP[SMemMat.N-parentIndex_27-1]+=SMemMat.e[Eidx_27]*dv_27;uHP[SMemMat.N-parentIndex_27-1]-=SMemMat.e[Eidx_27];}
#endif
#ifdef ILP28
		if(SonNo_28==1) {bHP[SMemMat.N-parentIndex_28-1]+=SMemMat.e[Eidx_28]*dv_28;uHP[SMemMat.N-parentIndex_28-1]-=SMemMat.e[Eidx_28];}
#endif
#ifdef ILP29
		if(SonNo_29==1) {bHP[SMemMat.N-parentIndex_29-1]+=SMemMat.e[Eidx_29]*dv_29;uHP[SMemMat.N-parentIndex_29-1]-=SMemMat.e[Eidx_29];}
#endif
#ifdef ILP30
		if(SonNo_30==1) {bHP[SMemMat.N-parentIndex_30-1]+=SMemMat.e[Eidx_30]*dv_30;uHP[SMemMat.N-parentIndex_30-1]-=SMemMat.e[Eidx_30];}
#endif
#ifdef ILP31
		if(SonNo_31==1) {bHP[SMemMat.N-parentIndex_31-1]+=SMemMat.e[Eidx_31]*dv_31;uHP[SMemMat.N-parentIndex_31-1]-=SMemMat.e[Eidx_31];}
#endif
#ifdef ILP32
		if(SonNo_32==1) {bHP[SMemMat.N-parentIndex_32-1]+=SMemMat.e[Eidx_32]*dv_32;uHP[SMemMat.N-parentIndex_32-1]-=SMemMat.e[Eidx_32];}
#endif

		if(SonNo==2) {bHP[SMemMat.N-parentIndex-1]+=SMemMat.e[Eidx]*dv;uHP[SMemMat.N-parentIndex-1]-=SMemMat.e[Eidx];}
		if(SonNo_2==2) {bHP[SMemMat.N-parentIndex_2-1]+=SMemMat.e[Eidx_2]*dv_2;uHP[SMemMat.N-parentIndex_2-1]-=SMemMat.e[Eidx_2];}
#ifdef ILP3
		if(SonNo_3==2) {bHP[SMemMat.N-parentIndex_3-1]+=SMemMat.e[Eidx_3]*dv_3;uHP[SMemMat.N-parentIndex_3-1]-=SMemMat.e[Eidx_3];}
#endif
#ifdef ILP4
		if(SonNo_4==2) {bHP[SMemMat.N-parentIndex_4-1]+=SMemMat.e[Eidx_4]*dv_4;uHP[SMemMat.N-parentIndex_4-1]-=SMemMat.e[Eidx_4];}
#endif
#ifdef ILP5
		if(SonNo_5==2) {bHP[SMemMat.N-parentIndex_5-1]+=SMemMat.e[Eidx_5]*dv_5;uHP[SMemMat.N-parentIndex_5-1]-=SMemMat.e[Eidx_5];}
#endif
#ifdef ILP6
		if(SonNo_6==2) {bHP[SMemMat.N-parentIndex_6-1]+=SMemMat.e[Eidx_6]*dv_6;uHP[SMemMat.N-parentIndex_6-1]-=SMemMat.e[Eidx_6];}
#endif
#ifdef ILP7
		if(SonNo_7==2) {bHP[SMemMat.N-parentIndex_7-1]+=SMemMat.e[Eidx_7]*dv_7;uHP[SMemMat.N-parentIndex_7-1]-=SMemMat.e[Eidx_7];}
#endif
#ifdef ILP8
		if(SonNo_8==2) {bHP[SMemMat.N-parentIndex_8-1]+=SMemMat.e[Eidx_8]*dv_8;uHP[SMemMat.N-parentIndex_8-1]-=SMemMat.e[Eidx_8];}
#endif
#ifdef ILP9
		if(SonNo_9==2) {bHP[SMemMat.N-parentIndex_9-1]+=SMemMat.e[Eidx_9]*dv_9;uHP[SMemMat.N-parentIndex_9-1]-=SMemMat.e[Eidx_9];}
#endif
#ifdef ILP10
		if(SonNo_10==2) {bHP[SMemMat.N-parentIndex_10-1]+=SMemMat.e[Eidx_10]*dv_10;uHP[SMemMat.N-parentIndex_10-1]-=SMemMat.e[Eidx_10];}
#endif
#ifdef ILP11
		if(SonNo_11==2) {bHP[SMemMat.N-parentIndex_11-1]+=SMemMat.e[Eidx_11]*dv_11;uHP[SMemMat.N-parentIndex_11-1]-=SMemMat.e[Eidx_11];}
#endif
#ifdef ILP12
		if(SonNo_12==2) {bHP[SMemMat.N-parentIndex_12-1]+=SMemMat.e[Eidx_12]*dv_12;uHP[SMemMat.N-parentIndex_12-1]-=SMemMat.e[Eidx_12];}
#endif
#ifdef ILP13
		if(SonNo_13==2) {bHP[SMemMat.N-parentIndex_13-1]+=SMemMat.e[Eidx_13]*dv_13;uHP[SMemMat.N-parentIndex_13-1]-=SMemMat.e[Eidx_13];}
#endif
#ifdef ILP14
		if(SonNo_14==2) {bHP[SMemMat.N-parentIndex_14-1]+=SMemMat.e[Eidx_14]*dv_14;uHP[SMemMat.N-parentIndex_14-1]-=SMemMat.e[Eidx_14];}
#endif
#ifdef ILP15
		if(SonNo_15==2) {bHP[SMemMat.N-parentIndex_15-1]+=SMemMat.e[Eidx_15]*dv_15;uHP[SMemMat.N-parentIndex_15-1]-=SMemMat.e[Eidx_15];}
#endif
#ifdef ILP16
		if(SonNo_16==2) {bHP[SMemMat.N-parentIndex_16-1]+=SMemMat.e[Eidx_16]*dv_16;uHP[SMemMat.N-parentIndex_16-1]-=SMemMat.e[Eidx_16];}
#endif
#ifdef ILP17
		if(SonNo_17==2) {bHP[SMemMat.N-parentIndex_17-1]+=SMemMat.e[Eidx_17]*dv_17;uHP[SMemMat.N-parentIndex_17-1]-=SMemMat.e[Eidx_17];}
#endif
#ifdef ILP18
		if(SonNo_18==2) {bHP[SMemMat.N-parentIndex_18-1]+=SMemMat.e[Eidx_18]*dv_18;uHP[SMemMat.N-parentIndex_18-1]-=SMemMat.e[Eidx_18];}
#endif
#ifdef ILP19
		if(SonNo_19==2) {bHP[SMemMat.N-parentIndex_19-1]+=SMemMat.e[Eidx_19]*dv_19;uHP[SMemMat.N-parentIndex_19-1]-=SMemMat.e[Eidx_19];}
#endif
#ifdef ILP20
		if(SonNo_20==2) {bHP[SMemMat.N-parentIndex_20-1]+=SMemMat.e[Eidx_20]*dv_20;uHP[SMemMat.N-parentIndex_20-1]-=SMemMat.e[Eidx_20];}
#endif
#ifdef ILP21
		if(SonNo_21==2) {bHP[SMemMat.N-parentIndex_21-1]+=SMemMat.e[Eidx_21]*dv_21;uHP[SMemMat.N-parentIndex_21-1]-=SMemMat.e[Eidx_21];}
#endif
#ifdef ILP22
		if(SonNo_22==2) {bHP[SMemMat.N-parentIndex_22-1]+=SMemMat.e[Eidx_22]*dv_22;uHP[SMemMat.N-parentIndex_22-1]-=SMemMat.e[Eidx_22];}
#endif
#ifdef ILP23
		if(SonNo_23==2) {bHP[SMemMat.N-parentIndex_23-1]+=SMemMat.e[Eidx_23]*dv_23;uHP[SMemMat.N-parentIndex_23-1]-=SMemMat.e[Eidx_23];}
#endif
#ifdef ILP24
		if(SonNo_24==2) {bHP[SMemMat.N-parentIndex_24-1]+=SMemMat.e[Eidx_24]*dv_24;uHP[SMemMat.N-parentIndex_24-1]-=SMemMat.e[Eidx_24];}
#endif
#ifdef ILP25
		if(SonNo_25==2) {bHP[SMemMat.N-parentIndex_25-1]+=SMemMat.e[Eidx_25]*dv_25;uHP[SMemMat.N-parentIndex_25-1]-=SMemMat.e[Eidx_25];}
#endif
#ifdef ILP26
		if(SonNo_26==2) {bHP[SMemMat.N-parentIndex_26-1]+=SMemMat.e[Eidx_26]*dv_26;uHP[SMemMat.N-parentIndex_26-1]-=SMemMat.e[Eidx_26];}
#endif
#ifdef ILP27
		if(SonNo_27==2) {bHP[SMemMat.N-parentIndex_27-1]+=SMemMat.e[Eidx_27]*dv_27;uHP[SMemMat.N-parentIndex_27-1]-=SMemMat.e[Eidx_27];}
#endif
#ifdef ILP28
		if(SonNo_28==2) {bHP[SMemMat.N-parentIndex_28-1]+=SMemMat.e[Eidx_28]*dv_28;uHP[SMemMat.N-parentIndex_28-1]-=SMemMat.e[Eidx_28];}
#endif
#ifdef ILP29
		if(SonNo_29==2) {bHP[SMemMat.N-parentIndex_29-1]+=SMemMat.e[Eidx_29]*dv_29;uHP[SMemMat.N-parentIndex_29-1]-=SMemMat.e[Eidx_29];}
#endif
#ifdef ILP30
		if(SonNo_30==2) {bHP[SMemMat.N-parentIndex_30-1]+=SMemMat.e[Eidx_30]*dv_30;uHP[SMemMat.N-parentIndex_30-1]-=SMemMat.e[Eidx_30];}
#endif
#ifdef ILP31
		if(SonNo_31==2) {bHP[SMemMat.N-parentIndex_31-1]+=SMemMat.e[Eidx_31]*dv_31;uHP[SMemMat.N-parentIndex_31-1]-=SMemMat.e[Eidx_31];}
#endif
#ifdef ILP32
		if(SonNo_32==2) {bHP[SMemMat.N-parentIndex_32-1]+=SMemMat.e[Eidx_32]*dv_32;uHP[SMemMat.N-parentIndex_32-1]-=SMemMat.e[Eidx_32];}
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
#ifdef ILP5
		Vmid_5=PX[SMemMat.N-PIdx_5-1];
#endif
#ifdef ILP6
		Vmid_6=PX[SMemMat.N-PIdx_6-1];
#endif
#ifdef ILP7
		Vmid_7=PX[SMemMat.N-PIdx_7-1];
#endif
#ifdef ILP8
		Vmid_8=PX[SMemMat.N-PIdx_8-1];
#endif
#ifdef ILP9
		Vmid_9=PX[SMemMat.N-PIdx_9-1];
#endif
#ifdef ILP10
		Vmid_10=PX[SMemMat.N-PIdx_10-1];
#endif
#ifdef ILP11
		Vmid_11=PX[SMemMat.N-PIdx_11-1];
#endif
#ifdef ILP12
		Vmid_12=PX[SMemMat.N-PIdx_12-1];
#endif
#ifdef ILP13
		Vmid_13=PX[SMemMat.N-PIdx_13-1];
#endif
#ifdef ILP14
		Vmid_14=PX[SMemMat.N-PIdx_14-1];
#endif
#ifdef ILP15
		Vmid_15=PX[SMemMat.N-PIdx_15-1];
#endif
#ifdef ILP16
		Vmid_16=PX[SMemMat.N-PIdx_16-1];
#endif
#ifdef ILP17
		Vmid_17=PX[SMemMat.N-PIdx_17-1];
#endif
#ifdef ILP18
		Vmid_18=PX[SMemMat.N-PIdx_18-1];
#endif
#ifdef ILP19
		Vmid_19=PX[SMemMat.N-PIdx_19-1];
#endif
#ifdef ILP20
		Vmid_20=PX[SMemMat.N-PIdx_20-1];
#endif
#ifdef ILP21
		Vmid_21=PX[SMemMat.N-PIdx_21-1];
#endif
#ifdef ILP22
		Vmid_22=PX[SMemMat.N-PIdx_22-1];
#endif
#ifdef ILP23
		Vmid_23=PX[SMemMat.N-PIdx_23-1];
#endif
#ifdef ILP24
		Vmid_24=PX[SMemMat.N-PIdx_24-1];
#endif
#ifdef ILP25
		Vmid_25=PX[SMemMat.N-PIdx_25-1];
#endif
#ifdef ILP26
		Vmid_26=PX[SMemMat.N-PIdx_26-1];
#endif
#ifdef ILP27
		Vmid_27=PX[SMemMat.N-PIdx_27-1];
#endif
#ifdef ILP28
		Vmid_28=PX[SMemMat.N-PIdx_28-1];
#endif
#ifdef ILP29
		Vmid_29=PX[SMemMat.N-PIdx_29-1];
#endif
#ifdef ILP30
		Vmid_30=PX[SMemMat.N-PIdx_30-1];
#endif
#ifdef ILP31
		Vmid_31=PX[SMemMat.N-PIdx_31-1];
#endif
#ifdef ILP32
		Vmid_32=PX[SMemMat.N-PIdx_32-1];
#endif

		v+=Vmid;
		v_2+=Vmid_2;
#ifdef ILP3
		v_3+=Vmid_3;
#endif
#ifdef ILP4
		v_4+=Vmid_4;
#endif
#ifdef ILP5
		v_5+=Vmid_5;
#endif
#ifdef ILP6
		v_6+=Vmid_6;
#endif
#ifdef ILP7
		v_7+=Vmid_7;
#endif
#ifdef ILP8
		v_8+=Vmid_8;
#endif
#ifdef ILP9
		v_9+=Vmid_9;
#endif
#ifdef ILP10
		v_10+=Vmid_10;
#endif
#ifdef ILP11
		v_11+=Vmid_11;
#endif
#ifdef ILP12
		v_12+=Vmid_12;
#endif
#ifdef ILP13
		v_13+=Vmid_13;
#endif
#ifdef ILP14
		v_14+=Vmid_14;
#endif
#ifdef ILP15
		v_15+=Vmid_15;
#endif
#ifdef ILP16
		v_16+=Vmid_16;
#endif
#ifdef ILP17
		v_17+=Vmid_17;
#endif
#ifdef ILP18
		v_18+=Vmid_18;
#endif
#ifdef ILP19
		v_19+=Vmid_19;
#endif
#ifdef ILP20
		v_20+=Vmid_20;
#endif
#ifdef ILP21
		v_21+=Vmid_21;
#endif
#ifdef ILP22
		v_22+=Vmid_22;
#endif
#ifdef ILP23
		v_23+=Vmid_23;
#endif
#ifdef ILP24
		v_24+=Vmid_24;
#endif
#ifdef ILP25
		v_25+=Vmid_25;
#endif
#ifdef ILP26
		v_26+=Vmid_26;
#endif
#ifdef ILP27
		v_27+=Vmid_27;
#endif
#ifdef ILP28
		v_28+=Vmid_28;
#endif
#ifdef ILP29
		v_29+=Vmid_29;
#endif
#ifdef ILP30
		v_30+=Vmid_30;
#endif
#ifdef ILP31
		v_31+=Vmid_31;
#endif
#ifdef ILP32
		v_32+=Vmid_32;
#endif
		Vs[PIdx]+=Vmid;
		Vs[PIdx_2]+=Vmid_2;
#ifdef ILP3
		Vs[PIdx_3]+=Vmid_3;
#endif
#ifdef ILP4
		Vs[PIdx_4]+=Vmid_4;
#endif
#ifdef ILP5
		Vs[PIdx_5]+=Vmid_5;
#endif
#ifdef ILP6
		Vs[PIdx_6]+=Vmid_6;
#endif
#ifdef ILP7
		Vs[PIdx_7]+=Vmid_7;
#endif
#ifdef ILP8
		Vs[PIdx_8]+=Vmid_8;
#endif
#ifdef ILP9
		Vs[PIdx_9]+=Vmid_9;
#endif
#ifdef ILP10
		Vs[PIdx_10]+=Vmid_10;
#endif
#ifdef ILP11
		Vs[PIdx_11]+=Vmid_11;
#endif
#ifdef ILP12
		Vs[PIdx_12]+=Vmid_12;
#endif
#ifdef ILP13
		Vs[PIdx_13]+=Vmid_13;
#endif
#ifdef ILP14
		Vs[PIdx_14]+=Vmid_14;
#endif
#ifdef ILP15
		Vs[PIdx_15]+=Vmid_15;
#endif
#ifdef ILP16
		Vs[PIdx_16]+=Vmid_16;
#endif
#ifdef ILP17
		Vs[PIdx_17]+=Vmid_17;
#endif
#ifdef ILP18
		Vs[PIdx_18]+=Vmid_18;
#endif
#ifdef ILP19
		Vs[PIdx_19]+=Vmid_19;
#endif
#ifdef ILP20
		Vs[PIdx_20]+=Vmid_20;
#endif
#ifdef ILP21
		Vs[PIdx_21]+=Vmid_21;
#endif
#ifdef ILP22
		Vs[PIdx_22]+=Vmid_22;
#endif
#ifdef ILP23
		Vs[PIdx_23]+=Vmid_23;
#endif
#ifdef ILP24
		Vs[PIdx_24]+=Vmid_24;
#endif
#ifdef ILP25
		Vs[PIdx_25]+=Vmid_25;
#endif
#ifdef ILP26
		Vs[PIdx_26]+=Vmid_26;
#endif
#ifdef ILP27
		Vs[PIdx_27]+=Vmid_27;
#endif
#ifdef ILP28
		Vs[PIdx_28]+=Vmid_28;
#endif
#ifdef ILP29
		Vs[PIdx_29]+=Vmid_29;
#endif
#ifdef ILP30
		Vs[PIdx_30]+=Vmid_30;
#endif
#ifdef ILP31
		Vs[PIdx_31]+=Vmid_31;
#endif
#ifdef ILP32
		Vs[PIdx_32]+=Vmid_32;
#endif

		if(SMemMat.boolModel[PIdx]==1) {KDerivModel(sim.dt, Vs[PIdx], ModelStates[0],ModelStates[1],ModelStates[2]);}
		if(SMemMat.boolModel[PIdx_2]==1) {KDerivModel(sim.dt, Vs[PIdx_2], ModelStates_2[0],ModelStates_2[1],ModelStates_2[2]); 		}		
#ifdef ILP3
		if(SMemMat.boolModel[PIdx_3]==1) {KDerivModel(sim.dt, Vs[PIdx_3], ModelStates_3[0],ModelStates_3[1],ModelStates_3[2]); 		}		
#endif
#ifdef ILP4
		if(SMemMat.boolModel[PIdx_4]==1) {KDerivModel(sim.dt, Vs[PIdx_4], ModelStates_4[0],ModelStates_4[1],ModelStates_4[2]); 		}		
#endif
#ifdef ILP5
		if(SMemMat.boolModel[PIdx_5]==1) {KDerivModel(sim.dt, Vs[PIdx_5], ModelStates_5[0],ModelStates_5[1],ModelStates_5[2]); 		}		
#endif
#ifdef ILP6
		if(SMemMat.boolModel[PIdx_6]==1) {KDerivModel(sim.dt, Vs[PIdx_6], ModelStates_6[0],ModelStates_6[1],ModelStates_6[2]); 		}		
#endif
#ifdef ILP7
		if(SMemMat.boolModel[PIdx_7]==1) {KDerivModel(sim.dt, Vs[PIdx_7], ModelStates_7[0],ModelStates_7[1],ModelStates_7[2]); 		}		
#endif
#ifdef ILP8
		if(SMemMat.boolModel[PIdx_8]==1) {KDerivModel(sim.dt, Vs[PIdx_8], ModelStates_8[0],ModelStates_8[1],ModelStates_8[2]); 		}		
#endif
#ifdef ILP9
		if(SMemMat.boolModel[PIdx_9]==1) {KDerivModel(sim.dt, Vs[PIdx_9], ModelStates_9[0],ModelStates_9[1],ModelStates_9[2]); 		}		
#endif
#ifdef ILP10
		if(SMemMat.boolModel[PIdx_10]==1) {KDerivModel(sim.dt, Vs[PIdx_10], ModelStates_10[0],ModelStates_10[1],ModelStates_10[2]); 		}		
#endif
#ifdef ILP11
		if(SMemMat.boolModel[PIdx_11]==1) {KDerivModel(sim.dt, Vs[PIdx_11], ModelStates_11[0],ModelStates_11[1],ModelStates_11[2]); 		}		
#endif
#ifdef ILP12
		if(SMemMat.boolModel[PIdx_12]==1) {KDerivModel(sim.dt, Vs[PIdx_12], ModelStates_12[0],ModelStates_12[1],ModelStates_12[2]); 		}		
#endif
#ifdef ILP13
		if(SMemMat.boolModel[PIdx_13]==1) {KDerivModel(sim.dt, Vs[PIdx_13], ModelStates_13[0],ModelStates_13[1],ModelStates_13[2]); 		}		
#endif
#ifdef ILP14
		if(SMemMat.boolModel[PIdx_14]==1) {KDerivModel(sim.dt, Vs[PIdx_14], ModelStates_14[0],ModelStates_14[1],ModelStates_14[2]); 		}		
#endif
#ifdef ILP15
		if(SMemMat.boolModel[PIdx_15]==1) {KDerivModel(sim.dt, Vs[PIdx_15], ModelStates_15[0],ModelStates_15[1],ModelStates_15[2]); 		}		
#endif
#ifdef ILP16
		if(SMemMat.boolModel[PIdx_16]==1) {KDerivModel(sim.dt, Vs[PIdx_16], ModelStates_16[0],ModelStates_16[1],ModelStates_16[2]); 		}		
#endif
#ifdef ILP17
		if(SMemMat.boolModel[PIdx_17]==1) {KDerivModel(sim.dt, Vs[PIdx_17], ModelStates_17[0],ModelStates_17[1],ModelStates_17[2]); 		}		
#endif
#ifdef ILP18
		if(SMemMat.boolModel[PIdx_18]==1) {KDerivModel(sim.dt, Vs[PIdx_18], ModelStates_18[0],ModelStates_18[1],ModelStates_18[2]); 		}		
#endif
#ifdef ILP19
		if(SMemMat.boolModel[PIdx_19]==1) {KDerivModel(sim.dt, Vs[PIdx_19], ModelStates_19[0],ModelStates_19[1],ModelStates_19[2]); 		}		
#endif
#ifdef ILP20
		if(SMemMat.boolModel[PIdx_20]==1) {KDerivModel(sim.dt, Vs[PIdx_20], ModelStates_20[0],ModelStates_20[1],ModelStates_20[2]); 		}		
#endif
#ifdef ILP21
		if(SMemMat.boolModel[PIdx_21]==1) {KDerivModel(sim.dt, Vs[PIdx_21], ModelStates_21[0],ModelStates_21[1],ModelStates_21[2]); 		}		
#endif
#ifdef ILP22
		if(SMemMat.boolModel[PIdx_22]==1) {KDerivModel(sim.dt, Vs[PIdx_22], ModelStates_22[0],ModelStates_22[1],ModelStates_22[2]); 		}		
#endif
#ifdef ILP23
		if(SMemMat.boolModel[PIdx_23]==1) {KDerivModel(sim.dt, Vs[PIdx_23], ModelStates_23[0],ModelStates_23[1],ModelStates_23[2]); 		}		
#endif
#ifdef ILP24
		if(SMemMat.boolModel[PIdx_24]==1) {KDerivModel(sim.dt, Vs[PIdx_24], ModelStates_24[0],ModelStates_24[1],ModelStates_24[2]); 		}		
#endif
#ifdef ILP25
		if(SMemMat.boolModel[PIdx_25]==1) {KDerivModel(sim.dt, Vs[PIdx_25], ModelStates_25[0],ModelStates_25[1],ModelStates_25[2]); 		}		
#endif
#ifdef ILP26
		if(SMemMat.boolModel[PIdx_26]==1) {KDerivModel(sim.dt, Vs[PIdx_26], ModelStates_26[0],ModelStates_26[1],ModelStates_26[2]); 		}		
#endif
#ifdef ILP27
		if(SMemMat.boolModel[PIdx_27]==1) {KDerivModel(sim.dt, Vs[PIdx_27], ModelStates_27[0],ModelStates_27[1],ModelStates_27[2]); 		}		
#endif
#ifdef ILP28
		if(SMemMat.boolModel[PIdx_28]==1) {KDerivModel(sim.dt, Vs[PIdx_28], ModelStates_28[0],ModelStates_28[1],ModelStates_28[2]); 		}		
#endif
#ifdef ILP29
		if(SMemMat.boolModel[PIdx_29]==1) {KDerivModel(sim.dt, Vs[PIdx_29], ModelStates_29[0],ModelStates_29[1],ModelStates_29[2]); 		}		
#endif
#ifdef ILP30
		if(SMemMat.boolModel[PIdx_30]==1) {KDerivModel(sim.dt, Vs[PIdx_30], ModelStates_30[0],ModelStates_30[1],ModelStates_30[2]); 		}		
#endif
#ifdef ILP31
		if(SMemMat.boolModel[PIdx_31]==1) {KDerivModel(sim.dt, Vs[PIdx_31], ModelStates_31[0],ModelStates_31[1],ModelStates_31[2]); 		}		
#endif
#ifdef ILP32
		if(SMemMat.boolModel[PIdx_32]==1) {KDerivModel(sim.dt, Vs[PIdx_32], ModelStates_32[0],ModelStates_32[1],ModelStates_32[2]); 		}		
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
