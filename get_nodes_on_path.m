% Get nodes in the path from node_1 to node_2.

% BFS Algorithm to find the shortest path.

[si temp] = size(dist_mat_ghat);
parent = node_1 ;
queue = [parent];
marked = zeros(1,si); marked(parent) = 1;
parent = zeros(1,si); 
has_path = false;
path_list = [];

%Regularize dist_mat_ghat


while (size(queue) > 0)
    t_node = queue(1);
    queue = queue(2:end);
    
    if(t_node == node_2)
        has_path = true;
        break ;
        
    end
    
    for i = 1:si
        if((dist_mat_ghat(t_node,i)>0.01) && (marked(i) == 0) )
            marked(i) = 1;
            parent(i) = t_node;
            queue = [queue i];
        end
    end
    
    
end
if(has_path == true)
    path_list = [node_2];
    c_node = node_2;
    while (c_node ~= node_1 )
        path_list = [path_list parent(c_node)];
        c_node = parent(c_node);
    end
end

% Need to manage the list when the paths do not exist. The previous
% path_list is being used. Need to redfeine it.