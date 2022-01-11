%A esta función se debe pasar el nombre del archivo que contiene los datos
%Esta función lee y desglosa los datos y retorna lo siguiente:
    %num_elementos: el numero de elementos de la instancia
    %num_subconjuntos:el numero de subconjuntos de la instancia
    %costos:un vector fila que contiene los costos de cada subconjunto
    %relaciones: Una matriz que en cada fila i tiene los subconjuntos que
    %cubren al elemento i. Los espacios en blanco de la matriz se llenan 
    %con ceros
 %
function [num_elementos,num_subconjuntos,costos,relaciones]=leer_datos(filename)
    
    fileID = fopen(filename,'r');
    formatSpec = '%f';
    first_line = [1 2];
    size= fscanf(fileID,formatSpec,first_line);
    num_elementos=size(1);
    num_subconjuntos=size(2);

    %guardar costos 
    num_costos = [1,num_subconjuntos];
    costos = fscanf(fileID,formatSpec,num_costos);

    % encontrar el numero maximo de subconjuntos que cubren a algun 
    % elemento para crear la matriz de este tamaño
    max_num_subconjuntos=0;
    num_subconjuntos_que_cubren_cada_i=[];
    subconjuntos_que_cubren_i=[];
    for i=1:num_elementos
    num_subconjuntos_cubriendo_i=fscanf(fileID,formatSpec,[1,1]);
    num_subconjuntos_que_cubren_cada_i=[num_subconjuntos_que_cubren_cada_i,num_subconjuntos_cubriendo_i];
    subconjuntos_que_cubren_i=[subconjuntos_que_cubren_i,fscanf(fileID,formatSpec,[1,num_subconjuntos_cubriendo_i])];
    if num_subconjuntos_cubriendo_i>=max_num_subconjuntos
        max_num_subconjuntos=num_subconjuntos_cubriendo_i;
    end   
    end

    %crear una matriz de relaciones 
    cont=1;
    for i=1:num_elementos
        if i==1
            relaciones(i,:)=[subconjuntos_que_cubren_i(cont:num_subconjuntos_que_cubren_cada_i(i)),zeros(1,max_num_subconjuntos-num_subconjuntos_que_cubren_cada_i(i))];
        else 
          relaciones(i,:)=[subconjuntos_que_cubren_i(cont:cont+num_subconjuntos_que_cubren_cada_i(i)-1),zeros(1,max_num_subconjuntos-num_subconjuntos_que_cubren_cada_i(i))];
        end
          cont=cont+num_subconjuntos_que_cubren_cada_i(i);
    end
end 




