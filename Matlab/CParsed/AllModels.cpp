// Automatically generated C for C:\Users\bensr\Documents\GitHub\NeuroGPU\URapNeuron\Markov2st\runModel.hoc
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
#define ek (-77.00000f)

// Locals:
float g,k12,k21;

// Ion currents as Locals:
float ik;

// NGlobals:
