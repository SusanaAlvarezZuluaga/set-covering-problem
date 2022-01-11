function poblacionActualizada = actualizar(padres,hijos,tamanoPoblacion,costos)
  poblacionGrande=[padres;hijos];
  for i=1:size(poblacionGrande,1)
        solucion=poblacionGrande(i,:);
        costoSol(i)=dot(costos,solucion);
  end
  [~, indicesMenorCosto]=mink(costoSol,tamanoPoblacion);
  poblacionActualizada=poblacionGrande(indicesMenorCosto,:);
end