% Clean screeen and variables
% Limpiar pantalla y variables
clc
clear

% Ask temperature and time parameters
% Pedir parámteros de temperaturas y tiempos
prompt = {'Temperatura Inicial Hielera', 'Temperatura Ambiente', 'Temperatura Hielera Segunda Lectura', 'Tiempo de Segunda Lectura'};
digtitle = 'Introduce los valores';
dims = [1 25]
definput = {'13','16', '14', '360'};
answer = inputdlg(prompt, digtitle, dims, definput);

% Convert the string inputs to numbers
% Convertir las entradas String a números
Tih = str2num(answer{1});
Ta = str2num(answer{2});
Tht = str2num(answer{3});
t2l = str2num(answer{4});

% Calculate the integration constant and thermal constant
% Calcular la constante de integración y la constante térmica
C = Tih-Ta;
k =((log((Tht-Ta)/(Tih-Ta)))/-t2l);

% Calculate the time that takes to reache a thermal balanca + - 0.1
%Calculo del tiempo que tomará alcanzar el equilibrio térmico + - 0.1
tet = (log(((Ta+0.1)-Ta)/C))/-k;
teth = tet/60;
tetd = teth/24;

% Cooler Temperature Change Graph over time
% Gráfica del cambio de temperatura de la hielera con el tiempo
t = [0:0.1:tet];
T = (C*exp(-(k*t)))+ Ta;
figure('Name', 'Gráfica Tiempo-Temperatura');
title('Gráfico Tiempo-Temperatura');
xlabel('Tiempo (minutos)');
ylabel('Temperatura (ºC)')
hold on
plot(t,T, 'color', 'red', 'LineWidth', 3)

%
%Impresión de resultados 
sprintf(['El equilibrio térmico será posible en el tiempo %.0f minutos, %.2f horas o %.1f días'], tet, teth, tetd)
