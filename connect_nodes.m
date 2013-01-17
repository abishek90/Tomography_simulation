% Connect nodes node_a with node_b with distance dist with the other side
% node index in other_side_node

done = false;
if(sum(dist_mat_ghat(node_b,:))>0.01)
    [si temp] = size(dist_mat_ghat);
    for i = 1:si
        if((dist_mat_ghat(node_b,i) > 0.01) && (dist_mat_ghat(node_a,i) < 0.01) )
            dtemp1 = dist - dist_mat_ghat(node_b,i);
            dtemp2 = dist_mat_ghat(i,other_side_node(1));
            dtemp3 = dist_mat_ghat(i,other_side_node(2));
            
            if ((dtemp1 > 0.1) && ((dtemp1 + dtemp2 - x_vec(1) - dmid - x_vec(3)) < 0.01 ) && ((dtemp1 + dtemp3 - x_vec(1) - dmid - x_vec(4)) < 0.01 ))
                dist_mat_ghat(node_a,i) = dtemp1;
                dist_mat_ghat(i,node_1) = dtemp1;
                done = true;
            end
            
        end
    end
end
if ( (sum(dist_mat_ghat(node_a,:))>0.01) && (done == false))
        [si temp] = size(dist_mat_ghat);
    for i = 1:si
        if((dist_mat_ghat(node_a,i) > 0.01) && (dist_mat_ghat(node_b,i) < 0.01) )
            dtemp1 = dist - dist_mat_ghat(node_a,i);
            dtemp2 = dist_mat_ghat(i,other_side_node(1));
            dtemp3 = dist_mat_ghat(i,other_side_node(2));
            
            if ((dtemp1 > 0.1) && ((dtemp1 + dtemp2 - x_vec(1) - dmid - x_vec(3)) < 0.01 ) && ((dtemp1 + dtemp3 - x_vec(1) - dmid - x_vec(4)) < 0.01 ))
                dist_mat_ghat(node_a,i) = dtemp1;
                dist_mat_ghat(i,node_1) = dtemp1;
                done = true;
            end
            
        end
    end
else
end