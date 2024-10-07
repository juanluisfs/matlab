% Clean screen and variables
% Limpiar pantalla y variables
clc
clear

% Ask user to input the parameters
% Pedir al usuario que ingrese los parámetros
prompt = {'Campo (B) [T]', 'Radio (r) [m]', 'Frecuencia (f) [rpm]','Resistencia (R) [Ω]', 'Número de vueltas de la bobina (N)', 'Ciclos (Ne)'};
digtitle = 'Introduce los valores';
dims = [1 25];
definput = {'0.2','0.6', '1000', '10', '1', '4'};
answer = inputdlg(prompt, digtitle, dims, definput);

% Convert the input strings to numbers
% Convertir los strings de entrada a números
B = str2num(answer{1});
r = str2num(answer{2});
rpm = str2num(answer{3});
R = str2num(answer{4});
N = str2num(answer{5});
Ne = str2num(answer{6});

A = pi * r^2;
f = rpm/60;
T = 1/f;
TNe = T * Ne;

t = [0:0.0001:TNe];

R4 = T / 4;
n = Ne*4;
t4 = [0];
for i = 1:n
    t4(i+1) = t4(i) + R4;
end

tp = [0];
for i = 1:Ne
    tp(i+1) = tp(i) + T;
end

respuesta_usuario = questdlg('Indica el tipo de generador a analizar','Tipo de Generador','Dinamo','Alternador','Ambos','Cancel');
switch respuesta_usuario
    case 'Dinamo'
        phi = abs(B*A*cos(2*pi*f*t));
        efem = abs(N*2*pi*f*B*A*sin(2*pi*f*t));
        Iind = abs(efem / R);
        
        phi4 = abs(B*A*cos(2*pi*f*t4));
        phip = abs(B*A*cos(2*pi*f*tp));
                
        efem4 = abs(N*2*pi*f*B*A*sin(2*pi*f*t4));
        efemp = abs(N*2*pi*f*B*A*sin(2*pi*f*tp));
                
        Iind4 = abs(efem4 / R);
        Iindp = abs(efemp / R);
        
        figure('Name','Análisis de Dinamo','Position',[1,1000,5000,400])
        
        subplot(1,3,1)
        hold on
        grid on
        title('Gráfica Flujo Magnético vs Tiempo')
        xlabel('Tiempo (Segundos)')
        ylabel('Flujo Magnético (Webers)')
        plot(t,phi,'Color','r','LineWidth',2)
        plot(t4,phi4, 'sk', 'LineWidth', 2,'Marker',"*")
        plot(tp,phip, 'sr', 'LineWidth', 4,'Marker',"o", 'MarkerSize',5)
                marca1 = line('XData',t(1),'YData',phi(1),'Marker','o','Color','k', ...
    'MarkerFaceColor','yellow','MarkerSize',10,'LineWidth',2);
                legend('Flujo Magnético','Indicador 1/4 de Revolución','Inicio y Fin de 1 Revolución','Simulación','Location','southoutside')
        
        subplot(1,3,2)
        hold on
        grid on
        title('Gráfica Voltaje Inducido vs Tiempo')
        xlabel('Tiempo (Segundos)')
        ylabel('Voltaje Inducido (Voltios)')
        plot(t,efem,'Color','g','LineWidth',2)
        plot(t4,efem4, 'sk', 'LineWidth', 2,'Marker',"*")
        plot(tp,efemp, 'sg', 'LineWidth', 4,'Marker',"o", 'MarkerSize',5)
        marca2 = line('XData',t(1),'YData',efem(1),'Marker','o','Color','k', ...
    'MarkerFaceColor','yellow','MarkerSize',10,'LineWidth',2);
        legend('Voltaje Inducido','Indicador 1/4 de Revolución','Inicio y Fin de 1 Revolución','Simulación','Location','southoutside')
        
        subplot(1,3,3)
        hold on
        grid on
        title('Gráfica Corriente Inducida vs Tiempo')
        xlabel('Tiempo (Segundos)')
        ylabel('Corriente Inducida (Amperios)')
        plot(t,Iind,'Color','b','LineWidth',2)
        plot(t4,Iind4, 'sk', 'LineWidth', 2,'Marker',"*")
        plot(tp,Iindp, 'sb', 'LineWidth', 4,'Marker',"o", 'MarkerSize',5)
        marca3 = line('XData',t(1),'YData',Iind(1),'Marker','o','Color','k', ...
    'MarkerFaceColor','yellow','MarkerSize',10,'LineWidth',2);
        legend('Corriente Inducida','Indicador 1/4 de Revolución','Inicio y Fin de 1 Revolución','Simulación','Location','southoutside')
        
        phim = max(phi);
        efemm = max(efem);
        Im = max(Iind);
        
        fprintf('Resultados del Dinamo: \n')
        fprintf(['  Flujo magnético máximo: %.2f Weber \n'], phim)
        fprintf(['  Voltaje inducido máximo: %.2f Voltios \n'], efemm)
        fprintf(['  Corriente inducida máxima: %.2f Amperios \n \n'], Im)
        
        lar = length(t);
        
        respuesta_usuario = questdlg('¿Deseas activar la simulación?','Simulación','Yes','No','Cancel');
        switch respuesta_usuario
            case 'Yes'
                for i= 1:lar
                subplot(1,3,1)
                set(marca1,'XData',t(i),'YData',phi(i));
                
                subplot(1,3,2)
                set(marca2,'XData',t(i),'YData',efem(i));
                
                subplot(1,3,3)
                set(marca3,'XData',t(i),'YData',Iind(i));
                
                pause(0.0001)
                end
        end
    
    case 'Alternador'
        phi = B*A*cos(2*pi*f*t);
        efem = N*2*pi*f*B*A*sin(2*pi*f*t);
        Iind = efem / R;
        
        phi4 = B*A*cos(2*pi*f*t4);
        phip = B*A*cos(2*pi*f*tp);
                
        efem4 = N*2*pi*f*B*A*sin(2*pi*f*t4);
        efemp = N*2*pi*f*B*A*sin(2*pi*f*tp);
                
        Iind4 = efem4 / R;
        Iindp = efemp / R;
        
        figure('Name','Análisis de Alternador','Position',[1,100,5000,2000])
        
        subplot(1,3,1)
        hold on
        grid on
        title('Gráfica Flujo Magnético vs Tiempo')
        xlabel('Tiempo (Segundos)')
        ylabel('Flujo Magnético (Webers)')
        plot(t,phi,'Color','r','LineWidth',2)
        plot(t4,phi4, 'sk', 'LineWidth', 2,'Marker',"*")
        plot(tp,phip, 'sr', 'LineWidth', 4,'Marker',"o", 'MarkerSize',5)
                marca1 = line('XData',t(1),'YData',phi(1),'Marker','o','Color','k', ...
    'MarkerFaceColor','yellow','MarkerSize',10,'LineWidth',2);
                legend('Flujo Magnético','Indicador 1/4 de Revolución','Inicio y Fin de 1 Revolución','Simulación','Location','southoutside')
        
        subplot(1,3,2)
        hold on
        grid on
        title('Gráfica Voltaje Inducido vs Tiempo')
        xlabel('Tiempo (Segundos)')
        ylabel('Voltaje Inducido (Voltios)')
        plot(t,efem,'Color','g','LineWidth',2)
        plot(t4,efem4, 'sk', 'LineWidth', 2,'Marker',"*")
        plot(tp,efemp, 'sg', 'LineWidth', 4,'Marker',"o", 'MarkerSize',5)
        marca2 = line('XData',t(1),'YData',efem(1),'Marker','o','Color','k', ...
    'MarkerFaceColor','yellow','MarkerSize',10,'LineWidth',2);
        legend('Voltaje Inducido','Indicador 1/4 de Revolución','Inicio y Fin de 1 Revolución','Simulación','Location','southoutside')
        
        subplot(1,3,3)
        hold on
        grid on
        title('Gráfica Corriente Inducida vs Tiempo')
        xlabel('Tiempo (Segundos)')
        ylabel('Corriente Inducida (Amperios)')
        plot(t,Iind,'Color','b','LineWidth',2)
        plot(t4,Iind4, 'sk', 'LineWidth', 2,'Marker',"*")
        plot(tp,Iindp, 'sb', 'LineWidth', 4,'Marker',"o", 'MarkerSize',5)
        marca3 = line('XData',t(1),'YData',Iind(1),'Marker','o','Color','k', ...
    'MarkerFaceColor','yellow','MarkerSize',10,'LineWidth',2);
        legend('Corriente Inducida','Indicador 1/4 de Revolución','Inicio y Fin de 1 Revolución','Simulación','Location','southoutside')
        
        phim = max(phi);
        efemm = max(efem);
        Im = max(Iind);
        
        fprintf('Resultados del Alternador: \n')
        fprintf(['  Flujo magnético máximo: %.2f Weber \n'], phim)
        fprintf(['  Voltaje inducido máximo: %.2f Voltios \n'], efemm)
        fprintf(['  Corriente inducida máxima: %.2f Amperios \n \n'], Im)
        
        lar = length(t);
        
        respuesta_usuario = questdlg('¿Deseas activar la simulación?','Simulación','Yes','No','Cancel');
        switch respuesta_usuario
            case 'Yes'
                for i= 1:lar
                subplot(1,3,1)
                set(marca1,'XData',t(i),'YData',phi(i));
                
                subplot(1,3,2)
                set(marca2,'XData',t(i),'YData',efem(i));
                
                subplot(1,3,3)
                set(marca3,'XData',t(i),'YData',Iind(i));
                
                pause(0.0001)
                end
        end
        
    case 'Ambos'
        phi = abs(B*A*cos(2*pi*f*t));
        efem = abs(N*2*pi*f*B*A*sin(2*pi*f*t));
        Iind = abs(efem / R);
        
        phi4 = abs(B*A*cos(2*pi*f*t4));
        phip = abs(B*A*cos(2*pi*f*tp));
                
        efem4 = abs(N*2*pi*f*B*A*sin(2*pi*f*t4));
        efemp = abs(N*2*pi*f*B*A*sin(2*pi*f*tp));
                
        Iind4 = abs(efem4 / R);
        Iindp = abs(efemp / R);
        
        figure('Name','Análisis Comparativo Dinamo (1º Renglón) y Alternador (2º Renglón)','Position',[1,1000,5000,3000])
        
        subplot(2,3,1)
        hold on
        grid on
        title('Dinamo - Flujo Magnético')
        xlabel('Tiempo (Segundos)')
        ylabel('Flujo Magnético (Wb)')
        plot(t,phi,'Color','r','LineWidth',2)
        plot(t4,phi4, 'sk', 'LineWidth', 2,'Marker',"*")
        plot(tp,phip, 'sr', 'LineWidth', 4,'Marker',"o", 'MarkerSize',5)
                marca1 = line('XData',t(1),'YData',phi(1),'Marker','o','Color','k', ...
    'MarkerFaceColor','yellow','MarkerSize',10,'LineWidth',2);
                legend('Flujo Magnético','Indicador 1/4 de Revolución','Inicio y Fin de 1 Revolución','Simulación','Location','southoutside')
        
        subplot(2,3,2)
        hold on
        grid on
        title('Dinamo - Voltaje Inducido')
        xlabel('Tiempo (Segundos)')
        ylabel('Voltaje Inducido (V)')
        plot(t,efem,'Color','g','LineWidth',2)
        plot(t4,efem4, 'sk', 'LineWidth', 2,'Marker',"*")
        plot(tp,efemp, 'sg', 'LineWidth', 4,'Marker',"o", 'MarkerSize',5)
        marca2 = line('XData',t(1),'YData',efem(1),'Marker','o','Color','k', ...
    'MarkerFaceColor','yellow','MarkerSize',10,'LineWidth',2);
        legend('Voltaje Inducido','Indicador 1/4 de Revolución','Inicio y Fin de 1 Revolución','Simulación','Location','southoutside')
        
        subplot(2,3,3)
        hold on
        grid on
        title('Dinamo - Corriente Inducida')
        xlabel('Tiempo (Segundos)')
        ylabel('Corriente Inducida (A)')
        plot(t,Iind,'Color','b','LineWidth',2)
        plot(t4,Iind4, 'sk', 'LineWidth', 2,'Marker',"*")
        plot(tp,Iindp, 'sb', 'LineWidth', 4,'Marker',"o", 'MarkerSize',5)
        marca3 = line('XData',t(1),'YData',Iind(1),'Marker','o','Color','k', ...
    'MarkerFaceColor','yellow','MarkerSize',10,'LineWidth',2);
        legend('Corriente Inducida','Indicador 1/4 de Revolución','Inicio y Fin de 1 Revolución','Simulación','Location','southoutside')
        
        phim = max(phi);
        efemm = max(efem);
        Im = max(Iind);
        
        fprintf('Resultados del Dinamo: \n')
        fprintf(['  Flujo magnético máximo: %.2f Weber \n'], phim)
        fprintf(['  Voltaje inducido máximo: %.2f Voltios \n'], efemm)
        fprintf(['  Corriente inducida máxima: %.2f Amperios \n \n'], Im)
        
        phia = B*A*cos(2*pi*f*t);
        efema = N*2*pi*f*B*A*sin(2*pi*f*t);
        Iinda = efema / R;
        
        phi4a = B*A*cos(2*pi*f*t4);
        phipa = B*A*cos(2*pi*f*tp);
                
        efem4a = N*2*pi*f*B*A*sin(2*pi*f*t4);
        efempa = N*2*pi*f*B*A*sin(2*pi*f*tp);
                
        Iind4a = efem4a / R;
        Iindpa = efempa / R;
        
        subplot(2,3,4)
        hold on
        grid on
        title('Alternador - Flujo Magnético')
        xlabel('Tiempo (Segundos)')
        ylabel('Flujo Magnético (Wb)')
        plot(t,phia,'Color','r','LineWidth',2)
        plot(t4,phi4a, 'sk', 'LineWidth', 2,'Marker',"*")
        plot(tp,phipa, 'sr', 'LineWidth', 4,'Marker',"o", 'MarkerSize',5)
        marca4 = line('XData',t(1),'YData',phi(1),'Marker','o','Color','k', ...
    'MarkerFaceColor','yellow','MarkerSize',10,'LineWidth',2);
        legend('Flujo Magnético','Indicador 1/4 de Revolución','Inicio y Fin de 1 Revolución','Simulación','Location','southoutside')
        
        subplot(2,3,5)
        hold on
        grid on
        title('Alternador - Voltaje Inducido')
        xlabel('Tiempo (Segundos)')
        ylabel('Voltaje Inducido (V)')
        plot(t,efema,'Color','g','LineWidth',2)
        plot(t4,efem4a, 'sk', 'LineWidth', 2,'Marker',"*")
        plot(tp,efempa, 'sg', 'LineWidth', 4,'Marker',"o", 'MarkerSize',5)
        marca5 = line('XData',t(1),'YData',efem(1),'Marker','o','Color','k', ...
    'MarkerFaceColor','yellow','MarkerSize',10,'LineWidth',2);
        legend('Voltaje Inducido','Indicador 1/4 de Revolución','Inicio y Fin de 1 Revolución','Simulación','Location','southoutside')
        
        subplot(2,3,6)
        hold on
        grid on
        title('Alternador - Corriente Inducida')
        xlabel('Tiempo (Segundos)')
        ylabel('Corriente Inducida (A)')
        plot(t,Iinda,'Color','b','LineWidth',2)
        plot(t4,Iind4a, 'sk', 'LineWidth', 2,'Marker',"*")
        plot(tp,Iindpa, 'sb', 'LineWidth', 4,'Marker',"o", 'MarkerSize',5)
        marca6 = line('XData',t(1),'YData',Iind(1),'Marker','o','Color','k', ...
    'MarkerFaceColor','yellow','MarkerSize',10,'LineWidth',2);
        legend('Corriente Inducida','Indicador 1/4 de Revolución','Inicio y Fin de 1 Revolución','Simulación','Location','southoutside')
        
        phim = max(phia);
        efemm = max(efema);
        Im = max(Iinda);
        
        fprintf('Resultados del Alternador: \n')
        fprintf(['  Flujo magnético máximo: %.2f Weber \n'], phim)
        fprintf(['  Voltaje inducido máximo: %.2f Voltios \n'], efemm)
        fprintf(['  Corriente inducida máxima: %.2f Amperios \n \n'], Im)
        
        lar = length(t);
        
        respuesta_usuario = questdlg('¿Deseas activar la simulación?','Simulación','Yes','No','Cancel');
        switch respuesta_usuario
            case 'Yes' 
                for i= 1:lar
                subplot(2,3,1)
                set(marca1,'XData',t(i),'YData',phi(i));
                
                subplot(2,3,2)
                set(marca2,'XData',t(i),'YData',efem(i));
                
                subplot(2,3,3)
                set(marca3,'XData',t(i),'YData',Iind(i));
                
                subplot(2,3,4)
                set(marca4,'XData',t(i),'YData',phia(i));
                
                subplot(2,3,5)
                set(marca5,'XData',t(i),'YData',efema(i));
                
                subplot(2,3,6)
                set(marca6,'XData',t(i),'YData',Iinda(i));
                
                pause(0.0001)
                end
        end
end
