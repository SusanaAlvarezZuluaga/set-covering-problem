function solMejor=VND(solucionInicial,relaciones,costos,maxTiempoComputo)
    solActual=solucionInicial;
    costoSolActual= dot(solActual,costos);   
    j=3;
    tic;
    while j>=1 && toc<=maxTiempoComputo
        % se hallan las soluciones vecinas de SolActual
        vecindarioS=generarVecindario(solActual,relaciones,j,maxTiempoComputo);%%el vecinadrio va a ser una matriz donde cada fila contiene una solucion vecina 
        
        %se halla la primer solucion del vecindario que sea mejor que la
        %se inicizializa un booleano que indica si se encontro una mejor
        %solucion que la actual 
        bool=0;
        for i=1:size(vecindarioS,1)
                solVecina=vecindarioS(i,:);
                costoSolVecina=dot(solVecina,costos);
                if costoSolVecina<costoSolActual
                   bool=1;
                   j=3;
                   solActual=solVecina;
                   costoSolActual=costoSolVecina;
                    break 
                end
        end
        if bool==0
           j=j-1;
        end
        
    end
    solMejor=solActual;
end