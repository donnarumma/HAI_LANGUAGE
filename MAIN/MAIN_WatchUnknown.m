function results = MAIN_WatchUnknown(filesidxs,test_dir)
try
    test_dir;
catch
    test_dir = [HAI_testsRoot() filesep 'DICTIONARY' filesep 'UNKNOWN' filesep];
end
listMDP=dir([test_dir '*.mat']);
filesMDP = {listMDP(:).name};
% filesidxs=1:length(filesMDP);
% filesidxs=2;
% filesidxs=3;
results.ProbS   =nan(length(filesidxs),1);
results.ProbSMax=nan(length(filesidxs),1);
results.NumSacc =nan(length(filesidxs),1);
% :3;
for iFile=filesidxs
    filename                = [test_dir filesMDP{iFile}];
    fprintf('loading %s\n',filename);
    fMDP                    = load(filename);
    MDPEXP                  = fMDP.MDP;
    ind                     = MDPEXP.s(1,1);
    val                     = MDPEXP.X{1}(ind,end);
    fprintf('Real P(%s)=%g\n',HAI_retrieveLevel(MDPEXP.sname{1}{ind}),val);
    [valMax,indMax]         = max(MDPEXP.X{1}(:,end));
    fprintf('max P(%s)=%g\n',HAI_retrieveLevel(MDPEXP.sname{1}{indMax}),valMax);
    numSaccades             = HAI_getSaccades(MDPEXP);
    fprintf('Number of saccades: %g\n',numSaccades);
    results.ProbS(iFile)    = val;
    results.ProbSMax(iFile) =valMax;
    results.NumSacc(iFile)  = numSaccades;
    results.MDP(iFile)      = MDPEXP;

    mdp                     = MDPEXP.mdp;
    T2max                   = MDPEXP.MDP.T;
    for im=1:length(mdp)
        loc                 = MDPEXP.s(2,im);
        [val,ind]           = max(mdp(im).X{1}(:,end));
        add                 = '';
        if mdp(im).T==T2max || val<0.6
            add             = 'I am not sure! Probably a new word';
            inloc           = loc;
        end
        fprintf('WL(%g):P(%s)=%g | %s\n',loc,HAI_retrieveLevel(MDPEXP.mdp(im).sname{1}{ind},''),val,add);
        mdpmdp              = mdp(im).mdp;
        for imm=1:length(mdpmdp)
            [val,ind]       = max(mdpmdp(imm).X{1}(:,end));
            sloc            = mdp(im).s(2,imm);
            recword{sloc}   = MDPEXP.mdp(im).mdp(imm).sname{1}{ind};
            fprintf('SL(%g):P(%s)=%g\n',sloc,HAI_retrieveLevel(MDPEXP.mdp(im).mdp(imm).sname{1}{ind},''),val);
        end
    end
    try
        fprintf('New word: %s, in word location %g\n',HAI_retrieveLevel(recword,''),inloc);
    catch
        fprintf('All read smoothly\n');
    end
end
