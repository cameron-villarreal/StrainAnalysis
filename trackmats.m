function [A_out,B_out,C_out] = trackmats(a,b,c,sortedcent)

%%Find Points corresponding to a,b,c at each timestep
%Where a, b, and c are points
%sorted cent is an n x 3 x t matrix
%A_out, B_out, C_out are the corresponding marker points through all time
%% Instantiate the variables that will be used during tracking
a_dist = double.empty;
b_dist = double.empty;
c_dist = double.empty;

a_min = double.empty;
b_min = double.empty;
c_min = double.empty;

A = double.empty;
B = double.empty;
C = double.empty;
a_in = a;
b_in = b;
c_in = c;
%% Assemble distance vectors
    for i = 1:length(sortedcent(1,1,:))
        if i ~= 1
                %Set a equal to the last found minimum value
                a = sortedcent(a_min(i-1),:,i-1);
                b = sortedcent(b_min(i-1),:,i-1);
                c = sortedcent(c_min(i-1),:,i-1);
        end
        for j = 1:length(sortedcent(:,1,1))
            %a_dist, b_dist, and c_dist are arrays comprised of the distance
            %from point p, q, and r respectively to all other points within
            %sorted cent for a particular time step
            
                a_dist(j) = norm(a-sortedcent(j,:,i));
                b_dist(j) = norm(b-sortedcent(j,:,i));
                c_dist(j) = norm(c-sortedcent(j,:,i));
                          
        end
        %Min vals arrays are all points of min distance calculated in above
        %for loop
                [~,I_a] = sort(a_dist);
                [~,I_b]= sort(b_dist);
                [~,I_c] = sort(c_dist);
                
               
                
                a_min(i) = I_a(1);
                b_min(i) = I_b(1);
                c_min(i) = I_c(1);
                
                 if I_a(1) == I_b(1)
                        a_min(i) = I_a(2);
                 end
                 if I_a(1) == I_c(1)
                            c_min(i) = I_c(2);
                 end
                 if I_b(1) == I_c(1)
                                b_min(i) = I_b(2);
                 end
                 
                   
        %Need to institute check to make sure the same point is not being
        %used for mulitple markers
        
    end  

    %% Find the points corresponding to the min distance points along sortedcent
       for k = 1:length(sortedcent(1,1,:))
           A(k,:) = sortedcent(a_min(k),:,k);
           B(k,:) = sortedcent(b_min(k),:,k);
           C(k,:) = sortedcent(c_min(k),:,k);
       end
       %remove extra term from front of matrix
        A_out = A(2:end,:);
        B_out = B(2:end,:);
        C_out = C(2:end,:);
        
        %set first term of matrix equal to inputs from matrices
        A_out(1,:) = a_in;
        B_out(1,:) = b_in;
        C_out(1,:) = c_in;
end


