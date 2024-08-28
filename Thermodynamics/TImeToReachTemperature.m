% Clean screen and variables
% Limpiar pantalla y variables
clc
clear

% Ask for temperature and time parameters
% Pedir parámteros de temperaturas y tiempos
prompt = {'Temperatura Inicial Hielera', 'Temperatura Ambiente', 'Temperatura Hielera Segunda Lectura', 'Tiempo de Segunda Lectura', 'Temperatura'};
digtitle = 'Introduce los valores';
dims = [1 25];
definput = {'13','16', '14', '360', '15'};
answer = inputdlg(prompt, digtitle, dims, definput);

% Convert the input strings to number
% Convertir las entradas string a números
Tih = str2num(answer{1});
Ta = str2num(answer{2});
Tht = str2num(answer{3});
t2l = str2num(answer{4});
temp = str2num(answer{5});

% Calculate the integration and thermal constant
% Calcular la constante de integración y la constante térmica
C = Tih-Ta;
k =((log((Tht-Ta)/(Tih-Ta)))/-t2l);
tiempo = (log((temp-Ta)/C))/-k;

% Cooler Temperature Change Graph over Time
% Gráfica del cambio de temperatura de la hielera en el tiempo
t = [0:1:tiempo];
T = (C*exp(-(k*t)))+ Ta;
figure('Name', 'Gráfica Tiempo-Temperatura');
title('Gráfico Tiempo-Temperatura');
xlabel('Tiempo (minutos)');
ylabel('Temperatura (ºC)');
hold on
plot(t,T, 'color', 'red', 'LineWidth', 3);

% Print results
% Impresión de resultados 
sprintf('El tiempo en el que la hielera alcanza los %.1f ºC es %.0f minutos',temp, tiempo)
