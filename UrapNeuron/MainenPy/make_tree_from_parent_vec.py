import numpy as np
from auxilliary import Aux
import cell

def make_tree_from_parent_vec(N, aux):
	def is_member(A, B):
		return [np.sum(a == B) for a in A]
	Nx = N
	NN = np.bincount(aux.Ks, minlength=Nx)
	Fathers = []
	for i in Ks:
		if i not in range(1, Ks.size + 1) and i > 0:
			Fathers.append(i)
	Fathers = np.array(Fathers)
	Fathers = np.unique(Fathers)
	Related = []
	for i in Fathers:
		Related.append(np.where(Ks == i))
	if Fathers.size != 0:
		RelStarts, RelEnds, RelCN, RelVec = cell.cell_2_vec(Related)
	else:
		RelStarts, RelEnds, RelCN, RelVec = [], [], [], []
	CallForFathers = np.where(is_member(aux.Ks, Fathers))
	RFathers = [ [] for i in range(np.max(Fathers)) ]
	for i in Fathers:
		RFathers[i] = [i for i in range(Fathers.size)]
	RFathers = np.array(RFathers)
	SegStartI = np.hstack((np.array(2), CallForFathers + 1))
	SegEndI = np.hstack((CallForFathers - 1, np.array(Nx - 1)))
	Level = SegStartI * 0
	Level[is_member(SegStart - 1, Fathers)] = 1
	for i in range(50):
		FF = np.where(Level == i)
		ToWhoTheyCall = Aux.Ks[SegEndI[FF] + 1]
		Level[np.where(is_member(SegStartI - 1, ToWhoTheyCall))] = i + 1
	FLevel = Fathers * 0 + 1
	for i in range(np.max(Level)):
		FF = np.where(Level == i + 1)
		ToWhoTheyCall = aux.Ks[SegEndI[FF] + 1]
		ToWhichFatherDoTheyCall = RFathers[ToWhoTheyCall[np.where(ToWhoTheyCall <= np.max(Fathers))]]
		FLevel[ToWhichFatherDoTheyCall] = i + 1
	SegEndI[-1] = N
	Depth = np.max(Level)
	# TODO, return all relevant values