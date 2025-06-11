Program Parcial;

type
    // Tipos del registro
    tipodia = 1..31;
    tipomes = 1..12;
    tipohora = 0..23;
    tipominuto = 0..59;
    tiposala = 1..440;
    tipopais = 1..24;
    tipopelicula = 1..340;
    tiponombre = string[40];

    registrodatos = record
        // Codigos de funcion, sala, pais y pelicula
        codFuncion: Integer;
        codSala: tiposala;
        codPais: tipopais;
        codPelicula: tipopelicula;

        // Fecha y hora
        dia: tipodia;
        mes: tipomes;
        year: Integer;
        hora: tipohora;
        minuto: tipominuto;

        // Cantidad de entradas vendidas
        cantEntradas: Integer;
    end;

    // Puntero a nodos
    ptrnodo = ^nodo;

    // Nodo de lista
    nodo = record
        // Registro con todos los datos
        datos: registrodatos;

        // Puntero al siguiente nodo
        sig: ptrnodo;
    end;

    // Para la matriz de recaudacion necesitamos que sea (Codigo de pelicula x Codigo de pais)
    matrizPeliculaxPais = array[tipopais, tipopelicula] of Integer;

function EntradasMayoresA(cantEntradas: integer; maxEntradas: integer): boolean;

begin
    EntradasMayoresA := (cantEntradas > maxEntradas);
end;

function SumaDigitos(nro: integer): integer;

var
    digito, total: integer;

begin
    total := 0;

    while (nro <> 0) do
        begin
            digito := nro mod 10;
            
            total := total + digito;

            nro := nro div 10;
        end;

    SumaDigitos := total;
end;

function EsPar(nro: integer): boolean;

begin
    EsPar := ((nro mod 2) = 0);
end;

function CalcularRecaudacion(cantEntradas: integer; Costo: integer): integer;

begin
    CalcularRecaudacion := cantEntradas * Costo;
end;

procedure LiberarLista(var Lista: ptrnodo);

var
    aux: ptrnodo;

begin
    while (Lista <> nil) do
        begin
            aux := Lista;
            Lista := Lista^.sig;
            dispose(aux);
        end;
end;

procedure InsertarOrdenado(var Lista: ptrnodo; datos: registrodatos);

var
    ant, act, nodo: ptrnodo;

begin
    ant := nil;
    act := Lista;

    new(nodo);
    nodo^.datos := datos;

    while (act <> nil) and (act^.datos.codFuncion <= nodo^.datos.codFuncion) do
        begin
            ant := act;
            act := act^.sig;
        end;
    
    if (ant = nil) then
        begin
            nodo^.sig := Lista;
            Lista := nodo;
        end
    else
        begin
            ant^.sig := nodo;
            nodo^.sig := act;
        end;
    
end;

function nombrePeli(pelicula: tipopelicula): tiponombre; // Se dispone

begin
    nombrePeli := 'Casino Royale (2006)';
end;

Procedure inicializarMatriz(var matriz: matrizPeliculaxPais);

var
    i, j: integer;

begin
    for i := 1 to 24 do
        begin
            for j := 1 to 340 do
                begin
                    matriz[i, j] := 0;
                end;
        end;
end;

procedure RecorrerLista(var Lista: ptrnodo);

var
    aux, Taquilleras: ptrnodo;
    maxEntradas, max1: integer;
    matrizCostos: matrizPeliculaxPais;

begin
    aux := Lista;
    Taquilleras := nil;
    max1 := 0;
    inicializarMatriz(matrizCostos);

    writeln('Cual es la cantidad de entradas a considerar maximo?');
    readln(maxEntradas);

    while (aux <> nil) do
        begin
            if (EntradasMayoresA(aux^.datos.cantEntradas, maxEntradas)) then
                InsertarOrdenado(Taquilleras, aux^.datos);
            
            if (EsPar(SumaDigitos(aux^.datos.codFuncion))) then
                writeln(aux^.datos.codFuncion);
            
            if (EntradasMayoresA(aux^.datos.cantEntradas, max1)) then
                max1 := aux^.datos.cantEntradas;

            // matrizPrecioEntrada se dispone
            matrizCostos[aux^.datos.codPais, aux^.datos.codPelicula] := matrizPrecioEntrada[aux^.datos.codPais, aux^.datos.codPelicula] * aux^.datos.cantEntradas;
        end;
end;

begin
    
end.