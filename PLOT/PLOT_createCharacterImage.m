function   IMC=PLOT_createCharacterImage(inchar,SIZE)
% function IMC=PLOT_createCharacterImage(inchar)

try
    SIZE;
catch
    SIZE=250;
end
hfig=figure('visible','off'); 
text(0.5-0.25,0.5,inchar,'fontsize',SIZE,'FontWeight','bold'); 
xlim([0,1]), 
ylim([0,1])
axis off;
F = getframe(hfig);
IMC = frame2im(F);
close (hfig);

