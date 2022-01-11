function solucionPerturbada=perturbacion(solucionInicial,relaciones)
    n=size(solucionInicial,2);
    while 1==1
        rand=randi(n);
        solucionVecina=solucionInicial;
         if solucionInicial(rand)==1
            solucionVecina(rand)=0;
         end 
         
         if factibilidad(solucionVecina,relaciones)==1
              solucionPerturbada=solucionVecina;
              break
         end
    end 
end 