function   IMC=PLOT_createCharacterImage(inchar)
% function IMC=PLOT_createCharacterImage(inchar)

X=0.5; Y=0.5; HOR='center'; VER='middle'; SIZE=430;    
hfig=figure('visible','off');
text(X,Y,inchar,'fontsize',SIZE,'FontWeight','bold','HorizontalAlignment',HOR,'VerticalAlignment',VER);
xlim([-inf,inf]);
ylim([-inf,inf]);
axis off;
F = getframe(hfig);
IMC = frame2im(F);
close (hfig);

