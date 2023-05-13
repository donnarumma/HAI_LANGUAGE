function   s=DICTIONARY_classprint(CLASSES)
% function s=DICTIONARY_classprint(CLASSES)

NUM_CLASSES=length(CLASSES);
s=sprintf('CLASSES=cell(1,%g);\n',NUM_CLASSES);
for il=1:length(CLASSES)
    CLASS=CLASSES{il};
    LEN_C=length(CLASS);
    if ~LEN_C
        ctxt=sprintf('CLASSES{%g} =[];\n',il);
        s=sprintf('%s%s',s,ctxt);
    else
        for ic=1:LEN_C
            ctxt=sprintf('CLASSES{%g}{%g} =[',il,ic);
            SUBCLASS=CLASS{ic};
            for is=1:length(SUBCLASS)
                ctxt=sprintf('%s%g,',ctxt,SUBCLASS(is));
            end
            ctxt = sprintf('%s];\n',ctxt(1:end-1));
            s=sprintf('%s%s',s,ctxt);
            if ic<LEN_C
                % ctxt=sprintf('CLASSES{%g}{%g} =[',il,ic+1);
            end
        end
    end
end
s=sprintf('%sDICTIONARY.CLASSES=CLASSES;\n;',s);
return