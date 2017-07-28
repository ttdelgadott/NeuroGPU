#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include "cuda_runtime.h"
#include "device_launch_parameters.h"
#include "AllModels.h"

__device__ float calc_determinant(float mat[NSTATES-1][NSTATES-1], int n) {
	//Only if this matrix is of dimension 1x1
	if (n == 1) {
		return mat[0][0];
	}

	float L[n][n];
	float U[n][n];
	float sum = 0;

	for (int i = 0; i < n; i++) {
		U[i][i] = 1;
	}

	for (int j = 0; j < n; j++) {
		for (int i = j; i < n; i++) {
			sum = 0;
			for (int k = 0; k < j; k++) {
				sum += L[i][k] * U[k][j];
			}
			L[i][j] = mat[i][j] - sum;
		}

		for (int i = j; i < n; i++) {
			sum = 0;
			for (int k = 0; k < j; k++) { sum += (L[j][k] * U[k][i]); }
			if (L[j][j] == 0) {
				//This is bad. bad things will happen. 
				return -1.0;
			}
			U[j][i] = (mat[j][i] - sum) / L[j][j];
		}
	}
	float det = 1.0;
	for (int i = 0; i < n; i++) {
		det = det * U[i][i] * L[i][i];
	}
	return det;
}


__device__ void init_state_probs(float q[NSTATES][NSTATES], float y[NSTATES]) {
	float sum = 0;
	for (int i = 0; i < NSTATES; i++) {
		y[i] = calc_prob(q, i);
		sum += y[i];
	}
	for (int i = 0; i < NSTATES; i++) {
		y[i] /= sum;
	}
}

__device__ float calc_prob(float q[NSTATES][NSTATES], int skip) {
	int i = 0;
	int j = 0;
	int temp_i_index = 0;
	int temp_j_index = 0;
	int n = NSTATES;  

	/*for the general nxn case*/
	float temp[NSTATES-1][NSTATES-1]; //dynamically generated--should be 1 less than the dimension of q
	while (i < n) {
		if (i == skip) {
			i++;
			continue;
		}
		j = 0;
		temp_j_index = 0;
		while (j < n) {
			if (j == skip) {
				j++;
				continue;
			}
			temp[temp_i_index][temp_j_index] = q[i][j];
			j += 1;
			temp_j_index += 1;
		}
		temp_i_index += 1;
		i++;
		printf("i = %d\n", i);
		printf("j = %d\n", j);
	}
	return calc_determinant(temp, n-1);
}

__device__ float rhs(float q[NSTATES][NSTATES], int index, float y[NSTATES]){
	float yout = 0;
	for (int i = 0; i < NSTATES; i++) {
		yout = yout + q[i][index] * y[i];
	}
	return yout;
}

__device__ void Cubackwards_euler(double dt, int N, int nkinStates,float y[NSTATES],float matq[NSTATES][NSTATES]){
	double h = dt / N;
  for (int i = 0; i < nkinStates; i++) {
       double w0 = y[i];
	  
       for (int j = 0; j < N; j++) {
		   double top = (w0 - y[i] - h * rhs(matq, i, y));
		   double bottom = (1 - h * matq[i][i]);
		   double dw = top / bottom;
            w0 = w0 - dw;
       }
       y[i] = w0;
  }
}
