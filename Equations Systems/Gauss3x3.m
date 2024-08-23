%     Juan Luis Flores Sánchez
%   Método de Gauss para resolver
% Sistemas de ecuaciones lineales de
%  3x3 (3 ecuaciones y 3 incógnitas)

%Limpiar pantalla y variables
clc
clear

%Capturar la matriz ampliada del sistema
M = [1,1,1,66;1,1,-2,0;1,-1,1,2];

% PASO 1. Triangularización
% - PASO 1.1 Eliminar x1 de la segunda ecuación
k = -M(2,1) / M(1,1);
M(2,:) = M(1, :)*k + M(2,:);

% - PASO 1.2 Eliminar x1 de la tercera ecuación
k = -M(3,1) / M(1,1);
M(3,:) = M(1,:)*k + M(3,:);

% - PASO 1.3 Eliminar x2 de la tercera ecuación
%SI EL PIVOTE ES IGUAL A CERO
if M(2,2) == 0 %Se intercambia la ecuación 2 y 3
    aux = M(2,:);
    M(2,:) = M(3,:);
    M(3,:) = aux(1,:);
else
    k = -M(3,2) / M(2,2);
    M(3,:) = M(2,:)*k + M(3,:);
end

%Sustitución regresiva
x3 = M(3,4)/M(3,3);
x2 = (M(2,4)-(M(2,3)*x3))/M(2,2);
x1 = ((M(1,4)-(M(1,2)*x2)-(M(1,3)*x3))/M(1,1));

fprintf("x1 = %.4f \n", x1)
fprintf("x2 = %.4f \n", x2)
fprintf("x3 = %.4f \n", x3)
