%Santiago de cali, 26 de mayo de 2017
%Universidad Icesi.
%--------------------------------------------------------------------------------------------------------------
%PROYECTO FINAL DE COMUNICACIONES DIGITALES.
%TEMA: Simulaci�n de un SCD.
%Presenta: William Mart�n Ch�vez Gonz�lez, C�digo: A00242064.
%Presenta: Juan Camilo Swan, C�digo:A00054620.
%Presenta: Tom�s Lemus, C�digo:A00054616. 
%--------------------------------------------------------------------------------------------------------------
%Requerimientos del proyecto:
%1)Formato de la informaci�n: archivo de audio.
%2)Decodificador de fuente: Base64.
%3)Decodificador de canal: C�digo convolucional (R=1/2; k=3; g1(x)=1+x;
%g2(x)=1+x^2).
%4)Decodificador digital-Demodulador digital: 8-PSK.
%5)Canal: Rayleigh.
%--------------------------------------------------------------------------------------------------------------
%--------------------------------------------------------------------------------------------------------------
%Instrucciones iniciales:
%clear all;
%close all;
%-------------------------------------------------------
%-------------------------------------------------------
%DEMODULADOR DIGITAL:
senalADemodular=vec2mat(senalEfectoCanalRayleighRuidoGaussiano,1);
demodulador8PSK = comm.PSKDemodulator('ModulationOrder',M,'PhaseOffset',separacionAngular,'BitOutput',true,'SymbolMapping','gray');
senalSalidaCanal=step(demodulador8PSK,senalEfectoCanalRayleighRuidoGaussiano);
disp('Se�al demodulada por el Demodulador Digital:');
disp(senalSalidaCanal(1:10)');
senalDemoduladaBinaria=senalSalidaCanal';
%-------------------------------------------------------
%-------------------------------------------------------
%DECODIFICADOR DE CANAL:
unidadesMemoriaCodigoConvolucional=3; %k=3 para el c�digo convolucional.
%.......................
%decodificaci�n del c�digo convolucional con el Algoritmo de Viterbi:
ristraBitsDecodificada=vitdec(senalDemoduladaBinaria,trellisAlgorithm,unidadesMemoriaCodigoConvolucional,'trunc','hard');
%.......................
disp('Se�al decodificada por el Decodificador de Canal:');
disp(ristraBitsDecodificada(1:20));
%-------------------------------------------------------
%-------------------------------------------------------
%DECODIFICADOR DE FUENTE:
codigoDecodificadoBase64=convertirVectorDecimal(ristraBitsDecodificada);
senalDecodificadaCaracteresBase64=char(codigoDecodificadoBase64);
senalAudioDecodificada=matlab.net.base64decode(senalDecodificadaCaracteresBase64);
disp('Se�al audio decodificada por el decodificador de fuente:');
disp(ristraBitsDecodificada(1:10));
%-------------------------------------------------------
%-------------------------------------------------------
player=audioplayer(senalAudioDecodificada,Fs);
play(player)

