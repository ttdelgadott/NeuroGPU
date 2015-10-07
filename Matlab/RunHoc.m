function RunHoc(HocFN)
if(filesep=='/')
    if(strhas(HocFN,filesep))
        CurCD=pwd;
        cd(HocFN(1:find(HocFN==filesep,1,'last')));
    end
    system('/usr/local/bin/nrnivmodl');
    system(['nrniv ' HocFN]);
    if(strhas(HocFN,filesep))
        cd(CurCD);
    end
else
    %eval(['! start /min Hstartnrniv.exe ', HocFN , ' &'])
    system(['nrniv ',HocFN,' ']);
    pause(2);
end

