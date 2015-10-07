function FNWithTopo=AddTopoToHoc(FN)
% FN='C:\SVN\Neuron\printCell\Amit\printCellBinaryK64Base.hoc';
NeuronFileSep = '/';
FNWithTopo=[FN(1:end-4) '_topo.hoc'];
Lines=getLines(FN)';
filesep = NeuronFileSep;
%Amit - it seems unneccessary to insert a special 'ADD STUFF HERE' to the
%hoc.file instead of just adding the lines at the end of the file

AddLineI=find(strhas(Lines,'ADD STUFF HERE'));
if(numel(AddLineI)~=1)
    error('Problem with finding place to add code: ADD STUFF HERE');
end

AddedLines{1}='// Start topology output';
AddedLines{end+1}=['hoc_stdout(".' filesep 'output' filesep '64T.csv")'];
AddedLines{end+1}='topology()';
AddedLines{end+1}='forall{';
AddedLines{end+1}='	printf("%s\n",secname())';
AddedLines{end+1}='	printf("%f,%f,%f,%f,%f,%f,%f,%f,%f,%f,%f,%f,%f,%f\n",nseg,L,diam,Ra,cm,dt,st.del,st.dur,st.amp,tfinal,v(0.5),area(0.5),parent_connection(),n3d())';
%AddedLines{end+1}='printf("%f,%f,%f,%f,%f,%f\n",gnabar_hh,gkbar_hh,gl_hh,ena,ek,el_hh)'; Amit - deleted it since not generic
AddedLines{end+1}='}';
AddedLines{end+1}='hoc_stdout()';
AddedLines{end+1}='// End topology output';
AddedLines{end+1}='// Start topologyList output';
AddedLines{end+1}=['hoc_stdout(".' filesep 'output' filesep '64TL.csv")'];
AddedLines{end+1}='MyTopology()';
AddedLines{end+1}='hoc_stdout()';
AddedLines{end+1}='// End topologyList output';
AddedLines{end+1}='// Start mechanisms output';
AddedLines{end+1}='objref mt,ms,fn,pp';
AddedLines{end+1}='strdef s,ss,mname';
AddedLines{end+1}='mt = new MechanismType(0)';
AddedLines{end+1}='fn = new File()';
AddedLines{end+1}=['fn.wopen(".' filesep 'output' filesep '64MDL.csv")'];
AddedLines{end+1}='forall{';
AddedLines{end+1}='	fn.printf("#%s\n",secname())';
AddedLines{end+1}='	for i=0, mt.count()-1 {';
AddedLines{end+1}='		mt.select(i)';
AddedLines{end+1}='		mt.selected(mname)';
AddedLines{end+1}='		if (ismembrane(mname)){';
AddedLines{end+1}='			ms = new MechanismStandard(mname,-1)';
AddedLines{end+1}='			for j=0, ms.count()-1 {';
AddedLines{end+1}='				k = ms.name(s, j)';
AddedLines{end+1}='				sprint(ss,"temp=%s",s)';
AddedLines{end+1}='				execute(ss)';
AddedLines{end+1}='				fn.printf("%s = %f\n",s,temp)';
AddedLines{end+1}='			}';
AddedLines{end+1}='		}';
AddedLines{end+1}='	}';
%AddedLines{end+1}='	fn.printf("END_OF_SECTION\n")';
AddedLines{end+1}='}';
AddedLines{end+1}='fn.close()';
AddedLines{end+1}='// End mechanisms output';

AddedLines{end+1}='// Start mechanisms output';
AddedLines{end+1}='objref mt,ms,fn,pp';
AddedLines{end+1}='strdef s,ss,mname';
AddedLines{end+1}='mt = new MechanismType(0)';
AddedLines{end+1}='fn = new File()';
AddedLines{end+1}=['fn.wopen(".' filesep 'output' filesep '64GLOBAL.csv")'];
AddedLines{end+1}='forall{';
AddedLines{end+1}='	fn.printf("#%s\n",secname())';
AddedLines{end+1}='	for i=0, mt.count()-1 {';
AddedLines{end+1}='		mt.select(i)';
AddedLines{end+1}='		mt.selected(mname)';
AddedLines{end+1}='		if (ismembrane(mname)){';
AddedLines{end+1}='			ms = new MechanismStandard(mname,0)';
AddedLines{end+1}='			for j=0, ms.count()-1 {';
AddedLines{end+1}='				k = ms.name(s, j)';
AddedLines{end+1}='				sprint(ss,"temp=%s",s)';
AddedLines{end+1}='				execute(ss)';
AddedLines{end+1}='				fn.printf("%s = %f\n",s,temp)';
AddedLines{end+1}='			}';
AddedLines{end+1}='		}';
AddedLines{end+1}='	}';
%AddedLines{end+1}='	fn.printf("END_OF_SECTION\n")'; 
AddedLines{end+1}='}';
AddedLines{end+1}='fn.close()';
AddedLines{end+1}='// End mechanisms output';

AddedLines{end+1}='// Start point processess mechanisms output';
AddedLines{end+1}='fn = new File()';
AddedLines{end+1}=['fn.wopen(".' filesep 'output' filesep '64PP.csv")'];
AddedLines{end+1}='forall{';
AddedLines{end+1}='	fn.printf("#%s\n",secname())';
AddedLines{end+1}='	mt = new MechanismType(1)';
AddedLines{end+1}='	mt.select("IClamp")';
AddedLines{end+1}='	for (pp = mt.pp_begin(); object_id(pp) != 0; pp = mt.pp_next()) {';
AddedLines{end+1}='		x = pp.get_loc()';
AddedLines{end+1}='		del1 = pp.del';
AddedLines{end+1}='		dur1 = pp.dur';
AddedLines{end+1}='		amp1 = pp.amp';
AddedLines{end+1}='		fn.printf("IClamp,%g, %g, %g, %g, ", x, del1, dur1, amp1)';
AddedLines{end+1}='		pop_section()';
AddedLines{end+1}='	}';
AddedLines{end+1}='	fn.printf("\n")';
AddedLines{end+1}='}';
AddedLines{end+1}='fn.close()';
AddedLines{end+1}='// End point processess mechanisms output';
AddedLines{end+1}='// Start printing the wanted output from neuron';
AddedLines{end+1}=['hoc_stdout(".' filesep 'output' filesep '64F.csv")'];
AddedLines{end+1}='while(t<tfinal){';
AddedLines{end+1}='		fcurrent()';
AddedLines{end+1}='		MyPrintMatrix()';
AddedLines{end+1}='		forall{';
AddedLines{end+1}='			printf("%s\n",secname())';

%Amit - new
AddedLines{end+1}='			printf("%f,%f\n",t,v(0))';
AddedLines{end+1}='			printf("%f,%f\n",t,v(0.2))';
AddedLines{end+1}='			printf("%f,%f\n",t,v(0.4))';
AddedLines{end+1}='			printf("%f,%f\n",t,v(0.6))';
AddedLines{end+1}='			printf("%f,%f\n",t,v(0.8))';

% AddedLines{end+1}='printf("%f,%f,%f,%f,%f,%f,%f,%f,%f,%f,%f,%f,%f,%f,%f\n",t,v(0),gk_hh(0),gna_hh(0),gl_hh(0),ik(0),ina(0),il_hh(0),m_hh(0),h_hh(0),n_hh(0),minf_hh,mtau_hh,hinf_hh,htau_hh)'; Amit - modified it since not generic
% AddedLines{end+1}='			printf("%f,%f,%f,%f,%f,%f,%f,%f,%f,%f,%f,%f,%f,%f,%f\n",t,v(0.2),gk_hh(0.2),gna_hh(0.2),gl_hh(0.2),ik(0.2),ina(0.2),il_hh(0.2),m_hh(0.2),h_hh(0.2),n_hh(0.2),minf_hh,mtau_hh,hinf_hh,htau_hh)';
% AddedLines{end+1}='			printf("%f,%f,%f,%f,%f,%f,%f,%f,%f,%f,%f,%f,%f,%f,%f\n",t,v(0.4),gk_hh(0.4),gna_hh(0.4),gl_hh(0.4),ik(0.4),ina(0.4),il_hh(0.4),m_hh(0.4),h_hh(0.4),n_hh(0.4),minf_hh,mtau_hh,hinf_hh,htau_hh)';
% AddedLines{end+1}='			printf("%f,%f,%f,%f,%f,%f,%f,%f,%f,%f,%f,%f,%f,%f,%f\n",t,v(0.6),gk_hh(0.6),gna_hh(0.6),gl_hh(0.6),ik(0.6),ina(0.6),il_hh(0.6),m_hh(0.6),h_hh(0.6),n_hh(0.6),minf_hh,mtau_hh,hinf_hh,htau_hh)';
% AddedLines{end+1}='			printf("%f,%f,%f,%f,%f,%f,%f,%f,%f,%f,%f,%f,%f,%f,%f\n",t,v(0.8),gk_hh(0.8),gna_hh(0.8),gl_hh(0.8),ik(0.8),ina(0.8),il_hh(0.8),m_hh(0.8),h_hh(0.8),n_hh(0.8),minf_hh,mtau_hh,hinf_hh,htau_hh)';
AddedLines{end+1}='		}';
AddedLines{end+1}='		fadvance()';
AddedLines{end+1}='}';
AddedLines{end+1}='hoc_stdout()';

OutLines=[Lines(1:AddLineI); AddedLines'; Lines((AddLineI+1):end)];
%OutLines=[Lines; AddedLines'];
Lines2File(OutLines,FNWithTopo);