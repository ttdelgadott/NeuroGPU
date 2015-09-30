/* Created by Language version: 6.2.0 */
/* NOT VECTORIZED */
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
 
#define _threadargscomma_ /**/
#define _threadargs_ /**/
 	/*SUPPRESS 761*/
	/*SUPPRESS 762*/
	/*SUPPRESS 763*/
	/*SUPPRESS 765*/
	 extern double *getarg();
 static double *_p; static Datum *_ppvar;
 
#define t nrn_threads->_t
#define dt nrn_threads->_dt
 
#if MAC
#if !defined(v)
#define v _mlhv
#endif
#if !defined(h)
#define h _mlhh
#endif
#endif
 static int hoc_nrnpointerindex =  -1;
 /* external NEURON variables */
 /* declaration of user functions */
 static int _hoc_GetB();
 static int _hoc_GetA();
 static int _hoc_MyTopology();
 static int _hoc_MyPrintMatrix();
 static int _hoc_SetB();
 static int _hoc_SetA();
 static int _hoc_init_files();
 static int _mechtype;
extern int nrn_get_mechtype();
 extern void _nrn_setdata_reg(int, void(*)(Prop*));
 static void _setdata(Prop* _prop) {
 _p = _prop->param; _ppvar = _prop->dparam;
 }
 static _hoc_setdata() {
 Prop *_prop, *hoc_getdata_range();
 _prop = hoc_getdata_range(_mechtype);
   _setdata(_prop);
 ret(1.);
}
 /* connect user functions to hoc names */
 static IntFunc hoc_intfunc[] = {
 "setdata_branching", _hoc_setdata,
 "GetB", _hoc_GetB,
 "GetA", _hoc_GetA,
 "MyTopology", _hoc_MyTopology,
 "MyPrintMatrix", _hoc_MyPrintMatrix,
 "SetB", _hoc_SetB,
 "SetA", _hoc_SetA,
 "init_files", _hoc_init_files,
 0, 0
};
 extern double GetB();
 extern double GetA();
 extern double SetB();
 extern double SetA();
 /* declare global and static user variables */
 /* some parameters have upper and lower limits */
 static HocParmLimits _hoc_parm_limits[] = {
 0,0,0
};
 static HocParmUnits _hoc_parm_units[] = {
 0,0
};
 static double v = 0;
 /* connect global user variables to hoc */
 static DoubScal hoc_scdoub[] = {
 0,0
};
 static DoubVec hoc_vdoub[] = {
 0,0,0
};
 static double _sav_indep;
 static void nrn_alloc(), nrn_init(), nrn_state();
 /* connect range variables in _p that hoc is supposed to know about */
 static char *_mechanism[] = {
 "6.2.0",
"branching",
 0,
 0,
 0,
 0};
 
static void nrn_alloc(_prop)
	Prop *_prop;
{
	Prop *prop_ion, *need_memb();
	double *_p; Datum *_ppvar;
 	_p = nrn_prop_data_alloc(_mechtype, 0, _prop);
 	/*initialize range parameters*/
 	_prop->param = _p;
 	_prop->param_size = 0;
 
}
 static _initlists();
 _branching_reg() {
	int _vectorized = 0;
  _initlists();
 	hoc_register_var(hoc_scdoub, hoc_vdoub, hoc_intfunc);
 	ivoc_help("help ?1 branching /cygdrive/c/Users/Roy/Documents/NeuroGPU2_2/Neuron/Mara/branching.mod\n");
 }
static int _reset;
static char *modelname = "";

static int error;
static int _ninits = 0;
static int _match_recurse=1;
static _modl_cleanup(){ _match_recurse=1;}
static MyTopology();
static MyPrintMatrix();
static init_files();
 
/*VERBATIM*/
char* secname();
 
static int  init_files (  )  {
   
/*VERBATIM*/
{
		
		
	}
  return 0; }
 
static int _hoc_init_files() {
  double _r;
   _r = 1.;
 init_files (  ) ;
 ret(_r);
}
 
double GetA (  _lx )  
	double _lx ;
 {
   double _lGetA;
 
/*VERBATIM*/
{
#if defined(t)
	_NrnThread* _nt = nrn_threads;
#endif
Section* sec;
	Node* nd;
	sec = chk_access();
	if (_lx < 0. || _lx > 1.) {
	printf("_lx is %f and _lx*(double)(sec->nnode-1) is %f\n",_lx,_lx*(double)(sec->nnode-1));
		hoc_execerror("out of range, must be 0 < x <= 1", (char*)0);
	}
	if (_lx == 1.) {
		nd = sec->pnode[sec->nnode-1];
	}else{
		nd = sec->pnode[(int) (_lx*(double)(sec->nnode-1))];
	}
	return NODEA(nd);
}
 
return _lGetA;
 }
 
static int _hoc_GetA() {
  double _r;
   _r =  GetA (  *getarg(1) ) ;
 ret(_r);
}
 
double GetB (  _lx )  
	double _lx ;
 {
   double _lGetB;
 
/*VERBATIM*/
{
#if defined(t)
	_NrnThread* _nt = nrn_threads;
#endif
Section* sec;
	Node* nd;
	sec = chk_access();
	if (_lx < 0. || _lx > 1.) {
		printf("_lx is %f and _lx*(double)(sec->nnode-1) is %f\n",_lx,_lx*(double)(sec->nnode-1));
		hoc_execerror("out of range, must be 0 < x <= 1", (char*)0);
	}
	if (_lx == 1.) {
		nd = sec->pnode[sec->nnode-1];
	}else{
		nd = sec->pnode[(int) (_lx*(double)(sec->nnode-1))];
	}
	return NODEB(nd);
}
 
return _lGetB;
 }
 
static int _hoc_GetB() {
  double _r;
   _r =  GetB (  *getarg(1) ) ;
 ret(_r);
}
 
double SetA (  _lx , _la )  
	double _lx , _la ;
 {
   double _lSetA;
 
/*VERBATIM*/
{
#if defined(t)
	_NrnThread* _nt = nrn_threads;
#endif
Section* sec;
	Node* nd;
	sec = chk_access();
	if (_lx < 0. || _lx > 1.) {
		hoc_execerror("out of range, must be 0 < x <= 1", (char*)0);
	}
	if (_lx == 1.) {
		nd = sec->pnode[sec->nnode-1];
	}else{
		nd = sec->pnode[(int) (_lx*(double)(sec->nnode-1))];
	}
	printf("index is %d,NODEA(nd) is %f _la is %f\n",nd->v_node_index,NODEA(nd),_la);
	NODEA(nd) = _la;
}
 
return _lSetA;
 }
 
static int _hoc_SetA() {
  double _r;
   _r =  SetA (  *getarg(1) , *getarg(2) ) ;
 ret(_r);
}
 
double SetB (  _lx , _lb )  
	double _lx , _lb ;
 {
   double _lSetB;
 
/*VERBATIM*/
{
#if defined(t)
	_NrnThread* _nt = nrn_threads;
#endif
Section* sec;
	Node* nd;
	sec = chk_access();
	if (_lx < 0. || _lx > 1.) {
		hoc_execerror("out of range, must be 0 < x <= 1", (char*)0);
	}
	if (_lx == 1.) {
		nd = sec->pnode[sec->nnode-1];
	}else{
		nd = sec->pnode[(int) (_lx*(double)(sec->nnode-1))];
	}
	printf("index is %d,NODEB(nd) is %f _lb is %f\n",nd->v_node_index,NODEB(nd),_lb);
	NODEB(nd) = _lb;
}
 
return _lSetB;
 }
 
static int _hoc_SetB() {
  double _r;
   _r =  SetB (  *getarg(1) , *getarg(2) ) ;
 ret(_r);
}
 
static int  MyPrintMatrix (  )  {
   
/*VERBATIM*/
{
	Section* sec;
	FILE* fm;
	fm= fopen("C:\fmatrix.dat", "wb");
	Node* nd;
	int ii;
#if defined(t)
	_NrnThread* _nt = nrn_threads;
#endif
for(ii=0;ii<_nt->end;ii++){
nd=_nt->_v_node[ii];
printf("%d %1.15f %1.15f %1.15f %1.15f\n", ii, NODEB(nd), NODEA(nd), NODED(nd), NODERHS(nd));
}
}
  return 0; }
 
static int _hoc_MyPrintMatrix() {
  double _r;
   _r = 1.;
 MyPrintMatrix (  ) ;
 ret(_r);
}
 
static int  MyTopology (  )  {
   
/*VERBATIM*/
{
	int ii;
#if defined(t)
	_NrnThread* _nt = nrn_threads;
#endif
for(ii=0;ii<_nt->end;ii++){

printf("%d %d\n", ii, _nt->_v_parent_index[ii]);
}
}
  return 0; }
 
static int _hoc_MyTopology() {
  double _r;
   _r = 1.;
 MyTopology (  ) ;
 ret(_r);
}

static void initmodel() {
  int _i; double _save;_ninits++;
{

}
}

static void nrn_init(_NrnThread* _nt, _Memb_list* _ml, int _type){
Node *_nd; double _v; int* _ni; int _iml, _cntml;
#if CACHEVEC
    _ni = _ml->_nodeindices;
#endif
_cntml = _ml->_nodecount;
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
 initmodel();
}}

static double _nrn_current(double _v){double _current=0.;v=_v;{
} return _current;
}

static void nrn_state(_NrnThread* _nt, _Memb_list* _ml, int _type){
 double _break, _save;
Node *_nd; double _v; int* _ni; int _iml, _cntml;
#if CACHEVEC
    _ni = _ml->_nodeindices;
#endif
_cntml = _ml->_nodecount;
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
}}

}

static terminal(){}

static _initlists() {
 int _i; static int _first = 1;
  if (!_first) return;
_first = 0;
}
