function probLevel=HAI_getTimeProb(MDP)
% function probLevel=HAI_getTimeProb(MDP)
% need matlab-tree
% get for each level the couples [prob(t),t]
% probLevel{iLevel}  (one for each level) =
% [prob(x_t =s_true|o_t), Cumulative RT, NodeExplored, TreeCorrespondence]  
ptree     = TREE_getMDPTime(MDP,@TREE_LevelTime_StateProb,@TREE_Append_NULL);  % tree of probability per level
levtree   = TREE_getMDPTime(MDP,@TREE_LevelTime_t,@TREE_Append_NULL);          % tree of cumulative time per level

ABSRTtree = TREE_AbsRT(MDP); % tree of cumulative depthfirst reaction times

% (1,2) - prob(x_t =s_true|o_t), Cumulative RT
probLevel = cell(ABSRTtree.depth,1);
btiterator= ABSRTtree.breadthfirstiterator;
for it=2:length(btiterator)
    cnode=btiterator(it);
    probLevel{levtree.get(cnode)}=[           probLevel{levtree.get(cnode)};  ...
                                   [ptree.get(cnode), ABSRTtree.get(cnode)]];
end

% (3) - NodeExplored - sequence of node explored
alltimes = full(spm_cat(probLevel));
alltimes = alltimes(:,end);
vals     = sort(alltimes);
for ilev=1:length(probLevel)
    for it=1:length(probLevel{ilev}(:,2))
        probLevel{ilev}(it,3)=find(probLevel{ilev}(it,2)==vals);
    end
end

% (4) - Tree Correspondence: lower level -> 0:nNodes-1. Higher levels-> correspondence to lower levels
probLevel{1}(:,4)=(1:length(probLevel{1}(:,3)))-1;
% RT=probLevel{1}(:,2);
for ilev=2:length(probLevel)
    RT=probLevel{ilev-1}(:,2);
    for it=1:length(probLevel{ilev}(:,3))
        [~,minR]=min(abs(RT-probLevel{ilev}(it,2)));
        probLevel{ilev}(it,4)=probLevel{ilev-1}(minR,4);
    end
end

%%
% EXPMDP=MDP;
minVB   = MDP.VBNi;
VBS     = MDP.VBNi;
try
    while (true)
        % for each level presumes the same amount of steps
        MDP     = MDP.mdp(1);
        minVB   = min(minVB,MDP.VBNi);
        VBS     = [MDP.VBNi,VBS];
    end
catch
end
%% (5) - strech wrt effective RT (minimum VB / minimum RT)
pbs             = full(spm_cat(probLevel));
allRTvals       = pbs(:,2);
% sort all rts
[rtvals,ind2]   = sort(allRTvals);
% order rt differences
deltas          = diff([0;rtvals]);
% find faster RT
mind            = min(deltas);
% scale wrt minimum of VB iteration on minimum RT (minVB/mind)
newsteps        = round(minVB*deltas/mind);
for il=1:length(probLevel)
    for ii=1:size(probLevel{il},1)
        % put the values where the RT corresponds
        probLevel{il}(ii,5) = newsteps(probLevel{il}(ii,3)==ind2);
    end
end
%% (6) - stretch wrt level and total RTs (minimum VB per level / minimum RT) 
for il=1:length(probLevel)
    deltas              = diff([0;probLevel{il}(:,2)]);
    newsteps            = round(minVB*deltas/mind);
    probLevel{il}(:,6)  = newsteps;
end
%% (7) - stretch wrt level (minimum VB per level / minimum RT per level)
for il=1:length(probLevel) 
    deltas              = diff([0;probLevel{il}(:,2)]);
    mind                = min(deltas);
    newsteps            = round(VBS(il)*deltas/mind);
    probLevel{il}(:,7)=newsteps;
end
