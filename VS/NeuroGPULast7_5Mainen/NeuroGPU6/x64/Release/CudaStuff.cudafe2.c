#line 1 "x64/Release/CudaStuff.cudafe1.gpu"
#line 63 "c:\\users\\rben.keck-center\\documents\\neurogpu2\\vs\\neurogpulast\\neurogpu6\\Util.h"
struct HMat;
#line 108 "c:\\users\\rben.keck-center\\documents\\neurogpu2\\vs\\neurogpulast\\neurogpu6\\Util.h"
struct Stim;
#line 123 "c:\\users\\rben.keck-center\\documents\\neurogpu2\\vs\\neurogpulast\\neurogpu6\\Util.h"
struct Sim;
#line 428 "C:\\Program Files (x86)\\Microsoft Visual Studio 11.0\\VC\\include\\crtdefs.h"
typedef unsigned __int64 size_t;
#include "crt/host_runtime.h"
#line 63 "c:\\users\\rben.keck-center\\documents\\neurogpu2\\vs\\neurogpulast\\neurogpu6\\Util.h"
struct HMat {
#line 64 "c:\\users\\rben.keck-center\\documents\\neurogpu2\\vs\\neurogpulast\\neurogpu6\\Util.h"
double *e;
#line 65 "c:\\users\\rben.keck-center\\documents\\neurogpu2\\vs\\neurogpulast\\neurogpu6\\Util.h"
double *f;
#line 66 "c:\\users\\rben.keck-center\\documents\\neurogpu2\\vs\\neurogpulast\\neurogpu6\\Util.h"
unsigned short N;
#line 68 "c:\\users\\rben.keck-center\\documents\\neurogpu2\\vs\\neurogpulast\\neurogpu6\\Util.h"
unsigned short *Ks;
#line 69 "c:\\users\\rben.keck-center\\documents\\neurogpu2\\vs\\neurogpulast\\neurogpu6\\Util.h"
float *Cms;
#line 70 "c:\\users\\rben.keck-center\\documents\\neurogpu2\\vs\\neurogpulast\\neurogpu6\\Util.h"
unsigned short NModels;
#line 71 "c:\\users\\rben.keck-center\\documents\\neurogpu2\\vs\\neurogpulast\\neurogpu6\\Util.h"
unsigned short NComps;
#line 72 "c:\\users\\rben.keck-center\\documents\\neurogpu2\\vs\\neurogpulast\\neurogpu6\\Util.h"
unsigned short *boolModel;
#line 74 "c:\\users\\rben.keck-center\\documents\\neurogpu2\\vs\\neurogpulast\\neurogpu6\\Util.h"
unsigned short Depth;
#line 75 "c:\\users\\rben.keck-center\\documents\\neurogpu2\\vs\\neurogpulast\\neurogpu6\\Util.h"
unsigned short LognDepth;
#line 76 "c:\\users\\rben.keck-center\\documents\\neurogpu2\\vs\\neurogpulast\\neurogpu6\\Util.h"
unsigned short nFathers;
#line 77 "c:\\users\\rben.keck-center\\documents\\neurogpu2\\vs\\neurogpulast\\neurogpu6\\Util.h"
unsigned short nCallForFather;
#line 78 "c:\\users\\rben.keck-center\\documents\\neurogpu2\\vs\\neurogpulast\\neurogpu6\\Util.h"
unsigned short *Fathers;
#line 80 "c:\\users\\rben.keck-center\\documents\\neurogpu2\\vs\\neurogpulast\\neurogpu6\\Util.h"
unsigned short *SonNoVec;
#line 82 "c:\\users\\rben.keck-center\\documents\\neurogpu2\\vs\\neurogpulast\\neurogpu6\\Util.h"
unsigned short *RelStarts;
#line 83 "c:\\users\\rben.keck-center\\documents\\neurogpu2\\vs\\neurogpulast\\neurogpu6\\Util.h"
unsigned short *RelEnds;
#line 84 "c:\\users\\rben.keck-center\\documents\\neurogpu2\\vs\\neurogpulast\\neurogpu6\\Util.h"
unsigned short *RelVec;
#line 85 "c:\\users\\rben.keck-center\\documents\\neurogpu2\\vs\\neurogpulast\\neurogpu6\\Util.h"
unsigned short *SegStartI;
#line 86 "c:\\users\\rben.keck-center\\documents\\neurogpu2\\vs\\neurogpulast\\neurogpu6\\Util.h"
unsigned short *SegEndI;
#line 87 "c:\\users\\rben.keck-center\\documents\\neurogpu2\\vs\\neurogpulast\\neurogpu6\\Util.h"
unsigned short *SegToComp;
#line 88 "c:\\users\\rben.keck-center\\documents\\neurogpu2\\vs\\neurogpulast\\neurogpu6\\Util.h"
unsigned short *MidComps;
#line 90 "c:\\users\\rben.keck-center\\documents\\neurogpu2\\vs\\neurogpulast\\neurogpu6\\Util.h"
unsigned short *FIdxs;
#line 93 "c:\\users\\rben.keck-center\\documents\\neurogpu2\\vs\\neurogpulast\\neurogpu6\\Util.h"
unsigned short *CompByLevel32;
#line 94 "c:\\users\\rben.keck-center\\documents\\neurogpu2\\vs\\neurogpulast\\neurogpu6\\Util.h"
unsigned short *CompByFLevel32;
#line 95 "c:\\users\\rben.keck-center\\documents\\neurogpu2\\vs\\neurogpulast\\neurogpu6\\Util.h"
unsigned short nLRel;
#line 96 "c:\\users\\rben.keck-center\\documents\\neurogpu2\\vs\\neurogpulast\\neurogpu6\\Util.h"
unsigned short *LRelStarts;
#line 97 "c:\\users\\rben.keck-center\\documents\\neurogpu2\\vs\\neurogpulast\\neurogpu6\\Util.h"
unsigned short *LRelEnds;
#line 98 "c:\\users\\rben.keck-center\\documents\\neurogpu2\\vs\\neurogpulast\\neurogpu6\\Util.h"
unsigned short nFLRel;
#line 99 "c:\\users\\rben.keck-center\\documents\\neurogpu2\\vs\\neurogpulast\\neurogpu6\\Util.h"
unsigned short *FLRelStarts;
#line 100 "c:\\users\\rben.keck-center\\documents\\neurogpu2\\vs\\neurogpulast\\neurogpu6\\Util.h"
unsigned short *FLRelEnds;};
#line 105 "c:\\users\\rben.keck-center\\documents\\neurogpu2\\vs\\neurogpulast\\neurogpu6\\Util.h"
typedef struct HMat HMat;
#line 108 "c:\\users\\rben.keck-center\\documents\\neurogpu2\\vs\\neurogpulast\\neurogpu6\\Util.h"
struct Stim {
#line 109 "c:\\users\\rben.keck-center\\documents\\neurogpu2\\vs\\neurogpulast\\neurogpu6\\Util.h"
unsigned short NStimuli;
#line 110 "c:\\users\\rben.keck-center\\documents\\neurogpu2\\vs\\neurogpulast\\neurogpu6\\Util.h"
unsigned short loc;
#line 111 "c:\\users\\rben.keck-center\\documents\\neurogpu2\\vs\\neurogpulast\\neurogpu6\\Util.h"
unsigned short comp;
#line 112 "c:\\users\\rben.keck-center\\documents\\neurogpu2\\vs\\neurogpulast\\neurogpu6\\Util.h"
unsigned short numofdts;
#line 113 "c:\\users\\rben.keck-center\\documents\\neurogpu2\\vs\\neurogpulast\\neurogpu6\\Util.h"
float area;
#line 114 "c:\\users\\rben.keck-center\\documents\\neurogpu2\\vs\\neurogpulast\\neurogpu6\\Util.h"
unsigned short *dtInds;
#line 115 "c:\\users\\rben.keck-center\\documents\\neurogpu2\\vs\\neurogpulast\\neurogpu6\\Util.h"
float *amps;
#line 116 "c:\\users\\rben.keck-center\\documents\\neurogpu2\\vs\\neurogpulast\\neurogpu6\\Util.h"
float *durs;
#line 117 "c:\\users\\rben.keck-center\\documents\\neurogpu2\\vs\\neurogpulast\\neurogpu6\\Util.h"
float *dels;
#line 118 "c:\\users\\rben.keck-center\\documents\\neurogpu2\\vs\\neurogpulast\\neurogpu6\\Util.h"
float Nt; char __nv_no_debug_dummy_end_padding_0[4];};
#line 119 "c:\\users\\rben.keck-center\\documents\\neurogpu2\\vs\\neurogpulast\\neurogpu6\\Util.h"
typedef struct Stim Stim;
#line 123 "c:\\users\\rben.keck-center\\documents\\neurogpu2\\vs\\neurogpulast\\neurogpu6\\Util.h"
struct Sim {
#line 124 "c:\\users\\rben.keck-center\\documents\\neurogpu2\\vs\\neurogpulast\\neurogpu6\\Util.h"
float *Vs;
#line 125 "c:\\users\\rben.keck-center\\documents\\neurogpu2\\vs\\neurogpulast\\neurogpu6\\Util.h"
float dt;
#line 126 "c:\\users\\rben.keck-center\\documents\\neurogpu2\\vs\\neurogpulast\\neurogpu6\\Util.h"
float TFinal;
#line 127 "c:\\users\\rben.keck-center\\documents\\neurogpu2\\vs\\neurogpulast\\neurogpu6\\Util.h"
float Celsius;
#line 128 "c:\\users\\rben.keck-center\\documents\\neurogpu2\\vs\\neurogpulast\\neurogpu6\\Util.h"
unsigned short NRecSites;
#line 129 "c:\\users\\rben.keck-center\\documents\\neurogpu2\\vs\\neurogpulast\\neurogpu6\\Util.h"
unsigned short *RecSites;};
#line 130 "c:\\users\\rben.keck-center\\documents\\neurogpu2\\vs\\neurogpulast\\neurogpu6\\Util.h"
typedef struct Sim Sim;
void *memcpy(void*, const void*, size_t); void *memset(void*, int, size_t);
#line 84 "c:\\users\\rben.keck-center\\documents\\neurogpu2\\vs\\neurogpulast\\neurogpu6\\AllModels.cu"
extern int fdividef();
#line 118 "c:\\users\\rben.keck-center\\documents\\neurogpu2\\vs\\neurogpulast\\neurogpu6\\AllModels.cu"
extern int fdivide();
#line 299 "C:/Users/rben.KECK-CENTER/Documents/neurogpu2/VS/NeuroGPULast/NeuroGPU6/CudaStuff.cu"
extern int __float2uint_rz();
#line 320 "C:/Users/rben.KECK-CENTER/Documents/neurogpu2/VS/NeuroGPULast/NeuroGPU6/CudaStuff.cu"
extern int __float2int_rz();

#include "x64/Release/CudaStuff.cudafe2.stub.c"
