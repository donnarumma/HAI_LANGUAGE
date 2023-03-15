function [s,outnf]=latexCompile_ImageDirecory(source_dir,out_dir,params)
%% function s=latexCompile_ImageDirecory(source_dir,out_dir,params)

try
    sourcedir=source_dir;
catch
%     source_dir=[root_dir_ '/' Rat_name '/' session_name '/Part' num2str(part) '/'];
end
try
    wm          =params.wm;
    N_subfigures=params.N_subfigures;
    file_type   =params.file_type;
catch
    wm          =100;
    N_subfigures=  4;
    file_type   ='pdf';
end
files=dir([sourcedir '/*.' file_type]);
N_files=length(files);

s=sprintf('\\documentclass[english]{article}\n\\usepackage[T1]{fontenc}\n\\usepackage[latin9]{inputenc}\n\\usepackage{caption}\n\\usepackage{float}\n\\usepackage{graphicx}\n\\usepackage{babel}\n\\usepackage{subfigure}\n\\usepackage{epstopdf}\n\\usepackage{comment}\n\\begin{document}\n');
% parts_str='abcde';
% s=sprintf('%s\\section{Rat %s ratemaps}\n',s,Rat_name);
% s=sprintf('%s\\begin{itemize}\n',s);
% s=sprintf('%s\\item{Rat Name: %s}\n',s,Rat_name);
% s=sprintf('%s\\item{Session: %s}\n',s,session_name);
% s=sprintf('%s\\item{Part: %g}\n',s,part);
% s=sprintf('%s\\item{Session+part: %s%s}\n',s,session_name,parts_str(part));
% s=sprintf('%s\\item{Neurons: %g}\n',s,N_files);
% s=sprintf('%s\\end{itemize}\n\n',s);


% grop_ind=1:4;hg=[-10,-1,-10,-1];
%% loop 

N_figures=ceil(N_files/N_subfigures);

for n_f=1:N_figures
    group_ind=(1:N_subfigures)+(n_f-1)*N_subfigures;
    s=sprintf('%s\n\\begin{figure}\n\\begin{centering}\\vspace{-3em}\n',s);
    for i=group_ind
        if  mod(i-group_ind(1),2)
            hg=-1;
        else
            hg=-10;
        end
%         if  mod(i,2)
%             hg=-10;
%         else
%             hg=-1;
%         end
        s=sprintf('%s\\hspace*{%gem}\\subfigure[\\label{Fig:N%g}]{\\includegraphics[width=%gmm]{%s}}%%\n',s,hg,i,wm,[regexprep(files(i).folder,'\','/') '/' files(i).name(1:end-4)]);
        if  ~mod(i-group_ind(1),2)%mod(i,2)
            
        else
            s=sprintf('%s\n',s);
        end
        if i==N_files
            break;
        end
    end
    s=sprintf('%s\\par\\end{centering}\n\\caption{\\label{Fig:%g}}\n',s,n_f);
    s=sprintf('%s\\end{figure}\n\n',s);
end

%% close
s=sprintf('%s\\end{document}\n',s);

%% save tex file

nts=strsplit(source_dir,'/');
rem=[];
for i=1:length(nts)
    if strcmp(nts{i},'.') | strcmp(nts{i},'..') | isempty(nts{i})
        rem(end+1)=i;
    end
end
nts(rem)=[];
fn='';
for i=1:length(nts)
    fn=[fn nts{i}];
    if i<length(nts)
        fn=[fn '_'];
    end
end

% fn=sprintf('FIGURES_Rat%s_%s_Part%g.tex',Rat_name,session_name,part);
fn=sprintf('%s.tex',fn);

destination_dir=['/tmp/' num2str(randi(10^6,1,1)) '/'];
mkdir(destination_dir);

nf=sprintf('%s%s',destination_dir,fn);
fid = fopen(nf,'w');
fprintf('Compiling %s\n',nf)
fprintf(fid,'%s',s);
fclose(fid);

% return
%% compile to pdf
curdir=cd;
cd (destination_dir);
comm=['latexmk -pdf -shell-escape -synctex=1 ' fn];
fprintf('executing %s\n',comm);
system(comm);
cd(curdir);
fprintf('Created %s.pdf\n',nf(1:end-4));

fprintf('File ready in %s.pdf\n',[out_dir '/' fn(1:end-4)]);
outnf=[nf(1:end-4) '.pdf'];
copyfile([nf(1:end-4) '.pdf'],out_dir);


%  system(latexmk -pdf -shell-escape -synctex=1 FIGURES_pca_S+K_frequency20_[-200,400].tex');