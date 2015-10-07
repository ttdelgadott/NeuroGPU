paramsToPrint = ['m_na','h_na','gbar_na','tha_na','qa_na','Ra_na','Rb_na','thi1_na','thi2_na','qi_na','thinf_na','qinf_na','Rg_na','Rd_na'];
clc;
NeuroGPUInit;
HocBaseFN=fullfile(BaseP, 'Neuron','printCell','ForC','mainen','mainenSimple.hoc');
FNWithDebug=[FN(1:end-4) '_Debug.hoc'];
Lines=getLines(HocBaseFN);
fadvanceLine = 1;
currLine = Lines{fadvanceLine};
while(true)
   if(strhas(currLine,'fadvance'))
       break;
   end
    fadvanceLine = fadvanceLine+1;
    currLine = Lines{fadvanceLine};
end

