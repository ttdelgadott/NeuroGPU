// Automatically generated CU for C:\Users\rben.KECK-CENTER\Documents\GitHub\NeuroGPU\URapNeuron\Markov2st\runModel.hoc
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

#define _RHS1(arg) rhs[arg]
#define _MATELM1(i, j) matq[i][j]


// GGlobals
#define celsius (6.30000)
#define stoprun (0.00000)
#define clamp_resist (0.00100)
#define secondorder (0.00000)

// NGlobals:
#define _RHS1(arg) rhs[arg]
#define _MATELM1(i, j) matq[i][j]

// Reversals:
#define ek (-77.00000f)


#define TRUNC 1000
// Declarations:
__device__ void Curates_CO(float v,float gbar_CO,float a12_CO,float a21_CO,float z12_CO,float z21_CO,float &k12,float &k21);
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

//helper functions:
__device__ void make_q(float v, float a[2][2], float z[2][2], float q[2][2]) {
	float rows = 2;
	float cols = 2;

	for (int i = 0; i < rows; i++) {
		for (int j = 0; j < cols; j++) {
			if (i != j) {
				q[i][j] = (a[i][j] * exp(-z[i][j] * v));
				q[j][i] = (a[j][i] * exp(z[j][i] * v));
				
			}
		}
	}
	for (int i = 0; i < rows; i++) {
		float sum = 0;
		for (int j = 0; j < cols; j++) {
			if (i != j) { 
				sum += q[i][j];
			}
		}
		q[i][i] = -sum;
	}
}

__device__ float calc_determinant(float mat[1][1], int n) {
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

/*Skip denotes skipping row i and column i */
__device__ float calc_prob(float q[2][2], int skip) {
	//float temp[1][1]; //these dimensions are not hardcoded, they should be generated 
	int i = 0;
	int j = 0;
	int temp_i_index = 0;
	int temp_j_index = 0;
	int n = 2; //generate this 

	/*kludge that works in the 2x2 case only
	if (skip == 0) {
	return q[1][1];
	}
	return q[0][0];
	*/

	/*for the general nxn case*/
	float temp[1][1]; //dynamically generated--should be 1 less than the dimension of q
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

__device__ void init_state_probs(float q[2][2], float y[2]) {
	float sum = 0;
	for (int i = 0; i < 2; i++) {
		y[i] = calc_prob(q, i);
		sum += y[i];
	}
	for (int i = 0; i < 2; i++) {
		y[i] /= sum;
	}
}


__device__ float rhs(float q[2][2], int index, float y[2]){
	float yout = 0;
	for (int i = 0; i < 2; i++) {
		yout = yout + q[i][index] * y[i];
	}
	return yout;
}

// Kinetic Code:
__device__ void Cubackwards_euler(double dt, int N, int nkinStates,float y[2],float matq[2][2]){
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

__device__ void dydt(float y[2], float dydx[2], float matq[2][2], int n) {
	for (int i = 0; i < n; i++) {
		float sum = 0;
		for (int j = 0; j < n; j++) {
			sum += matq[i][j] * y[j];
		}
		dydx[i] = sum;
	}
}

__device__ void Cubackwards_euler2(int numLoops, double h, float y[2], int numStates, float matq[2][2]) {
	float w0[2], dydx[2];
	float top, bot, dw;

	for (int i = 0; i < numStates; i++) {
		w0[i] = y[i];
	
		for (int j = 0; j < numLoops; j++) {
				dydt(w0, dydx, matq, 2);
				for (int state = 0; state < numStates; state++) {
					top = (w0[state] - y[state]) - h * dydx[state];
					bot = 1 - h * matq[state][state];
					dw = top / bot;
					w0[state] = w0[state] - dw;
				}
			}
		}
	for (int i = 0; i < numStates; i++) {
		y[i] = w0[i];
	}
}

__device__ void scalar_multiply(float vec[2], float scalar, float out_vec[2]) {
	for (int i = 0; i < 2; i++) {
		out_vec[i] = scalar * vec[i];
	}
}

__device__ void matrix_multiply(float mat[2][2], float vec[2], float out_vec[2]) {
	float debug = mat[1][0];
	float debug2 = mat[1][1];
	for (int i = 0; i < 2; i++) {
		float sum = 0; 
		for(int j = 0; j < 2; j++) {
			sum += mat[i][j] * vec[j]; 
		}
		out_vec[i] = sum;
	}
}

__device__ void add(float a[2], float b[2], float c[2]) {
	for (int i = 0; i < 2; i++) {
		c[i] = a[i] + b[i];
	}
}
__device__ void CuRK4(float h, float y[2], float matq[2][2]) {
	float yout[2], k1[2], k2[2], k3[2], k4[2];
	float k1_temp[2], k2_temp[2], k3_temp[2];
	
	matrix_multiply(matq, y, k1_temp);
	scalar_multiply(k1_temp, h, k1);

	scalar_multiply(k1, 0.5, k1_temp);
	add(y, k1_temp, yout);
	matrix_multiply(matq, yout, k2_temp);
	scalar_multiply(k2_temp, h, k2);

	scalar_multiply(k2, 0.5, k2_temp);
	add(y, k2_temp, yout);
	matrix_multiply(matq, yout, k3);

	add(y, k3, yout);
	matrix_multiply(matq, yout, k4);

	add(k2, k3, k3_temp);
	scalar_multiply(k3_temp, 2, k2_temp);
	add(k2_temp, k4, k1_temp);
	add(k1_temp, k1, k2_temp);
	scalar_multiply(k2_temp, 1 / 6.0, k1_temp);

	add(y, k1_temp, yout);
	float sum = 0; 
	for (int i = 0; i < 2; i++) {
		sum += yout[i];
	}
	scalar_multiply(yout, 1 / sum, y); //attempt to normalize 
}

// Functions:

// Procedures:
__device__ void Curates_CO(float v,float gbar_CO,float a12_CO,float a21_CO,float z12_CO,float z21_CO,float &k12,float &k21) {
      k12 = a12_CO*exp(z12_CO*v);
      k21 = a21_CO*exp(-z21_CO*v);
}


//Derivs: 
__device__ int CuDerivModel_CO(float t, float dt, float v, float &c1, float &o, float gbar_CO, float a12_CO, float a21_CO, float z12_CO, float z21_CO) {
	float y[2], q[2][2], a[2][2], z[2][2];

	a[0][1] = a12_CO;
	a[1][0] = a21_CO;
	z[0][1] = z12_CO;
	z[1][0] = z21_CO;
	//a[0][1] = 0.05; 
	//a[1][0] = 0.05;
	//z[0][1] = 0.05;
	//z[1][0] = 0.05; 

	/*Voltage Clamp*/
//	if (t > 500) {
//		v = 30; 
//	}
//	else {
//	if (t > 63)
//		v = 100;
//	else
	//	v = -100;
//	}
	printf("v = %f. t = %f", v, t);
	make_q(v, a, z, q);

	y[0] = c1;
	y[1] = o;

	//ITERATION:
	Cubackwards_euler(dt, 1, 2, y, q);
	//CuRK4(dt, y, q);
	//Cubackwards_euler2(10, dt, y, 2, q);
	printf(" probs = %f, %f\n",y[0], y[1]);
	c1 = y[0];
	o = y[1];
}

__device__ void CuInitModel_CO(float v,float &c1,float &o,float gbar_CO,float a12_CO,float a21_CO,float z12_CO,float z21_CO) {
	float k12,k21;
	double sum = 0;
	float temp[2];
	float tempq[2][2];
	float a[2][2], z[2][2];

	
	a[0][1] = a12_CO;
	a[1][0] = a21_CO;
	z[0][1] = z12_CO;
	z[1][0] = z21_CO;
	make_q(v, a, z, tempq);

	init_state_probs(tempq, temp);
	c1 = temp[0];
	o = temp[1];
}




// Breakpoints:
__device__ void CuBreakpointModel_CO(MYSECONDFTYPE &sumCurrents, MYFTYPE &sumConductivity, float v,float &c1,float &o,float gbar_CO,float a12_CO,float a21_CO,float z12_CO,float z21_CO) {
float g,gk;
float ik;
g=gbar_CO*o;
ik=(1e-4)*g*(v-ek);
sumCurrents+= ik;
;};
