% Clean screen and variables
% Limpiar pantalla y variables
clc
clear

% Ask user for the first generator initial data
% Preguntar al usuario los datos iniciales del primer generador
prompt = {'Campo Magnético [T]','Área de la Espira [m2]','Número de Vueltas de la Bobina','Frecuencia [rpm]'};
digtitle = 'Introduce los Valores del Primer Generador';
dims = [1 25];
definput = {'0.2','0.2','10','1000'};
answer = inputdlg(prompt, digtitle, dims, definput);

% Convert input strings to number
% Convertir strings de entrada a números
B1 = str2num(answer{1});
A1 = str2num(answer{2});
N1 = str2num(answer{3});
RPM1 = str2num(answer{4});

% Ask user for the second generator initial data
% Preguntat al usuario por datos iniciales del segundo generador
prompt = {'Campo Magnético [T]','Área de la Espira [m2]','Número de Vueltas de la Bobina','Frecuencia [rpm]'};
digtitle = 'Introduce los Valores del Segundo Generador';
dims = [1 25];
definput = {'0.5','0.1','1','10'};
answer = inputdlg(prompt, digtitle, dims, definput);

% Convert input strings to number
% Convertir strings de entrada a números
B2 = str2num(answer{1});
A2 = str2num(answer{2});
N2 = str2num(answer{3});
RPM2 = str2num(answer{4});

% Set maximum and minimum values of the initial data
% Establecer valores máximos y mínimos de los datos iniciales
Bmin = min(B1,B2);
Bmax = max(B1,B2);
Amin = min(A1,A2);
Amax = max(A1,A2);
Nmin = min(N1,N2);
Nmax = max(N1,N2);
RPMmin = min(RPM1,RPM2);
RPMmax = max(RPM1,RPM2);

% Calculate the percentage of generator improvement
% Calcular porcentaje de mejora del generador
Bi = (Bmax-Bmin)/100;
Ai = (Amax-Amin)/100;
Ni = (Nmax-Nmin)/100;
RPMi = (RPMmax-RPMmin)/100;

% Create vectors of parameters change
% Crear vectores de cambio en parámetros
B = [Bmin:Bi:Bmax];
A = [Amin:Ai:Amax];
N = [Nmin:Ni:Nmax];
RPM = [RPMmin:RPMi:RPMmax];

% Create figure
% Crear figura
figure('Name','Variación del Voltaje Inducido Respecto a la Diferencia de los Valores Introducidos','Position',[1,1000,5000,3000])

% Plot the induction voltage vs magnetic field plot
% Graficar la gráfica de voltaje inducido vs campo magnético
subplot(2,2,1)
EB = (2/pi)*B;
EB1 = (2/pi)*B1;
EB2 = (2/pi)*B2;
hold on
title('Voltaje Inducido Medio vs Campo Magnético')
xlabel('Campo Magnético (Teslas)')
ylabel('Voltaje Inducido Medio (V)')
plot(B,EB,'Color','r','LineWidth',2)
plot(B1,EB1,'sk','Marker','o','MarkerFaceColor','magenta','MarkerSize',8,'LineWidth',2)
plot(B2,EB2,'sk','Marker','o','MarkerFaceColor','yellow','MarkerSize',8,'LineWidth',2)
legend('Variación del Voltaje Inducido','Primer Valor de B','Segundo Valor de B','Location','Southeast')

% Plot the induction voltage vs spiral area
% Graficar el voltaje inducido vs área de espiral
subplot(2,2,2)
EA = (2/pi)*A;
EA1 = (2/pi)*A1;
EA2 = (2/pi)*A2;
hold on
title('Voltaje Inducido Medio vs Área de la Espira')
xlabel('Área de la Espira (m2)')
ylabel('Voltaje Inducido Medio (V)')
plot(A,EA,'Color','g','LineWidth',2)
plot(A1,EA1,'sk','Marker','o','MarkerFaceColor','magenta','MarkerSize',8,'LineWidth',2)
plot(A2,EA2,'sk','Marker','o','MarkerFaceColor','yellow','MarkerSize',8,'LineWidth',2)
legend('Variación del Voltaje Inducido','Primer Valor de A','Segundo Valor de A','Location','Southeast')

subplot(2,2,3)
EN = (2/pi)*N;
EN1 = (2/pi)*N1;
EN2 = (2/pi)*N2;
hold on
title('Voltaje Inducido Medio vs Número de Vueltas de la Bobina')
xlabel('Número de Vueltas de la Bobina')
ylabel('Voltaje Inducido Medio (V)')
plot(N,EN,'Color','b','LineWidth',2)
plot(N1,EN1,'sk','Marker','o','MarkerFaceColor','magenta','MarkerSize',8,'LineWidth',2)
plot(N2,EN2,'sk','Marker','o','MarkerFaceColor','yellow','MarkerSize',8,'LineWidth',2)
legend('Variación del Voltaje Inducido','Primer Valor de A','Segundo Valor de A','Location','Southeast')

subplot(2,2,4)
w = RPM*pi/30;
ERPM = (2/pi)*w;
w1 = RPM1*pi/30;
ERPM1 = (2/pi)*w1;
w2 = RPM2*pi/30;
ERPM2 = (2/pi)*w2;
hold on
title('Voltaje Inducido Medio vs Frecuencia')
xlabel('Frecuencia (rpm)')
ylabel('Voltaje Inducido Medio (V)')
plot(RPM,ERPM,'Color','k','LineWidth',2)
plot(RPM1,ERPM1,'sk','Marker','o','MarkerFaceColor','magenta','MarkerSize',8,'LineWidth',2)
plot(RPM2,ERPM2,'sk','Marker','o','MarkerFaceColor','yellow','MarkerSize',8,'LineWidth',2)
legend('Variación del Voltaje Inducido','Primer Valor de A','Segundo Valor de A','Location','Southeast')

pause(10)
close all

figure('Name','Comparación de los Voltajes Inducidos Medios','Position',[1,1000,5000,3000])

o = 0:1:10;
E1 = (2/pi)*N1*A1*B1*w1+(o*0);
E2 = (2/pi)*N2*A2*B2*w2+(o*0);
EM = (2/pi)*Nmax*Amax*Bmax*(RPMmax*pi/30)+(o*0);
hold on
title('Voltaje Inducido Medio de Cada Generador')
xlabel(' ')
ylabel('Voltaje Inducido Medio (V)')
plot(o,E1,'Color','r','LineWidth',2)
plot(o,E2,'Color','b','LineWidth',2)
plot(o,EM,'Color','k','LineWidth',2)
legend('Primer Generador','Segundo Generador','Mejor Opción con los Valores Introducidos','Location','Southeast')

pause(10)
close all

dB = EB(length(EB))-EB(1);
dA = EA(length(EA))-EA(1);
dN = EN(length(EN))-EN(1);
dRPM = ERPM(length(ERPM))-ERPM(1);

fprintf('Resultados - Comparación de la Diferencia de Magnitudes: \n')
fprintf(['  Variación de Voltaje por Diferencia de Campos Magnéticos:                %.4f Voltios \n'], dB)
fprintf(['  Variación de Voltaje por Diferencia de Áreas de las Espiras:             %.4f Voltios \n'], dA)
fprintf(['  Variación de Voltaje por Diferencia de Número de Vueltas de la Bobina:   %.4f Voltios \n'], dN)
fprintf(['  Variación de Voltaje por Diferencia de RPM:                              %.4f Voltios \n\n'], dRPM)
fprintf('Resultados - Comparación de los Dos Generadores: \n')
fprintf(['  Voltaje Inducido por el Primer Generador:  %.4f Voltios \n'], E1(1))
fprintf(['      Campo Magnético (B):                   %.4f Teslas \n'], B1)
fprintf(['      Área de la Espira (A):                 %.4f Metros Cuadrados \n'], A1)
fprintf(['      Número de Vueltas de la Bobina (N):    %.4f \n'], N1)
fprintf(['      Frecuencia (f):                        %.4f RPM \n\n'], RPM1)
fprintf(['  Voltaje Inducido por el Segundo Generador: %.4f Voltios \n'], E2(1))
fprintf(['      Campo Magnético (B):                   %.4f Teslas \n'], B2)
fprintf(['      Área de la Espira (A):                 %.4f Metros Cuadrados \n'], A2)
fprintf(['      Número de Vueltas de la Bobina (N):    %.4f \n'], N2)
fprintf(['      Frecuencia (f):                        %.4f RPM \n\n'], RPM2)
fprintf('Resultados - Mejores Parámetros Para Un Mayor Voltaje Inducido con los Valores Proporcionados: \n')
fprintf(['  Voltaje Inducido:                          %.4f Voltios \n'], EM(1))
fprintf(['      Campo Magnético (B):                   %.4f Teslas \n'], Bmax)
fprintf(['      Área de la Espira (A):                 %.4f Metros Cuadrados \n'], Amax)
fprintf(['      Número de Vueltas de la Bobina (N):    %.4f \n'], Nmax)
fprintf(['      Frecuencia (f):                        %.4f RPM \n\n'], RPMmax)
