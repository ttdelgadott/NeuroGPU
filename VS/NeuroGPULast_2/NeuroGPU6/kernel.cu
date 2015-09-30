
#include "Util.h"
#include <direct.h>

int main()
{
	 //RunByModelSerial();// FOR ROY!!!!!!!!!!!!!!! // Run, output VHot and look
	 /*Add to first kernel
	 cudaStatus = cudaSetDevice(0);
	if (cudaStatus != cudaSuccess) {
		fprintf(stderr, "cudaSetDevice failed!  Do you have a CUDA-capable GPU installed?");
		goto Error;
	}
	*/
	
	printf("we are in the %s directory\n",_getcwd( NULL, 0 ));
	RunByModelP();
	
    
    return 0;
}