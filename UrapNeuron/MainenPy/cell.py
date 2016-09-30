import numpy as np

def cell_numel(input):
	out = np.zeros(input.shape)
	if input.size == 0:
		return None
	for i in range(input.size):
		out[i] = len(input[i])
	return out

def cell_2_vec(input):
	cn = cell_numel(input)
	cs = np.cumsum(input)
	starts = np.array(list([1]) + list(cs[0:cs.size - 1] + 1))
	end = cs
	vec = []
	for i in range(input.size):
		vec[starts[i]:ends[i]] = input[i]
	vec = np.array(vec)
	return (starts, ends, cn, vec)
