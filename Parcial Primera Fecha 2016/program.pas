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

function FechaMenor(Fecha1: registrofecha, Fecha2: registrofecha): boolean;

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

procedure HallarMax(vect: ArrUsuarios; var max1, max2: tipousuario);

var i, cant1, cant2: integer;

begin
    cant1 := 0;
    cant2 := 0;

    for i := 1 to 50 do begin
        if (vect[i] > cant1) then begin
            max2 := max1;
            cant2 := cant1;

            cant1 := vect[i];
            max1 := i;
        end
        else if (vect[i] > cant2) then begin
            cant2 := vect[i];
            max2 := i;
        end;
    end;
end;

procedure RecorrerLista(Lista: ptrnodo, var Lista1, Lista2, Lista3: ptrnodo);

var
    act: ptrnodo;
    FechaActual: registrofecha;
    FechaAnterior: registrofecha;
    totalDia: integer;
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

        if (act^.datos.costoUnitario >= 10000) then
            InsertarOrdenado(Lista3, act^.datos);
        else if (act^.datos.costoUnitario >= 500) then
            InsertarOrdenado(Lista2, act^.datos);
        else if (act^.datos.costoUnitario > 0) then
            InsertarOrdenado(Lista1, act^.datos);

        FechaAnterior := FechaActual;

        act := act^.sig;
    end;

    // Al salir del ciclo se imprime el ultimo dia
    writeln(FechaAnterior.dia, FechaAnterior.mes, FechaAnterior.year);
    writeln(totalDia);

    HallarMax(ArrUsuarios, user1, user2);

    writeln(Nombre(user1), Nombre(user2));
end;

var
    Lista, Lista1, Lista2, Lista3: ptrnodo;

begin
    // CargarLista(Lista); se dispone
    Lista1 := nil;
    Lista2 := nil;
    Lista3 := nil;

    RecorrerLista(Lista, Lista1, Lista2, Lista3);

    LiberarLista(Lista);
    LiberarLista(Lista1);
    LiberarLista(Lista2);
    LiberarLista(Lista3);
end.