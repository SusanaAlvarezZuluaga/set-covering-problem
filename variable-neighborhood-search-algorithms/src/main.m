 
% definir parametros
maxIterSinMejorar=5;
maxTiempoComputo=300;%en segundos


%archivos con los datos
f1=string('../datos/scp41.txt');f2=string('../datos/scp42.txt');f3=string('../datos/scpnrg1.txt');
f4=string('../datos/scpnrg2.txt');f5=string('../datos/scpnrg3.txt');f6=string('../datos/scpnrg4.txt');
f7=string('../datos/scpnrg5.txt');f8=string('../datos/scpnrh1.txt');f9=string('../datos/scpnrh2.txt');
f10=string('../datos/scpnrh3.txt');f11=string('../datos/scpnrh4.txt');f12=string('../datos/scpnrh5.txt');
files=[f1,f2,f3,f4,f5,f6,f7,f8,f9,f10,f11,f12];
warning('off', 'MATLAB:xlswrite:AddSheet');

for i=1:12
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%LECTURA SOLUCION INICIAL%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    file=files(i);
    [num_elementos,num_subconjuntos,costos,relaciones]=leer_datos(file);
    solucionInicial=xlsread('../datos/SolucionesIniciales.xlsx',i);
   
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% ILS %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    tic;
    solucionILS=ILS(solucionInicial,relaciones,costos,maxIterSinMejorar,maxTiempoComputo);
    disp('El tiempo en correr el algoritmo ILS con la instancia'+files(i)+ 'es de:'+toc)
    
    %escribir la solucion en el excel
    costo_optimo=dot(solucionILS,costos);
    subconjuntos_elegidos=find(solucionILS==1);subconjuntos_elegidos=sort(subconjuntos_elegidos);
    numero_de_subconjuntos_elegidos=size(subconjuntos_elegidos,2);
    matriz_respuesta=[costo_optimo,numero_de_subconjuntos_elegidos,subconjuntos_elegidos];
    tabla_respuesta = table(matriz_respuesta);
    file_name='../resultados/SCP_ILS_susana_alvarez.xlsx';
    z=table(zeros(1000)*nan);
    writetable(z,file_name,'WriteVariableNames',0,'Sheet',i);
    writetable(tabla_respuesta,file_name,'WriteVariableNames',0,'Sheet',i);
  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% VND %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    tic;
    solucionVND=VND(solucionInicial,relaciones,costos,maxTiempoComputo);
    disp('El tiempo en correr el algoritmo VND con la instancia'+files(i)+ 'es de:'+toc)
    %escribir la solucion en el excel
    costo_optimo=dot(solucionVND,costos);
    subconjuntos_elegidos=find(solucionVND==1);subconjuntos_elegidos=sort(subconjuntos_elegidos);
    numero_de_subconjuntos_elegidos=size(subconjuntos_elegidos,2);
    matriz_respuesta=[costo_optimo,numero_de_subconjuntos_elegidos,subconjuntos_elegidos];
    tabla_respuesta = table(matriz_respuesta);
    file_name='../resultados/SCP_VND_susana_alvarez.xlsx';
    z=table(zeros(1000)*nan);
    writetable(z,file_name,'WriteVariableNames',0,'Sheet',i);
    writetable(tabla_respuesta,file_name,'WriteVariableNames',0,'Sheet',i);
    
end 

