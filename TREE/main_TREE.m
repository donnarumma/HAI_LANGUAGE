% function main_TREE

%% %%%%%%% CONTENT STATE TREE %%%%%%%%%
[stree] = TREE_getMDP(MDP,@TREE_Level_States,@TREE_Append_Obs);
 %           THE COMPUTATIONAL MODEL IS ABLE             
 %           +---------------+---+---------------+        
 %           |                   |               |        
 %          THE                 IS             ABLE       
 %       +---+-------+                                    
 %       |           |           |               |        
 %      THE          ø          IS             ABLE       
 % +---+-+-+---+             +---+---+       +---+---+    
 % |   |   |   |     |       |       |       |       |    
 % T   E   ø   H     ø       I       S       A       B 

%% %%%% CONTENT STRUCTURE TREE %%%%%%%%%%
[mtree] = TREE_getMDPStructure(MDP);
% Sentence  
% 
%     |     
%   Word    
% 
%     |     
% Syllable  
% 
%     |     
%  Letter 
disp([stree.tostring,mtree.tostring]);

%% %%% CONTENT NAME TREE %%%%%%%%%%%%%
guard = TREE_getMDP(MDP,@TREE_Level_StateName,@TREE_Append_ObsName);
%                Sentence                 
%          +---------+----+---------+     
%          |              |         |     
%        Word           Word      Word    
%     +----+----+                         
%     |         |         |         |     
% Syllable  Syllable  Syllable  Syllable  
% 
%     |         |         |         |     
%  Letter    Letter    Letter    Letter  
disp(guard.tostring);

%% %%% CONTENT NAME and LOCATION TREE %%%%%%%%%%%%%%%%%%%%%%%%%%%%
% [ttree] = TREE_getMDPTime(MDP,@TREE_LevelTime_LocationName,@TREE_Append_NULL);
%               +-----------+--------+-----------+      
%               |                    |           |      
%             WoL22                WoL25       WoL26    
%            +--+-----------+                           
%            |              |        |           |      
%          SyL1           SyL3     SyL1        SyL1     
%   +-----+--+--+-----+           +--+--+     +--+--+   
%   |     |     |     |     |     |     |     |     |   
% LeL1  LeL3  LeL4  LeL2  LeL1  LeL1  LeL2  LeL1  LeL2  

%% %%%%%%% LOCATION TREE %%%%%%%%%
[vtree] = TREE_getMDPTime(MDP,@TREE_LevelTime_Location,@TREE_Append_NULL);
 %             .             
 %       +----+----+-----+   
 %       |         |     |   
 %      22        25    26   
 %     ++------+             
 %     |       |   |     |   
 %     1       3   1     1   
 % +--++-+--+  |  ++-+  ++-+ 
 % |  |  |  |  |  |  |  |  | 
 % 1  3  4  2  1  1  2  1  2 
disp(vtree.tostring);

%% %%% MAX T TREE %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
maxTree= TREE_getMDP(MDP,@TREE_Level_maxT,@TREE_Append_NULL);
 %     3      
 %  +--+-+--+ 
 %  |    |  | 
 %  2    1  1 
 % ++-+  |  | 
 % |  |  |  | 
 % 4  1  2  2 
disp(maxTree.tostring);

% example disp([stree.tostring,mtree.tostring,otree.tostring,vtree.tostring]);

%% %%%%% LEVEL TREE %%%%%%%%%%
[ltree] = TREE_getMDPLevel(MDP);
 % Level 
 %   |   
 %   |   
 %   3   
 %   |   
 %   |   
 %   2   
 %   |   
 %   |   
 %   1  

 %% %%%%%%%%% CONTENT TREE %%%%%%%%%
[lstree]=TREE_getMDPStructureStates(MDP);
%     S3      
% 
%      |      
%     S2      
% 
%      |      
%     S1      
% 
%      |      
% STRUCTURES
disp(lstree.tostring);

%% %%% LOCATIONS TREE %%%%%%%%%%%%
[otree]=TREE_getMDPStructureLocations(MDP);
 % LOCATIONS 
 %     |     
 %     |     
 %    L3     
 %     |     
 %     |     
 %    L2     
 %     |     
 %     |     
 %    L1
disp([mtree.tostring,stree.tostring,lstree.tostring,vtree.tostring,otree.tostring,]);

% obstree=TREE_getMDPStructureObs(MDP);
% 
% disp([mtree.tostring,stree.tostring,lstree.tostring,otree.tostring,vtree.tostring,]);

%% %%%%%%% PROBABILITY PER LEVEL TREE %%%%%%%%%%%%%%%%%%%%%%%%%%%%
ptree=TREE_getMDPTime(MDP,@TREE_LevelTime_StateProb,@TREE_Append_NULL);
%                               .                               
%                  +------------+-----------+------------+      
%                  |                        |            |      
%              0.038462                  0.14286         1      
%               +-+--------------+          |                   
%               |                |          |            |      
%            0.33327             1          1            1      
%     +--------++-------+---+            +-+----+       ++----+ 
%     |         |       |   |    |       |      |       |     | 
% 0.015151  0.090909   0.5  1    1    0.80532   1    0.16667  1 
disp(ptree.tostring);

%% %%%%%%% TIME LEVEL TREE %%%%%%%%%%%%%%%%%%%%%%%%%%%%%
timetree=TREE_getMDPTime(MDP,@TREE_LevelTime_t,@TREE_Append_NULL);
 %             .             
 %       +----+----+-----+   
 %       |         |     |   
 %       1         2     3   
 %     ++------+             
 %     |       |   |     |   
 %     1       2   1     1   
 % +--++-+--+  |  ++-+  ++-+ 
 % |  |  |  |  |  |  |  |  | 
 % 1  2  3  4  1  1  2  1  2 
disp(timetree.tostring);

%% %%%%%%%%%%%%%%%%%%% LEVEL TREE %%%%%%%%%%%%%%%%%%%%%%%%%%%%
[levtree] = TREE_getMDPTime(MDP,@TREE_LevelTime_t,@TREE_Append_NULL);
 %             .             
 %       +----+----+-----+   
 %       |         |     |   
 %       3         3     3   
 %     ++------+             
 %     |       |   |     |   
 %     2       2   2     2   
 % +--++-+--+  |  ++-+  ++-+ 
 % |  |  |  |  |  |  |  |  | 
 % 1  1  1  1  1  1  1  1  1 
disp(levtree);
%% %%%%%% depth iterator time tree %%%%%%%
depthtime_tree=time_tree;
dtiterator=depthtime_tree.depthfirstiterator;
for lev=1:length(dtiterator)
    depthtime_tree = depthtime_tree.set(dtiterator(lev),lev);
end
 %               1               
 %       +------+---+-------+    
 %       |          |       |    
 %       2         10      14    
 %     ++------+                 
 %     |       |    |       |    
 %     3       8   11      15    
 % +--++-+--+  |  +-+-+   +-+-+  
 % |  |  |  |  |  |   |   |   |  
 % 4  5  6  7  9 12  13  16  17 
disp(depthtime_tree.tostring);

%% %%%%%%%%%%%%%%%%%% REACTION TIME TREE %%%%%%%%%%%%%%%%%%%%
RTtree = TREE_getMDPTime(MDP,@TREE_LevelTime_RT,@TREE_Append_NULL);
%                     +--------------+------------+---------------+        
%                     |                           |               |        
%                  3.5252                      1.8453          2.5195      
%                 +--+----------------+                                    
%                 |                   |           |               |        
%               1.49               2.5749      1.4009          1.9454      
%    +-------+---+---+--------+               +---+---+       +---+---+    
%    |       |       |        |       |       |       |       |       |    
% 3.3099  3.8045  6.5693   10.8182 3.0148  3.1151  5.8537  4.4543  5.9346 
disp(RTtree.tostring);

%% %%%%%%%%%%%%% CUMULATIVE REACTION TIME TREE %%%%%%%%%%%%%%%%%%%%%%%
ABSRTtree=TREE_AbsRT(MDP);
%                                    62.1755                                    
%                      +----------------+------------+-----------------+        
%                      |                             |                 |        
%                   35.1066                       47.3217           62.1755     
%                 +---+-----------------+                              |        
%                 |                     |            |                 |        
%              25.9918               31.5814      45.4764           59.656      
%    +-------+----+---+--------+        |        +---+----+       +---+----+    
%    |       |        |        |        |        |        |       |        |    
% 3.3099  7.1143   13.6836  24.5018  29.0065  38.2217  44.0754 51.776   57.7106 
disp(ABSRTtree.tostring); 

%%
breadthtime_tree=time_tree;
btiterator=breadthtime_tree.breadthfirstiterator;
for lev=1:length(btiterator)
    breadthtime_tree = breadthtime_tree.set(btiterator(lev),lev);
end
 %                 1                 
 %         +------+-----+-------+    
 %         |            |       |    
 %         2            3       4    
 %       ++-------+                  
 %       |        |     |       |    
 %       5        6     7       8    
 % +--+-+-+---+       +-+-+   +-+-+  
 % |  |   |   |   |   |   |   |   |  
 % 9 10  11  12  13  14  15  16  17
disp(breadthtime_tree.tostring);
%%
probLevel=HAI_getTimeProb(MDP);
% probLevel=cell(ABSRTtree.depth,1);
% btiterator=ABSRTtree.breadthfirstiterator;
% for it=2:length(btiterator)
%     cnode=btiterator(it);
%     probLevel{levtree.get(cnode)}=[probLevel{levtree.get(cnode)}; 
%                           [ptree.get(cnode), ABSRTtree.get(cnode)]];
% end
%%

figure; 
hold on
cmaps=lines(MDP.level);
Nlevels=length(probLevel);
ALLT=[];
for lev=1:Nlevels
    ALLT=[ALLT; probLevel{lev}(:,2)];
end
LIMT=[min(ALLT),max(ALLT)];
MDP_I=MDP;
dt=0.1;
t0=0;
for lev=Nlevels:-1:1
    subplot(Nlevels,1,Nlevels-lev+1);
    hold on; box on; grid on;
    Y=probLevel{lev}(:,1);
    T=probLevel{lev}(:,2)+t0;
    if lev<Nlevels
        t_reset=probLevel{lev+1}(:,2);
        p_reset=zeros(size(t_reset));
        xline([t0;t_reset],'color',cmaps(lev+1,:),'LineWidth',3);
        
        T=[t_reset-dt;t_reset;t_resetend-dt;t_resetend;T];
        Y=[p_reset*nan;p_reset;p_resetend*nan;p_resetend;Y];
        [T,sortind]=unique(T);
        Y=Y(sortind);
    else
        t_resetend=probLevel{end}(:,2);
        p_resetend=zeros(size(t_resetend));
    end
    if lev>1
        T=[t0;T];
        Y=[t0;Y];
    end
    h(lev)=plot(T,Y,'o:','linewidth',3,'color',cmaps(lev,:),'markersize',8);%legend({'Level 1','Level 2','Level 3'});
    legend(h(lev),MDP_I.Aname{1},'autoupdate','off','location','northwest');
    try
        MDP_I=MDP_I.MDP;
    catch
    end

    if lev==1
        xlabel('times [ms]')
    end
    ylabel(sprintf('p(C^{%g}|O)',lev));
    % xlim([LIMT(1)-dt,LIMT(2)+dt]); 
    xlim([t0-dt,LIMT(2)+dt]); 
    ylim([0-0.01;1+0.01]);
end
% legend(MDP.Aname{q})
%% VBI STEPS PER LEVEL

steptree=TREE_getMDPTime(MDP,@TREE_LevelTime_Steps,@TREE_Append_NULL);

%% stretched VBI steps
ssteptree  = TREE_getMDP(EXPMDP.MDP,@TREE_LevelTime_StepsStretched,@TREE_Append_NULL);


