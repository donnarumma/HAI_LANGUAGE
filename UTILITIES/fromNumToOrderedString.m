function numStr=fromNumToOrderedString(i,maxNumber)
% function numStr=fromNumToOrderedString(i,maxNumber)
% default maxNumber=100
try 
    maxNum=maxNumber;
catch
    maxNum=100;
end
M=length(num2str(maxNum));

numStr=char(ones(1,M) * '0');

is=num2str(i);

m=length(is);
numStr(end-m+1:end)=is;


    