%Santiago de cali, 02 de octubre de 2017
%Universidad Icesi.
%--------------------------------------------------------------------------------------------------------------
%TALLER #1 DE COMUNICACIONES INAL�MBRICAS.
%TEMA: Simulaci�n de un Sistema m�vil inal�mbrico.
%Presenta: William Mart�n Ch�vez Gonz�lez, C�digo: A00242064.
%--------------------------------------------------------------------------------------------------------------
%%
%-------------------------------------------------------
%-------------------------------------------------------
%CARACTER�STICAS DEL SCD M�VIL INAL�MBRICO:
close all;
clear all;
d = 0:0.1:7;         %Distancia entre el transmisior y el receptor en Km.
Rb = 0:1000:10000000;    %Tasa de transmisi�n binaria del SCD en bps.
pt = 30000;          %Potencia del Tx en mW.
Pt = 10*log10(pt);   %Potencia del Tx en dBm.
fc = 1700;           %Frecuencia de la se�al portadora carrier en MHz. 
No = 4.21*10^(-18);  %Densidad espectral del ruido en  mW/Hz.
ht = 25;             %Altura de la torre para la antena base en m.
hm = 0.01;           %Altura de la antena para el receptor m�vil en m.
Gt = 22.86;          %Ganancia de la antena en el transmisor en dB.
Gr = 2.86;           %Ganancia de la antena en el receptor en dB.
Lcable = 6.6/100;    %P�rdidas del cable desde el radio de la antena FlexLine 7/8" en dB/m.
Lconector = 0.5;     %P�rdidas debido a conectores del fabricante en dB/conector.
Lprotector = 0.1;    %P�rdidas por protector contra descargas el�ctricas en dB/protector.
FN = 10;             %Figura de ruido en el receptor en dB.
EbNo = 8;            %Relaci�n se�al a ruido de bit en dB.
BW = 20000000;       %Ancho de Banda en Hz.

%C�LCULOS PREVIOS:
S = -174 + 10.*log10(Rb)+EbNo+FN;    %Nivel de sensibilidad en el receptor en dBm.
aHm = 3.2*((log10(11.75*hm))^2)-4.97;%Factor de correcci�n del modelo Okumura-Hata en dB.
%P�rdidas de trayecto considerando shadowing - Modelo de Propagaci�n
%Okumura-Hata en dB.
Lnlos = 69.55+26.16*log10(fc)-13.82*log10(ht)-aHm+(44.9-6.55*log10(ht)).*log10(d);
Lm = (ht*Lcable)+(4*Lconector)+(1*Lprotector); %P�rdidas miscel�neas en dB.
Pr = Pt + Gt + Gr - Lm - Lnlos;                %Potencia media en el receptor en dBm.
FM = Pt - S;                                   %Margen de protecci�n en dB.
pr = 10.^(Pr/10);                              %Potencia en el receptor en mW.
C = BW.*log2(1+(pr/(No*BW)));                  %Capacidad de canal en bps.

%==================================================================================
% GR�FICA DE PATH LOSS VS DISTANCIA.
figure('Name','SCD m�vil inal�brico','NumberTitle','off');
semilogy(d,Lnlos,'r-');
legend('Lnlos Okumura-Hata dB');
xlabel('Distancia (Km)'); ylabel('Path Loss (dB)');
title('Path Loss(dB) vs Distancia (Km)');
ylim([0 170]);
%====================================
% GR�FICA DE POTENCIA RECIBIDA VS DISTANCIA.
figure('Name','SCD m�vil inal�brico','NumberTitle','off');
semilogy(d,Pr,'b-');
legend('Potencia recibida dBm');
xlabel('Distancia (Km)'); ylabel('Pr (dBm)');
title('Potencia Recibida(dBm) vs Distancia (Km)');
ylim([-100 -30]);
%====================================
% GR�FICA DE CAPACIDAD DE CANAL VS DISTANCIA.
figure('Name','SCD m�vil inal�brico','NumberTitle','off');
semilogy(d,C,'b-');
legend('Capacidad bps');
xlabel('Distancia (Km)'); ylabel('C (bps)');
title('Capacidad de Canal (bps) vs Distancia (Km)');
%ylim([-100 -30]);
%====================================
%====================================
% GR�FICA DE SENSIBILIDAD VS TASA BINARIA.
figure('Name','SCD m�vil inal�brico','NumberTitle','off');
semilogy(Rb,S,'b-');
legend('Sensibilidad dBm');
xlabel('Rb (bps)'); ylabel('S (dBm)');
title('Sensibilidad (dBm) vs Tasa Binaria (bps)');
ylim([-110 -80]);
%====================================
%====================================
% GR�FICA DE CAPACIDAD DE CANAL VS POTENCIA RECIBIDA.
figure('Name','SCD m�vil inal�brico','NumberTitle','off');
semilogy(Pr,C,'b-');
legend('Capacidad bps');
xlabel('Pr (dBm)'); ylabel('C (bps)');
title('Capacidad de Canal (bps) vs Potencia Recibida (dBm)');
xlim([-100 -30]);
%====================================