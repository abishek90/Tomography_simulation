% Script that returns the hidden node between node_a and node_b

node_1 = node_a;
node_2 = node_b;
get_nodes_on_path ;
nodes_on_path = fliplr(path_list);
[si temp] = size(dist_mat_ghat);
num_nodes_discovered = si;

% Quick Correction hack

for i = 1:si
    dist_mat_ghat(i,i) = 0;
end

cum_dist = 0;
s_node = node_a;
count = 1;
while (((-cum_dist + dist_1 ) > 0.01) && (count <= length(nodes_on_path)))
    cum_dist = cum_dist + dist_mat_ghat(s_node,nodes_on_path(count));
    count = count+1;
    s_node = nodes_on_path(count-1);
end
if(length(nodes_on_path) == 0)
    hid_node = si+1;
    num_nodes_discovered = num_nodes_discovered + 1;
    
    dist_mat_ghat(node_1,hid_node) = dist_1;
    dist_mat_ghat(hid_node,node_1) = dist_1;
    
    dist_mat_ghat(node_2,hid_node) = dist_2;
    dist_mat_ghat(hid_node,node_2) = dist_2;
    

elseif( abs(cum_dist - dist_1) > 0.01) % Need to create a new hidden node
    % Introduce hidden node between nodes_on_path(count-2) and s_node
    pd = cum_dist - dist_mat_ghat(nodes_on_path(count-2),s_node);
    dist_mat_ghat(nodes_on_path(count-2),s_node) = 0;
    dist_mat_ghat(s_node,nodes_on_path(count-2)) = 0;
    
    hid_node = si+1;
    num_nodes_discovered = num_nodes_discovered + 1;
    
    dist_mat_ghat(nodes_on_path(count-2),hid_node) = dist_1 - pd;
    dist_mat_ghat(hid_node,nodes_on_path(count-2)) = dist_1 - pd;
    
    dist_mat_ghat(s_node,hid_node) = cum_dist - dist_1;
    dist_mat_ghat(hid_node,s_node) = cum_dist - dist_1;
    
else % s_node is the hidden nde
    hid_node = s_node;
end