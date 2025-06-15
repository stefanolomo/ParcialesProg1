program parcial;

type
    tiponombre = string[25];
    tipopais = 1..200;
    tipotorneo = 1..20;
    vecttorneos = array[tipotorneo] of integer;

    registrodatos = record
        nombre: tiponombre;
        codPais: tipopais;
        torneosGanados: tipotorneo;
        vTorneos: vecttorneos;
    end;

    ptrnodo = ^nodo;
    nodo = record
        datos: registrodatos;
        sig: ptrnodo;
    end;

    vectPais = array[tipopais] of integer;

procedure leerdatos(var datos: registrodatos; var seguir: boolean);

var i: integer;

begin
    seguir := true;
    readln(datos.nombre);

    if (datos.nombre <> 'ZZZ') then begin
        readln(datos.codPais);
        readln(datos.torneosGanados);
        for i := 1 to datos.torneosGanados do
            readln(datos.vTorneos[i]);
    end
    else
        seguir := false;
end;

function invertir(num: integer): integer;

var
    inv, dig: integer;

begin
    inv := 0;
    while (num <> 0) do begin
        dig := num mod 10;
        inv := inv * 10 + dig;
        num := num div 10;
    end;
    invertir := inv;
end;

procedure insertarordenado(var lista: ptrnodo; datos: registrodatos);

var
    ant, act, nodo: ptrnodo;

begin
    ant := nil;
    act := lista;

    new(nodo);
    nodo^.datos := datos;

    while (act^.sig <> nil) and (act^.datos.nombre < nodo^.datos.nombre) do begin
        ant := act;
        act := act^.sig;
    end;

    if (ant = nil) then begin
        nodo^.sig := Lista;
        Lista := nodo;
    end
    else begin
        ant^.sig := nodo;
        nodo^.sig := act;
    end;
end;

procedure cargarlista(var lista: ptrnodo);

var
    seguir: boolean;
    datos: registrodatos;

begin
    seguir := true;

    while (seguir) do begin
        leerdatos(datos, seguir);
        insertarordenado(lista, datos);
    end;
end;

procedure hallar2max(vect: vectPais; var max1: tipopais; var max2: tipopais;
var cant1: integer; var cant2: integer);

var
    i: integer;

begin
    max1 := 1;
    max2 := 1;
    cant1 := -1;
    cant2 := -1;

    for i := 1 to 200 do begin
        if (vect[i] > cant1) then begin
            max2 := max1;
            cant2 := cant1;

            cant1 := vect[i];
            max1 := i;
        end
        else if (vect[i] > cant2) then begin
            max2 := i;
            cant2 := vect[i];
        end;
    end;
end;

procedure inicializarvector(var vect: vectPais);

var i: integer;

begin
    for i := 1 to 200 do
        vect[i] := 0;
end;

procedure recorrerlista(lista: ptrnodo; var vectormax: vectPais);

var
    act: ptrnodo;
    i: integer;

begin
    act := lista;

    while (act <> nil) do begin
        writeln(invertir(act^.datos.codPais));

        for i := 1 to act^.datos.torneosGanados do
            writeln(invertir(act^.datos.vTorneos[i]));

        vectormax[act^.datos.codPais] := vectormax[act^.datos.codPais] + act^.datos.torneosGanados;

        act := act^.sig;
    end;
end;

procedure liberarlista(var lista: ptrnodo);

var aux: ptrnodo;

begin
    while (lista <> nil) do begin
        aux := lista;
        lista := lista^.sig;
        dispose(aux);
    end;
end;

var
    lista: ptrnodo;
    vectormax: vectPais;
    max1, max2: tipopais;
    cant1, cant2: integer;

begin
    inicializarvector(vectormax);
    cargarlista(lista);
    recorrerlista(lista, vectormax);
    hallar2max(vectormax, max1, max2, cant1, cant2);
    writeln(max1, max2, cant1, cant2);
    writeln(Nombre(max1), Nombre(max2)); // Nombre se dispone
    liberarlista(lista);
end.