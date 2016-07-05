import numpy as np
from get_parent_from_neuron import get_parent_from_neuron

def creat_auxilliary_data_3(A, N, NSeg, Parent, Neuron, cmVec, FN_TopoList):
	f_type_str = 'float'

	father_base = np.zeros((1, N))
	for i in range(N - 1, -1, -1):
		k = None
		if A[i, i + 1] != 0:
			k = np.array([i + 1])
		else:
			k = np.where(A[i + 1:,i] != 0) + i
		father_base[i] = k
	d = np.diag(A).T
	f = np.zeros((1, N + 1))
	e = np.zeros((1, N + 1))
	for i in range(N):
		f[i] = A[i, father_base[i]]
		e[i + 1] = A[father_base[i], i]
	f[N] = 0
	ksx = get_parent_from_neuron(FN_Topolist)
	# Everything up to line 28 translated
	# TODO: Start from line 29