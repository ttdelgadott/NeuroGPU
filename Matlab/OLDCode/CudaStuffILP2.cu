#include "CudaStuff.cuh"
#include "Util.h"

XXX #define WARPSIZE 32

XXX For BeforeLU no change at all - all is predone is MATLAB. Just change to P32.
__device__ void BeforeLU(HMat InMat, MYFTYPE* B, MYFTYPE* uHP, MYFTYPE* bHP)
{
	MYDTYPE JumctionI =blockIdx.x*blockDim.x + threadIdx.x,i=0,j=0,CurJ,CurB,t, CurLevel;
	CurB = JumctionI;
	uHP[JumctionI]=InMat.d[JumctionI];
	bHP[JumctionI]=B[JumctionI];
		for(CurLevel=0;CurLevel<=InMat.Depth;CurLevel++) {
			if(InMat.Level[JumctionI]==CurLevel) {
				for(i=InMat.SegStartI[JumctionI]-1;i<InMat.SegEndI[JumctionI];i++) {
					MYFTYPE uHPm1=uHP[i-1];
					uHP[i]=uHP[i]-InMat.e[i]*(InMat.f[i-1]/uHPm1); // So far same as paper parallel
					uHPm1=uHP[i-1];
					MYFTYPE bHPm1=bHP[i-1];
					bHP[i]=bHP[i]-bHPm1*InMat.e[i]/uHPm1; // bH is y
				}
			}	
			__syncthreads();
			if(InMat.Level[CurB]==(CurLevel+1)) {
				CurJ=InMat.BranchP[CurB-1]-1;
				MYDTYPE St=InMat.RelStarts[CurB];
				MYDTYPE En=InMat.RelEnds[CurB];
				for(j=St;j<=En;j++) {
					t=InMat.RelVec[j-1]-1;
					MYFTYPE uHPm1=uHP[t-1];
					uHP[CurJ]=uHP[CurJ]-InMat.e[t]*(InMat.f[t-1]/uHPm1); 
					uHPm1=uHP[t-1];
					MYFTYPE bHPm1=bHP[t-1];
					bHP[CurJ]=bHP[CurJ]-bHPm1*InMat.e[t]/uHPm1; 
				}
			}	
			__syncthreads();
		}
	}
}

__device__ void BkSub(HMat InMat, MYFTYPE* PX, MYFTYPE* PF,MYFTYPE* uHP, MYFTYPE* bHP)
{
	MYDTYPE NextID,i,j;
	XXX MYDTYPE NextID_2,j_2;
	j =blockIdx.x*blockDim.x + threadIdx.x;
	XXX j_2 = j+WARPSIZE;
	PX[j]=bHP[j]/uHP[j];
	XXX PX[j_2]=bHP[j_2]/uHP[j_2];
	PF[j]=-InMat.f[j]/uHP[j];
	XXX PF[j_2]=-InMat.f[j_2]/uHP[j_2];
	PX[InMat.N]=0;
	PF[InMat.N]=1;
	for(i=0;i<InMat.LognDepth;i++) {	
		NextID=InMat.FIdxs[i+j*(InMat.LognDepth)]-1;
		XXX NextID_2=InMat.FIdxs[i+j_2*(InMat.LognDepth)]-1;
		MYFTYPE OldPXj=PX[j];
		XXX MYFTYPE OldPXj_2=PX[j_2];
		MYFTYPE OldPXNextID=PX[NextID];
		XXX MYFTYPE OldPXNextID_2=PX[NextID_2];
		PX[j]=OldPXj+OldPXNextID*PF[j];
		XXX PX[j_2]=OldPXj_2+OldPXNextID_2*PF[j_2];
		MYFTYPE OldPFj=PF[j];
		XXX MYFTYPE OldPFj_2=PF[j_2];
		MYFTYPE OldPFNextID=PF[NextID];
		XXX MYFTYPE OldPFNextID_2=PF[NextID_2];
		PF[j]=OldPFj*OldPFNextID;
		XXX PF[j_2]=OldPFj_2*OldPFNextID_2;
	}
}

__global__ void stEfork2TimeLoopGPUKernel(Stim stim, const HHparams InHHParams, HMat InMat, MYDTYPE Nt, MYFTYPE dt, MYDTYPE N, MYFTYPE *Iapp, MYFTYPE stimArea, MYFTYPE Cm, MYFTYPE *VHot, MYFTYPE *V, MYFTYPE *n, MYFTYPE *m, MYFTYPE *h, MYFTYPE *dOrig, MYFTYPE *d)
{
	MYDTYPE i=blockIdx.x*blockDim.x + threadIdx.x;
	MYDTYPE i_2=i+WARPSIZE;
	
	InMat.d=d;

	// for model
	MYFTYPE t;
	XXX MYFTYPE a_2, c_2, n4_2, m3h_2, TmpVec_2, TmpVec2_2, dVec_2, Vmid_2;
	MYFTYPE a, c, n4, m3h, TmpVec, TmpVec2, dVec, Vmid;
	XXX MYFTYPE v_2=V[i_2];
	MYFTYPE v=V[i];

	// For solving the matrix
	MYFTYPE *B=(MYFTYPE*) &smem[0];
	MYFTYPE *uHP,*bHP,*PX,*PF;
	uHP = (MYFTYPE*) &smem[InMat.N];
	bHP = (MYFTYPE*) &smem[2*InMat.N];
	//try to use only 2*N space  in shared memmo
	PX = (MYFTYPE*) &smem[3*InMat.N];
	PF = (MYFTYPE*) &smem[4*InMat.N+1];

	// Optimization - Mat on Shared memory
	MYFTYPE *SMemd,*SMeme,*SMemf,*SMemVHot;
	MYFTYPE *Oldd,*Olde,*Oldf,*OldVHot;
	Oldd=InMat.d;
	Olde=InMat.e;
	Oldf=InMat.f;
	OldVHot=VHot;
	SMemd = (MYFTYPE*) &smem[5*InMat.N+3];
	SMeme = (MYFTYPE*) &smem[6*InMat.N+3];
	SMemf = (MYFTYPE*) &smem[7*InMat.N+3];
	SMemVHot = (MYFTYPE*) &smem[8*InMat.N+3];
	SMemd[i]=InMat.d[i];
	XXX SMemd[i_2]=InMat.d[i_2];
	SMeme[i]=InMat.e[i];
	XXX 
	SMemf[i]=InMat.f[i];
	XXX 
	SMemVHot[0]=VHot[0];
	InMat.d=SMemd;
	InMat.e=SMeme;
	InMat.f=SMemf;
	d=InMat.d;
	VHot=SMemVHot;
	/* Call to solve matrix -
	BeforeLU(InMat,B,uHP,bHP);
	__syncthreads();
	BkSub(InMat, PX,PF,uHP,bHP);*/

	__syncthreads();
	for(int j=1;j<Nt;j++) {
		__syncthreads();
		__syncthreads();
		__syncthreads();
		__syncthreads();
		__syncthreads();
		__syncthreads();
		__syncthreads();

		t = j*dt;
		// I = Iapp*(t-dt/2>stim.t1)*(t-dt/2<stim.t2);
		if(t>stim.t1+dt/2 && t<stim.t2+dt/2) { 
			Iapp[stim.loc] = stim.amp/stimArea; } // All together?
		else {
			Iapp[stim.loc] = 0; // All together?
		}
		__syncthreads();
		__syncthreads();
		__syncthreads();
		__syncthreads();
		__syncthreads();
		__syncthreads();
		__syncthreads();
		__syncthreads();// a = an(V);  c = (a+bn(V))/2;
		// cu_an(V[i],a);
		a =.01*(10-(v+71))/(exp(1-(v+71)/10)-1);
		XXX a_2 =.01*(10-(v_2+71))/(exp(1-(v_2+71)/10)-1);
		// cu_bn(V[i],c);
		c = .125*exp(-((v+71)/80));
		XXX c_2 = .125*exp(-((v_2+71)/80));
		c+=a;
		XXX c_2+=a_2;
		c*=0.5f;
		XXX c_2*=0.5f;

		//  n = ( (1/dt-c).*n + a) ./ (1/dt + c); n4 = n.^4;
		// Parallel ! for(int i=0;i<N;i++) {
		n[i]=( (1/dt-c)*n[i] + a) / (1/dt + c);
		XXX n[i_2]=( (1/dt-c_2)*n[i_2] + a_2) / (1/dt + c_2);
		n4=pow(n[i],4);
		XXX n4_2=pow(n[i_2],4);
		// }
		// a = am(V);  c = (a+bm(V))/2;
		// cu_am(V[i],a);
		a = .1*(25-(v+71))/(exp(2.5-(v+71)/10)-1);
		XXX 
		// cu_bm(V[i],c);
		c = 4*exp(-(v+71)/18);
		XXX 
		c+=a;
		XXX 
		c*=0.5f;
		XXX 
		// m = ( (1/dt-c).*m + a) ./ (1/dt + c);
		// Parallel ! for(int i=0;i<N;i++) {
		m[i]=( (1/dt-c)*m[i] + a) / (1/dt + c);
		// }
		// a = ah(V);  c = (a+bh(V))/2;
		// cu_ah(V[i],a);
		a=0.07*exp(-(v+71)/20);
		// cu_bh(V[i],c);
		c=1./(exp(3-(v+71)/10)+1);
		c+=a;
		c*=0.5f;
		// h = ( (1/dt-c).*h + a) ./ (1/dt + c); m3h = m.^3.*h;
		// Parallel ! for(int i=0;i<N;i++) {
		h[i]=( (1/dt-c)*h[i] + a) / (1/dt + c);
		m3h=pow(m[i],3)*h[i];
		// }
		// d = g.Na.*m3h + g.K.*n4 + g.Cl;
		/*TmpVec=m3h;
		TmpVec*=InHHParams.gNa;
		TmpVec2=n4;
		TmpVec2*=InHHParams.gK;
		TmpVec+=TmpVec2;
		TmpVec+=InHHParams.gCl;
		dVec=TmpVec;*/
		// or
		dVec=m3h*InHHParams.gNa+n4*InHHParams.gK+InHHParams.gCl;
		XXX dVec_2=m3h_2*InHHParams.gNa+n4_2*InHHParams.gK+InHHParams.gCl;

		// f = g.Na.*m3h*E.Na + g.K.*n4*E.K + g.Cl.*E.Cl + I;
		/*cu_CopyVec(TmpVec,m3h,N);
		cu_VecMultScalar(TmpVec,InHHParams.gNa*InHHParams.ENa,N);
		cu_CopyVec(TmpVec2,n4,N);
		cu_VecMultScalar(TmpVec2,InHHParams.gK*InHHParams.EK,N);
		cu_VecPlusVec(TmpVec,TmpVec2,N);
		cu_VecPlusScalar(TmpVec,InHHParams.gCl*InHHParams.ECl,N);
		cu_VecPlusVec(TmpVec,Iapp,N); // TmpVec is f!*/
		TmpVec=m3h*InHHParams.gNa*InHHParams.ENa+n4*InHHParams.gK*InHHParams.EK+InHHParams.gCl*InHHParams.ECl+Iapp[i];
		XXX 
		
		// B(1:Nx+1:end) = dB + d + 2*Cm/dt;         % update the diagonal
		/*cu_CopyVec(d,dOrig,N);
		cu_VecPlusVec(d,dVec,N);
		cu_VecPlusScalar(d,2*Cm/dt,N);*/
		d[i]=dOrig[i]+dVec+2*Cm/dt;
		XXX d[i_2]=dOrig[i_2]+dVec_2+2*Cm/dt;
		
		//Vmid = B\(2*Cm*V/dt + f); % SOLUTION OF MATRIX
		// Mat=B;
		// Vec=2*Cm*V/dt + f;
		// %       Vmid = SolveNormally(Mat,Vec);
		/*cu_CopyVec(TmpVec2,V,N);
		cu_VecMultScalar(TmpVec2,2*Cm/dt,N);
		cu_VecPlusVec(TmpVec2,TmpVec,N);*/
		B[i]=v*2*Cm/dt+TmpVec;
		XXX B[i_2]=v_2*2*Cm/dt+TmpVec_2;
		// Vmid2 = SolveByUs(Mat,Vec,Aux)';

		//SolveTriDiagonalHinesSerialCPU(InMat, TmpVec2, Vmid);

		// SolveTriDiagonalGPU(InMat, TmpVec2, Vmid);
		__syncthreads();
		__syncthreads();
		__syncthreads();
		__syncthreads();
		__syncthreads();
		__syncthreads();
		__syncthreads();
		__syncthreads();
		// Call to solve matrix -
		BeforeLU(InMat,B,uHP,bHP);
		__syncthreads();
		__syncthreads();
		__syncthreads();
		__syncthreads();
		__syncthreads();
		__syncthreads();
		__syncthreads();
		__syncthreads();
		BkSub(InMat, PX,PF,uHP,bHP);
		__syncthreads();
		__syncthreads();
		__syncthreads();
		__syncthreads();
		__syncthreads();
		__syncthreads();
		__syncthreads();
		__syncthreads();
		__syncthreads();
		__syncthreads();
		__syncthreads();
		__syncthreads();
		__syncthreads();
		__syncthreads();
		__syncthreads();
		__syncthreads();
		__syncthreads();
		Vmid=PX[i];
		XXX Vmid_2=PX[i_2];
		// End Call to solve matrix

		//cudaStatus = cudaThreadSynchronize();

		// Err(j)=sum(abs(Vmid-Vmid2));
		// V = 2*Vmid - V;
		/* cu_VecMultScalar(V,-1,N);
		cu_VecMultScalar(Vmid,2,N);
		cu_VecPlusVec(V,Vmid,N); */
		v=Vmid*2-v;
		XXX v_2=Vmid_2*2-v_2;
		V[i]=v;
		V[i_2]=v_2;
		if(i==stim.loc) {
			VHot[j] = V[stim.loc]; } // All together?
	}

	// return data to global memory
	Oldd[i]=SMemd[i];
	XXX Oldd[i_2]=SMemd[i_2];
	Olde[i]=SMeme[i];
	XXX 
	Oldf[i]=SMemf[i];
	XXX 
	InMat.d=Oldd;
	InMat.e=Olde;
	InMat.f=Oldf;

	XXX XXX change XXX for(int j=0;j<Nt/N;j++) {
		OldVHot[i+j*N]=VHot[i+j*N];
	}
	VHot=OldVHot;
}