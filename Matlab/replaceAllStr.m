function [In] = replaceAllStr(In,Str,newStr)
if(iscell(In))
    for i=1:numel(In)
        if(strhas(In{i},Str));
            In{i} = strrep(In{i},Str,newStr);
        end
    end
    return;
end

