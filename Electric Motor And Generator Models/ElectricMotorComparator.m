clc
clear

prompt = {'Campo Magnético [T]','Área de la Espira [m2]','Número de Vueltas de la Bobina','Voltaje Aplicado'};
digtitle = 'Introduce los Valores del Primer Motor';
dims = [1 25];
definput = {'0.2','0.2','10','1000'};
answer = inputdlg(prompt, digtitle, dims, definput);

B1 = str2num(answer{1});
A1 = str2num(answer{2});
N1 = str2num(answer{3});
V1 = str2num(answer{4});

prompt = {'Campo Magnético [T]','Área de la Espira [m2]','Número de Vueltas de la Bobina','Voltaje Aplicado'};
digtitle = 'Introduce los Valores del Segundo Motor';
dims = [1 25];
definput = {'0.5','0.1','1','10'};
answer = inputdlg(prompt, digtitle, dims, definput);

B2 = str2num(answer{1});
A2 = str2num(answer{2});
N2 = str2num(answer{3});
V2 = str2num(answer{4});

prompt = {'Resistencia [Ω]'};
digtitle = 'Introduce el Valor de la Resistencia';
dims = [1 25];
definput = {'10'};
answer = inputdlg(prompt, digtitle, dims, definput);

R = str2num(answer{1});

Bmin = min(B1,B2);
Bmax = max(B1,B2);
Amin = min(A1,A2);
Amax = max(A1,A2);
Nmin = min(N1,N2);
Nmax = max(N1,N2);
Vmin = min(V1,V2);
Vmax = max(V1,V2);

Bi = (Bmax-Bmin)/100;
Ai = (Amax-Amin)/100;
Ni = (Nmax-Nmin)/100;
Vi = (Vmax-Vmin)/100;

B = [Bmin:Bi:Bmax];
A = [Amin:Ai:Amax];
N = [Nmin:Ni:Nmax];
V = [Vmin:Vi:Vmax];

O = [0:0.1:2*pi];

figure('Name','Variación del Torque Respecto a la Diferencia de los Valores Introducidos','Position',[1,1000,5000,3000])

subplot(2,2,1)
hold on
title('Torque vs Campo Magnético')
xlabel('Campo Magnético (Teslas)')
ylabel('Torque (Nm)')
plot(B,B,'Color','r','LineWidth',2)
plot(B1,B1,'sk','Marker','o','MarkerFaceColor','magenta','MarkerSize',8,'LineWidth',2)
plot(B2,B2,'sk','Marker','o','MarkerFaceColor','yellow','MarkerSize',8,'LineWidth',2)
legend('Variación del Torque','Primer Valor de B','Segundo Valor de B','Location','Southeast')

subplot(2,2,2)
hold on
title('Torque vs Área de la Espira')
xlabel('Área de la Espira (m2)')
ylabel('Torque (Nm)')
plot(A,A,'Color','g','LineWidth',2)
plot(A1,A1,'sk','Marker','o','MarkerFaceColor','magenta','MarkerSize',8,'LineWidth',2)
plot(A2,A2,'sk','Marker','o','MarkerFaceColor','yellow','MarkerSize',8,'LineWidth',2)
legend('Variación del Torque','Primer Valor de A','Segundo Valor de A','Location','Southeast')

subplot(2,2,3)
hold on
title('Torque vs Número de Vueltas de la Bobina')
xlabel('Área de la Espira (m2)')
ylabel('Torque (Nm)')
plot(N,N,'Color','b','LineWidth',2)
plot(N1,N1,'sk','Marker','o','MarkerFaceColor','magenta','MarkerSize',8,'LineWidth',2)
plot(N2,N2,'sk','Marker','o','MarkerFaceColor','yellow','MarkerSize',8,'LineWidth',2)
legend('Variación del Torque','Primer Valor de A','Segundo Valor de A','Location','Southeast')

subplot(2,2,4)
I = V/R;
I1 = V1/R;
I2 = V2/R;
hold on
title('Torque vs Voltaje Aplicado')
xlabel('Frecuencia (rpm)')
ylabel('Torque (Nm)')
plot(V,I,'Color','k','LineWidth',2)
plot(V1,I1,'sk','Marker','o','MarkerFaceColor','magenta','MarkerSize',8,'LineWidth',2)
plot(V2,I2,'sk','Marker','o','MarkerFaceColor','yellow','MarkerSize',8,'LineWidth',2)
legend('Variación del Torque','Primer Valor de A','Segundo Valor de A','Location','Southeast')

pause(10)
close all

figure('Name','Comparación del Torque Máximo','Position',[1,1000,5000,3000])

o = 0:1:10;
T1 = N1*I1*A1*B1+(o*0);
T2 = N2*I2*A2*B2+(o*0);
TM = Nmax*(Vmax/R)*Amax*Bmax+(o*0);
hold on
title('Torque Máximo de Cada Motor')
xlabel(' ')
ylabel('Torque (Newton-Metro)')
plot(o,T1,'Color','r','LineWidth',2)
plot(o,T2,'Color','b','LineWidth',2)
plot(o,TM,'Color','k','LineWidth',2)
legend('Primer Motor','Segundo Motor','Mejor Opción con los Valores Introducidos','Location','Southeast')

pause(10)
close all

dB = B(length(B))-B(1);
dA = A(length(A))-A(1);
dN = N(length(N))-N(1);
dV = I(length(I))-I(1);

fprintf('Resultados - Comparación de la Diferencia de Magnitudes: \n')
fprintf(['  Variación de Torque por Diferencia de Campos Magnéticos:                %.4f Nm \n'], dB)
fprintf(['  Variación de Torque por Diferencia de Áreas de las Espiras:             %.4f Nm \n'], dA)
fprintf(['  Variación de Torque por Diferencia de Número de Vueltas de la Bobina:   %.4f Nm \n'], dN)
fprintf(['  Variación de Torque por Diferencia de RPM:                              %.4f Nm \n\n'], dV)
fprintf('Resultados - Comparación de los Dos Motores: \n')
fprintf(['  Torque Generado por el Primer Motor:       %.4f Nm \n'], T1(1))
fprintf(['      Campo Magnético (B):                   %.4f Teslas \n'], B1)
fprintf(['      Área de la Espira (A):                 %.4f Metros Cuadrados \n'], A1)
fprintf(['      Número de Vueltas de la Bobina (N):    %.4f \n'], N1)
fprintf(['      Voltaje Aplicado (V):                  %.4f Voltios \n\n'], V1)
fprintf(['  Torque Generado por el Segundo Motor::     %.4f Nm \n'], T2(1))
fprintf(['      Campo Magnético (B):                   %.4f Teslas \n'], B2)
fprintf(['      Área de la Espira (A):                 %.4f Metros Cuadrados \n'], A2)
fprintf(['      Número de Vueltas de la Bobina (N):    %.4f \n'], N2)
fprintf(['      Voltaje Aplicado (V):                  %.4f Voltios \n\n'], V2)
fprintf('Resultados - Mejores Parámetros Para Un Mayor Torque con los Valores Proporcionados: \n')
fprintf(['  Torque Generado:                           %.4f Nm \n'], TM(1))
fprintf(['      Campo Magnético (B):                   %.4f Teslas \n'], Bmax)
fprintf(['      Área de la Espira (A):                 %.4f Metros Cuadrados \n'], Amax)
fprintf(['      Número de Vueltas de la Bobina (N):    %.4f \n'], Nmax)
fprintf(['      Voltaje Aplicado (V):                  %.4f Voltios \n\n'], Vmax)
