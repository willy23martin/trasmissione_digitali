%Santiago de cali, 26 de mayo de 2017
%Universidad Icesi.
%--------------------------------------------------------------------------------------------------------------
%PROYECTO FINAL DE COMUNICACIONES DIGITALES.
%TEMA: Simulaci�n de un SCD.
%Presenta: William Mart�n Ch�vez Gonz�lez, C�digo: A00242064
%Presenta: Juan Camilo Swan, C�digo:A00054620.
%Presenta: Tom�s Lemus, C�digo: A00054616.
%--------------------------------------------------------------------------------------------------------------
%Requerimientos del proyecto:
%1)Formato de la informaci�n: archivo de audio.
%2)Codificador de fuente: Base64.
%3)C�dificador de canal: C�digo convolucional (R=1/2; k=3; g1(x)=1+x;
%g2(x)=1+x^2).
%4)Codificador digital-Modulador digital: 8-PSK.
%5)Canal: Rayleigh.
%--------------------------------------------------------------------------------------------------------------
%--------------------------------------------------------------------------------------------------------------
%Instrucciones iniciales:
clear all;
close all;
%prompt = 'Ingrese la relaci�n se�al a ruido de bit (EbNo) en dB:';
%EbNo=input(prompt);%relaci�n se�al a ruido de bit requerido por el usuario.
gui=inputdlg({'Ingrese la relaci�n se�al a ruido de bit (EbNo) en dB:'}, 'SCD',[1 50]);
EbNo=str2double(gui{1});
disp(EbNo);
%%
%-------------------------------------------------------
%-------------------------------------------------------
%FUENTE DE LA INFORMACI�N:
%Captura de la se�al de audio con un micr�fono:
Fs=44100;%corresponde a dos veces la m�xima componente en frecuencia de una se�al de audio.
numeroBits=8;%n�mero de bits por muestra para la cuantizaci�n de las amplitudes de cada una de las muestras.
grabadora = audiorecorder(Fs,8,1);%8 bits por muestra y un solo canal.
msgbox('De click en OK. Tiene 6 segundos para hablar.')
recordblocking(grabadora, 6);%captura la se�al de audio durante 3 segundos.
msgbox('Finaliz� la grabaci�n.');
play(grabadora);%reproduce la se�al de audio grabada.
senalAudio = getaudiodata(grabadora, 'uint8');%almacena la se�al en un arreglo de doble precisi�n. 
disp('Se�al de audio grabada:');
disp(senalAudio(1:10));
figure('Name','Se�al de audio grabada','NumberTitle','off');
plot(senalAudio, 'LineStyle','-.',...
     'MarkerFaceColor','blue',...
     'MarkerEdgeColor','green'); %muestra la se�al de audio grabada.
title('Se�al de audio grabada');
xlabel('t');
ylabel('x(t)'); 
%%
%-------------------------------------------------------
%-------------------------------------------------------
%CODIFICADOR DE FUENTE: 
codigoBase64=matlab.net.base64encode(senalAudio);%codifica en base64 la se�al de audio binaria.
disp('Se�al codificada en Base64 por el Codificador de fuente:');
disp(codigoBase64(1:20));
%%
%-------------------------------------------------------
%-------------------------------------------------------
%CODIFICADOR DE CANAL:
representacionNumericaBase64=double(codigoBase64);%representaci�n num�rica de caracteres ASCII Base64.
disp('Representaci�n num�rica de la se�al codificada en Base64:');
disp(representacionNumericaBase64(1:5));
ristraBitsEntrada=convertirVectorBinario(representacionNumericaBase64);%decodifica el c�digo Base64 a binario.
%recibido del audio para determinar la se�alde audio binaria.
disp('Ristra de bits de entrada al codificador de canal:');
disp(ristraBitsEntrada(1:40));
%.......................
figure('Name','Se�al de audio codificada Base64 en binario:','NumberTitle','off');
stem(ristraBitsEntrada(1:1:100), 'LineStyle','-.',...
     'MarkerFaceColor','blue',...
     'MarkerEdgeColor','green');
title('Muestras de la se�al de audio:');
xlabel('n');
ylabel('x[n]'); 
%.......................
%definici�n del algoritmo Trellis:
%Posibles s�mbolos de entrada=2, porque puede entrar un 1 o un 0.
%Posibles s�mbolos de salida=4, porque puede salir un 1 (01), un 2 (10), un
%3(11) o un 0 (00).
%Posibles estados=4, porque son 00, 01, 11 y 10.
%Siguientes estados: cuatro filas porque son cuatro estados, dos columnas
%porque puede entrar un uno o un cero; la primera columna es si entra un cero y la
%segunda columna es si entra un uno. El contenido por fila vs columna es el
%estado al que pasa con relaci�n a la entrada: ejemplo, si est�  en 00 que
%es la primera fila y entra un 0, entonces para a estado 00; si entra un 1,
%entonces pasa a estado 2(10).
%Salidas: son las salidas requeridas por la codificaci�n ante una entrada,
%dependiendo en el estado en que se encuentre. Por ejemplo, si est� en
%estado 00(primera fila) y entra un 0, entonces sale 00(0); si entra un 1,
%entonces sale 11 (3).
trellisAlgorithm=struct('numInputSymbols',2,'numOutputSymbols',4,'numStates',4,...
    'nextStates',[0 2;0 2;1 3;1 3],'outputs',[0 3;1 2;2 1;3 0]);
%.......................
codigoConvolucional=convenc(ristraBitsEntrada,trellisAlgorithm);%c�digo convolucional aplicado a la ristra de bits.
disp('Se�al codificada en c�digo convolucional por el Codificador de Canal:');
disp(codigoConvolucional(1:20));
%-------------------------------------------------------
%-------------------------------------------------------
%MODULADOR DIGITAL:
M=8;%n�mero de s�mbolos correspondientes a la modulaci�n 8-PSK.
k=log2(M);%n�mero de bits por s�mbolo.
separacionAngular=(2*pi/M);
%.......................
%Definir el modelo de modulaci�n 8-PSK:
%Orden de la modulaci�n: M = 8 s�mbolos.
%Fase del punto cero de la constelaci�n.
%Entrada de bits habilitada.
%Codificaci�n gray habilitada.
modulador8PSK = comm.PSKModulator('ModulationOrder',M,'PhaseOffset',separacionAngular,'BitInput', ...
    true,'SymbolMapping','gray');
%.......................
senalModulada=step(modulador8PSK,codigoConvolucional');%modula el c�digo convolucional con 
%el modulador 8-PSK definido.
disp('Se�al modulada por un modulador 8-PSK:');
disp(senalModulada(1:10));
%.......................
h1=scatterplot(senalModulada);
hold on
scatterplot(senalModulada,[],[],'r*',h1)
title('Constelaci�n 8-PSK de los s�mbolos digitales antes de salir del canal:');
xlabel('I - en fase');
ylabel('Q - en cuadratura'); 
%.......................
constellation(modulador8PSK);
title('Codificaci�n Gray para cada s�mbolo digital 8-PSK:');
xlabel('I - en fase');
ylabel('Q - en cuadratura'); 
%.......................
%-------------------------------------------------------
%-------------------------------------------------------
%CANAL DE COMUNICACI�N:
%Tipo: canal Rayleigh-usada en comunicaciones inal�mbricas.
canalRayleigh=rayleighchan;%canal con una sola ruta sin efecto Doppler.
efectoCanalRayleigh=filter(canalRayleigh,senalModulada);%efecto del canal Rayleigh sobre los
%s�mbolos digitales.
disp('Efecto del canal Rayleigh sobre la se�al modulada:');
disp(efectoCanalRayleigh(1:10));
%.......................
senalEfectoCanalRayleighRuidoGaussiano = awgn(efectoCanalRayleigh,EbNo);%efectoCanalRayleigh
h=scatterplot(senalEfectoCanalRayleighRuidoGaussiano);%senalEfectoCanalRayleighRuidoGaussiano
hold on
scatterplot(senalModulada,[],[],'r*',h)
grid
title('Constelaci�n de los s�mbolos digitales despu�s de salir del Canal Rayleigh:');
xlabel('I - en fase');
ylabel('Q - en cuadratura'); 
%.......................

