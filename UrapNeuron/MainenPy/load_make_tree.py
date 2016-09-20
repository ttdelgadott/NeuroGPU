import scipy.io as sio

def load_make_tree_mat(fname):
	return sio.loadmat(fname)

def clean_make_tree_mat(mat):
	ret = {}
	ret['j'] = mat['j'][0][0]
	ret['SegStartI'] = mat['SegStartI'][0]
	ret['seg'] = mat['seg'][0]
	ret['Father'] = mat['Father'][0]
	ret['Ksx'] = mat['Ksx'][0]
	ret['Nx'] = mat['Nx'][0][0]
	ret['FF'] = mat['FF'][0][0]
	ret['RFathers'] = mat['RFathers'][0]
	ret['RelEnds'] = mat['RelEnds'][0]
	auxDict = {}
	auxDict['Data'] = mat['Aux'][0][0][0][0]
	auxDict['Ks'] = None
	auxDict['FIdxsX'] = None
	auxDict['LognDepth'] = None
	auxDict['SonNoVec'] = None
	ret['Aux'] = auxDict
	ret['RelCN'] = mat['RelCN'][0]
	ret['Parent'] = mat['Parent'][0]
	ret['CallForFathers'] = mat['CallForFathers'][0]
	ret['FatherBase'] = mat['FatherBase'][0]
	ret['ToWhoTheyCall'] = mat['ToWhoTheyCall'][0]
	ret['FTYPESTR'] = mat['FTYPESTR'][0]
	ret['__version__'] = mat['__version__']
	ret['cmVec'] = mat['cmVec'][0]
	ret['A'] = mat['A'][0]
	ret['ToWhichFatherDoTheyCall'] = mat['ToWhichFatherDoTheyCall']
	ret['Level'] = mat['Level'][0]
	ret['NSeg'] = mat['NSeg'][0]
	ret['LognDepth'] = mat['LognDepth'][0]
	ret['N'] = mat['N'][0]
	ret['Ks'] = mat['Ks'][0]
	ret['ParentUsed'] = mat['ParentUsed'][0]
	ret['SonNoVec'] = mat['SonNoVec'][0]
	ret['parentIndex'] = mat['parentIndex'][0][0]
	ret['CurF'] = mat['CurF'][0]
	ret['e'] = mat['e'][0]
	ret['d'] = mat['d'][0]
	ret['FLevel'] = mat['FLevel'][0]
	ret['f'] = mat['f'][0]
	ret['i'] = mat['i'][0][0]
	ret['k'] = mat['k'][0][0]
	ret['__header__'] = mat['__header__']
	related = []
	for i in mat['Related'][0]:
		if i.size == 1:
			related.append((i[0][0]))
		else:
			related.append((i[0][0], i[0][1]))
	ret['Related'] = related
	ret['__globals__'] = mat['__globals__']
	ret['NN'] = mat['NN'][0]
	ret['FN_TopoList'] = mat['FN_TopoList'][0]
	ret['SegEndI'] = mat['SegEndI'][0]
	ret['RelStarts'] = mat['RelStarts'][0]
	ret['Fathers'] = mat['Fathers'][0]
	ret['RelVec'] = mat['RelVec'][0]
	return ret
