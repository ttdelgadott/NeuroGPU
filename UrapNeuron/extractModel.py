import neuron as nrn
import ctypes
from cStringIO import StringIO
import sys

def nrn_dll(printpath=False):
    """Return a ctypes object corresponding to the NEURON library.
    
    .. warning::
    
        This provides access to the C-language internals of NEURON and should
        be used with care.
    """
    import ctypes
    import os
    import platform
    
    neuron_home = os.path.split(os.path.split(nrn.h.neuronhome())[0])[0]

    success = False
    base_path = os.path.join(neuron_home, 'lib' , 'python2.7', 'site-packages', 'neuron', 'hoc')
    for extension in ['', '.dll', '.so', '.dylib']:
        try:
            the_dll = ctypes.cdll[base_path + extension]
            if printpath : print base_path + extension
            success = True
        except:
            pass
        if success: break
    else:
        raise Exception('unable to connect to the NEURON library')
    return the_dll

def nrn_dll_sym(name, type=None):
    """return the specified object from the NEURON dlls.
    
    Parameters
    ----------
    name : string
        the name of the object (function, integer, etc...)
    type : None or ctypes type (e.g. ctypes.c_int)
        the type of the object (if None, assumes function pointer)
    """
    import os
    dll = nrn_dll()
    if type is None:
        return dll.__getattr__(name)
    else:
        return type.in_dll(dll, name)

class NrnThread(ctypes.Structure):
    _fields_ = [("_t", ctypes.c_double),
                ("_dt", ctypes.c_double),
                ("cj", ctypes.c_double),
                ("tml", ctypes.c_void_p),
                ("hcell", ctypes.c_int),
                ("end", ctypes.c_int),
                ("id", ctypes.c_int),
                ("_stop_stepping", ctypes.c_int),
                ("_actual_rhs", ctypes.POINTER(ctypes.c_double)),
                ("_actual_d", ctypes.POINTER(ctypes.c_double)),
                ("_actual_a", ctypes.POINTER(ctypes.c_double)),
                ("_actual_b", ctypes.POINTER(ctypes.c_double)),
                ("_actual_v", ctypes.POINTER(ctypes.c_double)),
                ("_actual_area", ctypes.POINTER(ctypes.c_double)),
                ("_v_parent_index", ctypes.POINTER(ctypes.c_int))]

USE_CTYPES = False
modelFile = "./runModel.hoc"
nrn.h.load_file(1, modelFile)
if USE_CTYPES:
    nrn_nthread = nrn_dll_sym('nrn_threads', ctypes.c_void_p)
    thread = ctypes.cast(nrn_nthread, ctypes.POINTER(NrnThread))
    for i in range(thread.contents.end):
        print i, thread.contents._v_parent_index[i]
else:

    for s in nrn.h.allsec():
        name = nrn.h.secname()

        topology =  [s.nseg, s.L, s.diam, s.Ra, s.cm, nrn.h.dt, nrn.h.st.delay, nrn.h.st.dur, nrn.h.st.amp, nrn.h.tfinal, s.v, nrn.h.area(.5), nrn.h.parent_connection(), nrn.h.n3d()]

    topolist = nrn.h.MyTopology()
    
