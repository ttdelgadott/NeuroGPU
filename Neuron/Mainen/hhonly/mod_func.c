#include <stdio.h>
#include "hocdec.h"
#define IMPORT extern __declspec(dllimport)
IMPORT int nrnmpi_myid, nrn_nobanner_;

modl_reg(){
	//nrn_mswindll_stdio(stdin, stdout, stderr);
    if (!nrn_nobanner_) if (nrnmpi_myid < 1) {
	fprintf(stderr, "Additional mechanisms from files\n");

fprintf(stderr," ca1.mod");
fprintf(stderr," cad1.mod");
fprintf(stderr," kca1.mod");
fprintf(stderr," km1.mod");
fprintf(stderr," kv1.mod");
fprintf(stderr," na1.mod");
fprintf(stderr, "\n");
    }
_ca1_reg();
_cad1_reg();
_kca1_reg();
_km1_reg();
_kv1_reg();
_na1_reg();
}
