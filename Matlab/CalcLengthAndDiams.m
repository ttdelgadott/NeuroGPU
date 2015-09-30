function [Lengths Diams]= CalcLengthAndDiams(Coords,Type,Parent)
somaInd = getCompIndex(Type,'(CellBody)');
axonInd = getCompIndex(Type,'(Axon)');
somaCords = Coords{somaInd};
axonStart = Coords{axonInd}{1};
distFromAxon = calcDistFromTarget(Coords{somaInd},axonStart);
[sorted inds] = sort(distFromAxon);
base = somaCords{inds(1)};
head = somaCords{inds(end)};
baseVec = (head(1:3)-base(1:3));
baseVec = baseVec./sqrt(baseVec(1)*baseVec(1)+baseVec(2)*baseVec(2)+baseVec(3)*baseVec(3));
somaPs = cell2mat(somaCords);
somaPs = somaPs(1:3,:);
someOrigPs=somaPs;
%figure(99);clf;plot3(someOrigPs(1,:),someOrigPs(2,:),someOrigPs(3,:),'*');hold on;
%plot3(head(1),head(2),head(3),'r*');
%plot3(base(1),base(2),base(3),'g*');
for i=1:length(somaPs)
    currv = somaPs(:,i);
    proj = baseVec.*(dot(baseVec,currv)./dot(baseVec,baseVec));
    somaNewPs(:,i)= currv-proj;
end
[pcs stam lambdas]= princomp(somaNewPs');
Vec2=pcs(1,:)-(dot(pcs(1,:),baseVec)/dot(baseVec,baseVec))*baseVec';
Vec2=Vec2./norm(Vec2);
Vec3=pcs(2,:)-(dot(pcs(2,:),baseVec)/dot(baseVec,baseVec))*baseVec';
Vec3=Vec3./norm(Vec3);
transMat = [baseVec';Vec2;Vec3];
TsomaNewPs = transMat*someOrigPs;
TBase=transMat*base(1:3);
THead=transMat*head(1:3);
%figure(1231232);clf;plot3(TsomaNewPs(1,:),TsomaNewPs(2,:),TsomaNewPs(3,:),'*');hold on;
%plot3(THead(1),THead(2),THead(3),'r*');
%plot3(TBase(1),TBase(2),TBase(3),'g*');

TTsomaNewPs=TsomaNewPs-repmat([TBase(1); TBase(2) ;0], 1,size(TsomaNewPs,2));
TTsomaNewPs(3,:)=0;
%figure(23);clf;plot3(TTsomaNewPs(1,:),TTsomaNewPs(2,:),TTsomaNewPs(3,:),'*');hold on;



firstDend = getCompIndex(Type,'(Dendrite)');
if length(firstDend)>1
    firstDend = firstDend(end);
end
for compt = 1:length(Coords)
    if(compt == somaInd)
        continue;
    end
    prevSegInd = Parent(compt);
    if(prevSegInd ==somaInd)%deciding if the base would be from the head or the tail of the soma
%         if(compt<firstDend)
%             prevSeg = base;
%         else
%             prevSeg = head;
%         end
        [bla, minInd] = min(calcDistFromTarget(Coords{somaInd},Coords{compt}{1}));
        prevSeg=Coords{somaInd}{minInd};
    else
        prevSeg = Coords{prevSegInd}{end};
    end
    [comptLengths,comptDiams] = getCompLengthDiam(Coords{compt},prevSeg);
    Lengths{compt}=comptLengths;
    Diams{compt} = comptDiams;
end
[ somaLengths somaDiams] = calcSoma(TTsomaNewPs([2 1],:)');
Lengths{somaInd}=somaLengths;
Diams{somaInd}=somaDiams;



