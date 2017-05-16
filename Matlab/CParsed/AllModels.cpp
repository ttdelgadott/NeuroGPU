// Automatically generated C for C:\Users\bensr\Documents\GitHub\NeuroGPU\URapNeuron\Mainen\runModel.hoc
#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include "AllModels.h"

// Universals:
#define PI (3.1415927f)
#define R (8.31441f)
#define FARADAY (96485.309f)
#define ktf (1000.*8.3134*(celsius + 273.15)/FARADAY)

// Reversals:
#define DEF_cai		5.e-5	   /* mM */
#define DEF_cao		2.	   /* mM */
#define ek (-90.00000000f)
#define ena (60.00000000f)

// Locals:
float a,b,drive_channel,gca,gk,gna,hinf,htau,minf,mtau,ninf,ntau;

// Ion currents as Locals:
float ica,ik,ina;

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

// Declarations:
void trates_ca(float v ,float gbar_ca,float cao_ca) ;
void rates_ca(float vm ,float gbar_ca,float cao_ca) ;
void rates_kca(float cai,float gbar_kca,float caix_kca,float Ra_kca,float Rb_kca) ;
void trates_km(float v ,float gbar_km,float tha_km,float qa_km,float Ra_km,float Rb_km) ;
void rates_km(float v ,float gbar_km,float tha_km,float qa_km,float Ra_km,float Rb_km) ;
void trates_kv(float v ,float gbar_kv,float tha_kv,float qa_kv,float Ra_kv,float Rb_kv) ;
void rates_kv(float v ,float gbar_kv,float tha_kv,float qa_kv,float Ra_kv,float Rb_kv) ;
void trates_na(float v,float gbar_na,float tha_na,float qa_na,float Ra_na,float Rb_na,float thi1_na,float thi2_na,float qi_na,float thinf_na,float qinf_na,float Rg_na,float Rd_na) ;
void rates_na(float vm,float gbar_na,float tha_na,float qa_na,float Ra_na,float Rb_na,float thi1_na,float thi2_na,float qi_na,float thinf_na,float qinf_na,float Rg_na,float Rd_na) ;
float nernst(float ci,float co, float z) {
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
float efun_ca(float z) {
	if (fabs(z) < 1e-4) {;
		return  1 - z/2;
	}else{;
		return  z/(exp(z) - 1);
	};
};
float efun_km(float z) {
	if (fabs(z) < 1e-4) {;
		return  1 - z/2;
	}else{;
		return  z/(exp(z) - 1);
	};
};
float efun_kv(float z) {
	if (fabs(z) < 1e-4) {;
		return  1 - z/2;
	}else{;
		return  z/(exp(z) - 1);
	};
};
float trap0_na(float v,float th,float a,float q) {
	if (fabs((v-th)/q) > 1e-6) {;
	        return  a * (v - th) / (1 - exp(-(v - th)/q));
	} else {;
	        return  a * q;
 	};
}	;

// Inits:
void InitModel_ca(float v,float &m,float &h,float gbar_ca,float cao_ca, float cai, float &ica) {
   /* removed tadj_ca recalculation */
	trates_ca(v+vshift_ca,gbar_ca,cao_ca);
	m = minf;
	h = hinf;
;};
void InitModel_cad(float v,float &ca, float ica, float &cai) {
	ca = cainf_cad;
	cai = ca;
;};
void InitModel_kca(float v,float &n,float gbar_kca,float caix_kca,float Ra_kca,float Rb_kca, float cai) {
	rates_kca(cai,gbar_kca,caix_kca,Ra_kca,Rb_kca);
	n = ninf;
;};
void InitModel_km(float v,float &n,float gbar_km,float tha_km,float qa_km,float Ra_km,float Rb_km) {
   /* removed tadj_km recalculation */
	trates_km(v,gbar_km,tha_km,qa_km,Ra_km,Rb_km);
	n = ninf;
;};
void InitModel_kv(float v,float &n,float gbar_kv,float tha_kv,float qa_kv,float Ra_kv,float Rb_kv) {
   /* removed tadj_kv recalculation */
	trates_kv(v,gbar_kv,tha_kv,qa_kv,Ra_kv,Rb_kv);
	n = ninf;
;};
void InitModel_na(float v,float &m,float &h,float gbar_na,float tha_na,float qa_na,float Ra_na,float Rb_na,float thi1_na,float thi2_na,float qi_na,float thinf_na,float qinf_na,float Rg_na,float Rd_na) {
   /* removed tadj_na recalculation */
	trates_na(v+vshift_na,gbar_na,tha_na,qa_na,Ra_na,Rb_na,thi1_na,thi2_na,qi_na,thinf_na,qinf_na,Rg_na,Rd_na);
	m = minf;
	h = hinf;
;};

// Procedures:
void trates_ca(float v ,float gbar_ca,float cao_ca) {
	rates_ca(v,gbar_ca,cao_ca);
;};
void rates_ca(float vm ,float gbar_ca,float cao_ca) {
float  a, b;
   /* removed tadj_ca recalculation */
    a = 0.209*efun_ca(-(27+vm)/3.8);
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
void rates_kca(float cai,float gbar_kca,float caix_kca,float Ra_kca,float Rb_kca) {
        ;
        a =pow((MYFTYPE) Ra_kca * cai,(MYFTYPE)caix_kca);
        b = Rb_kca;
       /* removed tadj_kca recalculation */
        ntau = 1/tadj_kca/(a+b);
	ninf = a/(a+b);
 ;
;};
void trates_km(float v ,float gbar_km,float tha_km,float qa_km,float Ra_km,float Rb_km) {
                      ;
	rates_km(v,gbar_km,tha_km,qa_km,Ra_km,Rb_km);
;};
void rates_km(float v ,float gbar_km,float tha_km,float qa_km,float Ra_km,float Rb_km) {
                      ;
    ;
    a = Ra_km * qa_km * efun_km(-(v - tha_km)/qa_km);
    ;
    b = Rb_km * qa_km * efun_km((v - tha_km)/qa_km);
       /* removed tadj_km recalculation */
        ntau = 1/tadj_km/(a+b);
	ninf = a/(a+b);
;};
void trates_kv(float v ,float gbar_kv,float tha_kv,float qa_kv,float Ra_kv,float Rb_kv) {
                      ;
	rates_kv(v,gbar_kv,tha_kv,qa_kv,Ra_kv,Rb_kv);
;};
void rates_kv(float v ,float gbar_kv,float tha_kv,float qa_kv,float Ra_kv,float Rb_kv) {
                      ;
    ;
    a = Ra_kv * qa_kv * efun_kv(-(v - tha_kv)/qa_kv);
    ;
    b = Rb_kv * qa_kv * efun_kv((v - tha_kv)/qa_kv);
       /* removed tadj_kv recalculation */
        ntau = 1/tadj_kv/(a+b);
	ninf = a/(a+b);
;};
void trates_na(float v,float gbar_na,float tha_na,float qa_na,float Ra_na,float Rb_na,float thi1_na,float thi2_na,float qi_na,float thinf_na,float qinf_na,float Rg_na,float Rd_na) {
                      ;
        ;
	;
	rates_na(v,gbar_na,tha_na,qa_na,Ra_na,Rb_na,thi1_na,thi2_na,qi_na,thinf_na,qinf_na,Rg_na,Rd_na);
;};
void rates_na(float vm,float gbar_na,float tha_na,float qa_na,float Ra_na,float Rb_na,float thi1_na,float thi2_na,float qi_na,float thinf_na,float qinf_na,float Rg_na,float Rd_na) {
float  a, b;
	a = trap0_na(vm,tha_na,Ra_na,qa_na);
	b = trap0_na(-vm,-tha_na,Rb_na,qa_na);
       /* removed tadj_na recalculation */
	mtau = 1/tadj_na/(a+b);
	minf = a/(a+b);
		;
	a = trap0_na(vm,thi1_na,Rd_na,qi_na);
	b = trap0_na(-vm,-thi2_na,Rg_na,qi_na);
	htau = 1/tadj_na/(a+b);
	hinf = 1/(1+exp((vm-thinf_na)/qinf_na));
;};

// Derivs:
void DerivModel_ca(float dt, float v,float &m,float &h,float gbar_ca,float cao_ca, float cai, float &ica) {
float rhs[2];
float y[2];
float matq[2][2];
   trates_ca (  v + vshift_ca ,gbar_ca,cao_ca) ;
    m = m + (1. - exp(dt*(( ( ( - 1.0 ) ) ) / mtau)))*(- ( ( ( minf ) ) / mtau ) / ( ( ( ( - 1.0) ) ) / mtau ) - m) ;
    h = h + (1. - exp(dt*(( ( ( - 1.0 ) ) ) / htau)))*(- ( ( ( hinf ) ) / htau ) / ( ( ( ( - 1.0) ) ) / htau ) - h) ;
   ;}
void DerivModel_cad(float dt, float v,float &ca, float ica, float &cai) {
float rhs[1];
float y[1];
float matq[1][1];
   drive_channel = - ( 10000.0 ) * ica / ( 2.0 * FARADAY * depth_cad ) ;
   if ( drive_channel <= 0. ) {
     drive_channel = 0. ;
     ;}
    ca = ca + (1. - exp(dt*(( ( ( - 1.0 ) ) ) / taur_cad)))*(- ( drive_channel + ( ( cainf_cad ) ) / taur_cad ) / ( ( ( ( - 1.0) ) ) / taur_cad ) - ca) ;
   cai = ca ;
   ;}
void DerivModel_kca(float dt, float v,float &n,float gbar_kca,float caix_kca,float Ra_kca,float Rb_kca, float cai) {
float rhs[1];
float y[1];
float matq[1][1];
   rates_kca (  cai ,gbar_kca,caix_kca,Ra_kca,Rb_kca) ;
    n = n + (1. - exp(dt*(( ( ( - 1.0 ) ) ) / ntau)))*(- ( ( ( ninf ) ) / ntau ) / ( ( ( ( - 1.0) ) ) / ntau ) - n) ;
   ;}
void DerivModel_km(float dt, float v,float &n,float gbar_km,float tha_km,float qa_km,float Ra_km,float Rb_km) {
float rhs[1];
float y[1];
float matq[1][1];
   trates_km (  v ,gbar_km,tha_km,qa_km,Ra_km,Rb_km) ;
    n = n + (1. - exp(dt*(( ( ( - 1.0 ) ) ) / ntau)))*(- ( ( ( ninf ) ) / ntau ) / ( ( ( ( - 1.0) ) ) / ntau ) - n) ;
   ;}
void DerivModel_kv(float dt, float v,float &n,float gbar_kv,float tha_kv,float qa_kv,float Ra_kv,float Rb_kv) {
float rhs[1];
float y[1];
float matq[1][1];
   trates_kv (  v ,gbar_kv,tha_kv,qa_kv,Ra_kv,Rb_kv) ;
    n = n + (1. - exp(dt*(( ( ( - 1.0 ) ) ) / ntau)))*(- ( ( ( ninf ) ) / ntau ) / ( ( ( ( - 1.0) ) ) / ntau ) - n) ;
   ;}
void DerivModel_na(float dt, float v,float &m,float &h,float gbar_na,float tha_na,float qa_na,float Ra_na,float Rb_na,float thi1_na,float thi2_na,float qi_na,float thinf_na,float qinf_na,float Rg_na,float Rd_na) {
float rhs[2];
float y[2];
float matq[2][2];
   trates_na (  v + vshift_na ,gbar_na,tha_na,qa_na,Ra_na,Rb_na,thi1_na,thi2_na,qi_na,thinf_na,qinf_na,Rg_na,Rd_na) ;
    m = m + (1. - exp(dt*(( ( ( - 1.0 ) ) ) / mtau)))*(- ( ( ( minf ) ) / mtau ) / ( ( ( ( - 1.0) ) ) / mtau ) - m) ;
    h = h + (1. - exp(dt*(( ( ( - 1.0 ) ) ) / htau)))*(- ( ( ( hinf ) ) / htau ) / ( ( ( ( - 1.0) ) ) / htau ) - h) ;
   ;}

// Breakpoints:
void BreakpointModel_ca(MYSECONDFTYPE &sumCurrents, MYFTYPE &sumConductivity, float v,float &m,float &h,float gbar_ca,float cao_ca, float cai, float &ica) {
float eca;
eca = nernst(cai,DEF_cao,2.);
gca=tadj_ca*gbar_ca*m*m*h;
ica=(1e-4)*gca*(v-eca);
sumCurrents+= ica;
sumConductivity+= gca;
;};
void BreakpointModel_cad(MYSECONDFTYPE &sumCurrents, MYFTYPE &sumConductivity, float v,float &ca, float ica, float &cai) {
;};
void BreakpointModel_kca(MYSECONDFTYPE &sumCurrents, MYFTYPE &sumConductivity, float v,float &n,float gbar_kca,float caix_kca,float Ra_kca,float Rb_kca, float cai) {
gk=tadj_kca*gbar_kca*n;
ik=(1e-4)*gk*(v-ek);
sumCurrents+= ik;
sumConductivity+= gk;
;};
void BreakpointModel_km(MYSECONDFTYPE &sumCurrents, MYFTYPE &sumConductivity, float v,float &n,float gbar_km,float tha_km,float qa_km,float Ra_km,float Rb_km) {
gk=tadj_km*gbar_km*n;
ik=(1e-4)*gk*(v-ek);
sumCurrents+= ik;
sumConductivity+= gk;
;};
void BreakpointModel_kv(MYSECONDFTYPE &sumCurrents, MYFTYPE &sumConductivity, float v,float &n,float gbar_kv,float tha_kv,float qa_kv,float Ra_kv,float Rb_kv) {
gk=tadj_kv*gbar_kv*n;
ik=(1e-4)*gk*(v-ek);
sumCurrents+= ik;
sumConductivity+= gk;
;};
void BreakpointModel_na(MYSECONDFTYPE &sumCurrents, MYFTYPE &sumConductivity, float v,float &m,float &h,float gbar_na,float tha_na,float qa_na,float Ra_na,float Rb_na,float thi1_na,float thi2_na,float qi_na,float thinf_na,float qinf_na,float Rg_na,float Rd_na) {
gna=tadj_na*gbar_na*m*m*m*h;
ina=(1e-4)*gna*(v-ena);
sumCurrents+= ina;
sumConductivity+= gna;
;};
