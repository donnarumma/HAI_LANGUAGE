function   vtree=TREE_substitute(stree,values1,values2)
% function vtree=TREE_substitute(stree,values1,values2)
iterator=stree.depthfirstiterator;
vtree=stree;
for it=iterator
    val=vtree.get(it);
    ind = val==values1;
    vtree=vtree.set(it,values2(ind));
end