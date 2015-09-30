
fid = fopen('ilpss.txt','wb');
for(i=32:50)
    fprintf(fid,'#ifdef ILP%d\n',i);
    fprintf(fid,'\t#define SUPERILPMACRO(x) ;');
    for(j=1:i)
        fprintf(fid,' ## x ## (%d);',j);
    end
    fprintf(fid,'\n');
     fprintf(fid,'#endif\n');
end