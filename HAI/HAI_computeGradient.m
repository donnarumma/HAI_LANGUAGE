function   x=HAI_computeGradient(z)
% function x=HAI_computeGradient(z)
x=cell(size(z));
for it=size(z)
    for iz1=1:size(z{it},1)
        for iz2=1:size(z{it},2)
            x{it}{iz1,iz2}=gradient(z{it}{iz1,iz2});
        end
    end
end