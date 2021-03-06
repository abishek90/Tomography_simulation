
% Script to merge current quartet. (Tree Merge)

if ( ((x_vec(1) == 0) || (x_vec(2) == 0)) && ((x_vec(3) == 0) || (x_vec(4) == 0)))
    % No new hidden nodes to be added
    hidden_1 = -1;
    hidden_2 = -1;
    dist_mat_ghat(curr_quartet(1),curr_quartet(2)) = max(x_vec(1),x_vec(2));
    dist_mat_ghat(curr_quartet(2),curr_quartet(1)) = max(x_vec(1),x_vec(2));
    
    dist_mat_ghat(curr_quartet(3),curr_quartet(4)) = max(x_vec(3),x_vec(4));
    dist_mat_ghat(curr_quartet(4),curr_quartet(3)) = max(x_vec(4),x_vec(3));
    
    % The bridge connection
    if(x_vec(1)==0) lnode = curr_quartet(1); else lnode = curr_quartet(2); end
    
    if(x_vec(3)==0) rnode = curr_quartet(3); else rnode = curr_quartet(4); end
    
    dist_mat_ghat(lnode,rnode) = dmid;
    dist_mat_ghat(rnode,lnode) = dmid;
    
elseif ((x_vec(1) == 0) || (x_vec(2)==0))
    % Only hidden node 2 is added.
    hidden_1 = -1;
    dist_mat_ghat(curr_quartet(1),curr_quartet(2)) = max(x_vec(1),x_vec(2));
    dist_mat_ghat(curr_quartet(2),curr_quartet(1)) = max(x_vec(1),x_vec(2));
    
    if(check_hidden_node_present(dist_mat_ghat,x_vec,curr_quartet,2))
        hidden_2 = num_nodes_discovered+1;
        num_nodes_discovered = num_nodes_discovered + 1;
        dist_mat_ghat(curr_quartet(3),hidden_2) = x_vec(3); 
        dist_mat_ghat(hidden_2,curr_quartet(3)) = x_vec(3);
    
        dist_mat_ghat(curr_quartet(4),hidden_2) = x_vec(4);
        dist_mat_ghat(hidden_2,curr_quartet(4)) = x_vec(4);
    end
    if(x_vec(1)==0) lnode = curr_quartet(1); else lnode = curr_quartet(2); end
    
    dist_mat_ghat(lnode,hidden_2) = dmid;
    dist_mat_ghat(hidden_2,lnode) = dmid;
    
elseif ( (x_vec(3)==0) || (x_vec(4)==0) )
    % Only hidden node 1 is present
    hidden_2 = -1;
    dist_mat_ghat(curr_quartet(3),curr_quartet(4)) = max(x_vec(3),x_vec(4));
    dist_mat_ghat(curr_quartet(4),curr_quartet(3)) = max(x_vec(3),x_vec(4));
    
    hidden_1 = num_nodes_discovered+1;
    num_nodes_discovered = num_nodes_discovered + 1;
    dist_mat_ghat(curr_quartet(1),hidden_1) = x_vec(1); 
    dist_mat_ghat(hidden_1,curr_quartet(1)) = x_vec(1);
    
    dist_mat_ghat(curr_quartet(2),hidden_1) = x_vec(2);
    dist_mat_ghat(hidden_1,curr_quartet(2)) = x_vec(2);
    
    if(x_vec(3)==0) rnode = curr_quartet(3); else rnode = curr_quartet(4); end
    
    dist_mat_ghat(rnode,hidden_1) = dmid;
    dist_mat_ghat(hidden_1,rnode) = dmid;    
    
    
else
    % Both hidden nodes are present
    
    hidden_1 = num_nodes_discovered+1;
    hidden_2 = num_nodes_discovered+2;
    num_nodes_discovered = num_nodes_discovered + 2;
    
    dist_mat_ghat(curr_quartet(1),hidden_1) = x_vec(1);
    dist_mat_ghat()
    
end
