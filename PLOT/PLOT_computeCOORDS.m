function   [x,y,XMAX]=PLOT_computeCOORDS(phr,LDIM)
% function [x,y,XMAX]=PLOT_computeCOORDS(phr,LDIM)

WORDNUMBER  =length(phr);
LETTERNUMBER=length(phr{1});

x       = zeros(LETTERNUMBER+1,2);
x(:,1)  = ((0:1:LETTERNUMBER)').*LDIM;
y       = zeros(WORDNUMBER,2);
% compute length of each word with a space in between
lenWs    = zeros(WORDNUMBER,1);  % store length of each word
for iw=1:WORDNUMBER
    lenWs(iw)=length(HAI_retrieveLevel(phr{iw}));
end
lenWSpace=lenWs+1; 
% compute location of each word
wordLoc   = zeros (WORDNUMBER,1);  % 
wordLoc(1)=1; 
for il=1:length(lenWSpace)-1 
    wordLoc(il+1)=(lenWSpace(il))*LDIM+wordLoc(il); 
end
y(:,1)   = wordLoc;
XMAX     = sum(lenWSpace)*LDIM;

% XMAX     = (sum(lenWSpace)+1)*LDIM;
