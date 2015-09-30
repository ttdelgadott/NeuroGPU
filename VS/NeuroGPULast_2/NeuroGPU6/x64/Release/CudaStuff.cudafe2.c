#line 1 "x64/Release/CudaStuff.cudafe1.gpu"
#line 56 "c:\\users\\rben.keck-center\\documents\\neurogpu2\\vs\\neurogpulast_2\\neurogpu6\\Util.h"
struct HMat;
#line 101 "c:\\users\\rben.keck-center\\documents\\neurogpu2\\vs\\neurogpulast_2\\neurogpu6\\Util.h"
struct Stim;
#line 116 "c:\\users\\rben.keck-center\\documents\\neurogpu2\\vs\\neurogpulast_2\\neurogpu6\\Util.h"
struct Sim;
#line 428 "C:\\Program Files (x86)\\Microsoft Visual Studio 11.0\\VC\\include\\crtdefs.h"
typedef unsigned __int64 size_t;
#include "crt/host_runtime.h"
#line 56 "c:\\users\\rben.keck-center\\documents\\neurogpu2\\vs\\neurogpulast_2\\neurogpu6\\Util.h"
struct HMat {
#line 57 "c:\\users\\rben.keck-center\\documents\\neurogpu2\\vs\\neurogpulast_2\\neurogpu6\\Util.h"
double *e;
#line 58 "c:\\users\\rben.keck-center\\documents\\neurogpu2\\vs\\neurogpulast_2\\neurogpu6\\Util.h"
double *f;
#line 59 "c:\\users\\rben.keck-center\\documents\\neurogpu2\\vs\\neurogpulast_2\\neurogpu6\\Util.h"
unsigned short N;
#line 61 "c:\\users\\rben.keck-center\\documents\\neurogpu2\\vs\\neurogpulast_2\\neurogpu6\\Util.h"
unsigned short *Ks;
#line 62 "c:\\users\\rben.keck-center\\documents\\neurogpu2\\vs\\neurogpulast_2\\neurogpu6\\Util.h"
float *Cms;
#line 63 "c:\\users\\rben.keck-center\\documents\\neurogpu2\\vs\\neurogpulast_2\\neurogpu6\\Util.h"
unsigned short NModels;
#line 64 "c:\\users\\rben.keck-center\\documents\\neurogpu2\\vs\\neurogpulast_2\\neurogpu6\\Util.h"
unsigned short NComps;
#line 65 "c:\\users\\rben.keck-center\\documents\\neurogpu2\\vs\\neurogpulast_2\\neurogpu6\\Util.h"
unsigned short *boolModel;
#line 67 "c:\\users\\rben.keck-center\\documents\\neurogpu2\\vs\\neurogpulast_2\\neurogpu6\\Util.h"
unsigned short Depth;
#line 68 "c:\\users\\rben.keck-center\\documents\\neurogpu2\\vs\\neurogpulast_2\\neurogpu6\\Util.h"
unsigned short LognDepth;
#line 69 "c:\\users\\rben.keck-center\\documents\\neurogpu2\\vs\\neurogpulast_2\\neurogpu6\\Util.h"
unsigned short nFathers;
#line 70 "c:\\users\\rben.keck-center\\documents\\neurogpu2\\vs\\neurogpulast_2\\neurogpu6\\Util.h"
unsigned short nCallForFather;
#line 71 "c:\\users\\rben.keck-center\\documents\\neurogpu2\\vs\\neurogpulast_2\\neurogpu6\\Util.h"
unsigned short *Fathers;
#line 73 "c:\\users\\rben.keck-center\\documents\\neurogpu2\\vs\\neurogpulast_2\\neurogpu6\\Util.h"
unsigned short *SonNoVec;
#line 75 "c:\\users\\rben.keck-center\\documents\\neurogpu2\\vs\\neurogpulast_2\\neurogpu6\\Util.h"
unsigned short *RelStarts;
#line 76 "c:\\users\\rben.keck-center\\documents\\neurogpu2\\vs\\neurogpulast_2\\neurogpu6\\Util.h"
unsigned short *RelEnds;
#line 77 "c:\\users\\rben.keck-center\\documents\\neurogpu2\\vs\\neurogpulast_2\\neurogpu6\\Util.h"
unsigned short *RelVec;
#line 78 "c:\\users\\rben.keck-center\\documents\\neurogpu2\\vs\\neurogpulast_2\\neurogpu6\\Util.h"
unsigned short *SegStartI;
#line 79 "c:\\users\\rben.keck-center\\documents\\neurogpu2\\vs\\neurogpulast_2\\neurogpu6\\Util.h"
unsigned short *SegEndI;
#line 80 "c:\\users\\rben.keck-center\\documents\\neurogpu2\\vs\\neurogpulast_2\\neurogpu6\\Util.h"
unsigned short *SegToComp;
#line 81 "c:\\users\\rben.keck-center\\documents\\neurogpu2\\vs\\neurogpulast_2\\neurogpu6\\Util.h"
unsigned short *MidComps;
#line 83 "c:\\users\\rben.keck-center\\documents\\neurogpu2\\vs\\neurogpulast_2\\neurogpu6\\Util.h"
unsigned short *FIdxs;
#line 86 "c:\\users\\rben.keck-center\\documents\\neurogpu2\\vs\\neurogpulast_2\\neurogpu6\\Util.h"
unsigned short *CompByLevel32;
#line 87 "c:\\users\\rben.keck-center\\documents\\neurogpu2\\vs\\neurogpulast_2\\neurogpu6\\Util.h"
unsigned short *CompByFLevel32;
#line 88 "c:\\users\\rben.keck-center\\documents\\neurogpu2\\vs\\neurogpulast_2\\neurogpu6\\Util.h"
unsigned short nLRel;
#line 89 "c:\\users\\rben.keck-center\\documents\\neurogpu2\\vs\\neurogpulast_2\\neurogpu6\\Util.h"
unsigned short *LRelStarts;
#line 90 "c:\\users\\rben.keck-center\\documents\\neurogpu2\\vs\\neurogpulast_2\\neurogpu6\\Util.h"
unsigned short *LRelEnds;
#line 91 "c:\\users\\rben.keck-center\\documents\\neurogpu2\\vs\\neurogpulast_2\\neurogpu6\\Util.h"
unsigned short nFLRel;
#line 92 "c:\\users\\rben.keck-center\\documents\\neurogpu2\\vs\\neurogpulast_2\\neurogpu6\\Util.h"
unsigned short *FLRelStarts;
#line 93 "c:\\users\\rben.keck-center\\documents\\neurogpu2\\vs\\neurogpulast_2\\neurogpu6\\Util.h"
unsigned short *FLRelEnds;};
#line 98 "c:\\users\\rben.keck-center\\documents\\neurogpu2\\vs\\neurogpulast_2\\neurogpu6\\Util.h"
typedef struct HMat HMat;
#line 101 "c:\\users\\rben.keck-center\\documents\\neurogpu2\\vs\\neurogpulast_2\\neurogpu6\\Util.h"
struct Stim {
#line 102 "c:\\users\\rben.keck-center\\documents\\neurogpu2\\vs\\neurogpulast_2\\neurogpu6\\Util.h"
unsigned short NStimuli;
#line 103 "c:\\users\\rben.keck-center\\documents\\neurogpu2\\vs\\neurogpulast_2\\neurogpu6\\Util.h"
unsigned short loc;
#line 104 "c:\\users\\rben.keck-center\\documents\\neurogpu2\\vs\\neurogpulast_2\\neurogpu6\\Util.h"
unsigned short comp;
#line 105 "c:\\users\\rben.keck-center\\documents\\neurogpu2\\vs\\neurogpulast_2\\neurogpu6\\Util.h"
unsigned short numofdts;
#line 106 "c:\\users\\rben.keck-center\\documents\\neurogpu2\\vs\\neurogpulast_2\\neurogpu6\\Util.h"
float area;
#line 107 "c:\\users\\rben.keck-center\\documents\\neurogpu2\\vs\\neurogpulast_2\\neurogpu6\\Util.h"
unsigned short *dtInds;
#line 108 "c:\\users\\rben.keck-center\\documents\\neurogpu2\\vs\\neurogpulast_2\\neurogpu6\\Util.h"
float *amps;
#line 109 "c:\\users\\rben.keck-center\\documents\\neurogpu2\\vs\\neurogpulast_2\\neurogpu6\\Util.h"
float *durs;
#line 110 "c:\\users\\rben.keck-center\\documents\\neurogpu2\\vs\\neurogpulast_2\\neurogpu6\\Util.h"
float *dels;
#line 111 "c:\\users\\rben.keck-center\\documents\\neurogpu2\\vs\\neurogpulast_2\\neurogpu6\\Util.h"
float Nt; char __nv_no_debug_dummy_end_padding_0[4];};
#line 112 "c:\\users\\rben.keck-center\\documents\\neurogpu2\\vs\\neurogpulast_2\\neurogpu6\\Util.h"
typedef struct Stim Stim;
#line 116 "c:\\users\\rben.keck-center\\documents\\neurogpu2\\vs\\neurogpulast_2\\neurogpu6\\Util.h"
struct Sim {
#line 117 "c:\\users\\rben.keck-center\\documents\\neurogpu2\\vs\\neurogpulast_2\\neurogpu6\\Util.h"
float *Vs;
#line 118 "c:\\users\\rben.keck-center\\documents\\neurogpu2\\vs\\neurogpulast_2\\neurogpu6\\Util.h"
float dt;
#line 119 "c:\\users\\rben.keck-center\\documents\\neurogpu2\\vs\\neurogpulast_2\\neurogpu6\\Util.h"
float TFinal;
#line 120 "c:\\users\\rben.keck-center\\documents\\neurogpu2\\vs\\neurogpulast_2\\neurogpu6\\Util.h"
float Celsius;
#line 121 "c:\\users\\rben.keck-center\\documents\\neurogpu2\\vs\\neurogpulast_2\\neurogpu6\\Util.h"
unsigned short NRecSites;
#line 122 "c:\\users\\rben.keck-center\\documents\\neurogpu2\\vs\\neurogpulast_2\\neurogpu6\\Util.h"
unsigned short *RecSites;};
#line 123 "c:\\users\\rben.keck-center\\documents\\neurogpu2\\vs\\neurogpulast_2\\neurogpu6\\Util.h"
typedef struct Sim Sim;
void *memcpy(void*, const void*, size_t); void *memset(void*, int, size_t);
#line 84 "c:\\users\\rben.keck-center\\documents\\neurogpu2\\vs\\neurogpulast_2\\neurogpu6\\AllModels.cu"
extern int fdividef();
#line 118 "c:\\users\\rben.keck-center\\documents\\neurogpu2\\vs\\neurogpulast_2\\neurogpu6\\AllModels.cu"
extern int fdivide();
#line 299 "C:/Users/rben.KECK-CENTER/Documents/neurogpu2/VS/NeuroGPULast_2/NeuroGPU6/CudaStuff.cu"
extern int __float2uint_rz();
#line 320 "C:/Users/rben.KECK-CENTER/Documents/neurogpu2/VS/NeuroGPULast_2/NeuroGPU6/CudaStuff.cu"
extern int __float2int_rz();

#include "x64/Release/CudaStuff.cudafe2.stub.c"
