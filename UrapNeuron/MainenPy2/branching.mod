COMMENT

ENDCOMMENT

NEURON { SUFFIX nothing }

VERBATIM

ENDVERBATIM
PROCEDURE init_files(){
	VERBATIM {
		
		
	}
	ENDVERBATIM
}





FUNCTION GetA(x) {
VERBATIM {
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
	return NODEA(nd);
}
ENDVERBATIM
}
FUNCTION GetB(x) {
VERBATIM {
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
	return NODEB(nd);
}
ENDVERBATIM
}
FUNCTION SetA(x,a) {
VERBATIM {
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
	
	NODEA(nd) = _la;
}
ENDVERBATIM
}
FUNCTION SetB(x,b) {
VERBATIM {
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
	
	NODEB(nd) = _lb;
}
ENDVERBATIM
}

PROCEDURE MyPrintMatrix() {
VERBATIM {
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

}
}
ENDVERBATIM
}
PROCEDURE MyAdb() {
VERBATIM {
	int ii;
#if defined(t)
	_NrnThread* _nt = nrn_threads;
#endif
for(ii=0;ii<_nt->end;ii++){


}
}
ENDVERBATIM
}

PROCEDURE PrintRHS_D() {
VERBATIM {
	int ii;
#if defined(t)
	_NrnThread* _nt = nrn_threads;
#endif
Node* nd;
for(ii=0;ii<_nt->end;ii++){
nd=_nt->_v_node[ii];

}
}
ENDVERBATIM
}




PROCEDURE MyTopology() {
VERBATIM {
	int ii;
#if defined(t)
	_NrnThread* _nt = nrn_threads;
#endif
for(ii=0;ii<_nt->end;ii++){


}
}
ENDVERBATIM
}