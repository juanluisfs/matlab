%% Gauss Method to Solve Systems of Lineal Equations in a 3x3 configuration
%% Método de Gauss para resolver sistemas de ecuaciones lineales con configuración 3x3

% Clean screen and variables
% Limpiar pantalla y variables
clc
clear

% Capture the system extended matrix
% Capturar la matriz ampliada del sistema
M = [4,-1,-1,0,30;-1,4,0,-1,35;-1,0,4,-1,15;0,-1,-1,4,20];

% Step 1. Triangularization
% Paso 1. Triangularización
% Step 1.1 Delte x1 from the second equation
% Paso 1.1 Eliminar x1 de la segunda ecuación
k = -M(2,1) / M(1,1);
M(2,:) = M(1, :)*k + M(2,:);

% Step 1.2 Delte x1 from the third equation
% Paso 1.2 Eliminar x1 de la tercera ecuación
k = -M(3,1) / M(1,1);
M(3,:) = M(1,:)*k + M(3,:);

k= -M(4,1) / M(1,1);
M(4,:) = M(1,:)*k + M(4,:);

k = -M(3,2) / M(2,2);
M(3,:) = M(2,:)*k + M(3,:);

k = -M(4,2) / M(2,2);
M(4,:) = M(2,:)*k + M(4,:);

k = -M(4,3) / M(3,3);
M(4,:) = M(3,:)*k + M(4,:);

% Progressive sustitution
% Sustitución regresiva
x4 = M(4,5)/M(4,4);
x3 = (M(3,5)-(M(3,4)*x4))/M(3,3);
x2 = (M(2,5)-(M(2,4)*x4)-(M(2,3)*x3))/M(2,2);
x1 = (M(1,5)-(M(1,4)*x4)-(M(1,3)*x3)-(M(1,2)*x2))/M(1,1);

% Print results
% Imprimir resultados
fprintf("x1 = %.4f \n", x1)
fprintf("x2 = %.4f \n", x2)
fprintf("x3 = %.4f \n", x3)
fprintf("x4 = %.4f \n", x4)
