function hijo = cruce(padre1,padre2)
    p1=padre1(1:size(padre1,2)/2);
    p2=padre2(size(padre2,2)/2+1:end);
    hijo=[p1,p2];
end