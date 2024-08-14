%% Analytic Solving Method for First Degree Differential Equations
%% Método analítico para resolver EDO primer orden

% Clean screen and variables
% Limpiar pantalla y variables
clc
clear
format shortG

% Capturing initial data
% Captura de datos iniciales
f = @(x,y) 37.5 - (3.5*y);
x0 = 0;
y0 = 50;
xf = 3;

% Analytic Solve
% Solución analítica
[xa,ya] = ode45(f,[x0 xf],y0)

