function [ senalAudioBinaria ] = convertirVectorBinario( representacionNumericaBase64 )
%Funci�n que convierte los valores decimales muestreados de la se�al de
%audio, en un vector binario correspondiente.
matrizAudioBinaria=de2bi(representacionNumericaBase64,8);%cada fila es el valor en binario del valor decimal de una muestra de se�al.
tamanioMatrizAudioBinaria=size(matrizAudioBinaria);
filasMatrizAudioBinaria=tamanioMatrizAudioBinaria(1,1);
%disp(filasMatrizAudioBinaria);
%Formar el vector binario de la se�al de audio:
senalAudioBinaria=[];
j=1;
for i=1:filasMatrizAudioBinaria
    %disp(i);
    filaBinaria= matrizAudioBinaria(i,:);
    %disp(filaBinaria);
    senalAudioBinaria(j:(7+j))=filaBinaria;
    %disp(senalAudioBinaria);
    j=8+j;
end

