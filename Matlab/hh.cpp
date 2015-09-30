#include "hh.h"
#include <math.h>

float hinf,htau,minf,mtau,ninf,ntau;

void rates(float v) ;

float vtrap(float x,float y) {
        if (fabs(x/y) < 1e-6) {;
                return y*(1 - x/y/2);
        }else{;
                return x/(exp(x/y) - 1);
        };
};

void InitModel(float v,float &m,float &h,float &n) {
	rates(v);
	m=minf;
	h=hinf;
	n=ninf;
};

void rates(float v) {
float  alpha, beta, sum, q10;
                      ;
        q10=3^((celsius - 6.3)/10);
                ;
        alpha=.1 * vtrap(-(v+40),10);
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
        alpha=.01*vtrap(-(v+55),10) ;
        beta=.125*exp(-(v+65)/80);
	sum=alpha + beta;
        ntau=1/(q10*sum);
        ninf=alpha/sum;
};

void DerivModel(float dt, float v, float &m,float &h,float &n) {
float m_d,h_d,n_d;
        rates(v);
        m_d=(minf-m)/mtau;
        h_d=(hinf-h)/htau;
        n_d=(ninf-n)/ntau;
m+=m_d*dt;
h+=h_d*dt;
n+=n_d*dt;
};

void BreakpointModel(float &sumCurrents, float &sumConductivity, float v,float &m,float &h,float &n,float gnabar,float gkbar,float gl,float el) {
float gk,gna;
float ina,ik,il;
gna=gnabar*m*m*m*h;
ina=gna*(v-ena);
gk=gkbar*n*n*n*n;
ik=gk*(v-ek);
il=gl*(v-el);
sumCurrents= ina+ik+il;
sumConductivity= gk+gna;
};

