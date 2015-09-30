FN='fork.ASC';
NComp = 3;
baseCords = [1 1 1 0.005];
for comp = 1:NComp
    NSeg(comp)=5;
    Diams{comp}=ones(1,5)*0.005;
    Lengths{comp}=ones(1,5)*0.005;
end
fid=fopen(FN,'wb');
fprintf(fid,';	V3 text file written for MicroBrightField products.\n');
fprintf(fid,'(ImageCoords)\n');
fprintf(fid,'("CellBody"\n(Color MoneyGreen)\n(CellBody)\n');
for i=1:NSeg(1)
    fprintf(fid,'(%3.2f %3.2f %3.2f 0.005 ) ; 1,d\n',baseCords(1)+Diams{1}(1),baseCords(2)+Lengths{1}(1),baseCords(3),i);
end
fprintf(fid,')  ;  End of contour\n');
fprintf(fid,'( (Color RGB (255, 4, 255))\n(Dendrite)\n');
for i=1:NSeg(1)
    fprintf(fid,'(%3.2f %3.2f %3.2f 0.005 ) ; 1,d\n',baseCords(1),baseCords(2)+Lengths{1}(1),baseCords(3),i);
end
fprintf(fid,')  ;  End of contour\n');
fprintf(fid,'( (Color RGB (255, 4, 255))\n(Dendrite)\n');
for i=1:NSeg(1)
    fprintf(fid,'(%3.2f %3.2f %3.2f 0.005 ) ; 1,d\n',baseCords(1),baseCords(2)+Lengths{1}(1),baseCords(3),i);
end
fprintf(fid,')  ;  End of contour\n');