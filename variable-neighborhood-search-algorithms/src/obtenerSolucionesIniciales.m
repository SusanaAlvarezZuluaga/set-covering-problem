%% archivos con los datos
f1=string('scp41.txt');f2=string('scp42.txt');f3=string('scpnrg1.txt');
f4=string('scpnrg2.txt');f5=string('scpnrg3.txt');f6=string('scpnrg4.txt');
f7=string('scpnrg5.txt');f8=string('scpnrh1.txt');f9=string('scpnrh2.txt');
f10=string('scpnrh3.txt');f11=string('scpnrh4.txt');f12=string('scpnrh5.txt');
files=[f1,f2,f3,f4,f5,f6,f7,f8,f9,f10,f11,f12];

%% sacar las soluciones iniciales del mestros constructivo para cada instancia
solucionesIniciales=[]
for i=1:12
    [~,num_subconjuntos,~,~]=leer_datos(files(i));
    solInstancia=zeros(1,num_subconjuntos);
    subconjuntosEnSol=xlsread('../datos/SCP_constructivo_susana_alvarez.xlsx',i);
    subconjuntosEnSol=subconjuntosEnSol(1,3:size(subconjuntosEnSol,2));
    for s=subconjuntosEnSol
         solInstancia(s)=1;
    end 
     writetable(table(solInstancia),'../datos/SolucionesIniciales.xlsx','WriteVariableNames',0,'Sheet',i);
end 

