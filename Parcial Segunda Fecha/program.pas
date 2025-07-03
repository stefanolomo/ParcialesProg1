program SegundaFecha2025;

const
    NUMJUGADORES = 2;

{ Se dispone de una lista con los equipos participantes del proximo mundial de clubes ordenados por pais al que pertenecen. De cada equipo se conoce el codigo de equipo, nombre, pais de origen, director tecnico, y los 30 jugadores convocados. De cada jugador se conoce su numero, valor en dolares y numero de camiseta (1 a 99).

Se requiere recorrer la lista una sola vez para:

1. Generar una nueva lista que contenga para cada pais, el nombre del pais de origen y el valor total en dolares de sus equipos (el valor de cada equipo es la suma de los valores de sus jugadores)

2. Calcular la frecuencia de cada numero de camiseta

3. Informar los dos numeros de camiseta mas usados

4. Informar el nombre y codigo de equipo cuyo codigo sea capicua (puede haber mas de uno).

> NOTA: Liberar memoria de todas las estructuras dinamicas, escribir el programa principal, modularizar solucion. }

type
    tipocadena = string[50];
    tipojugadores = 1..NUMJUGADORES;
    tipocamiseta = 1..99;
    jugador = record
        numero: longint;
        valor: longint;
        camiseta: tipocamiseta;
    end;
    ArrJugadores = Array[tipojugadores] of jugador;
    registroequipo = record
        codigo: longint;
        nombre: tipocadena;
        pais: tipocadena;
        director: tipocadena;
        convocados: ArrJugadores;
    end;
    registropais = record
        nombre: tipocadena;
        valor: longint;
    end;

    ptrequipo = ^equipo;
    equipo = record
        datos: registroequipo;
        sig: ptrequipo;
    end;

    ptrpais = ^pais;
    pais = record
        datos: registropais;
        sig: ptrpais;
    end;

    ArrCamiseta = Array[tipocamiseta] of longint;

function Inverso(num: longint): longint;

var
    digito, invertido: longint;

begin
    invertido := 0;

    while (num <> 0) do begin
        digito := num mod 10;

        invertido := (invertido * 10) + digito;

        num := num div 10;
    end;
    Inverso := invertido;
end;

function EsCapicua(num: longint): boolean;

begin
    EsCapicua := (Inverso(num) = num);
end;

procedure InicializarArrCamiseta(var A: ArrCamiseta);

var
    i: longint;

begin
    for i := 1 to 99 do
        A[i] := 0;
end;

procedure Hallar2MaxEnArrCamiseta(A: ArrCamiseta; var maxIn1, maxIn2: tipocamiseta);

var
    i, max1, max2: longint;

begin
    max1 := -1;
    max2 := -1;
    maxIn1 := 1;
    maxIn2 := 1;

    for i := 1 to 99 do begin
        if (A[i] > max1) then begin
            maxIn2 := maxIn1;
            max2 := max1;

            maxIn1 := i;
            max1 := A[i];
        end else if (A[i] > max2) then begin
            maxIn2 := i;
            max2 := A[i];
        end;
    end;
end;

procedure LiberarListaPais(var Lista: ptrpais);

var
    aux: ptrpais;

begin
    while (Lista <> nil) do begin
        aux := Lista;
        Lista := Lista^.sig;
        dispose(aux);
    end;
end;

procedure LiberarListaEquipo(var Lista: ptrequipo);

var
    aux: ptrequipo;

begin
    while (Lista <> nil) do begin
        aux := Lista;
        Lista := Lista^.sig;
        dispose(aux);
    end;
end;

procedure AgregarAlFinal(var Lista: ptrpais; datos: registropais);

var
    nuevo, act: ptrpais;

begin
    new(nuevo);
    nuevo^.datos := datos;
    nuevo^.sig := nil;

    if (Lista = nil) then
        Lista := nuevo
    else begin
        act := Lista;
        while (act^.sig <> nil) do
            act := act^.sig;
        act^.sig := nuevo;
    end;
end;


procedure RecorrerLista(ListaEquipos: ptrequipo; var ListaPaises: ptrpais);

{ Se requiere recorrer la lista una sola vez para:

1. Generar una nueva lista que contenga para cada pais, el nombre del pais de origen y el valor total en dolares de sus equipos (el valor de cada equipo es la suma de los valores de sus jugadores)

2. Calcular la frecuencia de cada numero de camiseta

3. Informar los dos numeros de camiseta mas usados

4. Informar el nombre y codigo de equipo cuyo codigo sea capicua (puede haber mas de uno).

> NOTA: Liberar memoria de todas las estructuras dinamicas, escribir el programa principal, modularizar solucion. }

var
    FrecuenciaCamiseta: ArrCamiseta;
    i: longint;
    max1, max2: tipocamiseta;
    paisActual: tipocadena;
    valorPais, valorEquipo: longint;
    paisAgregar: registropais;

begin
    InicializarArrCamiseta(FrecuenciaCamiseta);

    valorPais := 0;
    ListaPaises := nil;
    paisActual := '';

    while (ListaEquipos <> nil) do begin
        paisActual := ListaEquipos^.datos.pais;
        valorPais := 0;

        // Procesar todos los equipos del mismo país
        while (ListaEquipos <> nil) and (ListaEquipos^.datos.pais = paisActual) do begin
            valorEquipo := 0;

            for i := 1 to NUMJUGADORES do begin
                valorEquipo := valorEquipo + ListaEquipos^.datos.convocados[i].valor;
                FrecuenciaCamiseta[ListaEquipos^.datos.convocados[i].camiseta] := FrecuenciaCamiseta[ListaEquipos^.datos.convocados[i].camiseta] + 1;
            end;

            if EsCapicua(ListaEquipos^.datos.codigo) then
                writeln('El equipo ', ListaEquipos^.datos.nombre, ' con el código ', ListaEquipos^.datos.codigo, ' es capicúa.');

            valorPais := valorPais + valorEquipo;
            ListaEquipos := ListaEquipos^.sig;
        end;

        paisAgregar.nombre := paisActual;
        paisAgregar.valor := valorPais;

        AgregarAlFinal(ListaPaises, paisAgregar);
    end;

    Hallar2MaxEnArrCamiseta(FrecuenciaCamiseta, max1, max2);
    writeln('La primera camiseta mas usada es ', max1, '. La segunda mas usada es ', max2, '.');
end;

procedure LeerJugador(var j: jugador);
begin
    write('Ingrese numero de jugador: ');
    readln(j.numero);
    write('Ingrese valor en dolares: ');
    readln(j.valor);
    write('Ingrese numero de camiseta (1 a 99): ');
    readln(j.camiseta);
end;

{ <-----------------------------------> Modulos de prueba <-----------------------------------> }

procedure LeerEquipo(var e: registroequipo);
var i: longint;
begin
    write('Ingrese codigo de equipo: ');
    readln(e.codigo);
    write('Ingrese nombre del equipo: ');
    readln(e.nombre);
    write('Ingrese pais de origen: ');
    readln(e.pais);
    write('Ingrese nombre del director tecnico: ');
    readln(e.director);

    writeln('Ingrese datos de los 30 jugadores: ');
    for i := 1 to NUMJUGADORES do begin
        writeln('Jugador ', i, ':');
        LeerJugador(e.convocados[i]);
    end;
end;

procedure CargarListaEquipos(var Lista: ptrequipo);
var
    e: registroequipo;
    nuevo, act, ant: ptrequipo;
    opcion: char;
begin
    Lista := nil;
    repeat
        LeerEquipo(e);

        new(nuevo);
        nuevo^.datos := e;
        nuevo^.sig := nil;

        // Insertar ordenado por pais para que corte de control funcione bien
        if Lista = nil then
            Lista := nuevo
        else begin
            ant := nil;
            act := Lista;
            while (act <> nil) and (act^.datos.pais <= e.pais) do begin
                ant := act;
                act := act^.sig;
            end;
            if ant = nil then begin
                nuevo^.sig := Lista;
                Lista := nuevo;
            end else begin
                ant^.sig := nuevo;
                nuevo^.sig := act;
            end;
        end;

        write('Desea ingresar otro equipo? (S/N): ');
        readln(opcion);
    until (opcion = 'N') or (opcion = 'n');
end;

procedure ImprimirListaPaises(Lista: ptrpais);
begin
    while Lista <> nil do
    begin
        writeln('País: ', Lista^.datos.nombre, ' - Valor total: $', Lista^.datos.valor);
        Lista := Lista^.sig;
    end;
end;

var
    ListaEquipos: ptrequipo;
    ListaPaises: ptrpais;
begin
    CargarListaEquipos(ListaEquipos);

    RecorrerLista(ListaEquipos, ListaPaises);

    ImprimirListaPaises(ListaPaises);

    LiberarListaEquipo(ListaEquipos);

    LiberarListaPais(ListaPaises);
end.