
% Script to merge quartets edge by edge

% x_vec and curr_quartets are input and dist_mat_ghat.

% dist_mat_ghat is the adjacency matrix of ghat.

% Compute distances in ghat

shortest_dist_ghat = dist_mat_ghat ;
[si temp] = size(dist_mat_ghat);
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


if ((abs(shortest_dist_ghat(curr_quartet(1),curr_quartet(2)) - x_vec(1) - x_vec(2))>0.01) || (abs(shortest_dist_ghat(curr_quartet(1),curr_quartet(3)) - x_vec(1) - dmid - x_vec(3))>0.01) || (abs(shortest_dist_ghat(curr_quartet(1),curr_quartet(4)) - x_vec(1) - dmid - x_vec(4))>0.01) || (abs(shortest_dist_ghat(curr_quartet(2),curr_quartet(3)) - x_vec(2) - dmid - x_vec(3))>0.01) || (abs(shortest_dist_ghat(curr_quartet(2),curr_quartet(4)) - x_vec(2) -dmid - x_vec(4))>0.01) || (abs(shortest_dist_ghat(curr_quartet(3),curr_quartet(4)) - x_vec(3) - x_vec(4))>0.01))  

%__________________________________________________________________________

if ( abs(dmid)>0.01)
hid_reqd = true;
node_a = curr_quartet(1);
node_b = curr_quartet(2);
dist_1 = abs(x_vec(1));
dist_2 = abs(x_vec(2));
if ((dist_1 > 0.01) && (dist_2 > 0.01) ) 
    add_edge_new ;
    % Need a seperate script to find the actual quartet hidden node
    get_quartet_hidden_node ;
    hidden_left = hid_node;
elseif( (dist_1 < 0.001) && (dist_2 > 0.01) )
    
    hidden_left = node_a;
    % Connect node_a and node_b with distance dist_2 by path splitting.
    if ( (abs(shortest_dist_ghat(node_a,node_b) - dist_2) > 0.01)  )
    node_1 = node_b; node_2 = curr_quartet(3);
    get_nodes_on_path;
    if(has_path == false)
        node_1 = node_b; node_2 = curr_quartet(4);
        get_nodes_on_path;       
    end
    if(has_path == true)
        hid_reqd = false;
        nodes_on_path = fliplr(path_list);
        cum_dist = 0;
        s_node = node_b; 
        count = 1;
        while (((-cum_dist + dist_2)>0.01) && (count <= length(nodes_on_path)))
            cum_dist = cum_dist + dist_mat_ghat(s_node,nodes_on_path(count));
            count = count+1;
            s_node = nodes_on_path(count-1);
        end
        if(abs(cum_dist - dist_2)>0.01)
        % Need to split the path between s_node and nodes_on_path(count-2)
        prev_dist = cum_dist - dist_mat_ghat(s_node,nodes_on_path(count-2));
        dist_mat_ghat(s_node,nodes_on_path(count-2)) = 0;
        dist_mat_ghat(nodes_on_path(count-2),s_node) = 0;
        
        dist_mat_ghat(nodes_on_path(count-2),node_a) = dist_2 - prev_dist;
        dist_mat_ghat(node_a,nodes_on_path(count-2)) = dist_2 - prev_dist;
        
        dist_mat_ghat(s_node,node_a) = cum_dist - dist_2;
        dist_mat_ghat(node_a,s_node) = cum_dist - dist_2;       
        end
    end
    
    if (has_path == false)
        
         if( (sum(abs(dist_mat_ghat(node_a,:))) < 0.01)   && (sum(abs(dist_mat_ghat(node_b,:)))<0.01))
        
      dist_mat_ghat(node_a,node_b ) = dist_2;
      dist_mat_ghat(node_b,node_a) = dist_2;   
      hidden_left = node_a;
      hid_reqd = true;
      elseif ((sum(abs(dist_mat_ghat(node_a,:))) < 0.01)   && (sum(abs(dist_mat_ghat(node_b,:)))>0.01))
            node_single = node_a; node_comp = node_b; place_node_component;
        else
            node_single = node_b; node_comp = node_a; place_node_component;
        end
    end
    end

elseif ( (dist_1 > 0.01) && (dist_2 < 0.001))
    
    hidden_left = node_b;
    % Connect node_a and node_b with distance dist_1 by path splitting.
    if( (abs(shortest_dist_ghat(node_a,node_b) - dist_1) > 0.01) )
    node_1 = node_a; node_2 = curr_quartet(3); 
    get_nodes_on_path;
    if(has_path == false)
        node_1 = node_a; node_2 = curr_quartet(4);
        get_nodes_on_path;       
    end
    if(has_path == true)
        hid_reqd = false ;
        nodes_on_path = fliplr(path_list);
        cum_dist = 0;
        s_node = node_b;
        count = 1;
        while (((-cum_dist + dist_1)>0.01) && (count <= length(nodes_on_path)) )
            cum_dist = cum_dist + dist_mat_ghat(s_node,nodes_on_path(count));
            count = count+1;
            s_node = nodes_on_path(count-1);
        end
        if(abs(cum_dist - dist_1) > 0.01)
        % Need to split the path between s_node and nodes_on_path(count-2)
        prev_dist = cum_dist - dist_mat_ghat(s_node,nodes_on_path(count-2));
        dist_mat_ghat(s_node,nodes_on_path(count-2)) = 0;
        dist_mat_ghat(nodes_on_path(count-2),s_node) = 0;
        
        dist_mat_ghat(nodes_on_path(count-2),node_b) = dist_1 - prev_dist;
        dist_mat_ghat(node_b,nodes_on_path(count-2)) = dist_1 - prev_dist;
        
        dist_mat_ghat(s_node,node_b) = cum_dist - dist_1;
        dist_mat_ghat(node_b,s_node) = cum_dist - dist_1;       
        end
    end
    
    if (has_path == false)
        
        if( (sum(abs(dist_mat_ghat(node_a,:))) < 0.01)   && (sum(abs(dist_mat_ghat(node_b,:)))<0.01))
        
        
      dist_mat_ghat(node_a,node_b ) = dist_1;
      dist_mat_ghat(node_b,node_a) = dist_1; 
      hidden_left = node_b;
      hid_reqd = true;
        elseif ((sum(abs(dist_mat_ghat(node_a,:))) < 0.01)   && (sum(abs(dist_mat_ghat(node_b,:)))>0.01))
            node_single = node_a; node_comp = node_b; place_node_component;
        else
            node_single = node_b; node_comp = node_a; place_node_component;
        end
        
    end
    end


    
    
end





node_a = curr_quartet(3);
node_b = curr_quartet(4);
dist_1 = abs(x_vec(3));
dist_2 = abs(x_vec(4));



if ((dist_1 > 0.01) && (dist_2 > 0.01) ) 
    add_edge_new ;
    % Need a seperate script to find the quartet hidden node.
    get_quartet_hidden_node;
    hidden_right = hid_node;
elseif( (dist_1 < 0.001) && (dist_2 > 0.01) )
    hidden_right = node_a;
    if( (abs(shortest_dist_ghat(node_a,node_b) - dist_2) > 0.01)  )
    % Connect node_a and node_b with distance dist_2 by path splitting.
    node_1 = node_b; node_2 = curr_quartet(1);
    get_nodes_on_path;
    if(has_path == false)
        node_1 = node_b; node_2 = curr_quartet(2);
        get_nodes_on_path;       
    end
    if(has_path == true)
        hid_reqd = false;
        nodes_on_path = fliplr(path_list);
        cum_dist = 0;
        s_node = node_b;
        count = 1;
        while (((-cum_dist + dist_2)>0.01) && (count <= length(nodes_on_path)))
            cum_dist = cum_dist + dist_mat_ghat(s_node,nodes_on_path(count));
            count = count+1;
            s_node = nodes_on_path(count-1);
        end
        if ( abs(cum_dist - dist_2) > 0.01) 
        % Need to split the path between s_node and nodes_on_path(count-2)
        prev_dist = cum_dist - dist_mat_ghat(s_node,nodes_on_path(count-2));
        dist_mat_ghat(s_node,nodes_on_path(count-2)) = 0;
        dist_mat_ghat(nodes_on_path(count-2),s_node) = 0;
        
        dist_mat_ghat(nodes_on_path(count-2),node_a) = dist_2 - prev_dist;
        dist_mat_ghat(node_a,nodes_on_path(count-2)) = dist_2 - prev_dist;
        
        dist_mat_ghat(s_node,node_a) = cum_dist - dist_2;
        dist_mat_ghat(node_a,s_node) = cum_dist - dist_2;       
        end
    end
    
    if (has_path == false)
        
                if( (sum(abs(dist_mat_ghat(node_a,:))) < 0.01)   && (sum(abs(dist_mat_ghat(node_b,:)))<0.01))

      dist_mat_ghat(node_a,node_b ) = dist_2;
      dist_mat_ghat(node_b,node_a) = dist_2;  
      hid_reqd = true;
      hidden_right = node_a;
      
      elseif ((sum(abs(dist_mat_ghat(node_a,:))) < 0.01)   && (sum(abs(dist_mat_ghat(node_b,:)))>0.01))
            node_single = node_a; node_comp = node_b; place_node_component;
        else
            node_single = node_b; node_comp = node_a; place_node_component;
        end
      
    end
    end

elseif ( (dist_1 > 0.01) && (dist_2 < 0.001))

    
    hidden_right = node_b;
    % Connect node_a and node_b with distance dist_2 by path splitting.
    if( (abs(shortest_dist_ghat(node_a,node_b) - dist_1) > 0.01) )
    node_1 = node_a; node_2 = curr_quartet(1); 
    get_nodes_on_path;
    if(has_path == false)
        node_1 = node_a; node_2 = curr_quartet(2);
        get_nodes_on_path;       
    end
    if(has_path == true)
        hid_reqd = false;
        nodes_on_path = fliplr(path_list);
        cum_dist = 0;
        s_node = node_a; %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        count = 1;
        while (((-cum_dist + dist_1)>0.01) && (count<= length(nodes_on_path)))
            cum_dist = cum_dist + dist_mat_ghat(s_node,nodes_on_path(count));
            count = count+1;
            s_node = nodes_on_path(count-1);
        end
        if ( abs(cum_dist - dist_1) > 0.01)
        % Need to split the path between s_node and nodes_on_path(count-2)
        prev_dist = cum_dist - dist_mat_ghat(s_node,nodes_on_path(count-2));
        dist_mat_ghat(s_node,nodes_on_path(count-2)) = 0;
        dist_mat_ghat(nodes_on_path(count-2),s_node) = 0;
        
        dist_mat_ghat(nodes_on_path(count-2),node_b) = dist_1 - prev_dist;
        dist_mat_ghat(node_b,nodes_on_path(count-2)) = dist_1 - prev_dist;
        
        dist_mat_ghat(s_node,node_b) = cum_dist - dist_1;
        dist_mat_ghat(node_b,s_node) = cum_dist - dist_1;   
        end
        
    end
    
    if (has_path == false)
        
                if( (sum(abs(dist_mat_ghat(node_a,:))) < 0.01)   && (sum(abs(dist_mat_ghat(node_b,:)))<0.01))

      dist_mat_ghat(node_a,node_b ) = dist_1;
      dist_mat_ghat(node_b,node_a) = dist_1; 
      hidden_right = node_b;
      hid_reqd = true;
      
        elseif ((sum(abs(dist_mat_ghat(node_a,:))) < 0.01)   && (sum(abs(dist_mat_ghat(node_b,:)))>0.01))
            node_single = node_a; node_comp = node_b; place_node_component;
        else
            node_single = node_b; node_comp = node_a; place_node_component;
        end
    end
    end


    
    
end

shortest_dist_ghat = dist_mat_ghat ;
[si temp] = size(dist_mat_ghat);
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


if ( (hid_reqd == true) && (abs(dmid) > 0.01) && (abs(shortest_dist_ghat(hidden_left,hidden_right) - dmid) > 0.01) && (abs(dmid) > 0.01) ) % Modify to connect only if the hidden nodes are disconnected
   dist_mat_ghat(hidden_left,hidden_right) = dmid;
   dist_mat_ghat(hidden_right,hidden_left) = dmid;

end

else
    % There is only one hidden node.
    
    % If all nodes are disconnected,
    
    if ((sum(abs(dist_mat_ghat(curr_quartet(1),:))) < 0.01) && (sum(abs(dist_mat_ghat(curr_quartet(2),:))) < 0.01) && (sum(abs(dist_mat_ghat(curr_quartet(3),:))) < 0.01) && (sum(abs(dist_mat_ghat(curr_quartet(4),:))) < 0.01) )
        hid_node = si+1;
        num_nodes_discovered = num_nodes_discovered + 1;
        dist_mat_ghat(curr_quartet(1),hid_node) = x_vec(1);
        dist_mat_ghat(hid_node,curr_quartet(1)) = x_vec(1);
        
        dist_mat_ghat(curr_quartet(2),hid_node) = x_vec(2);
        dist_mat_ghat(hid_node,curr_quartet(2)) = x_vec(2);
        
        dist_mat_ghat(curr_quartet(3),hid_node) = x_vec(3);
        dist_mat_ghat(hid_node,curr_quartet(3)) = x_vec(3);
        
        
        dist_mat_ghat(curr_quartet(4),hid_node) = x_vec(4);
        dist_mat_ghat(hid_node,curr_quartet(4)) = x_vec(4);
    else % Some paths exist, some do-not
        
        
    end
        
    
    
end
end


