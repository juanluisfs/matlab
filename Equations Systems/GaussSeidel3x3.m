%% Gauss-Seidel Method to Solve Systems of Lineal Equations in a 3x3 configuration
%% Método de Gauss-Seidel para resolver sistemas de ecuaciones lineales con configuración 3x3

% Clean screen and variables
% Limpiar pantalla y variables
clc
clear

% Capture the matrix values
% Capturar los valores de la matriz
A = [1,1,1,160;
     1,2,-1,114;
     1,1,-4,-80];

% Capture the x values of each equation
% Capturar los valores de x de cada ecuación
x1 = 0;
x2 = 0;
x3 = 0;

% Operative variables setting
% Configuración de variables operativas
emax = 100;
i = 0;
a = 0;

% While the maximum error value is greater to 1(%)
% Mientras que el error máximo sea mayor a 1(%)
while emax > 1
    x1o = x1;
    x2o = x2;
    x3o = x3;
    
    x1 = (A(1,4) - (A(1,2) * x2) - (A(1,3) * x3))/A(1,1);
    x2 = (A(2,4) - (A(2,1) * x1) - (A(2,3) * x3))/A(2,2);
    x3 = (A(3,4) - (A(3,1) * x1) - (A(3,2) * x2))/A(3,3);
    
    e1 = abs((x1-x1o))/x1 * 100;
    e2 = abs((x2-x2o))/x2 * 100;
    e3 = abs((x3-x3o))/x3 * 100;

    emax = max([e1,e2,e3]);
    a = i;
    i = a + 1;

    % Print the results of each iteration
    % Imprimir los resultados de cada iteración
    fprintf("The equation system results using the Gauss-Seidel Method are: \n")
    fprintf("Iteration %.0f \n", i)
    fprintf("    x1 = %.4f \n", x1)
    fprintf("    x2 = %.4f \n", x2)
    fprintf("    x3 = %.4f \n", x3)
    fprintf("Maximum Error %.4f \n", emax)
    fprintf("\n")
    fprintf("Los resultados del sistema de ecuaciones mediante Gauss-Seidel son: \n")
    fprintf("Iteración %.0f \n", i)
    fprintf("    x1 = %.4f \n", x1)
    fprintf("    x2 = %.4f \n", x2)
    fprintf("    x3 = %.4f \n", x3)
    fprintf("Error máximo %.4f \n", emax)
    fprintf("\n")
end
