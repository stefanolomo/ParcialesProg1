Program Parcial;

type
    // Tipos del registro
    tipodia = 1..31;
    tipomes = 1..12;
    tipohora = 1..23;
    tipominuto = 1..59;
    tiposala = 1..440;
    tipopais = 1..24;
    tipopelicula = 1..340;

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

procedure InsertarOrdenado(var Lista: ptrnodo; nodo: ptrnodo);

var
    ant, act: ptrnodo;

begin
    ant := nil;
    act := Lista;

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

begin
    
end.