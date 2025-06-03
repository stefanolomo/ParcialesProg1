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

begin
end.