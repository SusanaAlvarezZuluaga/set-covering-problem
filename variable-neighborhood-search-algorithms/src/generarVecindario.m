function vecindario=generarVecindario(solucionInicial,relaciones,tipoVecindario,maxTiempoComputo)
vecindario=[];

if tipoVecindario==1
    for i=1:size(solucionInicial,2)
        solucionVecina=solucionInicial;
        if solucionInicial(i)==1
             solucionVecina(i)=0;
             if factibilidad(solucionVecina,relaciones)==1
                 vecindario=[vecindario;solucionVecina];
             end
        end 
    end 
end

if tipoVecindario==2
    cerosSolInicial=find(solucionInicial==0);
    unosSolInicial=find(solucionInicial==1);
    if size(cerosSolInicial,2)>size(unosSolInicial,2)
        niter=size(unosSolInicial,2);
    else
        niter=size(cerosSolInicial,2);
    end
    
    for i=1:niter
        indice_zero=cerosSolInicial(i);
        indice_uno=unosSolInicial(i); 
        solucionVecina=solucionInicial;
        solucionVecina(indice_zero)=1;
        solucionVecina(indice_uno)=0;
         if factibilidad(solucionVecina,relaciones)==1
             vecindario=[vecindario;solucionVecina];
         end 
    end 
end

if tipoVecindario==3
      n=size(solucionInicial,2);
      cont=1;
    while cont<n && toc<maxTiempoComputo
        solucionVecina=solucionInicial;%pongo la solucion vecina igual a la inicial 
        unos=find(solucionInicial==1);%%enceuntro las posiciones de los unos 
        n1=size(unos,2);
        posCambiar=randi(n1,[3,1]);%%% genero 3 random para obtener tres posiciones donde hay unos 
        %le cambio los valores a la solucion vecina con todo el for
        for p=posCambiar
            index=unos(p);%%selecciono una posicion donde hay un unpo 
            solucionVecina(index)=0;
        end 
        
        if factibilidad(solucionVecina,relaciones)==1
             vecindario=[vecindario;solucionVecina];
        end 
       cont=cont+1;
    end 

 end
end




