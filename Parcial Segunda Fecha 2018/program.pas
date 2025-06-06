program Parcial;

const
    TIPOS = 110;

type
    tiponombre = string[30];
    tipodia = 1..31;
    tipomes = 1..12;
    tipoarchivo = 1..TIPOS;
    ptrnodo = ^nodo;
    nodo = record
        nombre: tiponombre;
        dia: tipodia;
        mes: tipomes;
        year: integer;
        size: integer;
        archivo: tipoarchivo;
        codSeguridad: integer;
        sig: ptrnodo;
    end;
    ArrArchivos = array[1..TIPOS] of integer;
    ArrPorTipo = array[1..TIPOS] of ptrnodo;

procedure LiberarListas(var Lista: ptrnodo);

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

function SumarDigitos(a: integer; b: integer): integer;

var
    total, digitoa, digitob: integer;

begin
    total := 0;
    while (a <> 0) or (b <> 0) do
        begin
            // Descompone los digitos
            digitoa := a mod 10;
            digitob := b mod 10;

            // Suma los digitos al total
            total := total + digitoa + digitob;

            // Elimina el digito que sumamos
            a := a div 10;
            b := b div 10;
        end;
    SumarDigitos := total;
end;

function CodigoSeguridadValido(nodo: ptrnodo): boolean;

var
    codCalculado: integer;

begin
    codCalculado := SumarDigitos(nodo^.dia, nodo^.mes);
    codCalculado := codCalculado + SumarDigitos(nodo^.year, nodo^.size);
    codCalculado := codCalculado + nodo^.archivo;
    
    CodigoSeguridadValido := (nodo^.codSeguridad = codCalculado)
end;

procedure InicializarListasTipos(var ArrListas: ArrPorTipo);
var i: integer;
begin
    for i := 1 to TIPOS do
        ArrListas[i] := nil;
end;

procedure InicializarArrCantArch(var ArrCantArch: ArrArchivos);
var i: integer;
begin
    for i := 1 to TIPOS do
        ArrCantArch[i] := 0;
end;

procedure ActualizarMax(act: ptrnodo; var nomMax1: tiponombre; var nomMax2: tiponombre; var tamMax1: integer; var tamMax2: integer);

begin
    if (act^.size > tamMax1) then
        begin
            // Pasar max1 al max2
            nomMax2 := nomMax1;
            tamMax2 := tamMax1;

            // Actualizar max1
            nomMax1 := act^.nombre;
            tamMax1 := act^.size;
        end
    else if (act^.size > tamMax2) then
        begin
            // Actualizar max2
            nomMax2 := act^.nombre;
            tamMax2 := act^.size;
        end;
end;

procedure InsertarOrdenado(var Lista: ptrnodo; nodo: ptrnodo);

begin
    
end;

procedure RecorrerLista (var Lista: ptrnodo);

var
    act: ptrnodo;
    arregloCantTipos: ArrArchivos;
    arregloListaTipos: ArrPorTipo;
    totalArchivos, i: Integer;
    tamMax1, tamMax2: integer;
    nomMax1, nomMax2: tiponombre;

begin
    // Seteamos el anterior a nil y el actual a la lista
    act := lista;

    // Seteamos el total en 0
    totalArchivos := 0;

    // Inicializamos el arreglo de cantidades y el arreglo de listas
    InicializarArrCantArch(arregloCantTipos);
    InicializarListasTipos(arregloListaTipos);

    while (act <> nil) do
        begin
            if not (CodigoSeguridadValido(act)) then
                begin
                    // Si el codigo no es valido, informamos el nombre
                    writeln('Se encontro un archivo no valido con el nombre: ', act^.nombre);
                end
            else if (act^.year < 2015) then
                begin
                    // Si es de antes del 2015, llevamos cuenta del maximo tamaño y su nombre (2 maximos)
                    ActualizarMax(act, nomMax1, nomMax2, tamMax1, tamMax2);
                end;
            
            // Para cada archivo, sumamos 1 al arreglo de tipos dependiendo de su tipo
            arregloCantTipos[act^.archivo] := arregloCantTipos[act^.archivo] + 1;

            // Cada archivo lo insertamos en la lista del arreglo de listas en el indice del archivo
            InsertarOrdenado(arregloListaTipos[act^.archivo], act);

            // Avanzamos en la lista
            act := act^.sig;
            totalArchivos := totalArchivos + 1;
        end;
        // Cuanto termino el bucle, se termino de procesar todos los archivos

        // Calculamos e informamos los porcentajes de cada tipo de archivo
        for i := 1 to TIPOS do
            begin
                if (totalArchivos > 0) then
                    writeln('El tipo de archivo ', Nombre(i), ' aparece ', arregloCantTipos[i], ' veces. Eso hace que forme el ', (arregloCantTipos[i] / totalArchivos)*100, '% de los archivos en la lista');
            end;
end;

begin
end.