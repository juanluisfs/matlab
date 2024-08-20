%% 2nd Order - Runge Kutta Method
%% Método Runge - Kutta (2º Orden)

%Limpiar pantalla y variables
clc
clear
format shortG

%Datos iniciales
f = @(x,y) y + (2*x*(2.7183^(2*x)));
x0 = 0;
y0 = 1;
xf = 0.2;
n = 2;

%Inicia el método
h = (xf-x0)/n;
vx(1) = x0;
vy(1) = y0;
e(1) = 100;

%Llenar el vector x
for i = 1:n
    vx(i+1) = vx(i) + h;
end

%Solución Analítica
[valx,valy]=ode45(f,[vx],y0);

%Llenar el vector y
for i=1:n
    k1 = f(vx(i),vy(i));
    k2 = f((vx(i)+h),(vy(i)+k1*h));
    y1 = vy(i) + ((k1/2)+(k2/2))*h;
    vy(i+1) = y1;
    e(i+1) = abs((valy(i+1)-vy(i))/valy(i+1))*100;
end

disp('            x      y aprox       y real        Error  ')
disp('------------------------------------------------------')
disp([vx',vy',valy, abs((valy-vy')./valy)*100])

%Graficar los puntos obtenid
clf
hold on
plot(vx, valy, 'LineWidth', 2, 'color', 'b',"Marker",'square')
plot(vx, vy, 'sr', 'LineWidth', 2,'Marker',"o")
grid on
legend ('Analítica', 'Runge - Kutta 2º')
xlabel('Tiempo (segundos)', 'FontSize', 10)
ylabel('Velocidad Angular (rad/s)', 'FontSize', 10)
