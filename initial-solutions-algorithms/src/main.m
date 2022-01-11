%Este main se corre y el va dando la desviacion de la solucion a una cota
%inferior y el tiempo de computo 
%adicionalmente se crean 3 archivos- uno correspondiente a cada método-
%que contienen las soluciones 
%parametros que se pueden modificar 
numsol=1;
alpha=0.5;
ruido=randi(50);


%archivos con los datos
f1=string('../datos/scp41.txt');
f2=string('../datos/scp42.txt');
f3=string('../datos/scpnrg1.txt');
f4=string('../datos/scpnrg2.txt');
f5=string('../datos/scpnrg3.txt');
f6=string('../datos/scpnrg4.txt');
f7=string('../datos/scpnrg5.txt');
f8=string('../datos/scpnrh1.txt');
f9=string('../datos/scpnrh2.txt');
f10=string('../datos/scpnrh3.txt');
f11=string('../datos/scpnrh4.txt');
f12=string('../datos/scpnrh5.txt');
files=[f1,f2,f3,f4,f5,f6,f7,f8,f9,f10,f11,f12];
warning('off', 'MATLAB:xlswrite:AddSheet');

for i=1:size(files,2)
file=files(i);
disp('instancia:'+file)
fileid=i;
% leer datos
[num_elementos,num_subconjuntos,costos,relaciones]=leer_datos(file);

r=randi(ruido,[1,num_subconjuntos]);

cont=0;
tic; 
while cont<numsol

    min_desv0=Inf;
    min_valorfo0=Inf;
    cont=cont+1;
    [Z0,cota_inferior]=metodo_constructivo_final(fileid,num_elementos,num_subconjuntos,costos,relaciones);
    desv0=(Z0-cota_inferior)/cota_inferior;
    if desv0<min_desv0
        min_desv0=desv0;
        min_valorfo0=Z0;
    end  
end
disp('Algoritmo constructivo')
disp('El valor minimo de la funcion objetivo es de:')
disp(min_valorfo0)
disp('El % de desviacion minima para esta instancia es de:')
disp(min_desv0)
tf=toc;
disp('El tiempo en correr las nsol es de:')
disp(tf)

%correr  construccion GRASP
cont=0;
tic; 
while cont<numsol
   
    min_desv1=Inf;
    min_valorfo1=Inf;
    cont=cont+1;
    [Z1,cota_inferior]=GRASP_FINAL(fileid,num_elementos,num_subconjuntos,costos,relaciones,alpha);
    desv1=(Z1-cota_inferior)/cota_inferior;
    if desv1<min_desv1
        min_desv1=desv1;
        min_valorfo1=Z1;
    end  
end

disp('Construcción GRASP')
disp('El valor minimo de la funcion objetivo es de:')
disp(min_valorfo1)
disp('El % de desviacion minima para esta instancia es de:')
disp(min_desv1)
tf=toc;
disp('El tiempo en correr las nsol es de:')
disp(tf)


%Correr construccion con ruido
cont=0;
tic; 
while cont<numsol
   
    min_desv2=Inf;
    min_valorfo2=Inf;
    cont=cont+1;
    [Z2,cota_inferior]= metodo_con_ruido_final(fileid,num_elementos,num_subconjuntos,costos,relaciones,r);
    desv2=(Z2-cota_inferior)/cota_inferior;
    if desv2<min_desv2
        min_desv2=desv2;
        min_valorfo2=Z2;
    end  
end

disp('Construcción con ruido')
disp('El valor minimo de la funcion objetivo es de:')
disp(min_valorfo2)
disp('El % de desviacion minima para esta instancia es de:')
disp(min_desv2)
tf=toc;
disp('El tiempo en correr las nsol es de:')
disp(tf)

end 
