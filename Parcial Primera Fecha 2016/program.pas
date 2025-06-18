Program parcial;

type
    tipousuario = 1..50;
    tipodia = 1..31;
    tipomes = 1..12;
    registrofecha = record
        dia: tipodia;
        mes: tipomes;
        year: integer;
    end;
    registrodatos = record
        codProducto: integer;
        codUsuario: tipousuario;
        fecha: registrofecha;
        costoUnitario: integer;
        cantProducto: integer;
    end;
    ptrnodo = ^nodo;
    nodo = record
        datos: registrodatos;
        sig: ptrnodo;
    end;
    ArrUsuarios = array[tipousuario] of integer;

procedure LiberarLista(var Lista: ptrnodo);

var
    aux: ptrnodo;

begin
    while (Lista <> nil) do begin
        aux := Lista;
        Lista := Lista^.sig;
        dispose(aux);
    end;
end;

procedure FechaMenor(Fecha1: registrofecha, Fecha2: registrofecha);

begin
    FechaMenor := (Fecha1.dia <= Fecha2.dia) and (Fecha1.mes <= Fecha2.mes) and (Fecha1.year <= Fecha2.year);
end;

procedure InsertarOrdenado(var Lista: ptrnodo; datos: registrodatos);

var
    ant, act, nodo: ptrnodo;

begin
    ant := nil;
    act := Lista;

    new(nodo);
    nodo^.datos := datos;

    while (act <> nil) and FechaMenor(act^.datos.fecha, nodo^.datos.fecha) do begin
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

procedure InicializarArregloUsuarios(var Arreglo: ArrUsuarios);

var i: integer;

begin
    for i := 1 to 50 do
        Arreglo[i] := 0;
end;

procedure RecorrerLista(Lista: ptrnodo);

var
    act: ptrnodo;
    FechaActual: registrofecha;
    FechaAnterior: registrofecha;
    totalDia: integer;
    cant1, cant2: integer;
    user1, user2: tipousuario;
    ArrUsuarios: ArrUsuarios;

begin
    act := Lista;
    
    totalDia := 0;

    InicializarArregloUsuarios(ArrUsuarios);

    if (act <> nil) then
        FechaAnterior := act^.datos.fecha;

    user1 := 1;
    user2 := 1;
    cant1 := -1;
    cant2 := -1;

    while (act <> nil) do begin
        FechaActual := act^.datos.fecha;

        if (FechaActual.dia = FechaAnterior.dia) and (FechaActual.mes = FechaAnterior.mes) and (FechaActual.year = FechaAnterior.year) then begin
            totalDia := totalDia + (act^.datos.costoUnitario * act^.datos.cantProducto);
        end
        else begin
            writeln(FechaAnterior.dia, FechaAnterior.mes, FechaAnterior.year);
            writeln(totalDia);

            totalDia := act^.datos.costoUnitario * act^.datos.cantProducto;
        end;

        ArrUsuarios[act^.datos.codUsuario] := ArrUsuarios[act^.datos.codUsuario] + (act^.datos.costoUnitario * act^.datos.cantProducto);

        FechaAnterior := FechaActual;

        act := act^.sig;
    end;
end;

begin
end.