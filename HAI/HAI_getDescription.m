function   description = HAI_getDescription(params)
% function description = HAI_getDescription(params)
on1 =sprintf('%g_',round(100*params.level(1).obsnoise));     on1=[ 'n1_',on1];   on1(end)=[];
sn1=sprintf('%g_',round(100*params.level(1).statesnoise));   sn1=['tn1_',sn1];   sn1(end)=[];
on2 =sprintf('%g_',round(100*params.level(2).obsnoise));     on2=[ 'n2_',on2];   on2(end)=[];
sn2=sprintf('%g_',round(100*params.level(2).statesnoise));   sn2=['tn2_',sn2];   sn2(end)=[];

description =['HMDP' params.version 'm' num2str(params.imode) '_' on1 '_' sn1 '_' on2 '_' sn2];
end