Program CovidPBA;

type
    // Puntero y registro de nodos
    ptrnodo = ^nodo;
    nodo = record
        dia: 1..31;
        mes: 1..12;
        year: integer;
        codPartido: integer;
        codZona: 1..5;
        cantVacunados: integer;
        sig: ptrnodo;
    end;
    // Arreglo de 5 listas
    ArrListas = array[5] of ptrnodo;

function esPasado(nodo: ptrnodo): boolean;

begin
    esPasado := (nodo <> nil) and (nodo^.year <> 2025);
end;

procedure InsertarOrdenado(var Lista: ptrnodo; nodo: ptrnodo);

var
    ant, act: ptrnodo;

begin
    // Inicializamos act en la lista y el anterior en nil
    act := Lista;
    ant := nil;

    // Mientras no sea el ultimo y sea menor que el codigo de zona recorremos la lista
    while (act <> nil) and (act^.codPartido < nodo^.codPartido) do
        begin
            ant := act;
            act := act^.sig;
        end;
    // Cuando sale del bucle es porque llego a la posicion a la que tenemos que insertar

    // Si ant es nil, tenemos que insertar en el principio de la lista
    if (ant = nil) then
        begin
            nodo^.sig := Lista;
            Lista := nodo;
        end
    else // Si ant es un nodo, entonces hay que insertar entre ant y act o bien al final
        begin
            ant^.sig := nodo;
            nodo^.sig := act;
        end;
end;

begin
end.