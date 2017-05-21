function [ppLocInSections] = getPpInSegments(nSegsMat, fidPP, compSegsIndexArr)
%return all the point-processes segments number and their constants
%(amp,dur,del etc) for each section(compartment). currently treats all 
%Point-Processes as IClamp.

tline = fgetl(fidPP);
sectionInd = 1;

numOfSections = length(nSegsMat(:,1));
ppLocInSections = cell(numOfSections, 1);
while ischar(tline)
    S=regexp(tline,',','split');
    %there are 5 variables for each point process
    numOfPpInSection = (length(S)-1)/5;
    numOfSegsInSection = nSegsMat(sectionInd);
    ppInOneSection = zeros(4, numOfPpInSection);
    %get pp location
    for i=1:numOfPpInSection
        %set the exact segment in the section of the Point-Process
        %0.9999 is because 1 might give a segment out of the compartment.
        tmp = min(str2double(S{(i-1)*5+2}),0.9999);
        ppInOneSection(1,i) = compSegsIndexArr(sectionInd,1) + ...
            floor(tmp*numOfSegsInSection);
        %set the delay of the IClamp
        ppInOneSection(2,i) = str2double(S{(i-1)*5+3});
        %set the duration of the IClamp
        ppInOneSection(3,i) = str2double(S{(i-1)*5+4});
        %set the amplitude of the IClamp
        ppInOneSection(4,i) = str2double(S{(i-1)*5+5});
    end
    %save the point processes of the current section
    ppLocInSections{sectionInd} = ppInOneSection;
    sectionInd = sectionInd + 1;
    tline=fgetl(fidPP);
end