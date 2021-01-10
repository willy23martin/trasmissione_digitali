%Santiago de cali, 26 de mayo de 2017
%Universidad Icesi.
%--------------------------------------------------------------------------------------------------------------
%PROYECTO FINAL DE COMUNICACIONES DIGITALES.
%TEMA: Simulaci�n de un SCD.
%Presenta: William Mart�n Ch�vez Gonz�lez, C�digo: A00242064
%Presenta: Juan Camilo Swan, C�digo:A00054620.
%Presenta: Tom�s Lemus, C�digo: A00054616.
%--------------------------------------------------------------------------------------------------------------
%%
%-------------------------------------------------------
%-------------------------------------------------------
%PROBABILIDAD DE ERROR DE BIT Y DE S�MBOLO VS SNR:
tx = codigoConvolucional;        %c�digo convolucional (ristra de bits) que entra al modulador 8-PSK.
pskSig = step(modulador8PSK, tx');       % modular la se�al con 8PSK.
fadedSig = filter(canalRayleigh,pskSig);    % aplicar el efecto Rayleigh a la se�al modulada.
% Estimar la Probabilidad de error de bit (BER) para diferentes valores de
% SNR (EbNo).
SNR = 0:1:50; % valores de SNR en dB.0:2:20
numSNR = length(SNR);%cantidad de calores de SRN en dB.
berVec = zeros(3, numSNR);
% Crear el canal AWGN y calcular la tasa de error.
hChan = comm.AWGNChannel('NoiseMethod', 'Signal to noise ratio (SNR)');
hErrorCalc = comm.ErrorRate;
for n = 1:numSNR
    hChan.SNR = SNR(n);
   rxSig = step(hChan,fadedSig);   % Add Gaussian noise
   rx = step(demodulador8PSK, rxSig);  % Demodulate
   reset(hErrorCalc)
   % Compute error rate.
   berVec(:,n) = hErrorCalc(tx',rx);
end
BER = berVec(1,:);
% Compute theoretical performance results, for comparison.
BERtheory = berfading(SNR,'psk',M,1);
% Plot BER results.
figure('Name','Probabilidad de error de bit para canal Rayleigh','NumberTitle','off');
semilogy(SNR,BERtheory,'b-',SNR,BER,'r*');
legend('BER Te�rico','BER Experimental');
xlabel('SNR (dB)'); ylabel('BER');
title('8-PSK sobre un canal Rayleigh');
