

delete(instrfind({'Port'},{'COM4'}));
%crear objeto serie
s = serial('COM4','BaudRate',14400,'Terminator','CR/LF');
warning('off','MATLAB:serial:fscanf:unsuccessfulRead');





%abrir puerto
fopen(s);

    % parámetros de medidas
tmax = 10; % tiempo de captura en s
rate = 30; % resultado experimental (comprobar)
% preparar la figura

f = figure('Name','ECG');
a = axes('XLim',[0 tmax],'YLim',[-0.5 5]);
l1 = line(nan,nan,'Color','g','LineWidth',2);
xlabel('Tiempo (s)')
ylabel('Voltaje (V)')
title('Captura de Datos en tiempo real')
grid on
hold on
% inicializar
v1 = zeros(1,tmax*rate);
i = 1;
t = 0;
% ejecutar bucle cronometrado
tic

%while 1

    while t<tmax
    t = toc;
    % leer del puerto serie
    a = fscanf(s,'%d')';
    v1(i)=a(1)*5/1024;
    % dibujar en la figura
    x = linspace(0,i/rate,i);
    plot(l1,'YData',v1(1:i),'XData',x);
    drawnow
    % seguir
    
    i = i+1;
   
    end
    
   % save l1.dat l1 -ascii -append;
   % save v1.dat v1 -ascii -append;
    %save x.dat x -ascii -append;

%subplot(2,1,2);
%leerl1 = load('l1.dat');
%leerv1 = load('v1.dat');
%leerx = load('x.dat');
%f = figure('Name','ECG');
%a = axes('XLim',[0 tmax],'YLim',[4 5]);
%l1 = line(nan,nan,'Color','g','LineWidth',2);
%xlabel('Tiempo (s)')

%ylabel('Voltaje (V)')
%5title('Captura de Datos en tiempo real')
%grid on
%hold on
%plot(leerl1,'YData',leerv1,'XData',leerx);
    %drawnow
close;
% resultado del cronometro
%clc;
fprintf('MUESTRAS:   %g s de captura a %g cap/s \n',t,i/t);
% Limpiar la escena del crimen
fclose(s);
delete(s);
clear s;

%x=x+1


