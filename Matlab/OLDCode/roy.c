/***************************************************************************
 *   Copyright (C) 2012 by Gilad Liberman,,,   *
 *   libermg1@peptibase3   *
 *                                                                         *
 *   This program is free software; you can redistribute it and/or modify  *
 *   it under the terms of the GNU General Public License as published by  *
 *   the Free Software Foundation; either version 2 of the License, or     *
 *   (at your option) any later version.                                   *
 *                                                                         *
 *   This program is distributed in the hope that it will be useful,       *
 *   but WITHOUT ANY WARRANTY; without even the implied warranty of        *
 *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the         *
 *   GNU General Public License for more details.                          *
 *                                                                         *
 *   You should have received a copy of the GNU General Public License     *
 *   along with this program; if not, write to the                         *
 *   Free Software Foundation, Inc.,                                       *
 *   59 Temple Place - Suite 330, Boston, MA  02111-1307, USA.             *
 ***************************************************************************/


#ifdef HAVE_CONFIG_H
#include <config.h>
#endif

#include <stdio.h>
#include <stdlib.h>

#define MYFTYPE double
#define MYDTYPE unsigned short

int main(int argc, char *argv[])
{
	int i,j,t;
	printf("Start reading file\n");
	FILE *fl;
	fl = fopen("TreeData.x", "rb");
	MYDTYPE buffer[11000];
	if (!fl)
	{
		printf("aaaa\n");
		return -1;
	}
	MYDTYPE N,NComp,LognDepth, Depth;
	MYDTYPE *d,*e,*f,*B,*Ks,*RelStarts, *RelEnds, *RelCN, *RelVec,*FIdxsX, *Level, *BranchP;
	MYDTYPE *SegStartI, *SegEndI;
	fread(&N, sizeof(MYDTYPE), 1, fl);
	fread(&NComp, sizeof(MYDTYPE), 1, fl);
	d = (MYDTYPE*) malloc(N*sizeof(MYDTYPE));
	e = (MYDTYPE*) malloc(N*sizeof(MYDTYPE));
	f = (MYDTYPE*) malloc(N*sizeof(MYDTYPE));
	B = (MYDTYPE*) malloc(N*sizeof(MYDTYPE));
	Ks = (MYDTYPE*) malloc(N*sizeof(MYDTYPE));
	RelStarts = (MYDTYPE*) malloc(NComp*sizeof(MYDTYPE));
	RelEnds = (MYDTYPE*) malloc(NComp*sizeof(MYDTYPE));
	RelCN = (MYDTYPE*) malloc(NComp*sizeof(MYDTYPE));
	RelVec = (MYDTYPE*) malloc((NComp-1)*sizeof(MYDTYPE));
	Level = (MYDTYPE*) malloc(NComp*sizeof(MYDTYPE));
	BranchP = (MYDTYPE*) malloc((NComp-1)*sizeof(MYDTYPE));
	SegStartI = (MYDTYPE*) malloc(NComp*sizeof(MYDTYPE));
	SegEndI = (MYDTYPE*) malloc(NComp*sizeof(MYDTYPE));
	fread(d, sizeof(MYDTYPE), N, fl);
	fread(e, sizeof(MYDTYPE), N, fl);
	fread(f, sizeof(MYDTYPE), N, fl);
	fread(B, sizeof(MYDTYPE), N, fl);
	fread(Ks, sizeof(MYDTYPE), N, fl);
	fread(RelStarts, sizeof(MYDTYPE), NComp, fl);
	fread(RelEnds, sizeof(MYDTYPE), NComp, fl);
	fread(RelCN, sizeof(MYDTYPE), NComp, fl);
	fread(RelVec, sizeof(MYDTYPE), NComp-1, fl);
	fread(&LognDepth, sizeof(MYDTYPE), 1, fl);
	fread(&Depth, sizeof(MYDTYPE), 1, fl);
	fread(Level, sizeof(MYDTYPE), NComp, fl);
	fread(BranchP, sizeof(MYDTYPE), NComp-1, fl);
	fread(SegStartI, sizeof(MYDTYPE), NComp, fl);
	fread(SegEndI, sizeof(MYDTYPE), NComp, fl);
	FIdxsX = (MYDTYPE*) malloc(sizeof(MYDTYPE)*LognDepth*(N+1));
	fread(FIdxsX, sizeof(MYDTYPE), LognDepth*(N+1), fl);
	printf("End reading file\n");
	printf("Start Triang serial\n");
	/* uH=diag(A);
	bH=B;
	for i=2:N
		k=Ks(i);
		uH(k)=uH(k)-e(i)*(f(i-1)/uH(i-1)); % So far same as paper parallel
		bH(k)=bH(k)-bH(i-1)*e(i)/uH(i-1); % bH is y
	end */
	MYDTYPE k;
	MYFTYPE *uH,*bH;
	uH = (MYFTYPE*) malloc(N*sizeof(MYFTYPE));
	bH = (MYFTYPE*) malloc(N*sizeof(MYFTYPE));
	for(i=0;i<N;i++) {
		uH[i]=d[i];
		bH[i]=B[i];
	}
	for(i=1;i<N;i++) {
		k=Ks[i]-1;
		uH[k]=uH[k]-e[i]*(f[i-1]/uH[i-1]);
		bH[k]=bH[k]-bH[i-1]*e[i]/uH[i-1];
	}
	printf("End Triang serial\n");
	printf("Start BkSub serial\n");
	/*HX(N)=bH(N)/uH(N);
	for i=N-1:-1:1
		k=Ks(i+1);
		HX(i)=(bH(i)-HX(k)*f(i))/uH(i);
	end*/
	MYFTYPE *HX;
	HX = (MYFTYPE*) malloc(N*sizeof(MYFTYPE));
	HX[N-1]=bH[N-1]/uH[N-1];
	for(i=N-2;i>=0;i--) {
		k=Ks[i+1]-1;
		HX[i]=(bH[i]-HX[k]*f[i])/uH[i];
	}
	printf("End BkSub serial\n");
	printf("Start Triang Parallel\n");
	/*uHP=d;
	bHP=B;
	%%
	for CurLevel=0:Depth
	%     Run all independent set for this level, in parallel
		for JumctionI=find(Level==CurLevel) % in parallel
			for i=SegStartI(JumctionI):SegEndI(JumctionI)
				uHP(i)=uHP(i)-e(i)*(f(i-1)/uHP(i-1)); % So far same as paper parallel
				bHP(i)=bHP(i)-bHP(i-1)*e(i)/uHP(i-1); % bH is y
			end
		end
		%         sum relevant resuls
		if(CurLevel<Depth)
			for CurB=find(Level==CurLevel+1) % in parallel
				CurJ=BranchP(CurB-1);
				for j=RelVec(RelStarts(CurB):RelEnds(CurB))
				uHP(CurJ)=uHP(CurJ)-e(j)*(f(j-1)/uHP(j-1)); % So far same as paper parallel
				bHP(CurJ)=bHP(CurJ)-bHP(j-1)*e(j)/uHP(j-1); % bH is y
				end
			end
		end
	end*/
	MYDTYPE CurLevel,JumctionI,CurB,CurJ;
	MYFTYPE *uHP,*bHP;
	uHP = (MYFTYPE*) malloc(N*sizeof(MYFTYPE));
	bHP = (MYFTYPE*) malloc(N*sizeof(MYFTYPE));
	for(i=0;i<N;i++) {
		uHP[i]=d[i];
		bHP[i]=B[i];
	}
	for(CurLevel=0;CurLevel<=Depth;CurLevel++) {
		// Run all independent set for this level, in parallel
		for(JumctionI=0;JumctionI<NComp;JumctionI++) {
			// RRR JumctionI is the idx of the thread
			// RRR Start kernel A
			if(Level[JumctionI]!=CurLevel) continue;
			for(i=SegStartI[JumctionI]-1;i<SegEndI[JumctionI];i++) { 
				uHP[i]=uHP[i]-e[i]*(f[i-1]/uHP[i-1]); // So far same as paper parallel
				bHP[i]=bHP[i]-bHP[i-1]*e[i]/uHP[i-1]; // bH is y
			}
			// RRR End Kernel A
		}
		
		// RRR Here sync threads!!
		
		// sum relevant resuls
		if(CurLevel<Depth) {
			for(CurB=0;CurB<NComp;CurB++) {
				// RRR CurB is the idx of the thread
				// RRR Start kernel B
				if(Level[CurB]!=(CurLevel+1)) continue;
				CurJ=BranchP[CurB-1]-1;
				for(j=RelStarts[CurB];j<=RelEnds[CurB];j++) {
					t=RelVec[j-1]-1;
					uHP[CurJ]=uHP[CurJ]-e[t]*(f[t-1]/uHP[t-1]); 
					bHP[CurJ]=bHP[CurJ]-bHP[t-1]*e[t]/uHP[t-1]; 
				}
				// RRR End Kernel B
			}
		}
	}
	printf("End Triang Parallel\n");
	printf("Start BkSub Parallel\n");
	// RRR This is exactly like we did before, except the use of FIdxsX and NextID
	/*u=uHP;
	PY=bHP;
	%%
	PX=PY'./u; % in parallel
	PF=-f./u; % in parallel
	PF(numel(Father))=1;
	PX(numel(Father))=0;

	for i=1:LognDepth
		OldPX=PX;
		OldPF=PF;
		for j=1:N % in parallel
			NextID=FIdxsX(i,j);
			PX(j)=OldPX(j)+OldPX(NextID)*PF(j);
			PF(j)=OldPF(j)*OldPF(NextID);
		end
	end*/
	MYDTYPE NextID;
	MYFTYPE *PX,*PF,*OldPX,*OldPF;
	PX = (MYFTYPE*) malloc((N+1)*sizeof(MYFTYPE));
	PF = (MYFTYPE*) malloc((N+1)*sizeof(MYFTYPE));
	OldPX = (MYFTYPE*) malloc((N+1)*sizeof(MYFTYPE));
	OldPF = (MYFTYPE*) malloc((N+1)*sizeof(MYFTYPE));
	for(i=0;i<N;i++) {
		PX[i]=bHP[i]/uHP[i];
		PF[i]=-f[i]/uHP[i];
	}
	PX[N]=1;
	PF[N]=0;
	for(i=0;i<LognDepth;i++) {
		for(j=0;j<=N;j++) { // no need in cuda
			OldPX[j]=PX[j];
			OldPF[j]=PF[j];
		}
		
		for(j=0;j<N;j++) { // in parallel
			NextID=FIdxsX[i+j*(LognDepth)]-1;
			PX[j]=OldPX[j]+OldPX[NextID]*PF[j];
			PF[j]=OldPF[j]*OldPF[NextID];
		}
	}
	printf("End BkSub Parallel\n");
	printf("Start freeing\n");
	fclose(fl);
	free (d);
	free (e);
	free (f);
	free (B);
	free (Ks);
	free (RelStarts);
	free (RelEnds);
	free (RelCN);
	free (RelVec);
	free (Level);
	free (BranchP);
	free (SegStartI);
	free (SegEndI);
	free (FIdxsX);
	return EXIT_SUCCESS;
}
