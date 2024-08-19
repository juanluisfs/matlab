%% Second Order - Runge Kutta Method with Function
%% Método Runge Kutta de Segundo Orden con Función

% Clean screen and variables
% Limpiar pantalla y variables
clc
clear
format shortG

% Initial data
% Datos iniciales
f = @(x,y) -2.2067d-12 * (y^4-81d8);
x0 = 0;
y0 = 1200;
xf = 480;
n = 3;

% Call the function
% Llamar a la función
[vx,vy] = RungeKutta2(f,x0,y0,xf,n);

% Analytic Solution
% Solución Analítica
[valx,valy]=ode45(f,[vx],y0);

% Results Printing
% Impresión de resultados
disp('            x      y aprox       y real        Error  ')
disp('------------------------------------------------------')
disp([vx',vy',valy, abs((valy-vy')./valy)*100])

% Graph
% Grafica
clf
hold on
plot(vx, valy, 'LineWidth', 2, 'color', 'b',"Marker",'square')
plot(vx, vy, 'sr', 'LineWidth', 2,'Marker',"o")
grid on
legend ('Analítica', 'Runge - Kutta 2º')
xlabel('Valores en x', 'FontSize', 10)
ylabel('Valores en y', 'FontSize', 10)
