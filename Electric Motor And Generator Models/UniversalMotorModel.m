% Clean screen and variables
% Limpiar pantalla y variables
clc
clear

% Ask user for universal motor data
% Pedir al usuario los datos iniciales de motor universal
prompt = {'Permeabilidad del medio (Tm)', 'Corriente (A)', 'Número de Vuelta de la Bobina', 'Longitud del Electroimán (m)','Área de la Espira (m2)'};
digtitle = 'Valores del Electroimán';
dims = [1 25];
definput = {'0.000001257','0.564','110','0.075','0.00025'};
answer = inputdlg(prompt, digtitle, dims, definput);

miu = str2num(answer{1});
Ie = str2num(answer{2});
Ne = str2num(answer{3});
Le = str2num(answer{4});
Ae = str2num(answer{5});

prompt = {'Área de la Espira (m2)', 'Corriente (A)', 'Número de Vuelta de la Bobina','Longitud del Rotor (m)','Ángulo del Rotor Respecto al Campo Magnético (º)'};
digtitle = 'Valores del Rotor';
dims = [1 25];
definput = {'0.00008','0.808','90','0.07','90'};
answer = inputdlg(prompt, digtitle, dims, definput);

A = str2num(answer{1});
Ir = str2num(answer{2});
Nr = str2num(answer{3});
Lr = str2num(answer{4});
desp = str2num(answer{5});

prompt = {'Revoluciones Muestra', 'Tiempo de la Muestra (s)'};
digtitle = 'Valores de la Muestra';
dims = [1 25];
definput = {'5','5'};
answer = inputdlg(prompt, digtitle, dims, definput);

Rr = str2num(answer{1});
Tr = str2num(answer{2});

if desp == 0
    while desp == 0
        prompt = {'El ángulo no puede ser igual a 0. Ingresa un nuevo ángulo (º):'};
        digtitle = 'Ingresa el Ángulo de Nuevo';
        dims = [1 25];
        definput = {'90'};
        answer = inputdlg(prompt, digtitle, dims, definput);
        desp = str2num(answer{1});
    end
end

rad = desp*pi/180;

B = miu * Ie * Ne / Le;
FM = Ir * Lr * B * sin(pi/2);
mdm = Nr * Ir * A;
f = Rr / Tr;
T = 1/f;
Inducr = miu * Nr^2 * A / Lr;
Induce = miu * Ne^2 * Ae / Le;

t = [0:0.01:Tr];
tau = abs(mdm * B * sin((2*pi*f*t)+rad));
tiempo = t;

R4 = T / 4;
n = Rr*4;
t4 = [0];
for i = 1:n
    t4(i+1) = t4(i) + R4;
end
tau4 = abs(mdm * B * sin((2*pi*f*t4)+rad));

tp = [0];
for i = 1:Rr
    tp(i+1) = tp(i) + T;
end
taup = abs(mdm * B * sin((2*pi*f*tp)+rad));

figure('Name', 'Gráfica - Torque Respecto al Tiempo','Position',[1 1000 5000 3000]);
title('Gráfico Torque vs Tiempo');
        
xlabel('Tiempo (Segundos)');
ylabel('Torque (Newton - Metro)');
        
hold on
grid on

% Ask user about the figure display
% Preguntar al usuario acerca de la visualización de la figura
respuesta_usuario = questdlg('Indica la figura que deseas visualizar','Tipo de Figura','Gráfica','Simulación','Cancel');
switch respuesta_usuario

    % If the answer is "Graph"
    % Si la respuesta es "Gráfica"
    case 'Gráfica'
        plot(t,tau,'Color','r','LineWidth',2)
        plot(t4,tau4, 'sr', 'LineWidth', 2,'Marker',"*")
        plot(tp,taup, 'sk', 'LineWidth', 4,'Marker',"o", 'MarkerSize',5)
        legend('Torque','Indicador 1/4 de Revolución','Inicio y Fin de 1 Revolución','Location','southoutside')

    % If the answer is "Simulation"
    case 'Simulación'
        temp=plot (0,0,'Marker','o','MarkerSize',10,'MarkerFaceColor','r');  
        y_al = animatedline ( 'Color','r','LineWidth',2); 
        for t=1:length(tau) 
            delete(temp); 
            addpoints(y_al, tiempo(t) , tau(t)); 
            temp=plot (tiempo(t),tau(t),'MarkerSize',10,'MarkerFaceColor','k'); 
            drawnow;
            pause(1)
        end
        plot(t4,tau4, 'sr', 'LineWidth', 2,'Marker',"*")
        plot(tp,taup, 'sk', 'LineWidth', 4,'Marker',"o", 'MarkerSize',5)
        legend('Torque','','Indicador 1/4 de Revolución','Inicio y Fin de 1 Revolución','Location','southoutside')
end

% Get the maximum value of Tau
% Obtener el valor máximo de Tau
taumax = max(tau);

% Print the results
% Imprimir los resultados
fprintf('Resultados del Electroimán: \n')
fprintf(['  Campo Magnético Generado:   %.4f Teslas \n'], B)
fprintf(['  Inductancia:                %.6f Henrys \n \n'], Induce)
fprintf('Resultados del Motor: \n')
fprintf(['  Frecuencia:                 %.4f Hertz \n'], f)
fprintf(['  Fuerza máxima:              %.4f Newtons \n'], FM)
fprintf(['  Momento Dipolar Magnético:  %.4f Webers \n'], mdm)
fprintf(['  Torque Máximo:              %.4f Newton - Metro \n'], taumax)
fprintf(['  Inductancia:                %.6f Henrys \n \n'], Inducr)
