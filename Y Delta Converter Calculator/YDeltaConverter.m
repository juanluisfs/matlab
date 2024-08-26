%% From Star (Y) to DElta
%% De Estrella a Delta

format shortEng

r1 = 1300
r2 = 2100
r3 = 4780

suma = (r1*r2)+(r2*r3)+(r3*r1);
ra = suma/r2
rb = suma/r3
rc = suma/r1

%% From Delta to Star (Y)
%% De Delta a Estrella

format shortEng

ra = 33
rb = 20
rc = 21

suma = ra+rb+rc;
r1 = (ra*rb)/suma
r2 = (rb*rc)/suma
r3 = (rc*ra)/suma
