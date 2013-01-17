% Construct a binary tree upto arbitrary lengths and output the adjacency
% matrix.

% tree_depth = 5;
% q_ary = 3;

num_of_nodes = (q_ary^(tree_depth+1) -1)/(q_ary - 1) ;
adj_mat = zeros(num_of_nodes,num_of_nodes);

vertex_count = 1;
prev_count = 0;

for depth = 1:tree_depth
    
    for par = 1: q_ary^(tree_depth-depth)
        for leaf = 1:q_ary
            adj_mat(vertex_count, q_ary^(tree_depth-depth+1) + prev_count + par) = 1;
            adj_mat(q_ary^(tree_depth-depth+1) + prev_count + par,vertex_count) = 1;
            vertex_count = vertex_count+1;
        end
    end
    prev_count = vertex_count-1;
end

% draw_graph(adj_mat);