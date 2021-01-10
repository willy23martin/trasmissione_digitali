%Santiago de cali, 30 de mayo de 2017
%Universidad Icesi.
%--------------------------------------------------------------------------------------------------------------
%PROYECTO FINAL DE SE�ALES Y SISTEMAS.
%TEMA: FFT vs Wavelet Transform.
%Presenta: William Mart�n Ch�vez Gonz�lez, C�digo: A00242064.
%--------------------------------------------------------------------------------------------------------------
%Requerimientos del proyecto:
%1)FFT: Fast Fourier Transform.
%--------------------------------------------------------------------------------------------------------------
%--------------------------------------------------------------------------------------------------------------
%Instrucciones iniciales:
clear all;
close all;
Fs=44100;%corresponde a dos veces la m�xima componente en frecuencia de una se�al de audio.
numeroBits=8;%n�mero de bits por muestra para la cuantizaci�n de las amplitudes de cada una de las muestras.
%%
%--------------------------------------------------------------------------------------------------------------
%--------------------------------------------------------------------------------------------------------------
%Captura de la se�al de audio solicitada masculina con un micr�fono:
grabadoraSenalSolicitadaM = audiorecorder(Fs,numeroBits,1);%8 bits por muestra y un solo canal.
msgbox('De click en OK. Tiene 25 segundos para hablar.')
recordblocking(grabadoraSenalSolicitadaM, 25);%captura la se�al de audio durante 9 segundos.
msgbox('Finaliz� la grabaci�n.');
play(grabadoraSenalSolicitadaM);%reproduce la se�al de audio grabada.
senalAudioSolicitadaM = getaudiodata(grabadoraSenalSolicitadaM, 'uint8');%almacena la se�al en un arreglo de doble precisi�n. 
disp('Se�al de audio grabada:');
disp(senalAudioSolicitadaM(1:10));
figure('Name','Se�al de audio:','NumberTitle','off');
plot(senalAudioSolicitadaM, 'LineStyle','-.',...
     'MarkerFaceColor','blue',...
     'MarkerEdgeColor','green'); %muestra la se�al de audio grabada.
title('Se�al de audio grabada');
xlabel('t');
ylabel('x(t)'); 
audiowrite('ArchivoSolicitadaMicrofono1Masculina.wav',senalAudioSolicitadaM,Fs)
%%
%--------------------------------------------------------------------------------------------------------------
%--------------------------------------------------------------------------------------------------------------
%Captura de la se�al de audio solicitada femenina con un micr�fono:
grabadoraSenalSolicitadaF = audiorecorder(Fs,numeroBits,1);%8 bits por muestra y un solo canal.
msgbox('De click en OK. Tiene 25 segundos para hablar.')
recordblocking(grabadoraSenalSolicitadaF, 25);%captura la se�al de audio durante 9 segundos.
msgbox('Finaliz� la grabaci�n.');
play(grabadoraSenalSolicitadaF);%reproduce la se�al de audio grabada.
senalAudioSolicitadaF = getaudiodata(grabadoraSenalSolicitadaF, 'uint8');%almacena la se�al en un arreglo de doble precisi�n. 
disp('Se�al de audio grabada:');
disp(senalAudioSolicitadaF(1:10));
figure('Name','Se�al de audio:','NumberTitle','off');
plot(senalAudioSolicitadaF, 'LineStyle','-.',...
     'MarkerFaceColor','blue',...
     'MarkerEdgeColor','green'); %muestra la se�al de audio grabada.
title('Se�al de audio grabada');
xlabel('t');
ylabel('x(t)'); 
audiowrite('ArchivoSolicitadaMicrofono1Femenina.wav',senalAudioSolicitadaF,Fs)
%%
%--------------------------------------------------------------------------------------------------------------
%--------------------------------------------------------------------------------------------------------------
%Encontrar las componentes de frecuencia con mayor energ�a con FFT:
%...................................................
%Para la se�al de audio solicitada masculina:
guiSolicitadaM=inputdlg({'Ingrese el l�mite inferior de la resoluci�n a la cual desea visualizar las componentes espectrales:'}, 'FFT',[1 50]);
limiteInferiorResolucionM=str2double(guiSolicitadaM{1});

guiSolicitadaM=inputdlg({'Ingrese el l�mite superor de la resoluci�n a la cual desea visualizar las componentes espectrales:'}, 'FFT',[1 50]);
limiteSuperiorResolucionM=str2double(guiSolicitadaM{1});

archivoSenalAudioSolicitadaM=audioread('ArchivoSolicitadaMicrofono1Masculina.wav');
fftSenalAudioSolicitadaM=fft(archivoSenalAudioSolicitadaM,Fs);%transformada de fourier de 
%la se�al de audio letra U.
magnitudesComponentesSenalAudioSolicitadaM=abs(fftshift(fftSenalAudioSolicitadaM));%magnitudes de las componentes espectrales de la se�al
%de audio letra U.
ejeFrecuenciaSolicitadaM=(0:length(fftSenalAudioSolicitadaM(1:resolucionFFTSolicitadaM))-1)*(Fs)/length(fftSenalAudioSolicitadaM(1:resolucionFFTSolicitadaM));%eje de la frecuencia en Hz.
%Fs*(0:(longitudSenalAudioSolicitadaM/2))/longitudSenalAudioSolicitadaM;
%linspace(0,Fs,longitudSenalAudioSolicitadaM);
%=(0:length(fftSenalAudioSolicitadaM(1:resolucionFFTSolicitadaM))-1)*(Fs/2)/length(fftSenalAudioSolicitadaM(1:resolucionFFTSolicitadaM));%eje de la frecuencia en Hz.
figure('Name','An�lisis de Fourier','NumberTitle','off');
subplot(2,1,1);
plot(ejeFrecuenciaSolicitadaM(limiteInferiorResolucionM:limiteSuperiorResolucionM),magnitudesComponentesSenalAudioSolicitadaM(limiteInferiorResolucionM:limiteSuperiorResolucionM))
title('Espectro de frecuencias de la se�al de audio solicitada masculina:')
xlabel('f (Hz)');
ylabel('Amplitud (V)'); 
%...................................................
%...................................................
%Para la se�al de audio solicitada femenina:
guiSolicitadaF=inputdlg({'Ingrese el l�mite inferior de la resoluci�n a la cual desea visualizar las componentes espectrales:'}, 'FFT',[1 50]);
limiteInferiorResolucionF=str2double(guiSolicitadaF{1});

guiSolicitadaF=inputdlg({'Ingrese el l�mite superor de la resoluci�n a la cual desea visualizar las componentes espectrales:'}, 'FFT',[1 50]);
limiteSuperiorResolucionF=str2double(guiSolicitadaF{1});

archivoSenalAudioSolicitadaF=audioread('ArchivoSolicitadaMicrofono1Femenina.wav');

fftSenalAudioSolicitadaF=fft(archivoSenalAudioSolicitadaF,Fs);%transformada de fourier de 
%la se�al de audio solicitada.
magnitudesComponentesSenalAudioSolicitadaF=abs(fftshift(fftSenalAudioSolicitadaF));%magnitudes de las componentes espectrales de la se�al
%de audio solicitada.
ejeFrecuenciaSolicitadaF=(0:length(fftSenalAudioSolicitadaF(1:resolucionFFTSolicitadaF))-1)*Fs/length(fftSenalAudioSolicitadaF(1:resolucionFFTSolicitadaF));%eje de la frecuencia en Hz.

subplot(2,1,2);
plot(ejeFrecuenciaSolicitadaF(limiteInferiorResolucionF:limiteSuperiorResolucionF),magnitudesComponentesSenalAudioSolicitadaF(limiteInferiorResolucionF:limiteSuperiorResolucionF))
title('Espectro de frecuencias de la se�al de audio solicitada femenina:')
xlabel('f (Hz)');
ylabel('Amplitud (V)'); 
%...................................................
%%
%--------------------------------------------------------------------------------------------------------------
%--------------------------------------------------------------------------------------------------------------
%An�lisis usando ventana Hanning en la FFT:
%https://www.mathworks.com/help/signal/ref/hann.html
%...................................................
%https://www.researchgate.net/post/How_Can_I_apply_a_window_eg_Hann_Hamming_etc_after_computing_FFT
%Para la se�al de audio solicitada masculina:
guiSolicitadaM=inputdlg({'Ingrese el l�mite inferior de la resoluci�n a la cual desea visualizar las componentes espectrales:'}, 'FFT',[1 50]);
limiteInferiorResolucionHann=str2double(guiSolicitadaM{1});

guiSolicitadaM=inputdlg({'Ingrese el l�mite superor de la resoluci�n a la cual desea visualizar las componentes espectrales:'}, 'FFT',[1 50]);
limiteSuperiorResolucionHann=str2double(guiSolicitadaM{1});

archivoSenalAudioSolicitadaMHann=audioread('ArchivoSolicitadaMicrofono1Masculina.wav');
longitudSenalAudioSolicitadaM = length(archivoSenalAudioSolicitadaM);
ventanaHanningM=hann(longitudSenalAudioSolicitadaM).*archivoSenalAudioSolicitadaM;
wvtool(ventanaHanningM);

fftSenalAudioSolicitadaMHann=fft(ventanaHanningM,Fs);%transformada de fourier de 
%la ventana Hanning.
magnitudesComponentesSenalAudioSolicitadaMHann=abs(fftshift(fftSenalAudioSolicitadaMHann));%magnitudes de las componentes espectrales de la se�al
%de audio letra U.
ejeFrecuenciaSolicitadaMHann=(0:length(fftSenalAudioSolicitadaMHann(1:limiteSuperiorResolucionHann))-1)*(Fs)/length(fftSenalAudioSolicitadaMHann(1:limiteSuperiorResolucionHann));%eje de la frecuencia en Hz.
%Fs*(0:(longitudSenalAudioSolicitadaM/2))/longitudSenalAudioSolicitadaM;
%linspace(0,Fs,longitudSenalAudioSolicitadaM);
%=(0:length(fftSenalAudioSolicitadaM(1:resolucionFFTSolicitadaM))-1)*(Fs/2)/length(fftSenalAudioSolicitadaM(1:resolucionFFTSolicitadaM));%eje de la frecuencia en Hz.
figure('Name','An�lisis con ventana Hanning','NumberTitle','off');
subplot(2,1,1);
plot(ejeFrecuenciaSolicitadaMHann(limiteInferiorResolucionHann:limiteSuperiorResolucionHann),magnitudesComponentesSenalAudioSolicitadaMHann(limiteInferiorResolucionHann:limiteSuperiorResolucionHann))
title('Espectro de frecuencias de la se�al de audio solicitada masculina con ventana Hanning:')
xlabel('f (Hz)');
ylabel('Amplitud (V)'); 
%...................................................
%%
%...................................................
%Para la se�al de audio solicitada femenina:
guiSolicitadaF=inputdlg({'Ingrese el l�mite inferior de la resoluci�n a la cual desea visualizar las componentes espectrales:'}, 'FFT',[1 50]);
limiteInferiorResolucionHannF=str2double(guiSolicitadaF{1});

guiSolicitadaF=inputdlg({'Ingrese el l�mite superor de la resoluci�n a la cual desea visualizar las componentes espectrales:'}, 'FFT',[1 50]);
limiteSuperiorResolucionHannF=str2double(guiSolicitadaF{1});

archivoSenalAudioSolicitadaF=audioread('ArchivoSolicitadaMicrofono1Femenina.wav');
longitudSenalAudioSolicitadaF = length(archivoSenalAudioSolicitadaF);
ventanaHanningF=hann(longitudSenalAudioSolicitadaF).*archivoSenalAudioSolicitadaF;
wvtool(ventanaHanningF);

fftSenalAudioSolicitadaF=fft(ventanaHanningF,Fs);%transformada de fourier de 
%la se�al de audio solicitada.
magnitudesComponentesSenalAudioSolicitadaF=abs(fftshift(fftSenalAudioSolicitadaF));%magnitudes de las componentes espectrales de la se�al
%de audio letra U.
ejeFrecuenciaSolicitadaF=(0:length(fftSenalAudioSolicitadaF(1:limiteSuperiorResolucionHannF))-1)*Fs/length(fftSenalAudioSolicitadaF(1:limiteSuperiorResolucionHannF));%eje de la frecuencia en Hz.

subplot(2,1,2);
plot(ejeFrecuenciaSolicitadaF(limiteInferiorResolucionHannF:limiteSuperiorResolucionHannF),magnitudesComponentesSenalAudioSolicitadaF(limiteInferiorResolucionHannF:limiteSuperiorResolucionHannF))
title('Espectro de frecuencias de la se�al de audio solicitada femenina con ventana Hanning:')
xlabel('f (Hz)');
ylabel('Amplitud (V)'); 
%...................................................
%%
%--------------------------------------------------------------------------------------------------------------
%--------------------------------------------------------------------------------------------------------------
%An�lisis usando ventana Bartlett en la FFT:
%https://www.mathworks.com/help/signal/ref/hamming.html
%%
%Para la se�al de audio solicitada masculina:
guiSolicitadaM=inputdlg({'Ingrese el l�mite inferior de la resoluci�n a la cual desea visualizar las componentes espectrales:'}, 'FFT',[1 50]);
limiteInferiorResolucionBartlett=str2double(guiSolicitadaM{1});

guiSolicitadaM=inputdlg({'Ingrese el l�mite superor de la resoluci�n a la cual desea visualizar las componentes espectrales:'}, 'FFT',[1 50]);
limiteSuperiorResolucionBartlett=str2double(guiSolicitadaM{1});

archivoSenalAudioSolicitadaMBartlett=audioread('ArchivoSolicitadaMicrofono1Masculina.wav');
longitudSenalAudioSolicitadaMBartlett = length(archivoSenalAudioSolicitadaMBartlett);
ventanaBartlettM=bartlett(longitudSenalAudioSolicitadaMBartlett).*archivoSenalAudioSolicitadaMBartlett;
wvtool(ventanaBartlettM);

fftSenalAudioSolicitadaMBartlett=fft(ventanaBartlettM);%transformada de fourier de 
%la ventana Hanning.
magnitudesComponentesSenalAudioSolicitadaMBartlett=abs(fftshift(fftSenalAudioSolicitadaMBartlett));%magnitudes de las componentes espectrales de la se�al
%de audio letra U.
ejeFrecuenciaSolicitadaMBartlett=(0:length(fftSenalAudioSolicitadaMBartlett(1:limiteSuperiorResolucionBartlett))-1)*(Fs)/length(fftSenalAudioSolicitadaMBartlett(1:limiteSuperiorResolucionBartlett));%eje de la frecuencia en Hz.
%Fs*(0:(longitudSenalAudioSolicitadaM/2))/longitudSenalAudioSolicitadaM;
%linspace(0,Fs,longitudSenalAudioSolicitadaM);
%=(0:length(fftSenalAudioSolicitadaM(1:resolucionFFTSolicitadaM))-1)*(Fs/2)/length(fftSenalAudioSolicitadaM(1:resolucionFFTSolicitadaM));%eje de la frecuencia en Hz.
figure('Name','An�lisis con ventana Bartlett','NumberTitle','off');
subplot(2,1,1);
plot(ejeFrecuenciaSolicitadaMBartlett(limiteInferiorResolucionBartlett:limiteSuperiorResolucionBartlett),magnitudesComponentesSenalAudioSolicitadaMHamming(limiteInferiorResolucionBartlett:limiteSuperiorResolucionBartlett))
title('Espectro de frecuencias de la se�al de audio solicitada masculina con ventana Bartlett:')
xlabel('f (Hz)');
ylabel('Amplitud (V)'); 
%...................................................
%%
%...................................................
%Para la se�al de audio solicitada femenina:
guiSolicitadaF=inputdlg({'Ingrese el l�mite inferior de la resoluci�n a la cual desea visualizar las componentes espectrales:'}, 'FFT',[1 50]);
limiteInferiorResolucionBartlettF=str2double(guiSolicitadaF{1});

guiSolicitadaM=inputdlg({'Ingrese el l�mite superor de la resoluci�n a la cual desea visualizar las componentes espectrales:'}, 'FFT',[1 50]);
limiteSuperiorResolucionBartlettF=str2double(guiSolicitadaF{1});

archivoSenalAudioSolicitadaFBartlett=audioread('ArchivoSolicitadaMicrofono1Femenina.wav');
longitudSenalAudioSolicitadaFBartlett = length(archivoSenalAudioSolicitadaFBartlett);
ventanaBartlettF=bartlett(longitudSenalAudioSolicitadaFBartlett).*archivoSenalAudioSolicitadaFBartlett;
wvtool(ventanaBartlettF);

fftSenalAudioSolicitadaFBartlett=fft(ventanaBartlettF,Fs);%transformada de fourier de 
%la se�al de audio solicitada.
magnitudesComponentesSenalAudioSolicitadaFBartlett=abs(fftshift(fftSenalAudioSolicitadaFHamming));%magnitudes de las componentes espectrales de la se�al
%de audio letra U.
ejeFrecuenciaSolicitadaFBartlett=(0:length(fftSenalAudioSolicitadaFBartlett(1:limiteSuperiorResolucionBartlettF))-1)*Fs/length(fftSenalAudioSolicitadaFHamming(1:limiteSuperiorResolucionBartlettF));%eje de la frecuencia en Hz.

subplot(2,1,2);
plot(ejeFrecuenciaSolicitadaFBartlett(limiteInferiorResolucionBartlettF:limiteSuperiorResolucionBartlettF),magnitudesComponentesSenalAudioSolicitadaFBartlett(limiteInferiorResolucionBartlettF:limiteSuperiorResolucionBartlettF))
title('Espectro de frecuencias de la se�al de audio solicitada femenina con ventana Bartlett:')
xlabel('f (Hz)');
ylabel('Amplitud (V)'); 
%...................................................