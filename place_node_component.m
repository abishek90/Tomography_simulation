% Script to place a single node into a component.
% Input - node_single and node_comp.

% shortest_dist matrix is known ( the measurement matrix)
shortest_dist_ghat = dist_mat_ghat ;
[si temp] = size(dist_mat_ghat);
num_nodes_discovered = si;
shortest_dist_ghat = (shortest_dist_ghat==0)*infinity + shortest_dist_ghat ;
for i = 1:si
    shortest_dist_ghat(i,i) = 0;
end

for k = 1:si
    for i = 1:si
        for j = 1:si 
            if(shortest_dist_ghat(i,j) > shortest_dist_ghat(i,k) + shortest_dist_ghat(k,j) )
                shortest_dist_ghat(i,j) = shortest_dist_ghat(i,k) + shortest_dist_ghat(k,j);
            end
        end
    end
end

min_value = infinity;
min_node = -1;

for i = 1:num_participants
    if( (i == node_comp) || (i == node_single))
        continue;
    end
    if( (shortest_dist_ghat(node_comp,i) < 2*N))
    dtemp = (dist_1 + dist_2 - shortest_dist_ghat(node_comp,i) + shortest_dist(node_single,i))*0.5;
    if( dtemp < min_value)
        min_value = dtemp; 
        min_node = i;
    end
    end
end

if(min_node ~= -1)
    node_1 = node_comp; node_2 = min_node; get_nodes_on_path;
    nodes_on_path = fliplr(path_list);
    
    cum_dist = 0;
    s_node = node_comp;
    count = 1;
    while (((-cum_dist + (dist_1 + dist_2 - min_value))>0.01) && (count <= length(nodes_on_path)))
         cum_dist = cum_dist + dist_mat_ghat(s_node,nodes_on_path(count));
         count = count+1;
         s_node = nodes_on_path(count-1);
    end
    
    if(count == 1)
%         hid_node = num_nodes_discovered+1;
%         num_nodes_discovered = num_nodes_discovered + 1;
%         dist_mat_ghat(node_single,hid_node) = dist_2;
%         dist_mat_ghat(hid_node,node_single) = dist_2;
%         dist_mat_ghat(node_comp,hid_node) = dist_1;
%         dist_mat_ghat(hid_node,node_comp) = dist_1;
            bad_quartet = [bad_quartet; curr_quartet];
    
    
    
    elseif(abs(cum_dist - dist_1 - dist_2 + min_value) > 0.01)
        
        pd = cum_dist - dist_mat_ghat(s_node,nodes_on_path(count-2));
        if ( min_value>0.01)
        dist_mat_ghat(s_node,nodes_on_path(count-2)) = 0;
        dist_mat_ghat(nodes_on_path(count-2),s_node) = 0;
        num_nodes_discovered = num_nodes_discovered + 1;
        hid_node = si+1;
        dist_mat_ghat(nodes_on_path(count-2),hid_node) = dist_1 + dist_2 - min_value - pd;
        dist_mat_ghat(hid_node,nodes_on_path(count-2)) = dist_1 + dist_2 - min_value - pd;
        
        dist_mat_ghat(s_node,hid_node) = cum_dist - dist_1 - dist_2 + min_value;
        dist_mat_ghat(hid_node,s_node) = cum_dist - dist_1 - dist_2 + min_value;
        
        
        
        dist_mat_ghat(node_single,hid_node) = min_value;
        dist_mat_ghat(hid_node,node_single) = min_value;
        else
            dist_mat_ghat(nodes_on_path(count-2),node_single) = dist_1 + dist_2 - pd;
            dist_mat_ghat(node_single,nodes_on_path(count-2)) = dist_1 + dist_2 - pd;
            
            dist_mat_ghat(s_node,node_single) = cum_dist - dist_1 - dist_2;
            dist_mat_ghat(node_single,s_node) = cum_dist - dist_1 - dist_2;
            
            dist_mat_ghat(s_node,nodes_on_path(count-2)) = 0;
            dist_mat_ghat(nodes_on_path(count-2),s_node) = 0;
        end
        
    else % No need of hidden node
        dist_mat_ghat(node_single,s_node) = min_value;
        dist_mat_ghat(s_node,node_single) = min_value;
    end
else % node_comp has no edge connected to any other node. This event doesnot occur
    
end
    