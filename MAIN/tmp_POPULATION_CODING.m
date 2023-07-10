function tmp_POPULATION_CODING(MDP)

hai_neu= HAI_getNeuralStatistics(MDP,1);
z=hai_neu.z;

%% %%%%%% POPULATION CODING %%%%%%%
hfig=figure; hold on; 
Nr    = 16;%16;
R  = kron(spm_cat(z)',ones(Nr,Nr));
R  = rand(size(R)) > R*(1 - 1/Nr);
imagesc(t,1:(Nx*Ne + 1),R),title('Unit firing','FontSize',16)
xlabel('time (sec)','FontSize',12)
colormap gray;

grid on, set(gca,'XTick',(1:(Ne*Nt))*Nb*dt)

ylabel(sprintf('Population Coding C^{3} (%s x time step)',MDP(1).Aname{f})); %% DONNARUMMA

yt   =yticks;
yt(1)=1;
Nlabels=length(yticks);
allyticks= 1:(Ne*Nx);
grid on, set(gca,'YTick',allyticks)  % set y ticks for each neuron
HN=yline(allyticks);
set(HN,'alpha',0.1);
ylim([1-0.0,Ne*Nx+0.0]);
% nolabels=1;
% if ~nolabels
strnew=cell(Ne*Nx,1);               %% DONNARUMMA all strings reset
% ytks=1:Nx:Ne*Nx; strnew(ytks)=str(ytks);  %% put anly wanted strings 
strnew(yt)=num2cell(yt);
str=strnew;                         %% comment if you want disable DONNARUMMA
set(gca,'YTickLabel',str),
xlim([t(1),t(end)]);
% %%%%% FILL LINES %%%%%%
ylines  = 0:Nx:Ne*Nx;
istart  = 1;
ylines  = ylines(2:end);
cmaps   = lines(length(ylines));
for iy = 1:length(ylines)
    iend = ylines(iy);
    H(iy)=fill([t(1),t(1),t(end),t(end)],[istart,iend,iend,istart],cmaps(iy,:));
    istart=iend;
    set(H(iy),'facealpha',.1)
    HL{iy}=['Step=' num2str(iy)];
end
% 
legend(H,HL,'location','northwest')
%%%%%%%%%%%
