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
	ks = [0]
	ks.append(list(N + 1 - ksx[N + 2 - ksx[2:]]))
	ks = np.array(ks)
	aux = Aux()
	aux.Ks = ks
	father_base = ks[2:]
	father = [father_base]
	father.append(father_base.size + 2)
	father.append(father_base.size + 2)
	father = np.array(father)
	f_idxs_x_dimens = np.ceil(np.log2(N))+ 3
	f_idxs_x = np.zeroes((f_idxs_x_dimens, f_idxs_x_dimens))
	for i in range(1, np.ceil(np.log2(N)) + 3 + 1):
		cur_f = np.array(list(range(1, father.size + 1)))
		for j in range(1, np.power(2, i - 1) + 1):
			cur_f = father[cur_f]
		f_idxs_x[i,:] = cur_f
	# Everything up to line 41 translated
	# TODO: Start from line 42
