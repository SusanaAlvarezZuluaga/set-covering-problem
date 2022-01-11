
function [costo_optimo,cota_inferior]=metodo_con_ruido_final(fileid,num_elementos,num_subconjuntos,costos,relaciones,ruido)
    %se calcula cuantos elementos cubre cada subconjunto
    num_elementos_cubiertos_por_cada_subconjunto=zeros(1,num_subconjuntos);
    for i=1:num_subconjuntos
        [r c]=find(relaciones==i);
        num_elementos_cubiertos_por_cada_subconjunto(i)=size(r,1);
        elementos_cubiertos_por_cada_subconjunto(i,1:num_elementos_cubiertos_por_cada_subconjunto(i))=transpose(r); 
    end


    % se halla una cota inferior
    min_num_subconjuntos=0;
    suma=0;
    sorted_num_elementos_cubiertos_por_cada_subconjunto=sort(num_elementos_cubiertos_por_cada_subconjunto,'descend');
    while suma<num_elementos 
    min_num_subconjuntos=min_num_subconjuntos+1;
    suma=suma+sorted_num_elementos_cubiertos_por_cada_subconjunto(min_num_subconjuntos);
    end
    c_min= mink(costos,min_num_subconjuntos);
    cota_inferior=sum(c_min);

    %se corre le pone el ruido a los costos 
    costos_con_ruido=costos+ruido;
    
    %se inizializa la solucion 
    solucion=zeros(1,num_subconjuntos);

    for elemento=1:num_elementos
        candidatos=transpose(nonzeros(relaciones(elemento,:)));

        %se calcula el costo minimo de los candidatos que y se arma un conjunto 
        %que contiene aquellos subconjuntos que tienen el costo minimo
        %si uno de los subconjuntos candidatos ya esta incluido en la solucion
        %entonces se mueve al siguiente elemento porque ese elemento ya se
        %cubrio

        min_cost=Inf;
        subconjuntos_menor_costo=[];
        cont=1;
        cubierto=0;
        for subconjunto=candidatos 
            if solucion(subconjunto)==1
                cubierto=1;
                break;
            else 
                if costos_con_ruido(subconjunto)<min_cost
                    cont=1;
                    min_cost=costos_con_ruido(subconjunto);
                    subconjuntos_menor_costo=[subconjunto];
                elseif costos_con_ruido(subconjunto)==min_cost
                    cont=cont+1;
                    subconjuntos_menor_costo(cont)=subconjunto; 
                end 
            end    
        end
        if cubierto==1
            continue 
        else 
           if size(subconjuntos_menor_costo,2)==1
            subconjunto_elegido=subconjuntos_menor_costo;
           end
            if size(subconjuntos_menor_costo,2)>1
                % hallo la cantidad de elementos cubiertos por cada subconjunto del empate
                cont=1;
                max_elementos_cubiertos_por_subconjunto=0;
                subconjuntos_mayor_cubrimiento=[];
               for subconjunto_menor_costo=subconjuntos_menor_costo
                    [r c]=find(relaciones==subconjunto_menor_costo);
                    num_elementos_cubiertos_por_subconjunto=size(r,1);
                    if num_elementos_cubiertos_por_subconjunto>max_elementos_cubiertos_por_subconjunto
                        cont=1;
                        max_elementos_cubiertos_por_subconjunto=num_elementos_cubiertos_por_subconjunto;
                        subconjuntos_mayor_cubrimiento=[subconjunto_menor_costo];
                    elseif num_elementos_cubiertos_por_subconjunto==max_elementos_cubiertos_por_subconjunto
                        cont=cont+1;
                        subconjuntos_mayor_cubrimiento(cont)=subconjunto_menor_costo;
                    end

               end
                if size(subconjuntos_mayor_cubrimiento,2)==1
                    subconjunto_elegido=subconjuntos_mayor_cubrimiento;
                else
                r=randi([1,size(subconjuntos_mayor_cubrimiento,2)],1,1);
                subconjunto_elegido=subconjuntos_mayor_cubrimiento(r);
                end
            end 
            solucion(subconjunto_elegido)=1;   
        end 

    end 
    
    costo_optimo=dot(costos,solucion);
    subconjuntos_elegidos=find(solucion==1);
    subconjuntos_elegidos=sort(subconjuntos_elegidos);
    numero_de_subconjuntos_elegidos=size(subconjuntos_elegidos,2);
    matriz_respuesta=[costo_optimo, numero_de_subconjuntos_elegidos,subconjuntos_elegidos]; 
    tabla_respuesta = table(matriz_respuesta);
    file_name='../resultados/SCP_ruido_susana_alvarez.xlsx';
    z=table(zeros(500)*nan);
    writetable(z,file_name,'WriteVariableNames',0,'Sheet',fileid);
    writetable(tabla_respuesta,file_name,'WriteVariableNames',0,'Sheet', fileid);
end


