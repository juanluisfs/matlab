%% BI2012B Análisis de la Mecánica de Biofluidos
%% Juan Luis Flores Sánchez
%% Activity C - Atherosclerotic Plaque

clc

prompt = {'Internal Diameter (m)','Stenosis Diameter (m)',"Blood's
Density (kg/m3)","Blood's Viscosity (N s/m2)",'Internal Flow
(m3/s)','Length of the Input Cone (m)','Length of the Stenosis Cylinder
(m)','Aortic Pressure (Pa)'};
digtitle = 'Introduce los valores';
dims = [1 25];
definput = {'0.003','0.0015','1060','-0.0036','0.00000166','0.004','0.004','13332.2'};
answer = inputdlg(prompt, digtitle, dims, definput);

DI = str2num(answer{1});
DS = str2num(answer{2});
rho = str2num(answer{3});
miu = str2num(answer{4});
Q = str2num(answer{5});
LC = str2num(answer{6});
LS = str2num(answer{7});
PA = str2num(answer{8});

AI = pi * (DI/2) ^ 2;
AS = pi * (DS/2) ^ 2;
IS = ((DI/DS) ^ 3 - 1) / (3 * (1 - (DS/DI)));

PFC = (128 * miu * LC * IS * Q) / (pi * DI ^ 4);
PFS = (128 * miu * LS * Q) / (pi * DS ^ 4);
PIC = 0.5 * rho * ((1 / AS) ^ 2 - (1 / AI) ^ 2) * Q^2;
PTOT = PFC + PFS + PIC;

PD = PA - PTOT;
FFR = PD / PA;

M = round([AI;AS;IS;PFC;PFS;PIC;PTOT;PD;FFR],12);
T = array2table(M,'VariableNames',{'Resultados'},'RowName',{'A_s','A_i','I_s','P_FC','P_FS','P_IC','P_Total','PD','FFR'});
disp(T)
