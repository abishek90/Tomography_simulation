% Adds an edge between node_a and node_b. hid_node is the returned hidden
% Script run only when the edge distances are non - zero

if (abs(dist_mat_ghat(node_a,node_b) -( dist_1+ dist_2)) < 0.01) % If the path exists, then we only need to split it.
    hidden_flag = false;
    [si temp] = size(dist_mat_ghat);
    num_nodes_discovered = si;
    for i = 1:si
        dtemp = dist_mat_ghat(node_a,i);
        if( ((dtemp - dist_1)<0.01) && ((dist_mat_ghat(i,node_b)-dist_2))<0.01 )
            hidden_flag = true;
            hid_node = i; % No more work needs to be done for  this edge.            
        end
    end
    if (hidden_flag == false)
        hid_node = num_nodes_discovered + 1;
        num_nodes_discovered = num_nodes_discovered + 1;
        
        for i = 1:num_nodes_discovered
            dist_mat_ghat(num_nodes_discovered,i) = 0;
            dist_mat_ghat(i,num_nodes_discovered) = 0;
        end
        
        dist_mat_ghat(node_a,hid_node) = dist_1;
        dist_mat_ghat(hid_node,node_a) = dist_1;
        
        dist_mat_ghat(node_b,hid_node) = dist_2;
        dist_mat_ghat(hid_node, node_b) = dist_2 ;
    end
else %Need to search for paths from node_b to other places.
    
    min_found_flag = false;
    min_val = infinity;
    min_node = -1;
    
    for i = 1:num_participants
        value = (dist_1 + dist_2 + dist_mat_ghat(node_a,i) - dist_mat_ghat(node_b,i))*0.5 ;
        if (value < min_val)
            min_found_flag = true;
            min_val = value;
            min_node = i;
            min_rem_len = shortest_dist(node_a,i) - value;
        end
        
    end
    if (sum(dist_mat_ghat(node_b,:)) > 0.01)
        
        dist_mat_ghat(node_b,i) = 0;
        dist_mat_ghat(i,node_b) = 0;
        
        % Need to Check if a new hidden node must be introduced.
        
        hid_present = false;
        for i = 1:num_nodes_discovered
            if((abs(dist_mat_ghat(node_b,i) - dist_2)<0.01) && (abs(dist_mat_ghat(i,min_node) - min_rem_len)<0.01))
                hid_present = true;
                hidden_node = i;
                hid_node = hidden_node;
            end
        end
        if(hid_present == false)
            hidden_node = num_nodes_discovered + 1;
            hid_node = hidden_node;
            num_nodes_discovered = num_nodes_discovered + 1;
            dist_mat_ghat(node_b,hidden_node) = dist_2;
            dist_mat_ghat(hidden_node,node_b) = dist_2;
        end
        
        dist_mat_ghat(node_a,hidden_node) = min_val;
        dist_mat_ghat(hidden_node,node_a) = min_val;
    else % This is if node_b is disconnected
        hidden_node = num_nodes_discovered + 1;
        num_nodes_discovered = num_nodes_discovered + 1;
        dist_mat_ghat(node_a,hidden_node) = dist_1;
        dist_mat_ghat(hidden_node,node_a) = dist_1;
        dist_mat_ghat(node_b,hidden_node) = dist_2;
        dist_mat_ghat(hidden_node,node_b) = dist_2;
        hid_node = hidden_node ;
    end
    
        
end