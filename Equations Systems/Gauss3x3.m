%% Gauss Method to Solve Systems of Lineal Equations in a 3x3 configuration
%% Método de Gauss para resolver sistemas de ecuaciones lineales con configuración 3x3

% Clean screen and variables
% Limpiar pantalla y variables
clc
clear

% Capture the system extended matrix
% Capturar la matriz ampliada del sistema
M = [1,1,1,66;1,1,-2,0;1,-1,1,2];

% Step 1. Triangularization
% Paso 1. Triangularización
% Step 1.1 Delete x1 from the second equation
% Paso 1.1 Eliminar x1 de la segunda ecuación
k = -M(2,1) / M(1,1);
M(2,:) = M(1, :)*k + M(2,:);

% Step 1.2 Delete x1 from the second equation
% PASO 1.2 Eliminar x1 de la tercera ecuación
k = -M(3,1) / M(1,1);
M(3,:) = M(1,:)*k + M(3,:);

% Step 1.3 Delete x2 from the third equation
% Paso 1.3 Eliminar x2 de la tercera ecuación
if M(2,2) == 0           % If pivot equals zero          -  Si el pivote es igual a cero
    aux = M(2,:);        % Intercgange equation 2 and 3  -  Se intercambia la ecuación 2 y 3
    M(2,:) = M(3,:);
    M(3,:) = aux(1,:);
else
    k = -M(3,2) / M(2,2);
    M(3,:) = M(2,:)*k + M(3,:);
end

% Regressive sustitution
% Sustitución regresiva
x3 = M(3,4)/M(3,3);
x2 = (M(2,4)-(M(2,3)*x3))/M(2,2);
x1 = ((M(1,4)-(M(1,2)*x2)-(M(1,3)*x3))/M(1,1));

% Print results
% Imprimir resultados
fprintf("x1 = %.4f \n", x1)
fprintf("x2 = %.4f \n", x2)
fprintf("x3 = %.4f \n", x3)
