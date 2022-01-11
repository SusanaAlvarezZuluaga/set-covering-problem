function bool=factibilidad(solucion,relaciones)
num_elementos=size(relaciones,1);
elementos_cubiertos=[];
    for i=1:size(solucion,2)
        if solucion(i)==1
            [elemento,~]=find(i==relaciones);
           elementos_cubiertos=[elementos_cubiertos; elemento];
        end
    end
    elementos_cubiertos=unique(elementos_cubiertos);
    if size(elementos_cubiertos,1)==num_elementos
        bool=1;
    else 
        bool=0;
    end
end