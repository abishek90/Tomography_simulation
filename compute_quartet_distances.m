
% Script to compute the quartet distances

dmid = shortest_dist(curr_quartet(1),curr_quartet(3)) + shortest_dist(curr_quartet(2),curr_quartet(4)) - shortest_dist(curr_quartet(1),curr_quartet(2)) - shortest_dist(curr_quartet(4),curr_quartet(3));
dmid = dmid/2;

B_vec_dis = [shortest_dist(curr_quartet(1),curr_quartet(3)) - dmid ; shortest_dist(curr_quartet(2),curr_quartet(4)) - dmid; shortest_dist(curr_quartet(1),curr_quartet(4)) - dmid;shortest_dist(curr_quartet(2),curr_quartet(3))-dmid;shortest_dist(curr_quartet(1),curr_quartet(2))];
A_mat_dis = [1 0 1 0;0 1 0 1;1 0 0 1;0 1 1 0;1 1 0 0];
x_vec = A_mat_dis\B_vec_dis ;