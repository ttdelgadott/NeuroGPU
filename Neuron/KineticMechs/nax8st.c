/* Created by Language version: 6.2.0 */
/* VECTORIZED */
#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include "scoplib.h"
#undef PI
 
#include "md1redef.h"
#include "section.h"
#include "md2redef.h"

#if METHOD3
extern int _method3;
#endif

#undef exp
#define exp hoc_Exp
extern double hoc_Exp();
 
#define _threadargscomma_ _p, _ppvar, _thread, _nt,
#define _threadargs_ _p, _ppvar, _thread, _nt
 	/*SUPPRESS 761*/
	/*SUPPRESS 762*/
	/*SUPPRESS 763*/
	/*SUPPRESS 765*/
	 extern double *getarg();
 /* Thread safe. No static _p or _ppvar. */
 
#define t _nt->_t
#define dt _nt->_dt
#define gbar _p[0]
#define a1_0 _p[1]
#define a1_1 _p[2]
#define b1_0 _p[3]
#define b1_1 _p[4]
#define a2_0 _p[5]
#define a2_1 _p[6]
#define b2_0 _p[7]
#define b2_1 _p[8]
#define a3_0 _p[9]
#define a3_1 _p[10]
#define b3_0 _p[11]
#define b3_1 _p[12]
#define bh_0 _p[13]
#define bh_1 _p[14]
#define bh_2 _p[15]
#define ah_0 _p[16]
#define ah_1 _p[17]
#define ah_2 _p[18]
#define vShift_inact_local _p[19]
#define gna _p[20]
#define ina_inax _p[21]
#define c1 _p[22]
#define c2 _p[23]
#define c3 _p[24]
#define i1 _p[25]
#define i2 _p[26]
#define i3 _p[27]
#define i4 _p[28]
#define o _p[29]
#define ena _p[30]
#define ina _p[31]
#define a1 _p[32]
#define b1 _p[33]
#define a2 _p[34]
#define b2 _p[35]
#define a3 _p[36]
#define b3 _p[37]
#define ah _p[38]
#define bh _p[39]
#define tadj _p[40]
#define tadjh _p[41]
#define Dc1 _p[42]
#define Dc2 _p[43]
#define Dc3 _p[44]
#define Di1 _p[45]
#define Di2 _p[46]
#define Di3 _p[47]
#define Di4 _p[48]
#define Do _p[49]
#define v _p[50]
#define _g _p[51]
#define _ion_ena	*_ppvar[0]._pval
#define _ion_ina	*_ppvar[1]._pval
#define _ion_dinadv	*_ppvar[2]._pval
 
#if MAC
#if !defined(v)
#define v _mlhv
#endif
#if !defined(h)
#define h _mlhh
#endif
#endif
 static int hoc_nrnpointerindex =  -1;
 static Datum* _extcall_thread;
 static Prop* _extcall_prop;
 /* external NEURON variables */
 extern double celsius;
 /* declaration of user functions */
 static int _hoc_rates();
 static int _mechtype;
extern int nrn_get_mechtype();
 extern void _nrn_setdata_reg(int, void(*)(Prop*));
 static void _setdata(Prop* _prop) {
 _extcall_prop = _prop;
 }
 static _hoc_setdata() {
 Prop *_prop, *hoc_getdata_range();
 _prop = hoc_getdata_range(_mechtype);
   _setdata(_prop);
 ret(1.);
}
 /* connect user functions to hoc names */
 static IntFunc hoc_intfunc[] = {
 "setdata_nax", _hoc_setdata,
 "rates_nax", _hoc_rates,
 0, 0
};
 /* declare global and static user variables */
#define maxrate maxrate_nax
 double maxrate = 8000;
#define q10h q10h_nax
 double q10h = 2.3;
#define q10 q10_nax
 double q10 = 2.3;
#define temp temp_nax
 double temp = 23;
#define vShift_inact vShift_inact_nax
 double vShift_inact = 10;
#define vShift vShift_nax
 double vShift = 12;
 /* some parameters have upper and lower limits */
 static HocParmLimits _hoc_parm_limits[] = {
 0,0,0
};
 static HocParmUnits _hoc_parm_units[] = {
 "vShift_nax", "mV",
 "vShift_inact_nax", "mV",
 "maxrate_nax", "/ms",
 "temp_nax", "degC",
 "gbar_nax", "pS/um2",
 "a1_0_nax", "/ms",
 "a1_1_nax", "/mV",
 "b1_0_nax", "/ms",
 "b1_1_nax", "/mV",
 "a2_0_nax", "/ms",
 "a2_1_nax", "/mV",
 "b2_0_nax", "/ms",
 "b2_1_nax", "/mV",
 "a3_0_nax", "/ms",
 "a3_1_nax", "/mV",
 "b3_0_nax", "/ms",
 "b3_1_nax", "/mV",
 "bh_0_nax", "/ms",
 "bh_2_nax", "/mV",
 "ah_0_nax", "/ms",
 "ah_2_nax", "/mV",
 "vShift_inact_local_nax", "mV",
 "gna_nax", "millimho/cm2",
 "ina_inax_nax", "milliamp/cm2",
 0,0
};
 static double c30 = 0;
 static double c20 = 0;
 static double c10 = 0;
 static double delta_t = 0.01;
 static double i40 = 0;
 static double i30 = 0;
 static double i20 = 0;
 static double i10 = 0;
 static double o0 = 0;
 /* connect global user variables to hoc */
 static DoubScal hoc_scdoub[] = {
 "vShift_nax", &vShift_nax,
 "vShift_inact_nax", &vShift_inact_nax,
 "maxrate_nax", &maxrate_nax,
 "temp_nax", &temp_nax,
 "q10_nax", &q10_nax,
 "q10h_nax", &q10h_nax,
 0,0
};
 static DoubVec hoc_vdoub[] = {
 0,0,0
};
 static double _sav_indep;
 static void nrn_alloc(), nrn_init(), nrn_state();
 static void nrn_cur(), nrn_jacob();
 
static int _ode_count(), _ode_map(), _ode_spec(), _ode_matsol();
 
#define _cvode_ieq _ppvar[3]._i
 /* connect range variables in _p that hoc is supposed to know about */
 static char *_mechanism[] = {
 "6.2.0",
"nax",
 "gbar_nax",
 "a1_0_nax",
 "a1_1_nax",
 "b1_0_nax",
 "b1_1_nax",
 "a2_0_nax",
 "a2_1_nax",
 "b2_0_nax",
 "b2_1_nax",
 "a3_0_nax",
 "a3_1_nax",
 "b3_0_nax",
 "b3_1_nax",
 "bh_0_nax",
 "bh_1_nax",
 "bh_2_nax",
 "ah_0_nax",
 "ah_1_nax",
 "ah_2_nax",
 "vShift_inact_local_nax",
 0,
 "gna_nax",
 "ina_inax_nax",
 0,
 "c1_nax",
 "c2_nax",
 "c3_nax",
 "i1_nax",
 "i2_nax",
 "i3_nax",
 "i4_nax",
 "o_nax",
 0,
 0};
 static Symbol* _na_sym;
 
static void nrn_alloc(_prop)
	Prop *_prop;
{
	Prop *prop_ion, *need_memb();
	double *_p; Datum *_ppvar;
 	_p = nrn_prop_data_alloc(_mechtype, 52, _prop);
 	/*initialize range parameters*/
 	gbar = 1000;
 	a1_0 = 62.6477;
 	a1_1 = 0.0116055;
 	b1_0 = 0.00193691;
 	b1_1 = 0.137719;
 	a2_0 = 34.7828;
 	a2_1 = 0.0299559;
 	b2_0 = 0.0957515;
 	b2_1 = 0.0928114;
 	a3_0 = 76.6983;
 	a3_1 = 0.0537432;
 	b3_0 = 1.24879;
 	b3_1 = 0.0311504;
 	bh_0 = 3.57365;
 	bh_1 = 0.193321;
 	bh_2 = 0.0749654;
 	ah_0 = 6.88267;
 	ah_1 = 4654.02;
 	ah_2 = 0.0295833;
 	vShift_inact_local = 0;
 	_prop->param = _p;
 	_prop->param_size = 52;
 	_ppvar = nrn_prop_datum_alloc(_mechtype, 4, _prop);
 	_prop->dparam = _ppvar;
 	/*connect ionic variables to this model*/
 prop_ion = need_memb(_na_sym);
 nrn_promote(prop_ion, 0, 1);
 	_ppvar[0]._pval = &prop_ion->param[0]; /* ena */
 	_ppvar[1]._pval = &prop_ion->param[3]; /* ina */
 	_ppvar[2]._pval = &prop_ion->param[4]; /* _ion_dinadv */
 
}
 static _initlists();
  /* some states have an absolute tolerance */
 static Symbol** _atollist;
 static HocStateTolerance _hoc_state_tol[] = {
 0,0
};
 static void _thread_cleanup(Datum*);
 static void _update_ion_pointer(Datum*);
 _nax8st_reg() {
	int _vectorized = 1;
  _initlists();
 	ion_reg("na", -10000.);
 	_na_sym = hoc_lookup("na_ion");
 	register_mech(_mechanism, nrn_alloc,nrn_cur, nrn_jacob, nrn_state, nrn_init, hoc_nrnpointerindex, 3);
  _extcall_thread = (Datum*)ecalloc(2, sizeof(Datum));
 _mechtype = nrn_get_mechtype(_mechanism[1]);
     _nrn_setdata_reg(_mechtype, _setdata);
     _nrn_thread_reg(_mechtype, 0, _thread_cleanup);
     _nrn_thread_reg(_mechtype, 2, _update_ion_pointer);
  hoc_register_dparam_size(_mechtype, 4);
 	hoc_register_cvode(_mechtype, _ode_count, _ode_map, _ode_spec, _ode_matsol);
 	hoc_register_tolerance(_mechtype, _hoc_state_tol, &_atollist);
 	hoc_register_var(hoc_scdoub, hoc_vdoub, hoc_intfunc);
 	ivoc_help("help ?1 nax /cygdrive/c/Users/Roy/Documents/NeuroGPU2_2/Neuron/Kole/nax8st.mod\n");
 hoc_register_limits(_mechtype, _hoc_parm_limits);
 hoc_register_units(_mechtype, _hoc_parm_units);
 }
static int _reset;
static char *modelname = "";

static int error;
static int _ninits = 0;
static int _match_recurse=1;
static _modl_cleanup(){ _match_recurse=1;}
static rates();
 extern double *_nrn_thread_getelm();
 
#define _MATELM1(_row,_col) *(_nrn_thread_getelm(_so, _row + 1, _col + 1))
 
#define _RHS1(_arg) _rhs[_arg+1]
  
#define _linmat1  1
 static int _spth1 = 1;
 static int _cvspth1 = 0;
 
static int _ode_spec1(), _ode_matsol1();
 static int _slist1[8], _dlist1[8]; static double *_temp1;
 static int kin();
 
static int kin (void* _so, double* _rhs, double* _p, Datum* _ppvar, Datum* _thread, _NrnThread* _nt)
 {int _reset=0;
 {
   double b_flux, f_flux, _term; int _i;
 {int _i; double _dt1 = 1.0/dt;
for(_i=1;_i<8;_i++){
  	_RHS1(_i) = -_dt1*(_p[_slist1[_i]] - _p[_dlist1[_i]]);
	_MATELM1(_i, _i) = _dt1;
      
} }
 rates ( _threadargscomma_ v ) ;
   /* ~ c1 <-> c2 ( a1 , b1 )*/
 f_flux =  a1 * c1 ;
 b_flux =  b1 * c2 ;
 _RHS1( 3) -= (f_flux - b_flux);
 _RHS1( 2) += (f_flux - b_flux);
 
 _term =  a1 ;
 _MATELM1( 3 ,3)  += _term;
 _MATELM1( 2 ,3)  -= _term;
 _term =  b1 ;
 _MATELM1( 3 ,2)  -= _term;
 _MATELM1( 2 ,2)  += _term;
 /*REACTION*/
  /* ~ c2 <-> c3 ( a2 , b2 )*/
 f_flux =  a2 * c2 ;
 b_flux =  b2 * c3 ;
 _RHS1( 2) -= (f_flux - b_flux);
 _RHS1( 1) += (f_flux - b_flux);
 
 _term =  a2 ;
 _MATELM1( 2 ,2)  += _term;
 _MATELM1( 1 ,2)  -= _term;
 _term =  b2 ;
 _MATELM1( 2 ,1)  -= _term;
 _MATELM1( 1 ,1)  += _term;
 /*REACTION*/
  /* ~ c3 <-> o ( a3 , b3 )*/
 f_flux =  a3 * c3 ;
 b_flux =  b3 * o ;
 _RHS1( 1) -= (f_flux - b_flux);
 
 _term =  a3 ;
 _MATELM1( 1 ,1)  += _term;
 _term =  b3 ;
 _MATELM1( 1 ,0)  -= _term;
 /*REACTION*/
  /* ~ i1 <-> i2 ( a1 , b1 )*/
 f_flux =  a1 * i1 ;
 b_flux =  b1 * i2 ;
 _RHS1( 7) -= (f_flux - b_flux);
 _RHS1( 6) += (f_flux - b_flux);
 
 _term =  a1 ;
 _MATELM1( 7 ,7)  += _term;
 _MATELM1( 6 ,7)  -= _term;
 _term =  b1 ;
 _MATELM1( 7 ,6)  -= _term;
 _MATELM1( 6 ,6)  += _term;
 /*REACTION*/
  /* ~ i2 <-> i3 ( a2 , b2 )*/
 f_flux =  a2 * i2 ;
 b_flux =  b2 * i3 ;
 _RHS1( 6) -= (f_flux - b_flux);
 _RHS1( 5) += (f_flux - b_flux);
 
 _term =  a2 ;
 _MATELM1( 6 ,6)  += _term;
 _MATELM1( 5 ,6)  -= _term;
 _term =  b2 ;
 _MATELM1( 6 ,5)  -= _term;
 _MATELM1( 5 ,5)  += _term;
 /*REACTION*/
  /* ~ i3 <-> i4 ( a3 , b3 )*/
 f_flux =  a3 * i3 ;
 b_flux =  b3 * i4 ;
 _RHS1( 5) -= (f_flux - b_flux);
 _RHS1( 4) += (f_flux - b_flux);
 
 _term =  a3 ;
 _MATELM1( 5 ,5)  += _term;
 _MATELM1( 4 ,5)  -= _term;
 _term =  b3 ;
 _MATELM1( 5 ,4)  -= _term;
 _MATELM1( 4 ,4)  += _term;
 /*REACTION*/
  /* ~ i1 <-> c1 ( ah , bh )*/
 f_flux =  ah * i1 ;
 b_flux =  bh * c1 ;
 _RHS1( 7) -= (f_flux - b_flux);
 _RHS1( 3) += (f_flux - b_flux);
 
 _term =  ah ;
 _MATELM1( 7 ,7)  += _term;
 _MATELM1( 3 ,7)  -= _term;
 _term =  bh ;
 _MATELM1( 7 ,3)  -= _term;
 _MATELM1( 3 ,3)  += _term;
 /*REACTION*/
  /* ~ i2 <-> c2 ( ah , bh )*/
 f_flux =  ah * i2 ;
 b_flux =  bh * c2 ;
 _RHS1( 6) -= (f_flux - b_flux);
 _RHS1( 2) += (f_flux - b_flux);
 
 _term =  ah ;
 _MATELM1( 6 ,6)  += _term;
 _MATELM1( 2 ,6)  -= _term;
 _term =  bh ;
 _MATELM1( 6 ,2)  -= _term;
 _MATELM1( 2 ,2)  += _term;
 /*REACTION*/
  /* ~ i3 <-> c3 ( ah , bh )*/
 f_flux =  ah * i3 ;
 b_flux =  bh * c3 ;
 _RHS1( 5) -= (f_flux - b_flux);
 _RHS1( 1) += (f_flux - b_flux);
 
 _term =  ah ;
 _MATELM1( 5 ,5)  += _term;
 _MATELM1( 1 ,5)  -= _term;
 _term =  bh ;
 _MATELM1( 5 ,1)  -= _term;
 _MATELM1( 1 ,1)  += _term;
 /*REACTION*/
  /* ~ i4 <-> o ( ah , bh )*/
 f_flux =  ah * i4 ;
 b_flux =  bh * o ;
 _RHS1( 4) -= (f_flux - b_flux);
 
 _term =  ah ;
 _MATELM1( 4 ,4)  += _term;
 _term =  bh ;
 _MATELM1( 4 ,0)  -= _term;
 /*REACTION*/
   /* c1 + c2 + c3 + i1 + i2 + i3 + i4 + o = 1.0 */
 _RHS1(0) =  1.0;
 _MATELM1(0, 0) = 1;
 _RHS1(0) -= o ;
 _MATELM1(0, 4) = 1;
 _RHS1(0) -= i4 ;
 _MATELM1(0, 5) = 1;
 _RHS1(0) -= i3 ;
 _MATELM1(0, 6) = 1;
 _RHS1(0) -= i2 ;
 _MATELM1(0, 7) = 1;
 _RHS1(0) -= i1 ;
 _MATELM1(0, 1) = 1;
 _RHS1(0) -= c3 ;
 _MATELM1(0, 2) = 1;
 _RHS1(0) -= c2 ;
 _MATELM1(0, 3) = 1;
 _RHS1(0) -= c1 ;
 /*CONSERVATION*/
   } return _reset;
 }
 
static int  rates ( _p, _ppvar, _thread, _nt, _lv ) double* _p; Datum* _ppvar; Datum* _thread; _NrnThread* _nt; 
	double _lv ;
 {
   double _lvS ;
 _lvS = _lv - vShift ;
   tadj = pow( q10 , ( ( celsius - temp ) / 10.0 ) ) ;
   tadjh = pow( q10h , ( ( celsius - temp ) / 10.0 ) ) ;
   a1 = tadj * a1_0 * exp ( a1_1 * _lvS ) ;
   a1 = a1 * maxrate / ( a1 + maxrate ) ;
   b1 = tadj * b1_0 * exp ( - b1_1 * _lvS ) ;
   b1 = b1 * maxrate / ( b1 + maxrate ) ;
   a2 = tadj * a2_0 * exp ( a2_1 * _lvS ) ;
   a2 = a2 * maxrate / ( a2 + maxrate ) ;
   b2 = tadj * b2_0 * exp ( - b2_1 * _lvS ) ;
   b2 = b2 * maxrate / ( b2 + maxrate ) ;
   a3 = tadj * a3_0 * exp ( a3_1 * _lvS ) ;
   a3 = a3 * maxrate / ( a3 + maxrate ) ;
   b3 = tadj * b3_0 * exp ( - b3_1 * _lvS ) ;
   b3 = b3 * maxrate / ( b3 + maxrate ) ;
   bh = tadjh * bh_0 / ( 1.0 + bh_1 * exp ( - bh_2 * ( _lvS - vShift_inact - vShift_inact_local ) ) ) ;
   bh = bh * maxrate / ( bh + maxrate ) ;
   ah = tadjh * ah_0 / ( 1.0 + ah_1 * exp ( ah_2 * ( _lvS - vShift_inact - vShift_inact_local ) ) ) ;
   ah = ah * maxrate / ( ah + maxrate ) ;
    return 0; }
 
static int _hoc_rates() {
  double _r;
   double* _p; Datum* _ppvar; Datum* _thread; _NrnThread* _nt;
   if (_extcall_prop) {_p = _extcall_prop->param; _ppvar = _extcall_prop->dparam;}else{ _p = (double*)0; _ppvar = (Datum*)0; }
  _thread = _extcall_thread;
  _nt = nrn_threads;
 _r = 1.;
 rates ( _p, _ppvar, _thread, _nt, *getarg(1) ) ;
 ret(_r);
}
 
/*CVODE ode begin*/
 static int _ode_spec1(double* _p, Datum* _ppvar, Datum* _thread, _NrnThread* _nt) {int _reset=0;{
 double b_flux, f_flux, _term; int _i;
 {int _i; for(_i=0;_i<8;_i++) _p[_dlist1[_i]] = 0.0;}
 rates ( _threadargscomma_ v ) ;
 /* ~ c1 <-> c2 ( a1 , b1 )*/
 f_flux =  a1 * c1 ;
 b_flux =  b1 * c2 ;
 Dc1 -= (f_flux - b_flux);
 Dc2 += (f_flux - b_flux);
 
 /*REACTION*/
  /* ~ c2 <-> c3 ( a2 , b2 )*/
 f_flux =  a2 * c2 ;
 b_flux =  b2 * c3 ;
 Dc2 -= (f_flux - b_flux);
 Dc3 += (f_flux - b_flux);
 
 /*REACTION*/
  /* ~ c3 <-> o ( a3 , b3 )*/
 f_flux =  a3 * c3 ;
 b_flux =  b3 * o ;
 Dc3 -= (f_flux - b_flux);
 Do += (f_flux - b_flux);
 
 /*REACTION*/
  /* ~ i1 <-> i2 ( a1 , b1 )*/
 f_flux =  a1 * i1 ;
 b_flux =  b1 * i2 ;
 Di1 -= (f_flux - b_flux);
 Di2 += (f_flux - b_flux);
 
 /*REACTION*/
  /* ~ i2 <-> i3 ( a2 , b2 )*/
 f_flux =  a2 * i2 ;
 b_flux =  b2 * i3 ;
 Di2 -= (f_flux - b_flux);
 Di3 += (f_flux - b_flux);
 
 /*REACTION*/
  /* ~ i3 <-> i4 ( a3 , b3 )*/
 f_flux =  a3 * i3 ;
 b_flux =  b3 * i4 ;
 Di3 -= (f_flux - b_flux);
 Di4 += (f_flux - b_flux);
 
 /*REACTION*/
  /* ~ i1 <-> c1 ( ah , bh )*/
 f_flux =  ah * i1 ;
 b_flux =  bh * c1 ;
 Di1 -= (f_flux - b_flux);
 Dc1 += (f_flux - b_flux);
 
 /*REACTION*/
  /* ~ i2 <-> c2 ( ah , bh )*/
 f_flux =  ah * i2 ;
 b_flux =  bh * c2 ;
 Di2 -= (f_flux - b_flux);
 Dc2 += (f_flux - b_flux);
 
 /*REACTION*/
  /* ~ i3 <-> c3 ( ah , bh )*/
 f_flux =  ah * i3 ;
 b_flux =  bh * c3 ;
 Di3 -= (f_flux - b_flux);
 Dc3 += (f_flux - b_flux);
 
 /*REACTION*/
  /* ~ i4 <-> o ( ah , bh )*/
 f_flux =  ah * i4 ;
 b_flux =  bh * o ;
 Di4 -= (f_flux - b_flux);
 Do += (f_flux - b_flux);
 
 /*REACTION*/
   /* c1 + c2 + c3 + i1 + i2 + i3 + i4 + o = 1.0 */
 /*CONSERVATION*/
   } return _reset;
 }
 
/*CVODE matsol*/
 static int _ode_matsol1(void* _so, double* _rhs, double* _p, Datum* _ppvar, Datum* _thread, _NrnThread* _nt) {int _reset=0;{
 double b_flux, f_flux, _term; int _i;
   b_flux = f_flux = 0.;
 {int _i; double _dt1 = 1.0/dt;
for(_i=0;_i<8;_i++){
  	_RHS1(_i) = _dt1*(_p[_dlist1[_i]]);
	_MATELM1(_i, _i) = _dt1;
      
} }
 rates ( _threadargscomma_ v ) ;
 /* ~ c1 <-> c2 ( a1 , b1 )*/
 _term =  a1 ;
 _MATELM1( 3 ,3)  += _term;
 _MATELM1( 2 ,3)  -= _term;
 _term =  b1 ;
 _MATELM1( 3 ,2)  -= _term;
 _MATELM1( 2 ,2)  += _term;
 /*REACTION*/
  /* ~ c2 <-> c3 ( a2 , b2 )*/
 _term =  a2 ;
 _MATELM1( 2 ,2)  += _term;
 _MATELM1( 1 ,2)  -= _term;
 _term =  b2 ;
 _MATELM1( 2 ,1)  -= _term;
 _MATELM1( 1 ,1)  += _term;
 /*REACTION*/
  /* ~ c3 <-> o ( a3 , b3 )*/
 _term =  a3 ;
 _MATELM1( 1 ,1)  += _term;
 _MATELM1( 0 ,1)  -= _term;
 _term =  b3 ;
 _MATELM1( 1 ,0)  -= _term;
 _MATELM1( 0 ,0)  += _term;
 /*REACTION*/
  /* ~ i1 <-> i2 ( a1 , b1 )*/
 _term =  a1 ;
 _MATELM1( 7 ,7)  += _term;
 _MATELM1( 6 ,7)  -= _term;
 _term =  b1 ;
 _MATELM1( 7 ,6)  -= _term;
 _MATELM1( 6 ,6)  += _term;
 /*REACTION*/
  /* ~ i2 <-> i3 ( a2 , b2 )*/
 _term =  a2 ;
 _MATELM1( 6 ,6)  += _term;
 _MATELM1( 5 ,6)  -= _term;
 _term =  b2 ;
 _MATELM1( 6 ,5)  -= _term;
 _MATELM1( 5 ,5)  += _term;
 /*REACTION*/
  /* ~ i3 <-> i4 ( a3 , b3 )*/
 _term =  a3 ;
 _MATELM1( 5 ,5)  += _term;
 _MATELM1( 4 ,5)  -= _term;
 _term =  b3 ;
 _MATELM1( 5 ,4)  -= _term;
 _MATELM1( 4 ,4)  += _term;
 /*REACTION*/
  /* ~ i1 <-> c1 ( ah , bh )*/
 _term =  ah ;
 _MATELM1( 7 ,7)  += _term;
 _MATELM1( 3 ,7)  -= _term;
 _term =  bh ;
 _MATELM1( 7 ,3)  -= _term;
 _MATELM1( 3 ,3)  += _term;
 /*REACTION*/
  /* ~ i2 <-> c2 ( ah , bh )*/
 _term =  ah ;
 _MATELM1( 6 ,6)  += _term;
 _MATELM1( 2 ,6)  -= _term;
 _term =  bh ;
 _MATELM1( 6 ,2)  -= _term;
 _MATELM1( 2 ,2)  += _term;
 /*REACTION*/
  /* ~ i3 <-> c3 ( ah , bh )*/
 _term =  ah ;
 _MATELM1( 5 ,5)  += _term;
 _MATELM1( 1 ,5)  -= _term;
 _term =  bh ;
 _MATELM1( 5 ,1)  -= _term;
 _MATELM1( 1 ,1)  += _term;
 /*REACTION*/
  /* ~ i4 <-> o ( ah , bh )*/
 _term =  ah ;
 _MATELM1( 4 ,4)  += _term;
 _MATELM1( 0 ,4)  -= _term;
 _term =  bh ;
 _MATELM1( 4 ,0)  -= _term;
 _MATELM1( 0 ,0)  += _term;
 /*REACTION*/
   /* c1 + c2 + c3 + i1 + i2 + i3 + i4 + o = 1.0 */
 /*CONSERVATION*/
   } return _reset;
 }
 
/*CVODE end*/
 
static int _ode_count(_type) int _type;{ return 8;}
 
static int _ode_spec(_NrnThread* _nt, _Memb_list* _ml, int _type) {
   double* _p; Datum* _ppvar; Datum* _thread;
   Node* _nd; double _v; int _iml, _cntml;
  _cntml = _ml->_nodecount;
  _thread = _ml->_thread;
  for (_iml = 0; _iml < _cntml; ++_iml) {
    _p = _ml->_data[_iml]; _ppvar = _ml->_pdata[_iml];
    _nd = _ml->_nodelist[_iml];
    v = NODEV(_nd);
  ena = _ion_ena;
     _ode_spec1 (_p, _ppvar, _thread, _nt);
  }}
 
static int _ode_map(_ieq, _pv, _pvdot, _pp, _ppd, _atol, _type) int _ieq, _type; double** _pv, **_pvdot, *_pp, *_atol; Datum* _ppd; { 
	double* _p; Datum* _ppvar;
 	int _i; _p = _pp; _ppvar = _ppd;
	_cvode_ieq = _ieq;
	for (_i=0; _i < 8; ++_i) {
		_pv[_i] = _pp + _slist1[_i];  _pvdot[_i] = _pp + _dlist1[_i];
		_cvode_abstol(_atollist, _atol, _i);
	}
 }
 
static int _ode_matsol(_NrnThread* _nt, _Memb_list* _ml, int _type) {
   double* _p; Datum* _ppvar; Datum* _thread;
   Node* _nd; double _v; int _iml, _cntml;
  _cntml = _ml->_nodecount;
  _thread = _ml->_thread;
  for (_iml = 0; _iml < _cntml; ++_iml) {
    _p = _ml->_data[_iml]; _ppvar = _ml->_pdata[_iml];
    _nd = _ml->_nodelist[_iml];
    v = NODEV(_nd);
  ena = _ion_ena;
 _cvode_sparse_thread(&_thread[_cvspth1]._pvoid, 8, _dlist1, _p, _ode_matsol1, _ppvar, _thread, _nt);
 }}
 
static void _thread_cleanup(Datum* _thread) {
   _nrn_destroy_sparseobj_thread(_thread[_cvspth1]._pvoid);
   _nrn_destroy_sparseobj_thread(_thread[_spth1]._pvoid);
 }
 extern void nrn_update_ion_pointer(Symbol*, Datum*, int, int);
 static void _update_ion_pointer(Datum* _ppvar) {
   nrn_update_ion_pointer(_na_sym, _ppvar, 0, 0);
   nrn_update_ion_pointer(_na_sym, _ppvar, 1, 3);
   nrn_update_ion_pointer(_na_sym, _ppvar, 2, 4);
 }

static void initmodel(double* _p, Datum* _ppvar, Datum* _thread, _NrnThread* _nt) {
  int _i; double _save;{
  c3 = c30;
  c2 = c20;
  c1 = c10;
  i4 = i40;
  i3 = i30;
  i2 = i20;
  i1 = i10;
  o = o0;
 {
    _ss_sparse_thread(&_thread[_spth1]._pvoid, 8, _slist1, _dlist1, _p, &t, dt, kin, _linmat1, _ppvar, _thread, _nt);
  }
 
}
}

static void nrn_init(_NrnThread* _nt, _Memb_list* _ml, int _type){
double* _p; Datum* _ppvar; Datum* _thread;
Node *_nd; double _v; int* _ni; int _iml, _cntml;
#if CACHEVEC
    _ni = _ml->_nodeindices;
#endif
_cntml = _ml->_nodecount;
_thread = _ml->_thread;
for (_iml = 0; _iml < _cntml; ++_iml) {
 _p = _ml->_data[_iml]; _ppvar = _ml->_pdata[_iml];
#if CACHEVEC
  if (use_cachevec) {
    _v = VEC_V(_ni[_iml]);
  }else
#endif
  {
    _nd = _ml->_nodelist[_iml];
    _v = NODEV(_nd);
  }
 v = _v;
  ena = _ion_ena;
 initmodel(_p, _ppvar, _thread, _nt);
 }}

static double _nrn_current(double* _p, Datum* _ppvar, Datum* _thread, _NrnThread* _nt, double _v){double _current=0.;v=_v;{ {
   gna = gbar * o ;
   ina = gna * ( v - ena ) * ( 1e-4 ) ;
   ina_inax = gna * ( v - ena ) * ( 1e-4 ) ;
   }
 _current += ina;

} return _current;
}

static void nrn_cur(_NrnThread* _nt, _Memb_list* _ml, int _type) {
double* _p; Datum* _ppvar; Datum* _thread;
Node *_nd; int* _ni; double _rhs, _v; int _iml, _cntml;
#if CACHEVEC
    _ni = _ml->_nodeindices;
#endif
_cntml = _ml->_nodecount;
_thread = _ml->_thread;
for (_iml = 0; _iml < _cntml; ++_iml) {
 _p = _ml->_data[_iml]; _ppvar = _ml->_pdata[_iml];
#if CACHEVEC
  if (use_cachevec) {
    _v = VEC_V(_ni[_iml]);
  }else
#endif
  {
    _nd = _ml->_nodelist[_iml];
    _v = NODEV(_nd);
  }
  ena = _ion_ena;
 _g = _nrn_current(_p, _ppvar, _thread, _nt, _v + .001);
 	{ double _dina;
  _dina = ina;
 _rhs = _nrn_current(_p, _ppvar, _thread, _nt, _v);
  _ion_dinadv += (_dina - ina)/.001 ;
 	}
 _g = (_g - _rhs)/.001;
  _ion_ina += ina ;
#if CACHEVEC
  if (use_cachevec) {
	VEC_RHS(_ni[_iml]) -= _rhs;
  }else
#endif
  {
	NODERHS(_nd) -= _rhs;
  }
 
}}

static void nrn_jacob(_NrnThread* _nt, _Memb_list* _ml, int _type) {
double* _p; Datum* _ppvar; Datum* _thread;
Node *_nd; int* _ni; int _iml, _cntml;
#if CACHEVEC
    _ni = _ml->_nodeindices;
#endif
_cntml = _ml->_nodecount;
_thread = _ml->_thread;
for (_iml = 0; _iml < _cntml; ++_iml) {
 _p = _ml->_data[_iml];
#if CACHEVEC
  if (use_cachevec) {
	VEC_D(_ni[_iml]) += _g;
  }else
#endif
  {
     _nd = _ml->_nodelist[_iml];
	NODED(_nd) += _g;
  }
 
}}

static void nrn_state(_NrnThread* _nt, _Memb_list* _ml, int _type) {
 double _break, _save;
double* _p; Datum* _ppvar; Datum* _thread;
Node *_nd; double _v; int* _ni; int _iml, _cntml;
#if CACHEVEC
    _ni = _ml->_nodeindices;
#endif
_cntml = _ml->_nodecount;
_thread = _ml->_thread;
for (_iml = 0; _iml < _cntml; ++_iml) {
 _p = _ml->_data[_iml]; _ppvar = _ml->_pdata[_iml];
 _nd = _ml->_nodelist[_iml];
#if CACHEVEC
  if (use_cachevec) {
    _v = VEC_V(_ni[_iml]);
  }else
#endif
  {
    _nd = _ml->_nodelist[_iml];
    _v = NODEV(_nd);
  }
 _break = t + .5*dt; _save = t;
 v=_v;
{
  ena = _ion_ena;
 { {
 for (; t < _break; t += dt) {
  sparse_thread(&_thread[_spth1]._pvoid, 8, _slist1, _dlist1, _p, &t, dt, kin, _linmat1, _ppvar, _thread, _nt);
  
}}
 t = _save;
 } }}

}

static terminal(){}

static _initlists(){
 double _x; double* _p = &_x;
 int _i; static int _first = 1;
  if (!_first) return;
 _slist1[0] = &(o) - _p;  _dlist1[0] = &(Do) - _p;
 _slist1[1] = &(c3) - _p;  _dlist1[1] = &(Dc3) - _p;
 _slist1[2] = &(c2) - _p;  _dlist1[2] = &(Dc2) - _p;
 _slist1[3] = &(c1) - _p;  _dlist1[3] = &(Dc1) - _p;
 _slist1[4] = &(i4) - _p;  _dlist1[4] = &(Di4) - _p;
 _slist1[5] = &(i3) - _p;  _dlist1[5] = &(Di3) - _p;
 _slist1[6] = &(i2) - _p;  _dlist1[6] = &(Di2) - _p;
 _slist1[7] = &(i1) - _p;  _dlist1[7] = &(Di1) - _p;
_first = 0;
}
