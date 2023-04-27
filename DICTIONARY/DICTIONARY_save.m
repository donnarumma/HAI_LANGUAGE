function   DICTIONARY=DICTIONARY_save(filename,dic_dir,words,sentences,deleteoldsentences,dohyphen)
% function DICTIONARY=DICTIONARY_save(filename,dic_dir,words,sentences,deleteoldsentences,dohyphen)
try
    deleteoldsentences;
catch
    deleteoldsentences=0;
end
try
    dohyphen;
catch
    dohyphen=0;
end
%% create dictionary string
if ~dohyphen
    s = DICTIONARY_create(filename,words,sentences,deleteoldsentences);
else
    s = DICTIONARY_createHyphenated(filename,words,sentences,deleteoldsentences);
end
SEP = filesep;%'//'; 
%% save m file
nf=[dic_dir SEP filename '.m'];
fprintf('Compiling %s\n',nf);
fid = fopen(nf,'w');
fprintf(fid,'%s',s);
fclose(fid);
%% save words and sentences
dicfun    =str2func(filename);
DICTIONARY=dicfun();
WORDS=DICTIONARY.Word;
words=cell(size(WORDS));
for iw=1:length(WORDS)
    words{iw}=HAI_retrieveLevel(WORDS{iw},'');
end
SENTENCES=DICTIONARY.Sentence;
sentences=cell(size(SENTENCES));
for is=1:length(SENTENCES)
    sentences{is}=HAI_retrieveLevel(SENTENCES{is});
end

dic_mat_file=[dic_dir SEP filename '.mat'];
fprintf('Saving Dictionary info in %s\n', dic_mat_file);
save(dic_mat_file,'words','sentences');