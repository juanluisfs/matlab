% Ckean screen, variables and figures
% Limpiar pantalla, variables y figuras
clc
clear

% Input voltage, capacitance, resistance and time parameters
% Ingresar parámetro de voltaje, capacitancia, resistencia y tiempo
prompt = {'Voltaje (V)', 'Capacitancia (F)', 'Resistencia Carga (Ω)', 'Resistencia Descarga (Ω)', 'Tiempo de almacenamiento (s)'};
digtitle = 'Introduce los valores';
dims = [1 25];
definput = {'5','0.0002', '1000', '1000', '10'};
answer = inputdlg(prompt, digtitle, dims, definput);

% Convert the input strings to numbers
% Convertir los parámteros string a números
V = str2num(answer{1});
C = str2num(answer{2});
Rc = str2num(answer{3});
Rd = str2num(answer{4});
to = str2num(answer{5});

% Calculate the different values from the input data
% Cálculo de diferentes valores a partir de los datos ingresados
tc = 5*Rc*C;        % Charge time            -  Tiempo de Carga
td = 5*Rd*C;        % Discharge time         -  Tiempo de Descarga
Q = C*V;            % Charge                 -  Carga
U = (Q^2)/(2*C);    % Store Energy           -  Energía acumulada
tt = tc+to+td;      % Total time             -  Tiempo total
Pc = (V^2)/(Rc);    % Max Charge Power       -  Potencia máxima de carga
Pd = (V^2)/(Rd);    % Max Discharge Power    -  Potencia máxima de descarga
Icmax = V/Rc;       % Max Charge Current     -  Corriente máxima de carga
Idmax = V/Rd;       % Max Discharge Current  -  Corriente máxima de descarga

% Ask user for the graph preferences
% Preguntar al usuario si quiere ver la gráfica de carga y descarga
respuesta_usuario = questdlg('¿Deseas abrir la gráfica de carga y descarga?','Gráficas');
switch respuesta_usuario
    case 'Yes' %Si la respuesta es si
        
        t = [0:0.01:(tc+0.01)];       %Crear vector de tiempo de 0 a tiempo de carga
        L = V*(1-exp(-(t/(Rc*C))));   %Calcular voltaje respecto al vector t
        
        te = [tc:0.01:(tc+to)];       %Crear vector de tiempo de tiempo de carga a tiempo de carga más almacenamiento
        Le = V*(1-exp(-(te/(Rc*C)))); %Calcular voltaje respecto al vector te
        
        itd = [0:0.01:td];            %Crear vector de tiempo de 0 a tiempo de descarga
        Lf = V * exp(-(itd/(Rd*C)));  %Calcular voltaje respecto al vector itd
        td2 = itd + (tc+to);          %Sumar el tiempo de carga y almacenamiento al vector itd
        
        %Configuración de la gráfica
        figure('Name', 'Gráfica Carga - Descarga');
        title('Gráfico Tiempo-Voltaje');
        
        %Establecer etiquetas de los ejes
        xlabel('Tiempo (Segundos)');
        ylabel('Voltaje (Volts)')
        
        hold on
        
        %Graficar L, Le y Lf respecto a sus respectivos vectores de tiempo t, te y td2
        plot(t,L, 'color', 'red', 'LineWidth', 3)
        plot(te,Le, 'color', 'green', 'LineWidth', 3)
        plot(td2,Lf, 'color', 'blue', 'LineWidth', 3)
        
        %Añadir leyenda para identificar carga, almacenamiento y descarga
        legend({'Carga','Almacenamiento','Descarga'}, 'Location', 'south')
end

%Preguntar al usuario si quiere ver la gráfica de corriente respecto al tiempo
respuesta_usuario = questdlg('¿Deseas abrir la gráfica de corriente respecto al tiempo?','Gráficas');
switch respuesta_usuario
    case 'Yes' %Si la respuesta es si
        
        ti = [0:0.01:(tc+to)];                 %Crear vector de tiempo de 0 a tiempo de carga y almacenamiento
        I = (V/Rc)*exp(-((((1/C)/Rc)*ti)));    %Calcular corriente respecto al vector ti
        
        ti1 = [0:0.01:td];                     %Crear vector de tiempo de 0 a tiempo de descarga
        I2 = (V/Rd)*(exp(-(((1/C)/Rd)*ti1)));  %Calcular voltaje respecto al vector de ti1
        ti2 = ti1 + (tc+to);                   %Sumar el tiempo de carga y almacenamiento al vector ti2
        
        %Configuración de la gráfica
        figure('Name', 'Gráfica Corriente Respecto al Tiempo');
        title('Gráfico Tiempo-Corriente');
        
        %Establecer etiquetas de los ejes
        xlabel('Tiempo (Segundos)');
        ylabel('Corriente (Ampere)')
        
        hold on 
        
        %Graficar I e I2 respecto a sus respectivos vectores de tiempo ti y ti2
        plot(ti,I, 'color', 'black', 'LineWidth', 3)
        plot(ti2,I2, 'color', 'black', 'LineWidth', 3)
end

%Preguntar al usuario si quiere ver la gráfica de carga respecto al tiempo
respuesta_usuario = questdlg('¿Deseas abrir la gráfica de carga respecto al tiempo?','Gráficas');
switch respuesta_usuario
    case 'Yes' %Si la respuesta es si
        
        tq = [0:0.01:(tc+to)];               %Crear vector de tiempo de 0 a tiempo de carga y almacenamiento
        Q1 = (V*(1-exp(-(tq/(Rc*C))))) * C;  %Calcular carga respecto al vector de tq
        
        tq15 = [0:0.001:td];                 %Crear vector de tiempo de 0 a tiempo de descarga
        Q2 = (V * exp(-(tq15/(Rd*C)))) * C;  %Calcular carga respecto al vector de tq15
        tq2 = tq15 + (tc + to);              %Sumar el tiempo de carga y almacenamiento al vector tq15
        
        %Configuración de la gráfica
        figure('Name', 'Gráfica Carga Respecto al Tiempo');
        title('Gráfico Tiempo-Carga');
        
        %Establecer etiquetas de los ejes
        xlabel('Tiempo (Segundos)');
        ylabel('Carga (Coulomb)')
        
        hold on
        
        %Graficar Q1 y Q2 respecto a sus respectivos vectores de tiempo tq y tq2
        plot(tq,Q1, 'color', 'magenta', 'LineWidth', 3)
        plot(tq2,Q2, 'color', 'magenta', 'LineWidth', 3)
end

%Imprimir los resultados del circuito
fprintf('Resultados: \n')
fprintf(['  Tiempo de carga: %.2f segundos \n'], tc)
fprintf(['  Tiempo de descarga: %.2f segundos \n'], td)
fprintf(['  Tiempo total del sistema: %.2f segundos \n \n'], tt)
fprintf(['  Carga máxima: %.5f Coulomb \n'], Q)
fprintf(['  Energía almacenada: %.5f Joules \n \n'], U)
fprintf(['  Potencia máxima de carga: %.5f Watts \n'], Pc)
fprintf(['  Potencia máxima de descarga: %.5f Watts \n \n'], Pd)
fprintf(['  Corriente máxima de carga: %.5f Amperes \n'], Icmax)
fprintf(['  Corriente máxima de descarga: %.5f Amperes \n'], Idmax)

%Juan Luis Flores Sánchez A01383088
