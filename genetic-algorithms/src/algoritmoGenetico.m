function mejorSol=algoritmoGenetico(solucionInicial,costos,relaciones,numElementos,numSubconjuntos,alphaGrasp,tamanoPoblacion,numGeneraciones,numHijos,probMutacion,maxTiempoComputo)
    poblacion(1,:)=solucionInicial;
    for i=2:tamanoPoblacion
        poblacion(i,:)=GRASP(numElementos,numSubconjuntos,costos,relaciones,alphaGrasp);
    end
    tic
    i=1;
    while  i<numGeneraciones &&toc<maxTiempoComputo
        cont=1;
        hijos=[];
        while cont<=numHijos && toc<maxTiempoComputo
            [padre1,padre2]=seleccion(poblacion,costos);
            h=cruce(padre1,padre2);
            h=reparacion(h,relaciones,costos,maxTiempoComputo);
            if size(h,2)==0
                continue
            else
                hijos(cont,:)=h;
                if rand()<probMutacion
                    hijos(cont,:)=mutacion(hijos(cont,:),relaciones);
                end 
                cont=cont+1;
            end
            
        end
        poblacion=actualizar(poblacion,hijos,tamanoPoblacion,costos);
        i=i+1;
    end
    %hallar costos
     for i=1:size(poblacion,1)
        solucion=poblacion(i,:);
        costoSol(i)=dot(costos,solucion);
     end
     [~, indiceMenorCosto]=min(costoSol);
     mejorSol=poblacion(indiceMenorCosto,:);
end