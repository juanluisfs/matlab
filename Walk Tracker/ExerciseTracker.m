%% Exercise Tracker by Juan Luis
%  Made 2022/10/02

% Clean screen and variables
%
clc
clear
close all

load MobileSensorData/sensorlog_20220927_130136.mat

h = Acceleration.Timestamp.Hour;
m = Acceleration.Timestamp.Minute;
s = Acceleration.Timestamp.Second;

s_global = (h * 3600) + (m * 60) + s;
t_relativo = s_global - min(s_global);

a = [t_relativo Acceleration.X Acceleration.Y Acceleration.Z];

plot(a(:,1),a(:,2:4))
legend("x","y","z")
xlabel("Tiempo (s)")
ylabel("Aceleración (m/s^2)")
grid on
axis tight

a_x = a(:,2);
a_y = a(:,3);
a_z = a(:,4);

a_magnitud = sqrt(sum(a_x.^2 + a_y.^2 + a_z.^2, 2));

a_magnitud_sin_gravedad = a_magnitud - mean(a_magnitud);

altura_minima_cuspides = std(a_magnitud_sin_gravedad);

[pks,locs] = findpeaks(a_magnitud_sin_gravedad,"MinPeakHeight",altura_minima_cuspides);
numero_pasos = numel(pks) * 2;

linea_minima = altura_minima_cuspides + (t_relativo * 0);

figure
hold on;
plot(t_relativo,a_magnitud_sin_gravedad,'Color',[0.06666667 0.44705882 0.61960784])
plot(t_relativo,linea_minima,"r","LineWidth",1.5,"LineStyle","--")
plot(t_relativo(locs),pks,'Color',[1 0.54901961 0],"Marker","v","LineStyle","none","MarkerFaceColor",[1 0.54901961 0]);
legend("Magnitud (Sin Gravedad)","Magnitud Mínima","Pasos")
title(sprintf("Conteo de Pasos = %0.0f", numero_pasos));
xlabel("Tiempo (s)")
ylabel("Aceleración (m/s^2)")
hold off;
grid on
axis tight

h_p = Position.Timestamp.Hour;
m_p = Position.Timestamp.Minute;
s_p = Position.Timestamp.Second;

s_p_global = (h_p * 3600) + (m_p * 60) + s_p;
t_p_relativo = s_p_global - min(s_p_global);

alt = Position.altitude;
alt_max = max(alt);
alt_min = min(alt);
alt_dif = alt_max - alt_min;

lat = Position.latitude;
lat1 = lat(1:(length(lat)-1),1);
lat2 = lat(2:length(lat),1);

lon = Position.longitude;
lon1 = lon(1:(length(lon)-1),1);
lon2 = lon(2:length(lon),1);

circunferencia_Tierra = 40075;
distancia_total = 0;


for i = 1:length(lat1)
    distancia_angulo = distance(lat1,lon1,lat2,lon2);
    distancia_longitud = (distancia_angulo / 360) * circunferencia_Tierra;
    distancia_total = distancia_total + distancia_longitud(i);
end

figure
hold on
plot(lon,lat,"LineWidth",3)
plot(lon(1),lat(1),"Marker","o","Color","k","MarkerSize",7,"MarkerFaceColor","g","LineWidth",1.5,"LineStyle","none")
plot(lon(length(lon)),lat(length(lat)),"Marker","o","Color","k","MarkerSize",7,"MarkerFaceColor","r","LineWidth",1.5,"LineStyle","none")
legend("Trayectoria","Punto Inicial","Punto Final")
xlabel("Longitud (º)")
ylabel("Latitud (º)")
title(sprintf("Distancia Recorrida = %0.3f km", distancia_total))
hold off
grid on

figure
plot3(lon,lat,alt,"LineWidth",2)
hold on
plot3(lon(1),lat(1),alt(1),"Marker","o","Color","k","MarkerSize",7,"MarkerFaceColor","g","LineWidth",1.5,"LineStyle","none")
plot3(lon(length(lon)),lat(length(lat)),alt(length(alt)),"Marker","o","Color","k","MarkerSize",7,"MarkerFaceColor","r","LineWidth",1.5,"LineStyle","none")
hold off
legend("Trayectoria","Punto Inicial","Punto Final")
xlabel("Longitud (º)")
ylabel("Latitud (º)")
zlabel("Altitud (m)")
title(sprintf("Distancia Recorrida = %0.3f km  Altitud = %0.3f m", distancia_total,alt_dif))
grid on
axis tight

pasos_promedio = distancia_total / numero_pasos;
delta_pasos = numero_pasos / length(distancia_longitud);
delta_distancia_pasos = distancia_longitud / delta_pasos;
delta_distancia_pasos_normalizada = delta_distancia_pasos - (pasos_promedio * delta_pasos);
desv_est_pasos = std(delta_distancia_pasos_normalizada);


fprintf("Resumen de Sesión de Captura de Datos \n")
fprintf("   Distancia Reccorria = %0.3f km \n",distancia_total)
fprintf("      Pasos Realizados = %0.0f pasos \n",numero_pasos)
fprintf("      Distancia Promedio por Zancada = %0.3f cm \n",((distancia_total * 100000) / numero_pasos))
fprintf("      Desviación Estándar de Zancada = %0.3f cm \n",(desv_est_pasos*100000))
fprintf("   Altitud Relativa = %0.3f m \n",alt_dif)
fprintf("      Equivalente en pisos = %0.0f pisos \n",floor(alt_dif/3))
fprintf("      Altitud Máxima = %0.3f m \n",alt_max)
fprintf("      Altitud Mínima = %0.3f m \n",alt_min)
