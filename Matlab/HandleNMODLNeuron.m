% NEURON {
%         SUFFIX hh
%         USEION na READ ena WRITE ina
%         USEION k READ ek WRITE ik
%         NONSPECIFIC_CURRENT il
%         RANGE gnabar, gkbar, gl, el, gna, gk
%         GLOBAL minf, hinf, ninf, mtau, htau, ntau
% 	THREADSAFE : assigned GLOBALs will be per thread
% }

NeuronLine=find(strhas(Lines,'NEURON'));
StartL=NeuronLine;
EndL=min(EndLines(EndLines>StartL));
NeuronS.Suffix=[];
NeuronS.UseIon=struct([]);
NeuronS.NonspecificCurrent=[];
NeuronS.Range=cell(0);
NeuronS.Global=cell(0);
for j=(StartL+1):(EndL-1)
    [Tok RestLine]=strtok(Lines{j});
    switch(Tok)
        case 'SUFFIX'
            NeuronS.Suffix=strtok(RestLine);
        case 'USEION'
            [CurIon.name RestLine]=strtok(RestLine);
            F=strfind(RestLine,'READ');
            F2=strfind(RestLine,'WRITE');
            if(~isempty(F2))
                Rline=RestLine(F(1)+4:F2(1)-1);
                Wline=RestLine(F2(1)+5:end);
            else
                Rline=RestLine(F(1)+4:end);
                Wline='';
            end
            CurIon.read=regexprep(regexp(Rline,',','split'),'\W','');
            CurIon.write=regexprep(regexp(Wline,',','split'),'\W','');
%             [Tmp RestLine]=strtok(RestLine);
%             [CurIon.read RestLine]=strtok(RestLine);
%             [Tmp RestLine]=strtok(RestLine);
%             [CurIon.write RestLine]=strtok(RestLine);
            if(isempty(NeuronS.UseIon))
                NeuronS.UseIon=CurIon;
            else
                NeuronS.UseIon(end+1)=CurIon;
            end
        case 'NONSPECIFIC_CURRENT'
            NeuronS.NonspecificCurrent=strtok(RestLine);
        case 'RANGE'
            RestLine=regexprep(RestLine,'\s*','');
            NeuronS.Range=regexp(RestLine,',','split');
        case 'GLOBAL'
            RestLine=regexprep(RestLine,'\s*','');
            NeuronS.Global=regexp(RestLine,',','split');
        otherwise
            disp(['Unknown stuff - ' Tok]);
    end
end
if(isempty(NeuronS.UseIon))
    NeuronS.UseIon=struct();
    if(strcmp(NeuronS.Suffix,'pas'))
        NeuronS.UseIon.write={'i'};
    else
        NeuronS.UseIon.write=cell(0);
    end
    NeuronS.UseIon.read=cell(0);
    NeuronS.UseIon.name='';
end
Tmp={NeuronS.UseIon.read};
Tmp=[Tmp{:}];
NeuronS.Read=Tmp(cellNumel(Tmp)>0);
Tmp={NeuronS.UseIon.write};
Tmp=[Tmp{:}];
NeuronS.Writes=Tmp(cellNumel(Tmp)>0);
NeuronS.OnlyReads=setdiff(NeuronS.Read,NeuronS.Writes);
NeuronS.Ions=[{NeuronS.UseIon.name}];
NeuronS.Currents=strcat('i',NeuronS.Ions);
NeuronS.Condatances=strcat('g',NeuronS.Ions);
if(strcmp(NeuronS.Suffix,'pas'))
    NeuronS.Condatances={'gpas'};
end
NeuronS.Reversals=strcat('e',NeuronS.Ions);
NeuronS.WritesNoCurrents=setdiff(NeuronS.Writes,NeuronS.Currents);
NeuronS.ReadsNoReversals=setdiff(NeuronS.Read,NeuronS.Reversals);
NeuronS.OnlyReadsNoReversals=setdiff(NeuronS.OnlyReads,NeuronS.Reversals);
