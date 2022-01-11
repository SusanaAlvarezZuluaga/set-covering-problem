function solucionMutada=mutacion(hijo,relaciones)
    n=size(hijo,2);
    while 1==1
        rand=randi(n);
        solucionVecina=hijo;
         if hijo(rand)==1
            solucionVecina(rand)=0;
         end 
         
         if factibilidad(solucionVecina,relaciones)==1
              solucionMutada=solucionVecina;
              break
         end
    end 
end 