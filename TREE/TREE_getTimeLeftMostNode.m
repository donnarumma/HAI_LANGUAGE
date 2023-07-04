function   leftmost_node = TREE_getTimeLeftMostNode(mtree,current_node)
% function leftmost_node = TREE_getTimeLeftMostNode(mtree,current_node)
if current_node==1
    leftmost_node=[];
else
    siblings=mtree.getsiblings(current_node);
    leftmost_node=siblings(siblings<current_node);

    if ~isempty(leftmost_node)
        leftmost_node = leftmost_node(end);
    else
        leftmost_node = TREE_getTimeLeftMostNode(mtree,mtree.Parent(current_node));
    end
end