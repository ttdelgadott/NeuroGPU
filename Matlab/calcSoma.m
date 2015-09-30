% load('dots.mat');
% plot([p(:,1); p(1,1)],[p(:,2); p(1,2)]);
function [Length Diams] = calcSoma(p)
%figure(34);plot(p(:,1),p(:,2))
[stam inds] = sort(p(:,2),'descend');
sorted = p(inds,:);
firstPoint = sorted(1,:);
lastPoint = sorted(end,:);
%[Aline Bline Cline] = ABCLine(firstPoint,lastPoint);
%DistLine = Aline.*sorted(:,1)+Bline.*sorted(:,1)+Cline./sqrt(Aline*Aline + Bline*Bline);
linds = find(sorted(:,1)>=0);%p1 is the positive and p2 is the negative
rinds = find(sorted(:,1)<0);%p1 is the positive and p2 is the negative
if(linds(end)== length(sorted))
    rinds = [rinds; length(sorted)];
else
    linds = [linds; length(sorted)];
end
for i=1:length(sorted)-1
    Length(i) = abs((sorted(i,2)-sorted(i+1,2))/2);
    ymid = (sorted(i,2)+sorted(i+1,2))/2;
    left1 = find(sorted(linds,2)>ymid,1,'last');
    if isempty(left1)
        left1=1;
        left2=linds(1);
    else
        if left1 == length(linds)
            left1 = left1-1;
        end
        left2 = linds(left1+1); 
        left1 = linds(left1);
    end
    leftp1 = sorted(left1,:);
    leftp2 = sorted(left2,:);
    right1 = find(sorted(rinds,2)>ymid,1,'last');
    if isempty(right1)
        right1=1;
        right2=rinds(1);
    else
        if right1 == length(rinds)
            right1 = right1-1;
        end
        right2 = rinds(right1+1); 
        right1 = rinds(right1);
    end
    rightp1 = sorted(right1,:);
    rightp2 = sorted(right2,:);
    leftx = getxbetweenpoints(leftp1,leftp2,ymid);
    rightx = getxbetweenpoints(rightp1,rightp2,ymid);
    Diams(i) = abs(rightx-leftx);
    %line([rightx leftx],[ymid ymid],'Color','r');
end
 Length(end+1)=Length(end)/5;
 Diams(end+1)=Diams(end)/5;

