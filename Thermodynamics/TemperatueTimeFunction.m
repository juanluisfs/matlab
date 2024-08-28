% Clean screen and variables
% Limpiar pantalla y variables
clc
clear

% Ask temperature and time parameters
%cPedir parámteros de temperaturas y tiempos
prompt = {'Temperatura Inicial Hielera', 'Temperatura Ambiente', 'Temperatura Hielera Segunda Lectura', 'Tiempo de Segunda Lectura', 'Tiempo'};
digtitle = 'Introduce los valores';
dims = [1 25];
definput = {'13','16', '14', '360', '500'};
answer = inputdlg(prompt, digtitle, dims, definput);

% Convert the string inputs to numbers
% Convertir las entradas string a números
Tih = str2num(answer{1});
Ta = str2num(answer{2});
Tht = str2num(answer{3});
t2l = str2num(answer{4});
tiempo = str2num(answer{5});

% Calculate the integration constant and thermal constant
% Calcular la constante de integración y la constante térmica
C = Tih-Ta;
k =((log((Tht-Ta)/(Tih-Ta)))/-t2l);

% Calculate the temperature in the given time
% Calcular la temperatura del tiempo dado
Tt = (C*exp(-(k*tiempo)))+ Ta;

% Cooler Temperature Change Graph over time
% Gráfica del cambio de temperatura de la hielera en el tiempo
t = [0:1:tiempo];
T = (C*exp(-(k*t)))+ Ta;
figure('Name', 'Gráfica Tiempo-Temperatura');
title('Gráfico Tiempo-Temperatura');
xlabel('Tiempo (minutos)');
ylabel('Temperatura (ºC)');
hold on
plot(t,T, 'color', 'red', 'LineWidth', 3);

% Print the results
% Impresión de resultados 
sprintf('La temperatura de la hielera a los %.1f minutos es de %.1f ºC',tiempo, Tt)
