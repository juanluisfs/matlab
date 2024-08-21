%% LU Decomposition Method to Solve 3x3 Lineal Equarion Systems
%% Método de DEscomposición LU para Resolver Sistemas 3x3 de Ecuaciones Lineales

% Clean screen and variables
% Limpiar pantalla y variables
clc
clear

% Capture the expanded system matrix
% Capturar matriz ampliada del sistema
M = [1,1,0,26;1,0,1,34;0,1,1,28];
A = [M(1,1:3);M(2,1:3);M(3,1:3)];
I = ["x1";"x2";"x3"];

% Step 1. Decompose A in U and U
% Paso 1. Descomponer A en U y U
    %PASO 1.1 Obtener la matriz U
    U = A;
        % Step 1.11 Delete x1 from the second equation 
        % PASO 1.11 Eliminar x1 de la segunda ecuación
        k = -U(2,1) / U(1,1);
        U(2,:) = U(1, :)*k + U(2,:);
        a = k;

        % Step 1.12 Delete x1 from the third equation
        % Paso 1.12 Eliminar x1 de la tercera ecuación
        k = -U(3,1) / U(1,1);
        U(3,:) = U(1,:)*k + U(3,:);
        b = k;

        % Step 1.13 Delete x2 from the third equation
        % Paso 1.13 Eliminar x2 de la tercera ecuación
        if U(2,2) == 0           % If the pivot equals zero        -  Si el pivote es igual a cero
            aux = U(2,:);        % Equation 2 and 3 change places  -  Se intercambia la ecuación 2 y 3
            U(2,:) = U(3,:);
            U(3,:) = aux(1,:);
        else
            k = -U(3,2) / U(2,2);
            U(3,:) = U(2,:)*k + U(3,:);
            c = k;
        end

    % Step 1.2 Get the L matrix
    % Paso 1.2 Obtener la matriz L
   L = eye(3);
   L(2,1) = -a;
   L(3,1) = -b;
   L(3,2) = -c;

B = [M(1,4);M(2,4);M(3,4)];

d1 = B(1);
d2 = B(2) - L(2,1)*d1;
d3 = B(3) - L(3,1)*d1 - L(3,2)*d2;
D = [d1;d2;d3];

x3 = d3/U(3,3);
x2 = (d2 - U(2,3)*x3)/U(2,2);
x1 = (d1 - U(1,3)*x3 - U(1,2)*x2)/U(1,1);
X = [x1;x2;x3];

% Print results
% Imprimir resultados
disp("Matriz de coeficientes A")
disp(A)
disp(" ")
disp("Vector de incógnitas X")
disp(I)
disp(" ")
disp("Vector de términos independientes B")
disp(B)
disp(" ")
disp("Matriz U")
disp(U)
disp(" ")
disp("Matriz L")
disp(L)
disp(" ")
disp("Vector D")
disp(D)
disp(" ")
disp("Vector X")
disp(X)
disp(" ")
