% if ( t < del + dur  && t >= del ) {
%      i = amp ;
%      }
%    else {
%      i = 0.0 ;
%      }
%    }
%  _current += i;

% function [sumCurrents sumConductivity]=AmitNrnCurrent_HH(v, m, h, n, gnabar, gkbar, gl, el)
% ena=50;
% ek=-77;
% gl = 0.0003;
% gna=gnabar*m*m*m*h;
% ina=gna*(v-ena);
% gk=gkbar*n*n*n*n;
% ik=gk*(v-ek);
% il=gl*(v-el);
% sumCurrents= ina+ik+il;
% sumConductivity= gk+gna+gl;

function [sumCurrents sumConducts] = AmitNrnCurrent_Stim (t, v, varsForThisModel,...
    varsForAllModels, constsForThisModel, constsForAllModels)

AmitModelConstsIndicesDef_Stim;
AmitModelVarsIndicesDef_Stim;
AmitCommonConstsIndicesDef;

%QWERTY - for now constsForThisModel is taken from the "PARAMETER" section 
%in the mod file. to check if it's sufficient for our purpose
del = constsForThisModel(del_index);
dur = constsForThisModel(dur_index);
amp = constsForThisModel(amp_index);
area = constsForThisModel(area_index);

%see next QWERTY
%i = varsForThisModel(i_index);

isElectrodeCurrent = 1;
if (t < del + dur && t >= del)
	i = 100*amp/area;
else
	i = 0;
end;


%QWERTY - varsForThisModel isn't returned - should I return it in every model
%so we can update the vars every nrn_cur?
sumConducts = 0;
%varsForThisModel(i_index) = i;
sumCurrents = i;
if (isElectrodeCurrent)
    sumCurrents = -sumCurrents;
    sumConducts = -sumConducts;
end;
