// Automatically generated CU for C:\Users\rben.KECK-CENTER\Documents\GitHub\NeuroGPU\UrapNeuron\Mainen\runModel.hoc
#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include "cuda_runtime.h"
#include "device_launch_parameters.h"
#include "AllModels.cuh"

// Universals:
#define PI (3.1415927f)
#define R (8.31441f)
#define FARADAY (96485.309f)
#define ktf (1000.*8.3134*(celsius + 273.15)/FARADAY)

// GGlobals
#define celsius (37.00000)
#define stoprun (0.00000)
#define clamp_resist (0.00100)
#define secondorder (0.00000)

// NGlobals:
#define q10_ca (2.3)
#define temp_ca (23)
#define tadj_ca (3.2094)
#define vmin_ca (-120)
#define vmax_ca (100)
#define vshift_ca (0)
#define depth_cad (0.1)
#define cainf_cad (0.0001)
#define taur_cad (200)
#define q10_kca (2.3)
#define temp_kca (23)
#define tadj_kca (3.2094)
#define vmin_kca (-120)
#define vmax_kca (100)
#define q10_km (2.3)
#define temp_km (23)
#define tadj_km (3.2094)
#define vmin_km (-120)
#define vmax_km (100)
#define q10_kv (2.3)
#define temp_kv (23)
#define tadj_kv (3.2094)
#define vmin_kv (-120)
#define vmax_kv (100)
#define q10_na (2.3)
#define temp_na (23)
#define tadj_na (3.2094)
#define vmin_na (-120)
#define vmax_na (100)
#define vshift_na (-5)

// Reversals:
#define eca (140.00000f)
#define ek (-90.00000f)
#define ena (60.00000f)

// Declarations:
__device__ void Cutrates_ca(float v ,float gbar_ca,float cao_ca,float &hinf,float &htau,float &minf,float &mtau);
__device__ void Curates_ca(float vm ,float gbar_ca,float cao_ca,float &hinf,float &htau,float &minf,float &mtau);
__device__ void Curates_kca(float cai,float gbar_kca,float caix_kca,float Ra_kca,float Rb_kca,float &a,float &b,float &ninf,float &ntau);
__device__ void Cutrates_km(float v ,float gbar_km,float tha_km,float qa_km,float Ra_km,float Rb_km,float &a,float &b,float &ninf,float &ntau);
__device__ void Curates_km(float v ,float gbar_km,float tha_km,float qa_km,float Ra_km,float Rb_km,float &a,float &b,float &ninf,float &ntau);
__device__ void Cutrates_kv(float v ,float gbar_kv,float tha_kv,float qa_kv,float Ra_kv,float Rb_kv,float &a,float &b,float &ninf,float &ntau);
__device__ void Curates_kv(float v ,float gbar_kv,float tha_kv,float qa_kv,float Ra_kv,float Rb_kv,float &a,float &b,float &ninf,float &ntau);
__device__ void Cutrates_na(float v,float gbar_na,float tha_na,float qa_na,float Ra_na,float Rb_na,float thi1_na,float thi2_na,float qi_na,float thinf_na,float qinf_na,float Rg_na,float Rd_na,float &hinf,float &htau,float &minf,float &mtau);
__device__ void Curates_na(float vm,float gbar_na,float tha_na,float qa_na,float Ra_na,float Rb_na,float thi1_na,float thi2_na,float qi_na,float thinf_na,float qinf_na,float Rg_na,float Rd_na,float &hinf,float &htau,float &minf,float &mtau);
float Cunernst(float ci,float co, float z) {
	if (z == 0) {
		return 0.;
	}
	if (ci <= 0.) {
		return 1e6;
	}else if (co <= 0.) {
		return -1e6;
	}else{
		return ktf/z*log(co/ci);
	}	
}

// Functions:
__device__ float Cuefun_ca(float z) {
	if (fabs(z) < 1e-4) {;
		return  1 - z/2;
	}else{;
		return  z/(exp(z) - 1);
	};
};
__device__ float Cuefun_km(float z) {
	if (fabs(z) < 1e-4) {;
		return  1 - z/2;
	}else{;
		return  z/(exp(z) - 1);
	};
};
__device__ float Cuefun_kv(float z) {
	if (fabs(z) < 1e-4) {;
		return  1 - z/2;
	}else{;
		return  z/(exp(z) - 1);
	};
};
__device__ float Cutrap0_na(float v,float th,float a,float q) {
	if (fabs((v-th)/q) > 1e-6) {;
	        return  a * (v - th) / (1 - exp(-(v - th)/q));
	} else {;
	        return  a * q;
 	};
}	;

// Procedures:
__device__ void Cutrates_ca(float v ,float gbar_ca,float cao_ca,float &hinf,float &htau,float &minf,float &mtau) {
	Curates_ca(v,gbar_ca,cao_ca,hinf,htau,minf,mtau);
;};
__device__ void Curates_ca(float vm ,float gbar_ca,float cao_ca,float &hinf,float &htau,float &minf,float &mtau) {
float  a, b;
   /* removed tadj_ca recalculation */
    a = 0.209*Cuefun_ca(-(27+vm)/3.8);
	b = 0.94*exp((-75-vm)/17);
	;
	mtau = 1/tadj_ca/(a+b);
	minf = a/(a+b);
		;
	a = 0.000457*exp((-13-vm)/50);
	b = 0.0065/(exp((-vm-15)/28) + 1);
	htau = 1/tadj_ca/(a+b);
	hinf = a/(a+b);
;};
__device__ void Curates_kca(float cai,float gbar_kca,float caix_kca,float Ra_kca,float Rb_kca,float &a,float &b,float &ninf,float &ntau) {
        ;
        a =pow( Ra_kca * cai,caix_kca);
        b = Rb_kca;
       /* removed tadj_kca recalculation */
        ntau = 1/tadj_kca/(a+b);
	ninf = a/(a+b);
 ;
;};
__device__ void Cutrates_km(float v ,float gbar_km,float tha_km,float qa_km,float Ra_km,float Rb_km,float &a,float &b,float &ninf,float &ntau) {
                      ;
	Curates_km(v,gbar_km,tha_km,qa_km,Ra_km,Rb_km,a,b,ninf,ntau);
;};
__device__ void Curates_km(float v ,float gbar_km,float tha_km,float qa_km,float Ra_km,float Rb_km,float &a,float &b,float &ninf,float &ntau) {
                      ;
    ;
    a = Ra_km * qa_km * Cuefun_km(-(v - tha_km)/qa_km);
    ;
    b = Rb_km * qa_km * Cuefun_km((v - tha_km)/qa_km);
       /* removed tadj_km recalculation */
        ntau = 1/tadj_km/(a+b);
	ninf = a/(a+b);
;};
__device__ void Cutrates_kv(float v ,float gbar_kv,float tha_kv,float qa_kv,float Ra_kv,float Rb_kv,float &a,float &b,float &ninf,float &ntau) {
                      ;
	Curates_kv(v,gbar_kv,tha_kv,qa_kv,Ra_kv,Rb_kv,a,b,ninf,ntau);
;};
__device__ void Curates_kv(float v ,float gbar_kv,float tha_kv,float qa_kv,float Ra_kv,float Rb_kv,float &a,float &b,float &ninf,float &ntau) {
                      ;
    ;
    a = Ra_kv * qa_kv * Cuefun_kv(-(v - tha_kv)/qa_kv);
    ;
    b = Rb_kv * qa_kv * Cuefun_kv((v - tha_kv)/qa_kv);
       /* removed tadj_kv recalculation */
        ntau = 1/tadj_kv/(a+b);
	ninf = a/(a+b);
;};
__device__ void Cutrates_na(float v,float gbar_na,float tha_na,float qa_na,float Ra_na,float Rb_na,float thi1_na,float thi2_na,float qi_na,float thinf_na,float qinf_na,float Rg_na,float Rd_na,float &hinf,float &htau,float &minf,float &mtau) {
                      ;
        ;
	;
	Curates_na(v,gbar_na,tha_na,qa_na,Ra_na,Rb_na,thi1_na,thi2_na,qi_na,thinf_na,qinf_na,Rg_na,Rd_na,hinf,htau,minf,mtau);
;};
__device__ void Curates_na(float vm,float gbar_na,float tha_na,float qa_na,float Ra_na,float Rb_na,float thi1_na,float thi2_na,float qi_na,float thinf_na,float qinf_na,float Rg_na,float Rd_na,float &hinf,float &htau,float &minf,float &mtau) {
float  a, b;
	a = Cutrap0_na(vm,tha_na,Ra_na,qa_na);
	b = Cutrap0_na(-vm,-tha_na,Rb_na,qa_na);
       /* removed tadj_na recalculation */
	mtau = 1/tadj_na/(a+b);
	minf = a/(a+b);
		;
	a = Cutrap0_na(vm,thi1_na,Rd_na,qi_na);
	b = Cutrap0_na(-vm,-thi2_na,Rg_na,qi_na);
	htau = 1/tadj_na/(a+b);
	hinf = 1/(1+exp((vm-thinf_na)/qinf_na));
;};

// Inits:
__device__ void CuInitModel_ca(float v,float &m,float &h,float gbar_ca,float cao_ca, float cai, float &ica) {
float hinf,htau,minf,mtau;
   /* removed tadj_ca recalculation */
	Cutrates_ca(v+vshift_ca,gbar_ca,cao_ca,hinf,htau,minf,mtau);
	m = minf;
	h = hinf;
;};
__device__ void CuInitModel_cad(float v,float &ca, float ica, float &cai) {
	ca = cainf_cad;
	cai = ca;
;};
__device__ void CuInitModel_kca(float v,float &n,float gbar_kca,float caix_kca,float Ra_kca,float Rb_kca, float cai) {
float a,b,ninf,ntau;
	Curates_kca(cai,gbar_kca,caix_kca,Ra_kca,Rb_kca,a,b,ninf,ntau);
	n = ninf;
;};
__device__ void CuInitModel_km(float v,float &n,float gbar_km,float tha_km,float qa_km,float Ra_km,float Rb_km) {
float a,b,ninf,ntau;
   /* removed tadj_km recalculation */
	Cutrates_km(v,gbar_km,tha_km,qa_km,Ra_km,Rb_km,a,b,ninf,ntau);
	n = ninf;
;};
__device__ void CuInitModel_kv(float v,float &n,float gbar_kv,float tha_kv,float qa_kv,float Ra_kv,float Rb_kv) {
float a,b,ninf,ntau;
   /* removed tadj_kv recalculation */
	Cutrates_kv(v,gbar_kv,tha_kv,qa_kv,Ra_kv,Rb_kv,a,b,ninf,ntau);
	n = ninf;
;};
__device__ void CuInitModel_na(float v,float &m,float &h,float gbar_na,float tha_na,float qa_na,float Ra_na,float Rb_na,float thi1_na,float thi2_na,float qi_na,float thinf_na,float qinf_na,float Rg_na,float Rd_na) {
float hinf,htau,minf,mtau;
   /* removed tadj_na recalculation */
	Cutrates_na(v+vshift_na,gbar_na,tha_na,qa_na,Ra_na,Rb_na,thi1_na,thi2_na,qi_na,thinf_na,qinf_na,Rg_na,Rd_na,hinf,htau,minf,mtau);
	m = minf;
	h = hinf;
;};
__device__ void CuInitModel_pas(float v,float g_pas,float e_pas) {
;};

// Derivs:
__device__ void CuDerivModel_ca(float dt, float v,float &m,float &h,float gbar_ca,float cao_ca, float cai, float &ica) {
float hinf,htau,minf,mtau;
   Cutrates_ca (  v + vshift_ca ,gbar_ca,cao_ca,hinf,htau,minf,mtau);
    m = m + (1. - exp(dt*(( ( ( - 1.0 ) ) ) / mtau)))*(- ( ( ( minf ) ) / mtau ) / ( ( ( ( - 1.0) ) ) / mtau ) - m) ;
    h = h + (1. - exp(dt*(( ( ( - 1.0 ) ) ) / htau)))*(- ( ( ( hinf ) ) / htau ) / ( ( ( ( - 1.0) ) ) / htau ) - h) ;
   ;}
__device__ void CuDerivModel_cad(float dt, float v,float &ca, float ica, float &cai) {
float drive_channel;
   drive_channel = - ( 10000.0 ) * ica / ( 2.0 * FARADAY * depth_cad ) ;
   if ( drive_channel <= 0. ) {
     drive_channel = 0. ;
     ;}
    ca = ca + (1. - exp(dt*(( ( ( - 1.0 ) ) ) / taur_cad)))*(- ( drive_channel + ( ( cainf_cad ) ) / taur_cad ) / ( ( ( ( - 1.0) ) ) / taur_cad ) - ca) ;
   cai = ca ;
   ;}
__device__ void CuDerivModel_kca(float dt, float v,float &n,float gbar_kca,float caix_kca,float Ra_kca,float Rb_kca, float cai) {
float a,b,ninf,ntau;
   Curates_kca (  cai ,gbar_kca,caix_kca,Ra_kca,Rb_kca,a,b,ninf,ntau);
    n = n + (1. - exp(dt*(( ( ( - 1.0 ) ) ) / ntau)))*(- ( ( ( ninf ) ) / ntau ) / ( ( ( ( - 1.0) ) ) / ntau ) - n) ;
   ;}
__device__ void CuDerivModel_km(float dt, float v,float &n,float gbar_km,float tha_km,float qa_km,float Ra_km,float Rb_km) {
float a,b,ninf,ntau;
   Cutrates_km (  v ,gbar_km,tha_km,qa_km,Ra_km,Rb_km,a,b,ninf,ntau);
    n = n + (1. - exp(dt*(( ( ( - 1.0 ) ) ) / ntau)))*(- ( ( ( ninf ) ) / ntau ) / ( ( ( ( - 1.0) ) ) / ntau ) - n) ;
   ;}
__device__ void CuDerivModel_kv(float dt, float v,float &n,float gbar_kv,float tha_kv,float qa_kv,float Ra_kv,float Rb_kv) {
float a,b,ninf,ntau;
   Cutrates_kv (  v ,gbar_kv,tha_kv,qa_kv,Ra_kv,Rb_kv,a,b,ninf,ntau);
    n = n + (1. - exp(dt*(( ( ( - 1.0 ) ) ) / ntau)))*(- ( ( ( ninf ) ) / ntau ) / ( ( ( ( - 1.0) ) ) / ntau ) - n) ;
   ;}
__device__ void CuDerivModel_na(float dt, float v,float &m,float &h,float gbar_na,float tha_na,float qa_na,float Ra_na,float Rb_na,float thi1_na,float thi2_na,float qi_na,float thinf_na,float qinf_na,float Rg_na,float Rd_na) {
float hinf,htau,minf,mtau;
   Cutrates_na (  v + vshift_na ,gbar_na,tha_na,qa_na,Ra_na,Rb_na,thi1_na,thi2_na,qi_na,thinf_na,qinf_na,Rg_na,Rd_na,hinf,htau,minf,mtau);
    m = m + (1. - exp(dt*(( ( ( - 1.0 ) ) ) / mtau)))*(- ( ( ( minf ) ) / mtau ) / ( ( ( ( - 1.0) ) ) / mtau ) - m) ;
    h = h + (1. - exp(dt*(( ( ( - 1.0 ) ) ) / htau)))*(- ( ( ( hinf ) ) / htau ) / ( ( ( ( - 1.0) ) ) / htau ) - h) ;
   ;}
__device__ void CuDerivModel_pas(float dt, float v,float g_pas,float e_pas) {
float i;
;}

// Breakpoints:
__device__ void CuBreakpointModel_ca(MYSECONDFTYPE &sumCurrents, MYFTYPE &sumConductivity, float v,float &m,float &h,float gbar_ca,float cao_ca, float cai, float &ica) {
float eca;
eca = Cunernst(cai,DEF_cao,2.);
float gca,hinf,htau,minf,mtau;
gca=tadj_ca*gbar_ca*m*m*h;
ica=(1e-4)*gca*(v-eca);
sumCurrents+= ica;
sumConductivity+= gca;
;};
__device__ void CuBreakpointModel_cad(MYSECONDFTYPE &sumCurrents, MYFTYPE &sumConductivity, float v,float &ca, float ica, float &cai) {
float gca;
;};
__device__ void CuBreakpointModel_kca(MYSECONDFTYPE &sumCurrents, MYFTYPE &sumConductivity, float v,float &n,float gbar_kca,float caix_kca,float Ra_kca,float Rb_kca, float cai) {
float gca,gk,ninf,ntau;
float ik;
gk=tadj_kca*gbar_kca*n;
ik=(1e-4)*gk*(v-ek);
sumCurrents+= ik;
sumConductivity+= gk;
;};
__device__ void CuBreakpointModel_km(MYSECONDFTYPE &sumCurrents, MYFTYPE &sumConductivity, float v,float &n,float gbar_km,float tha_km,float qa_km,float Ra_km,float Rb_km) {
float gk,ninf,ntau;
float ik;
gk=tadj_km*gbar_km*n;
ik=(1e-4)*gk*(v-ek);
sumCurrents+= ik;
sumConductivity+= gk;
;};
__device__ void CuBreakpointModel_kv(MYSECONDFTYPE &sumCurrents, MYFTYPE &sumConductivity, float v,float &n,float gbar_kv,float tha_kv,float qa_kv,float Ra_kv,float Rb_kv) {
float gk,ninf,ntau;
float ik;
gk=tadj_kv*gbar_kv*n;
ik=(1e-4)*gk*(v-ek);
sumCurrents+= ik;
sumConductivity+= gk;
;};
__device__ void CuBreakpointModel_na(MYSECONDFTYPE &sumCurrents, MYFTYPE &sumConductivity, float v,float &m,float &h,float gbar_na,float tha_na,float qa_na,float Ra_na,float Rb_na,float thi1_na,float thi2_na,float qi_na,float thinf_na,float qinf_na,float Rg_na,float Rd_na) {
float gna,hinf,htau,minf,mtau;
float ina;
gna=tadj_na*gbar_na*m*m*m*h;
ina=(1e-4)*gna*(v-ena);
sumCurrents+= ina;
sumConductivity+= gna;
;};
__device__ void CuBreakpointModel_pas(MYSECONDFTYPE &sumCurrents, MYFTYPE &sumConductivity, float v,float g_pas,float e_pas) {
float gpas;
float i;
i=g_pas*(v-e_pas);
sumCurrents+= i;
sumConductivity+= g_pas;
;};
