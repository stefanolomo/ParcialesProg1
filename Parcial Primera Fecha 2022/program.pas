Program CovidPBA;

const
    PARTIDOS = 135;
    ZONAS = 5;

type
    tipodia = 1..31;
    tipomes = 1..12;
    tipozonas = 1..ZONAS;
    tipopartido = 1..PARTIDOS;
    // Puntero y registro de nodos
    ptrnodo = ^nodo;
    nodo = record
        dia: tipodia;
        mes: tipomes;
        year: integer;
        codPartido: integer;
        partido: tipopartido;
        codZona: tipozonas;
        cantVacunados: integer;
        sig: ptrnodo;
    end;
    // Arreglo de 5 listas
    ArrListas = array[5] of ptrnodo;
    ArrPartidos = array[1..PARTIDOS] of integer;

function esPasado(nodo: ptrnodo): boolean;
// La funcion checkea si el año es menor al actual
begin
    esPasado := (nodo <> nil) and (nodo^.year > 2025);
end;

procedure InsertarOrdenadoCopia(var Lista: ptrnodo; nodo: ptrnodo);

var
    ant, act, copia: ptrnodo;

begin
    // Inicializamos act en la lista y el anterior en nil
    act := Lista;
    ant := nil;

    // Crear copia del nodo a insertar
    new(copia);
    copia^ := nodo^;
    copia^.sig := nil;

    // Mientras no sea el ultimo y sea menor que el codigo de zona recorremos la lista
    while (act <> nil) and (act^.codPartido < copia^.codPartido) do
        begin
            ant := act;
            act := act^.sig;
        end;
    // Cuando sale del bucle es porque llego a la posicion a la que tenemos que insertar

    // Si ant es nil, tenemos que insertar en el principio de la lista
    if (ant = nil) then
        begin
            copia^.sig := Lista;
            Lista := copia;
        end
    else // Si ant es un nodo, entonces hay que insertar entre ant y act o bien al final
        begin
            ant^.sig := copia;
            copia^.sig := act;
        end;
end;

procedure RecorrerLista (var Lista: ptrnodo);

var
    ant, act: ptrnodo;
    ArregloZonas: ArrListas;
    ArregloTotal: ArrPartidos;
    min1, min2, codMin1, codMin2: integer;
    i: integer;

begin
    // Inicializamos punteros para recorrer
    act := Lista;
    ant := nil;

    // Inicializamos los minimos en valores grandes y el total de vacunados en cero
    min1 := 999999;
    min2 := 999999;

    // Inicalizamos los codigos de los dos minimos
    codMin1 := 0;
    codMin2 := 0;

    // Inicializar el arreglo de las 5 listas (zonas)
    for i := 1 to ZONAS do
        ArregloZonas[i] := nil;
    
    // Inicializar el arreglo de los totales de vacunados
    for i := 1 to PARTIDOS do
        ArregloTotal[i] := 0;

    // Recorremos la lista hasta llegar al ultimo
    while (act <> nil) do
        begin
            if (act^.year < 2025) then
                begin // Si el año es anterior al 2025, tenemos que eliminar el nodo porque el registro es de un año pasado
                    if (ant = nil) then // Hay que eliminar el primer nodo (act)
                        begin
                            // La cabeza de lista pasa a ser el siguiente
                            Lista := act^.sig;
                            // Eliminamos el nodo que ya no esta enlazado
                            dispose(act);
                            // Act ahora es la lista (cabeza de lista)
                            act := Lista;
                        end
                    else // De otra manera, hay que eliminar act cuyo anterior es ant
                        begin
                            // El que le sigue al anterior lo enganchamos con el que le sigue a act
                            ant^.sig := act^.sig;
                            // Eliminamos el nodo que ya no esta enlazado
                            dispose (act);
                            // Act ahora es el siguiente del anterior (antiguo act^.sig)
                            act := ant^.sig;
                        end;
                end
            else // De otra manera el año es 2025 entonces es valido procesarlo
                begin
                    // Sumamos al total de vacunados los vacunados de ese dia
                    ArregloTotal[act^.codPartido] := ArregloTotal[act^.codPartido] + act^.cantVacunados;
                    
                    // Tenemos que insertar act en la lista dependiendo de la zona
                    InsertarOrdenado(ArregloZonas[act^.codZona], act);

                    // Por ultimo, avanzamos los punteros
                    ant := act;
                    act := act^.sig;
                end;
        end;
    // Cuando se termino de recorrer los nodos, procedemos a calcular los minimos
    for i := 1 to PARTIDOS do
        begin
            if (ArregloTotal[i] < min1) then
                begin
                    // Pasamos los minimos al segundo puesto
                    min2 := min1;
                    codMin2 := codMin1;

                    // Actualizamos los minimos
                    min1 := ArregloTotal[i];
                    codMin1 := i;
                end
            else if (ArregloTotal[i] < min2) then
                begin
                    // Actualizamos los minimos
                    min2 := ArregloTotal[i];
                    codMin2 := i;
                end;
        end;

    // Una vez se termino de calcular los minimos, debemos informar los 2 partidos con la menor cantidad de vacunados y sus nombres

    writeln('El primer partido con la menor cantidad de vacunados fue ', Nombre(codMin1), ' con ', min1, ' vacunados.');

    writeln('El segundo partido con la menor cantidad de vacunados fue ', Nombre(codMin2), ' con ', min2, ' vacunados.');
end;

function Nombre(codPartido: integer): string[20];
begin
    if (codPartido mod 2 = 0) then
        Nombre := 'La Plata'
    else
        Nombre := 'Buenos Aires Ciudad';
end;

begin
end.