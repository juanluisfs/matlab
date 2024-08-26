%% Inverse Method to Solve Equation System in 2x2 Configuration
%% Método de la Inversa para Resolver Sistemas de Ecuaciones en Configuración 2x2

% Clean screen and variables
% Limpiar pantalla y variables
clc
clear
format shortG

% Captura the matrix coeficients
% Capturar coeficientes de la matriz
x1 = 1;
x2 = 5;
y1 = 1;
y2 = -2;
C = [x1,y1;x2,y2]

% Capture independient terms vector
% Capturar vector de términos independientes
V = [7;-7]

% Solution is equal to the vector multiplied by the coeficient matrix inverse
% La solución es igual a la multiuplicación del vector por la matriz inversa de coeficientes
resultado = inv(C) * V


fprintf("x = %f \n", resultado(1))
fprintf("y = %f \n", resultado(2))
