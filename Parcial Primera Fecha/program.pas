program ParcialPrimeraFecha2025;

type
    tipocadena = string[40];
    tipoobra = 1..20;
    tipoconsultorio = 1..12;

    registrodatos = record
        Dni: integer;
        Nombre: tipocadena;
        Apellido: tipocadena;
        ObraSocial: tipoobra;
        Afiliado: integer;
    end;

    ptrnodo = ^nodo;
    nodo = record
        datos: registrodatos;
        sig: ptrnodo;
    end;

    ArrListas = Array[tipoconsultorio] of ptrnodo;

procedure InsertarOrednado(var Lista: ptrnodo; datos: registrodatos);

var
    ant, act, nodo: ptrnodo;

begin
    ant := nil;
    act := Lista;

    new(nodo);
    nodo^.datos := datos;

    while (act <> nil) and (act^.datos.Apellido < nodo^.datos.Apellido) do begin
        ant := act;
        act := act^.sig;
    end;

    if (ant = nil) then begin
        nodo^.sig = Lista;
        Lista := nodo;
    end else begin
        ant^.sig := nodo;
        nodo^.sig := act;
    end;
end;



begin
    
end.