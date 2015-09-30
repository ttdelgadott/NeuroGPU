AA = csvread('auxData.txt');
AAA = AA(:,1:end-1);
for i=1:size(AAA)
    for j=1:size(AAA)
        if(AAA(i,j)==A(i,j))
            disp([i j]);
        end
    end
end
