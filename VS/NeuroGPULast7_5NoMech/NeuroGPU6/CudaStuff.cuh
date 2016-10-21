#ifndef __CUDASTUFF__
#define __CUDASTUFF__

#include "cuda_runtime.h"

#include "device_launch_parameters.h"
#include "Util.h"
#include <cusparse.h>
extern __shared__ char smem[];

cudaError_t stEfork2Main(Stim stim, Sim sim, MYFTYPE* ParamsM, HMat& InMat, MYFTYPE* V,MYDTYPE CompDepth,MYDTYPE CompFDepth,MYDTYPE NSets);
cudaError_t stEfork2TimeLoopGPU(Stim stim, Sim sim, MYFTYPE* ParamsM, HMat& InMat, MYFTYPE* V,MYDTYPE CompDepth,MYDTYPE CompFDepth,MYDTYPE NSets);
void ReadParamsMatX(const char* FN, MYFTYPE* ParamsM,MYDTYPE NParams,MYDTYPE Nx);
void ReadParamsMat(const char* FN, MYFTYPE** ParamsM,MYDTYPE NParams,MYDTYPE Nx);
MYFTYPE* ReadAllParams(const char* FN, MYDTYPE NParams,MYDTYPE Nx,MYDTYPE &NSets);
void FreeParallelNeuronData(HMat &InMat);

#endif
