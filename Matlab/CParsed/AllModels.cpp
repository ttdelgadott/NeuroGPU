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
