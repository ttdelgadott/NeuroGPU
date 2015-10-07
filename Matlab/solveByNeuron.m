function [OurDiag rhs] =solveByNeuron(Nx,Aux,OurDiag,rhs,Neuron)
%TRIANG
% for (i = i3 - 1; i >= i2; --i) {
% 		nd = _nt->_v_node[i];
% 		pnd = _nt->_v_parent[i];
% 		p = NODEA(nd) / NODED(nd);,
% 		NODED(pnd) -= p * NODEB(nd);
% 		NODERHS(pnd) -= p * NODERHS(nd);
% 	}
for seg=Nx:-1:2
%     parentIndex =  getParentInd(Neuron,seg);
    parentIndex =Nx+1-Aux.Ks(Nx+2-seg);
    p = Aux.e(Nx+2-seg)/OurDiag(seg);
    OurDiag(parentIndex)=OurDiag(parentIndex)-p*Aux.f(Nx+1-seg);
    rhs(parentIndex)=rhs(parentIndex)-p*rhs(seg);
end
% %BKSUB
% for (i = i1; i < i2; ++i) {
% 		NODERHS(_nt->_v_node[i]) /= NODED(_nt->_v_node[i]);
% 	}
% 	for (i = i2; i < i3; ++i) {
% 		cnd = _nt->_v_node[i];
% 		nd = _nt->_v_parent[i];
% 		NODERHS(cnd) -= NODEB(cnd) * NODERHS(nd);
% 		NODERHS(cnd) /= NODED(cnd);
% 	}	
%     }
rhs(1) = rhs(1)/OurDiag(1);
for seg=2:Nx
%     parentIndex =  getParentInd(Neuron,seg);
    parentIndex =Nx+1-Aux.Ks(Nx+2-seg);
    rhs(seg) = rhs(seg)- Aux.f(Nx+1-seg)*rhs(parentIndex);
    rhs(seg)=rhs(seg)/OurDiag(seg);
end


