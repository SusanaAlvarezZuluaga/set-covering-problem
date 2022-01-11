function mejorSol=busquedaLocal(solInicial,relaciones,costos,maxTiempoComputo) 
    solActual=solInicial;
    costoSolActual= dot(solActual,costos);   
    while 1==1 && toc<=maxTiempoComputo
        % se hallan las soluciones vecinas de SolActual
        vecindarioS=generarVecindario(solActual,relaciones,1);%%el vecinadrio va a ser una matriz donde cada fila contiene una solucion vecina 
        
        %se halla la primer solucion del vecindario que sea mejor que la
        %se inicizializa un booleano que indica si se encontro una mejor
        %solucion que la actual 
        bool=0;
        for i=1:size(vecindarioS,1)
                solVecina=vecindarioS(i,:);
                costoSolVecina=dot(solVecina,costos);
                if costoSolVecina<costoSolActual
                   bool=1;
                   solActual=solVecina;
                   costoSolActual=costoSolVecina;
                    break 
                end
        end
        if bool==0
            break
        end
    end
    mejorSol=solActual;
end 