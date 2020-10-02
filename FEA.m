function [u] = FEA(A, E, L, f, NN)
%FEA Summary of this function goes here

% Check for odd number of nodes

if mod(NN,2) == 0
    error('Please enter an odd number for NN');
end
    

% Initialize global stiffness matrix and force vector
K = zeros(NN,NN);
F = zeros(NN, 1);

NE = NN - 1;

% Le = L / NE;

Ke1 = ((A * E) / L) * [1, -1; -1,  1];
Ke2 = ((A * E) / L) * [2, -2; -2,  2];

Fe1 = ((f*L)/2) * [1; 1];
Fe2 = ((f*L)/4) * [1; 1];

% Partition, for the first half, use Ke1, for the second half, use Ke2

for e = 1 : NE/2
       
    % Node numbers for element (assume element 1 has nodes 1 & 2, etc.)
    i = e;  j = i+1;
    
    % Accumulate [Ke] into global [K]  ("Direct Stiffness" method)
    K(i : j, i : j) = K(i : j, i : j) + Ke1
    
end

for e = (NE/2+1) : NE
       
    % Node numbers for element (assume element 1 has nodes 1 & 2, etc.)
    i = e;  j = i+1;
    
    % Accumulate [Ke] into global [K]  ("Direct Stiffness" method)
    K(i : j, i : j) = K(i : j, i : j) + Ke2
   
end

% Use a similar process for the Force Vector

for e = 1 : (NE/2)
       
    i = e;  j = i+1;
   
    F(i : j) = F(i : j) + Fe1
    
end

for e = (NE/2+1) : NE
       
    i = e;  j = i+1;
    
    F(i : j) = F(i : j) + Fe2
   
end

% Make K non-singular

K = K(1:NN-1,1:NN-1)
F = F(1:NN-1)

% Solve for u

u = K\F

end

