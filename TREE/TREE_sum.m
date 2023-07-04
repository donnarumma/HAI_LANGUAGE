function val=TREE_sum(mtree)
% function val=TREE_sum(mtree)
diterator=mtree.depthfirstiterator;
val = 0;
for it=1:length(diterator)
    value = mtree.get(diterator(it));
    if ~ischar(value)
        val=val+value;
    end
end