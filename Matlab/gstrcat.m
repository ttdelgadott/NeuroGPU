function Out=gstrcat(Str,StrC)
Str=strrep(Str,' ','|X|');
NotCell=false;
if(ischar(StrC))
    StrC={StrC};
    NotCell=true;
end
for i=1:numel(StrC)
    Out{i}=strrep(strcat(Str,StrC{i}),'|X|',' ');
end
if(NotCell)
    Out=Out{1};
end