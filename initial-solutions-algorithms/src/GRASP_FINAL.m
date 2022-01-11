
%Este algoritmo requiere que primero se le pase lo siguiente:
    %file_id=Un numero que representa que instancia se le está pasando.
    %Este se utiliza al momento de crear un excel con la solucion.
    %num_elementos: el numero de elementos de la instancia
    %num_subconjuntos:el numero de subconjuntos de la instancia
    %costos:un vector fila que contiene los costos de cada subconjunto
    %relaciones: Una matriz que en cada fila i tiene los subconjuntos que
    %cubren al elemento i. 
    %este algoritmo encuentra una solución y devuelve la solución, el costo
    %de esta y  una cota inferior de la solución
function [costo_optimo,cota_inferior]=GRASP_FINAL(fileid,num_elementos,num_subconjuntos,costos,relaciones,alpha) %#ok<INUSL>

    %calculo numero de elementos que cubre cada subconjunto
    num_elementos_cubiertos_por_cada_subconjunto=zeros(1,num_subconjuntos);
    for i=1:num_subconjuntos
        [r c]=find(relaciones==i);
        num_elementos_cubiertos_por_cada_subconjunto(i)=size(r,1);
        elementos_cubiertos_por_cada_subconjunto(i,1:num_elementos_cubiertos_por_cada_subconjunto(i))=transpose(r); 
    end

    % calculo cota inferior
    min_num_subconjuntos=0;
    suma=0;
    sorted_num_elementos_cubiertos_por_cada_subconjunto=sort(num_elementos_cubiertos_por_cada_subconjunto,'descend');
    while suma<num_elementos 
    min_num_subconjuntos=min_num_subconjuntos+1;
    suma=suma+sorted_num_elementos_cubiertos_por_cada_subconjunto(min_num_subconjuntos);
    end
    c_min= mink(costos,min_num_subconjuntos); 
    cota_inferior=sum(c_min);

    %inicializar solucion
    solucion=zeros(1,num_subconjuntos);

    for elemento=1:num_elementos
        candidatos=transpose(nonzeros(relaciones(elemento,:))); 
        
        %se calcula el costo minimo y maximo de esos subconjuntos 
        %candidatos sin tener en cuenta los costos de  aquellos 
        %subconjuntos que ya se eligieron 
        min_cost=Inf;
        max_cost=0;
        cubierto=0;
        for subconjunto=candidatos 
            if solucion(subconjunto)==1 
                 cubierto=1;
                break 
            else 

               if costos(subconjunto)<min_cost
                  min_cost=costos(subconjunto);
               end    
               if costos(subconjunto)>max_cost
                   max_cost=costos(subconjunto);
                end 
            end    
        end
        if cubierto==1
            continue 
        
        else 
            %se halla el conjunto RCL considerando aquellos elementos que
            % no han  sido cubiertos
            cota_RCL=min_cost+alpha*(max_cost-min_cost);
            RCL=[];
            cont=1;
            for subconjunto=candidatos
                if solucion(subconjunto)==1 
                  break 
                else
                   if costos(subconjunto)<=cota_RCL
                    RCL(cont)=subconjunto;
                    cont=cont+1;
                   end   
                end 
            end
            %se elije aleatoriamente un subconjunto del RCL
            r=randi([1,size(RCL,2)],1,1);
            subconjunto_elegido=RCL(r);
            solucion(subconjunto_elegido)=1;
        
        end 
        

    end
    costo_optimo=dot(solucion,costos);
    subconjuntos_elegidos=find(solucion==1);
    subconjuntos_elegidos=sort(subconjuntos_elegidos);
    numero_de_subconjuntos_elegidos=size(subconjuntos_elegidos,2);
    matriz_respuesta=[costo_optimo, numero_de_subconjuntos_elegidos,subconjuntos_elegidos];
    tabla_respuesta = table(matriz_respuesta);
    file_name='../resultados/SCP_GRASP_susana_alvarez.xlsx';
    z=table(zeros(100)*nan);
    writetable(z,file_name,'WriteVariableNames',0,'Sheet',fileid);
    writetable(tabla_respuesta,file_name,'WriteVariableNames',0,'Sheet', fileid);
end


