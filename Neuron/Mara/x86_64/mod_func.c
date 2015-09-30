#include <stdio.h>
#include "hocdec.h"
extern int nrnmpi_myid;
extern int nrn_nobanner_;
modl_reg(){
  if (!nrn_nobanner_) if (nrnmpi_myid < 1) {
    fprintf(stderr, "Additional mechanisms from files\n");

    fprintf(stderr," BK.mod");
    fprintf(stderr," SK.mod");
    fprintf(stderr," ca_h.mod");
    fprintf(stderr," ca_r.mod");
    fprintf(stderr," cad.mod");
    fprintf(stderr," epsp.mod");
    fprintf(stderr," ih.mod");
    fprintf(stderr," kfast.mod");
    fprintf(stderr," kslow.mod");
    fprintf(stderr," na.mod");
    fprintf(stderr, "\n");
  }
  _BK_reg();
  _SK_reg();
  _ca_h_reg();
  _ca_r_reg();
  _cad_reg();
  _epsp_reg();
  _ih_reg();
  _kfast_reg();
  _kslow_reg();
  _na_reg();
}
