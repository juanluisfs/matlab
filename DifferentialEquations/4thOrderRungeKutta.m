%% 4th order - Runge Kutta Method
%% Método Runge - Kutta (4º Orden)

%Limpiar pantalla y variables
clc
clear
format shortG

%Datos iniciales
f = @(x,y) 0.026*(1-y/12000)*y;
x0 = 2000;
y0 = 6079;
xf = 2025;
n = 2;

%Inicia el método
h = (xf-x0)/n;
vx(1) = x0;
vy(1) = y0;
    
%Llenar el vector x
for i = 1:n
    vx(i+1) = vx(i) + h;
end

%Llenar el vector y
for i=1:n
    k1 = f(vx(i),vy(i));
    k2 = f(vx(i)+(h/2),vy(i)+((h/2)*k1));
    k3 = f(vx(i)+(h/2),vy(i)+((h/2)*k2));
    k4 = f(vx(i)+h,vy(i)+(h*k3));
    vy(i+1) = vy(i) + (h/6)*(k1+(2*k2)+(2*k3)+k4);
end

%Solución Analítica
[valx,valy]=ode45(f,[vx],y0);

%Impresión de resultados
disp('            x      y aprox       y real        Error  ')
disp('------------------------------------------------------')
disp([vx',vy',valy, abs((valy-vy')./valy)*100])

%Graficar los puntos obtenid
clf
hold on
plot(vx, valy, 'LineWidth', 2, 'color', 'b',"Marker",'square')
plot(vx, vy, 'sr', 'LineWidth', 2,'Marker',"o")
grid on
legend ('Analítica', 'Runge - Kutta 4º')
xlabel('Valores en x', 'FontSize', 10, 'Color', 'r')
ylabel('Valores en y', 'FontSize', 10, 'Color', 'r')
