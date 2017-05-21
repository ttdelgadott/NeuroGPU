: Four state kinetic scheme for Sodium channel
: Gurkiewicz 2007
NEURON {
      SUFFIX CO
      USEION k READ ek WRITE ik
      RANGE g, gbar,a12,a21,z12,z21
}
UNITS {
        (mA) = (milliamp)
        (mV) = (millivolt)
        (pS) = (picosiemens)
        (um) = (micron)
}

PARAMETER {
      gbar = 1000     (pS/um2)
      a12 = 0.995050492	(/ms)
      a21 = 7.617215488	(/ms)
      z12 = 0.015702762	(/mV)
      z21 = 0.054372320	(/mV)
      
}
ASSIGNED {
      v    (mV)
      ek   (mV)
      g    (pS/um2)
      ik  (mA/cm2)
      k12  (/ms)
      k21  (/ms)
}

STATE { c1  o }

BREAKPOINT {
      SOLVE states METHOD sparse
      g = gbar*o
      ik = (1e-4) * g*(v - ek)
}

INITIAL {c1=0 
o=0}

KINETIC states {
        rates(v)
        ~c1 <-> o (k12,k21)

        CONSERVE c1+o=1
}

PROCEDURE rates(v(millivolt)) {

      k12 = a12*exp(z12*v)
      k21 = a21*exp(-z21*v)
     
}