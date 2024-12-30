%% From Star (Y) to DElta
%% De Estrella a Delta

format shortEng

% Capture Star (Y) Resistor Values
% Capturar los valores de las resistencia Estrella (Y)
r1 = 1300
r2 = 2100
r3 = 4780

suma = (r1*r2)+(r2*r3)+(r3*r1);

% Print Star (Y) Results
% Imprimir resultados Estrella (Y)
ra = suma/r2
rb = suma/r3
rc = suma/r1

heubr
