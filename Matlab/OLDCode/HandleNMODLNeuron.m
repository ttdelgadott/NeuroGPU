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
            [Tmp RestLine]=strtok(RestLine);
            [CurIon.read RestLine]=strtok(RestLine);
            [Tmp RestLine]=strtok(RestLine);
            [CurIon.write RestLine]=strtok(RestLine);
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
            disp(['Unknown stuff - .' Tok]);
    end
end