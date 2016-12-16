%this function creates a file name called runModel_topo.hoc and adds lines
%to run_model so it will output all the topology and other parameters of
%the cell as can be seen in the AddedLines{6}


function FNWithTopo=AddTopologyToHocV2(FN,FN_Topo,FN_TopoF,FN_TopoPP,FN_TopoMDL,FN_TopoList,FN_RecSites)
% FN='C:\SVN\Neuron\printCell\Amit\printCellBinaryK64Base.hoc';
FNWithTopo=[FN(1:end-4) '_topo.hoc'];
Lines=getLines(FN)';
AddLineI=find(strhas(Lines,'ADD STUFF HERE'));
if(numel(AddLineI)~=1)
    error('Problem with finding place to add code: ADD STUFF HERE');
end

AddedLines{1}='// Start topology output';
AddedLines{2}=['hoc_stdout("' ,FN_Topo '")'];
AddedLines{3}='topology()';
AddedLines{4}='forall{';
AddedLines{5}='	printf("%s\n",secname())';
AddedLines{6}='	printf("%f,%f,%f,%f,%f,%f,%f,%f,%f,%f,%f,%.16f,%f,%f\n",nseg,L,diam,Ra,cm,dt,st.del,st.dur,st.amp,tfinal,v(0.5),area(0.5),parent_connection(),n3d())';
AddedLines{7}='}';
AddedLines{8}='hoc_stdout()';
AddedLines{9}='// End topology output';
AddedLines{end+1}='// Start topologyList output';
AddedLines{end+1}=['hoc_stdout("' ,FN_TopoList '")'];
AddedLines{end+1}='MyTopology()';
AddedLines{end+1}='hoc_stdout()';
AddedLines{end+1}='// End topologyList output';
AddedLines{end+1}='// Start mechanisms output';
AddedLines{end+1}='objref mt,ms,fn,pp';
AddedLines{end+1}='strdef s,ss,mname';
AddedLines{end+1}='mt = new MechanismType(0)';
AddedLines{end+1}='fn = new File()';
AddedLines{end+1}=['fn.wopen("' FN_TopoMDL '")'];
AddedLines{end+1}='forall{';
AddedLines{end+1}='	fn.printf("#%s\n",secname())';
AddedLines{end+1}='	if (ismembrane("pas")){';
AddedLines{end+1}='		fn.printf("g_pas = %f\n",g_pas)';
AddedLines{end+1}='		fn.printf("e_pas = %f\n",e_pas)';
AddedLines{end+1}='	}';
% AddedLines{end+1}='	} else { fn.printf("g_pas = -777\n")	}';
AddedLines{end+1}='	for i=0, mt.count()-1 {'; % move through all mechanisms
AddedLines{end+1}='		mt.select(i)';
AddedLines{end+1}='		mt.selected(mname)';
AddedLines{end+1}='		if (ismembrane(mname)){';
AddedLines{end+1}='			ms = new MechanismStandard(mname,-1)';
AddedLines{end+1}='			for j=0, ms.count()-1 {'; % all global parameters of the mechanism
AddedLines{end+1}='				k = ms.name(s, j)';
AddedLines{end+1}='				sprint(ss,"temp=%s",s)';
AddedLines{end+1}='				execute(ss)';
AddedLines{end+1}='				fn.printf("%s = %f\n",s,temp)';
AddedLines{end+1}='			}';
AddedLines{end+1}='			ms = new MechanismStandard(mname,3)';
AddedLines{end+1}='			for j=0, ms.count()-1 {'; % all global parameters of the mechanism
AddedLines{end+1}='				k = ms.name(s, j)';
AddedLines{end+1}='				sprint(ss,"temp=%s",s)';
AddedLines{end+1}='				execute(ss)';
AddedLines{end+1}='				fn.printf("%s = %f\n",s,temp)';
AddedLines{end+1}='			}';
AddedLines{end+1}='		}';
AddedLines{end+1}='	}';
AddedLines{end+1}='}';
AddedLines{end+1}='fn.close()';
AddedLines{end+1}='// End mechanisms output';
AddedLines{end+1}='// Start point processess mechanisms output';




AddedLines{end+1}='fn = new File()';
AddedLines{end+1}=['fn.wopen("' FN_TopoPP '")'];
AddedLines{end+1}='forall{';
AddedLines{end+1}='	fn.printf("#%s\n",secname())';
AddedLines{end+1}='	mt = new MechanismType(1)';
AddedLines{end+1}='	for i=0, mt.count()-1 {'; % move through all mechanisms
AddedLines{end+1}='		mt.select(i)';
AddedLines{end+1}='		mt.selected(mname)';
AddedLines{end+1}='		if (ismembrane(mname)){';
AddedLines{end+1}='         fn.printf("%s\n",mname)';
AddedLines{end+1}='			for (pp = mt.pp_begin(); object_id(pp) != 0; pp = mt.pp_next()) {';
AddedLines{end+1}='             ms = new MechanismStandard(mname)';
AddedLines{end+1}='             for j=0, ms.count()-1 {';
AddedLines{end+1}='				k = ms.name(s, j)';
AddedLines{end+1}='				sprint(ss,"temp=pp.%s",s)';
AddedLines{end+1}='				execute(ss)';
AddedLines{end+1}='				fn.printf("%s = %f\n",s,temp)';
AddedLines{end+1}='			}';
AddedLines{end+1}='			ms = new MechanismStandard(mname,3)';
AddedLines{end+1}='			for j=0, ms.count()-1 {'; % all global parameters of the mechanism
AddedLines{end+1}='				k = ms.name(s, j)';
AddedLines{end+1}='				sprint(ss,"temp=%s",s)';
AddedLines{end+1}='				execute(ss)';
AddedLines{end+1}='				fn.printf("%s = %f\n",s,temp)';
AddedLines{end+1}='			}';
AddedLines{end+1}='		}';
AddedLines{end+1}='	}';
AddedLines{end+1}='}';
AddedLines{end+1}='}';
AddedLines{end+1}='fn.close()';
AddedLines{end+1}='//End point processess mechanisms output'
AddedLines{end+1}=['hoc_stdout("' ,FN_TopoF '")'];
AddedLines{end+1}='MyPrintMatrix()';
AddedLines{end+1}='hoc_stdout()';
AddedLines{end+1}='// End Fmatrix';
AddedLines{end+1}='// Start Recording Sites';
AddedLines{end+1}=['hoc_stdout("' ,FN_RecSites '")'];
AddedLines{end+1}='PrintRecSites()';
AddedLines{end+1}='hoc_stdout()';
OutLines=[Lines(1:AddLineI); AddedLines'; Lines((AddLineI+1):end)];
Lines2File(OutLines,FNWithTopo);