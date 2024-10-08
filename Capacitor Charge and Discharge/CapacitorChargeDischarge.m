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
    case 'Yes'                        % If answer is yes - Si la respuesta es si
        
        t = [0:0.01:(tc+0.01)];       % Create time vector from 0 to charge time      -  Crear vector de tiempo de 0 a tiempo de carga
        L = V*(1-exp(-(t/(Rc*C))));   % Calculate voltage based on time vector        -  Calcular voltaje respecto al vector t
        
        te = [tc:0.01:(tc+to)];       % Create time vector from charge to storage     -  Crear vector de tiempo de carga a tiempo de carga más almacenamiento
        Le = V*(1-exp(-(te/(Rc*C)))); % Calculate voltage based on te vector          -  Calcular voltaje respecto al vector te
        
        itd = [0:0.01:td];            % Create time vector from 0 to discharge time   -  Crear vector de tiempo de 0 a tiempo de descarga
        Lf = V * exp(-(itd/(Rd*C)));  % Calculate voltage based on itd vector         -  Calcular voltaje respecto al vector itd
        td2 = itd + (tc+to);          % Sum the charge time and storage to itd vector -  Sumar el tiempo de carga y almacenamiento al vector itd

        % Graph configuration
        % Configuración de la gráfica
        figure('Name', 'Gráfica Carga - Descarga');
        title('Gráfico Tiempo-Voltaje');

        % Set axis labels
        % Establecer etiquetas de los ejes
        xlabel('Tiempo (Segundos)');
        ylabel('Voltaje (Volts)')
        
        hold on

        % Plot L, Le, and Lf with respective time vector t, te, and td2
        % Graficar L, Le y Lf respecto a sus respectivos vectores de tiempo t, te y td2
        plot(t,L, 'color', 'red', 'LineWidth', 3)
        plot(te,Le, 'color', 'green', 'LineWidth', 3)
        plot(td2,Lf, 'color', 'blue', 'LineWidth', 3)

        % Add legend to identify charge, storage and discharge
        % Añadir leyenda para identificar carga, almacenamiento y descarga
        legend({'Carga','Almacenamiento','Descarga'}, 'Location', 'south')
end

% Ask user if the current vs time plot is required
% Preguntar al usuario si quiere ver la gráfica de corriente respecto al tiempo
respuesta_usuario = questdlg('¿Deseas abrir la gráfica de corriente respecto al tiempo?','Gráficas');
switch respuesta_usuario
    case 'Yes'                                 % If answer us yes - Si la respuesta es si
        
        ti = [0:0.01:(tc+to)];                 % Create time vector from 0 to charge time      -  Crear vector de tiempo de 0 a tiempo de carga
        I = (V/Rc)*exp(-((((1/C)/Rc)*ti)));    % Calculate current based on ti vector          -  Calcular corriente respecto al vector ti
        
        ti1 = [0:0.01:td];                     % Create time vector from 0 to discharge time   -  Crear vector de tiempo de 0 a tiempo de descarga
        I2 = (V/Rd)*(exp(-(((1/C)/Rd)*ti1)));  % Calculate voltage based on ti1 vector         -  Calcular voltaje respecto al vector de ti1
        ti2 = ti1 + (tc+to);                   % Sum charge and storage time to ti2 vector     -  Sumar el tiempo de carga y almacenamiento al vector ti2

        % Graph configuration
        % Configuración de la gráfica
        figure('Name', 'Gráfica Corriente Respecto al Tiempo');
        title('Gráfico Tiempo-Corriente');

        % Set axis labels
        % Establecer etiquetas de los ejes
        xlabel('Tiempo (Segundos)');
        ylabel('Corriente (Ampere)')
        
        hold on 

        % Plot I and I2 using their respective ti and ti2 time vectors
        % Graficar I e I2 respecto a sus respectivos vectores de tiempo ti y ti2
        plot(ti,I, 'color', 'black', 'LineWidth', 3)
        plot(ti2,I2, 'color', 'black', 'LineWidth', 3)
end

% Ask user if the charge vs time plot is required
% Preguntar al usuario si quiere ver la gráfica de carga respecto al tiempo
respuesta_usuario = questdlg('¿Deseas abrir la gráfica de carga respecto al tiempo?','Gráficas');
switch respuesta_usuario
    case 'Yes'                               % If answer us yes - Si la respuesta es si
        
        tq = [0:0.01:(tc+to)];               % Create time vector from 0 to charge and storage time  -  Crear vector de tiempo de 0 a tiempo de carga y almacenamiento
        Q1 = (V*(1-exp(-(tq/(Rc*C))))) * C;  % Calculate charge using tq vector                      -  Calcular carga respecto al vector de tq
        
        tq15 = [0:0.001:td];                 % Create time vector from 0 to discharge time           -  Crear vector de tiempo de 0 a tiempo de descarga
        Q2 = (V * exp(-(tq15/(Rd*C)))) * C;  % Calculate charge using tq15 vector                    -  Calcular carga respecto al vector de tq15
        tq2 = tq15 + (tc + to);              % Sum charge and storage time using tq15 vector         -  Sumar el tiempo de carga y almacenamiento al vector tq15

        % Graph configuration
        % Configuración de la gráfica
        figure('Name', 'Gráfica Carga Respecto al Tiempo');
        title('Gráfico Tiempo-Carga');

        % Set axis labels
        % Establecer etiquetas de los ejes
        xlabel('Tiempo (Segundos)');
        ylabel('Carga (Coulomb)')
        
        hold on

        % Plot Q1 and Q2 using their respective time vector tq and tq2
        % Graficar Q1 y Q2 respecto a sus respectivos vectores de tiempo tq y tq2
        plot(tq,Q1, 'color', 'magenta', 'LineWidth', 3)
        plot(tq2,Q2, 'color', 'magenta', 'LineWidth', 3)
end

% Print the circuit results
% Imprimir los resultados del circuito
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
