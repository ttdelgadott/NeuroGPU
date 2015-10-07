function []=plotNeuron(coords,lengths,diams)
figure(12);
for compt = 1:length(coords)
    currCompt = cell2mat(coords{compt});
    hold on;
    plot3(currCompt(1,:),currCompt(2,:),currCompt(3,:));
    for seg = 1:size(currCompt,2)
        hold on;
        text(currCompt(1,seg),currCompt(2,seg),currCompt(3,seg),['*' num2str(lengths{compt}(seg)),' ',num2str(diams{compt}(seg))],'FontSize',7);
    end
end