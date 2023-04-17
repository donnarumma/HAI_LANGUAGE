function   s = DICTIONARY_createHyphenated(dname,words,sentences,deleteoldsentences)
% function s = DICTIONARY_createHyphenated(dname,words,sentences,deleteoldsentences)
s='';
try
    fdic        =load(dname);
    words       =[words(:);     fdic.words(:)];
    if deleteoldsentences
        sentences = sentences(:);
    else
        sentences =[sentences(:); fdic.sentences(:)];
    end
catch
    words       = [words(:)];
    sentences   = [sentences(:)];
end
words           = unique(strtrim(upper(words)));
sentences       = unique(strtrim(upper(sentences)));
Syllables       = [];
lenHy           = zeros(length(words),1);
for iw=1:length(words)
    word        = words{iw};
    % wordsplitted= hyphenate(word);
    wordsplitted= DICTIONARY_hyphenate(word);
    lenHy(iw)   = length(wordsplitted);
    Syllables   = [Syllables(:); wordsplitted(:)];
end
Syllables       = unique(Syllables);
NSy             = length(Syllables);
lenSy           = zeros(NSy,1);
for iSy=1:NSy
    Syllable    =Syllables{iSy};
    lenSy(iSy)  =length(Syllable);
end
maxSy           = max(lenSy);
maxHy           = max(lenHy);
LEN         =0;
for iw=1:length(words)
    LEN=max(LEN,length(words{iw}));
end



CONTAINER=repmat(' ',1,maxSy);
% add empty Syllable
Syllables=[{CONTAINER};Syllables];
NSy      =NSy+1;
s=sprintf('%sfunction DICTIONARY = %s()\n',s,dname);

s=sprintf('%sLETTERS=cell(0,0);\n',s);
s=sprintf('%sLETTERS{end+1,1}='' ''; iL.s=length(LETTERS);\n',s);

for ch='A':'Z'
    s=sprintf('%sLETTERS{end+1,1}=''%s''; iL.(LETTERS{end})=length(LETTERS);\n',s,ch);
end

s=sprintf('%sSYLLABLES=cell(0,0); D='''';\n',s);
% s=sprintf('%sSYLLABLES{end+1,1}=''%s''; iS.s=length(SYLLABLES);\n',s,CONTAINER);

for iSy=1:NSy
    SYLLABLE                        = Syllables{iSy};
    TMPSYLLABLE                     = CONTAINER;
    TMPSYLLABLE(1:length(SYLLABLE)) = SYLLABLE;
    SYLLABLE                        = TMPSYLLABLE;
    sytxt                            ='SYLLABLES{end+1,1}  ={';
    for il=1:length(SYLLABLE)
        LET=SYLLABLE(il);
        if isequal(' ',LET)
            sytxt=sprintf('%sLETTERS{iL.s},', sytxt);
        else
            sytxt=sprintf('%sLETTERS{iL.%s},',sytxt,LET);
        end
    end
    if isequal(TMPSYLLABLE,CONTAINER)
        sytxt = sprintf('%s}; iS.s=length(SYLLABLES);\n',sytxt(1:end-1));
    else
        sytxt = sprintf('%s}; iS.(HAI_retrieveLevel(SYLLABLES{end},D))=length(SYLLABLES);\n',sytxt(1:end-1));
    end
    s=sprintf('%s%s',s,sytxt);
end

s=sprintf('%sWORDS=cell(0,0); D='''';\n',s);
for iw=1:length(words)
    WORD                    = upper(words{iw});
    % WORDSPLITTED            = hyphenate(WORD);
    WORDSPLITTED            = DICTIONARY_hyphenate(WORD);
    LenHy                   = length(WORDSPLITTED);
    wtxt                    ='WORDS{end+1,1}  ={';
    for il=1:maxHy
        if il>LenHy
            wtxt=sprintf('%sSYLLABLES{iS.s},',wtxt);
        else
            wtxt=sprintf('%sSYLLABLES{iS.%s},',wtxt,WORDSPLITTED{il});
        end
    end
    wtxt = sprintf('%s}; iW.(HAI_retrieveLevel(WORDS{end},D))=length(WORDS);\n',wtxt(1:end-1));
    s=sprintf('%s%s',s,wtxt);
end
s=sprintf('%sSENTENCES=cell(0,0);\n',s);

for is=1:length(sentences)
    sentence=upper(sentences{is});
    ws=strsplit(sentence,' ');
    stxt='SENTENCES{end+1,1}  ={';
    for iw=1:length(ws)
        word=ws{iw};
        stxt=sprintf('%sWORDS{iW.%s},',stxt,word);
    end
    stxt = sprintf('%s};\n',stxt(1:end-1));
    s=sprintf('%s%s',s,stxt);
end 

s = sprintf('%sDICTIONARY.STATES       = {   SYLLABLES ,      WORDS,   SENTENCES};\n',s);
s = sprintf('%sDICTIONARY.OBS          = {     LETTERS ,  SYLLABLES,       WORDS};\n',s);
s = sprintf('%sDICTIONARY.CLASSES      = {          [] ,         [],          []};\n',s);
s = sprintf('%sDICTIONARY.StateNames   = {''Syllable'' ,   ''Word'',''Sentence''};\n',s);
s = sprintf('%sDICTIONARY.ObsNames     = {''Letter'',  ''Syllable'',     ''Word''};\n',s);

s = sprintf('%sDICTIONARY.Sentence     = SENTENCES;\n',s);
s = sprintf('%sDICTIONARY.Word         = WORDS;\n'    ,s);
s = sprintf('%sDICTIONARY.Syllable     = SYLLABLES;\n',s);
s = sprintf('%sDICTIONARY.Letter       = LETTERS;\n'  ,s);
s = sprintf('%sDICTIONARY.NAME         = mfilename;\n',s);