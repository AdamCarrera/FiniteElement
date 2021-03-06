%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Author: Adam Carrera
% Semester: 09/29/20
% Program:  Plot Analytical and FEA solutions for 3 point BVP
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

clc;
clear;

set(0,'defaulttextinterpreter', 'LaTeX') % set interpreter

%% PLOT ANALYTICAL SOLUTION

[A,E,L,f] = assignValues(); % material values assigned from assignValues

N = 51; % define number of points

x = [linspace(0,L/2,N/2);linspace(L/2,L,N/2)]; % define two length vectors
% to partition the rod into two parts


% define piecewise analytical solution
u = [-((2*f)/(E*A))*x(1,:).^2 + ((13*f*L^2)/(8*E*A));
    -((f)/(2*E*A)*x(2,:).^2) - ((3*f*L)/(2*E*A))*x(2,:) + ((2*f*L^2)/(E*A))];

%check if strain is over 2 percent.
% If True, plot the diagram
% Else, raise error
if overStrain(L, u(2,1))
    figure
    plot(x(1,:),u(1,:))
    hold on
    plot(x(2,:),u(2,:))
    hold on
    % Plot FEA solns as points
    plot(0,((9*f*L^2)/(8*A*E)),'d')
    hold on
    plot(L/2,((5*f*L^2)/(8*A*E)),'d')
    hold on
    plot(L,0,'d')

    title('Displacement as a Function of $x$ in Sectioned Rod', 'FontSize', 12);
    xlabel('Distance along the length of the Rod $x$');
    ylabel('Horizontal displacement $u(x)$');
    legend('$u_L(x)$','$u_R(x)$','$u_1$','$u_2$','$u_3$','Interpreter', 'latex');
    grid on
else
    error('The engineering strain has exceeded 2%, adjust material values');
end

%% Compute FEA Solution

u = FEA(A, E, L, f, 3)