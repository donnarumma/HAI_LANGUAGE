% scelta della distribuzione

%Poisson
 n=3;  %scelta fatta da noi
    x3 = 10:30;
    y3 = poisspdf(x3,10*n/2);
    name3 = strcat('Poisson',sprintf(' n=%i',n));
    figure(n+2*n1)
    bar(x3,y3)
    title(name3)