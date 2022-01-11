function [padre1,padre2] = seleccion(poblacion,costos)
    for i=1:size(poblacion,1)
        solucion=poblacion(i,:);
        costoSol(i)=dot(costos,solucion);
    end
    for i=1:2
        costosInv=1./costoSol;
        pSeleccion=costosInv/sum(costosInv);
        pSeleccionAcum=cumsum(pSeleccion);
        r=rand();
        k=pSeleccionAcum>r;
        r=find(k==1);
        indice=r(1);
        padre(i,:)=poblacion(indice,:);
    end
    padre1= padre(1,:);
    padre2=padre(2,:);
end