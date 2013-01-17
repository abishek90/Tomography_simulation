% Add Edge modified.

% See if the path already exists.

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

if( abs(shortest_dist_ghat(node_a,node_b) - dist_1 - dist_2) < 0.01) % Path exists
    % Need to either find a hidden node or create a hidden node.
    hid_present = false;
    for i = 1:si
        if(( abs(shortest_dist_ghat(node_a,i) - dist_1) < 0.01) && ( abs(shortest_dist_ghat(node_b,i) - dist_2)<0.01 ))
            hid_present = true;
            hid_node = i;
        end
    end
    
    if ((hid_present == false) && (length(nodes_on_path)>0))
        % Split the path and introduce a hidden node
        node_1 = node_a; node_2 = node_b; get_nodes_on_path;
        
        nodes_on_path = fliplr(path_list);
        cum_dist = 0;
        s_node = node_b;
        count = 1;
        while ((cum_dist < dist_1) && (count <= length(nodes_on_path)))
            cum_dist = cum_dist + dist_mat_ghat(s_node,nodes_on_path(count));
            count = count+1;
            s_node = nodes_on_path(count-1);
        end
        
       
        if( length(nodes_on_path) >2)
        dist_mat_ghat(nodes_on_path(count-2),s_node) = 0;
        dist_mat_ghat(s_node,nodes_on_path(count-2)) = 0;
        
        hid_node = si+1;
        num_nodes_discovered = num_nodes_discovered + 1;
        
        dist_mat_ghat(node_a,hid_node) = dist_1;
        dist_mat_ghat(hid_node,node_a) = dist_1;
        
        dist_mat_ghat(node_b,hid_node) = dist_2;
        dist_mat_ghat(hid_node,node_b) = dist_2;
        end
        
    end
else
    % Create a path by searching to place nodes. node_a and node_b are in
    % two disconnected components.
    
    if ( sum(dist_mat_ghat(node_b,:)) < 0.01) % Node_b has no edges.
        % Search for placing node_b into node_a's components.
        
        if( sum(dist_mat_ghat(node_a,:)) < 0.01) % node_a has no edges
            hid_node = si+1;
            num_nodes_discovered = num_nodes_discovered + 1;
            dist_mat_ghat(node_a,hid_node) = dist_1;
            dist_mat_ghat(hid_node,node_a) = dist_1;
            
            dist_mat_ghat(node_b,hid_node) = dist_2;
            dist_mat_ghat(hid_node,node_b) = dist_2;
            
        else % Need to place node_b into node_a's components
            node_single = node_b; node_comp = node_a; place_node_component;
        end
        
    else % node_b has an edge
        if( sum(dist_mat_ghat(node_a,:)) < 0.01)
            node_single = node_a; node_comp = node_b; place_node_component;
        else
            % Need to merge two components.
            
            node_single = node_a; node_comp = node_b; place_node_component;
        end
    end
    
    
    
    
end