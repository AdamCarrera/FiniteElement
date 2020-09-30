function [] = FEA(A, E, L, f, NN)
%FEA Summary of this function goes here

% Check that matrix dimension allows symmetry

if mod(NN,2) == 0
    error('Please enter an odd number for NN');
end
    

% Initialize global stiffness matrix and force vector
K = zeros(NN,NN);
F = zeros(NN, 1);

NE = NN - 1;

Le = L / NE;

Ke1 = A * E / Le * [1, -1; -1,  1];
Ke2 = A * E / Le * [2, -2; -2,  2];

Fe1 = f*L/2;
Fe2 = f*L/4;

    % Partition, for the first half, use Ke1, for the second half, use Ke2

for e = 1 : NE/2
       
    % Node numbers for element (assume element 1 has nodes 1 & 2, etc.)
    i = e;  j = i+1;
    
    % Accumulate [Ke] into global [K]  ("Direct Stiffness" method)
    K(i : j, i : j) = K(i : j, i : j) + Ke1
    
    % Can do same for load (force) vector
end

for e = (NE/2+1) : NE
       
    % Node numbers for element (assume element 1 has nodes 1 & 2, etc.)
    i = e;  j = i+1;
    
    % Accumulate [Ke] into global [K]  ("Direct Stiffness" method)
    K(i : j, i : j) = K(i : j, i : j) + Ke2
    
    % Can do same for load (force) vector
end

end

