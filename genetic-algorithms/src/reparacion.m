function solReparada=reparacion(hijo,relaciones,costos,maxTiempoComputo) 
    solActual=hijo;
    costoSolActual= dot(solActual,costos);  
    vecindario=generarVecindario(solActual,relaciones,1,maxTiempoComputo);
    if size(vecindario,1)>0
        % escojo la mejor sol del vecindario 
        for i=1:size(vecindario,1)
                solVecina=vecindario(i,:);
                costoSolVecina=dot(solVecina,costos);
                if costoSolVecina<costoSolActual
                   solActual=solVecina;
                   costoSolActual=costoSolVecina;
                end
        end
        solReparada=solActual;
    else
        solReparada=[];
    end
end 