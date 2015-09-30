function [MainStruct] = CreateBaseStructure()
MainStruct.MorphologyFileName='TreeData1.x';
MainStruct.Stim.t1=10;
MainStruct.Stim.t2=12;
MainStruct.Stim.comptLoc={'soma',0.5};
MainStruct.Stim.loc={'(CellBody)',0.5};
MainStruct.Stim.Amplitudes=[0.1 0.2 0.4 0.6 0.9 1.3];
MainStruct.Stim.amp=0.01;

MainStruct.MechanismsNames={'na.mod','ca.mod','k.mod'};
MainStruct.ActiveMechanisms=ones(100,3);
MainStruct.ActiveMechanisms(1:10,1)=0;
MainStruct.MechnismsParamsNames{1}={'gnabar','gkbar'};
MainStruct.MechnismsParamsNames{2}={'gcabar','gcbar'};
MainStruct.MechnismsParamsNames{3}={'blak'};
MainStruct.MechnismsParams{1}=0.12*ones(100,2);
MainStruct.MechnismsParams{1}(:,2)=0.036;
MainStruct.MechnismsParams{2}=0.44*ones(100,2);
MainStruct.MechnismsParams{2}(:,2)=0.66;
MainStruct.MechnismsParams{3}=0.44*ones(100,1);


MainStruct(2).MorphologyFileName='TreeData2.x';
MainStruct(2).Stim.t1=10;
MainStruct(2).Stim.t2=12;
MainStruct(2).Stim.loc=1;
MainStruct(2).Stim.Amplitudes=1:0.05:2;
MainStruct(2).MechanismsNames={'na.mod'};
MainStruct(2).ActiveMechanisms=ones(200,1);
MainStruct(2).MechnismsParamsNames{1}={'gnabar','gkbar'};
MainStruct(2).MechnismsParams{1}=0.12*ones(200,2);
MainStruct(2).MechnismsParams{1}(:,2)=0.036;

save('MainStruct.mat','MainStruct');