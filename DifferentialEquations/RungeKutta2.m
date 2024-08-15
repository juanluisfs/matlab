%% Function to solve differential equation with Runge Kutta Approach
%% Función para resolver ecuaciones diferenciales con el método Runge Kutta

function [vx,vy] = RungeKutta2(f,x0,y0,xf,n)
    %Inicia el método
    h = (xf-x0)/n;
    vx(1) = x0;
    vy(1) = y0;
    
    %Llenar el vector x
    for i = 1:n
        vx(i+1) = vx(i) + h;
    end

    %Llenar el vector y
    for i=1:n
        k1 = f(vx(i),vy(i));
        k2 = f((vx(i)+h),(vy(i)+k1*h));
        y1 = vy(i) + ((k1/2)+(k2/2))*h;
        vy(i+1) = y1;
    end
end
