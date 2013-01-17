% The Main Program file. 

% System parameters - 
% N = 25;
% p = 1.5/N;
% num_participants = 16;
% infinity = N^3 ;
%__________________________________________________________________________

% Toy Tree System

tree_depth = 4;
q_ary = 2;
N = (q_ary^(tree_depth+1) -1)/(q_ary - 1) ;
tree_build ;
num_participants = q_ary^tree_depth;
infinity = N^3 ;
% End Toy Tree System.

% adj_mat = zeros(N,N);
% 
%  for i = 1:N
%      for j = i+1:N
%          temp = rand(1);
%          if (temp<=p)
%              adj_mat(i,j) = 1;
%              adj_mat(j,i) = 1;
%          end
%      end
%  end
%    
% The participating nodes are 1 - n. The unknown hidden nodes are n+1 to N.
% custom_adj_mat; 
shortest_dist = adj_mat ;
fprintf('Matrix Constructed\n');

shortest_dist = (shortest_dist==0)*(N^2) + shortest_dist ;
for i = 1:N
    shortest_dist(i,i) = 0;
end

for k = 1:N
    for i = 1:N
        for j = 1:N 
            if(shortest_dist(i,j) > shortest_dist(i,k) + shortest_dist(k,j) )
                shortest_dist(i,j) = shortest_dist(i,k) + shortest_dist(k,j);
            end
        end
    end
end

fprintf('Shortest Distance Matrix Computed\n');
shortest_dist = shortest_dist(1:num_participants,1:num_participants);

% The set of quartets.
 quartet_set = zeros(1,4);
 
comb_matrix = combnk(1:num_participants,4);

[len_comb_mat temp] = size(comb_matrix);

fprintf('starting to build the quartets\n');

for i = 1:len_comb_mat
    
    vec_index = comb_matrix(i,:);
    % The first arrangement
    check1 = shortest_dist(vec_index(1),vec_index(3)) + shortest_dist(vec_index(2),vec_index(4)) ;
    check2 = shortest_dist(vec_index(1),vec_index(4)) + shortest_dist(vec_index(2),vec_index(3)) ;
    if ((check1 == check2) && (check1 < N^2) && (check2 < N^2))
        quartet_set = [quartet_set; vec_index(1) vec_index(2) vec_index(3) vec_index(4)];
    end
    
    % The second arrangement
    check1 = shortest_dist(vec_index(1),vec_index(2)) + shortest_dist(vec_index(3),vec_index(4)) ;
    check2 = shortest_dist(vec_index(1),vec_index(4)) + shortest_dist(vec_index(2),vec_index(3));
    if ((check1 == check2) && (check1 < N^2) && (check2<N^2))
        quartet_set = [quartet_set; vec_index(1) vec_index(3) vec_index(2) vec_index(4)];
    end
    
    % The third arrangement
    check1 = shortest_dist(vec_index(1),vec_index(3)) + shortest_dist(vec_index(2),vec_index(4)) ;
    check2 = shortest_dist(vec_index(1),vec_index(2)) + shortest_dist(vec_index(4),vec_index(3));
    if ((check1 == check2) && (check1 < N^2) && (check2 < N^2))
        quartet_set = [quartet_set; vec_index(1) vec_index(4) vec_index(3) vec_index(2)];
    end    
      
    
end
 quartet_set = quartet_set(2:end,:);
 
 fprintf('starting merging\n');
 % The merging process
 
 bad_quartet = [0 0 0 0];
 
 [num_quartets temp] = size(quartet_set); 
 dist_mat_ghat = zeros(num_participants,num_participants);
 for i = 1:num_participants
     dist_mat_ghat(i,i) = 0;
 end
 num_nodes_discovered = num_participants ;
 if( size(quartet_set) ~= 0)
     for quarts = 1:num_quartets
     curr_quartet = quartet_set(quarts,:);
     
     
     compute_quartet_distances ; % Script to compute the internal distances in the quartet by solving the linear equations.
     if(sum(x_vec < -0.01) ~=0) 
         continue; 
     end
     merge_curr_quartet_edge; % Script to merge current quartet edge by edge(Tree Merge Conditions need to be checked)
     [size(dist_mat_ghat) quarts num_quartets]
     end
 end
 
 
 
