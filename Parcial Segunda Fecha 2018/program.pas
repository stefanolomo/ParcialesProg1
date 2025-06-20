program Parcial;

const
    TIPOS = 110;

type
    tiponombre = string[30];
    tipodia = 1..31;
    tipomes = 1..12;
    tipoarchivo = 1..TIPOS;
    ptrnodo = ^nodo;
    registrodatos = record
        nombre: tiponombre;
        dia: tipodia;
        mes: tipomes;
        year: integer;
        size: integer;
        archivo: tipoarchivo;
        codSeguridad: integer;
    end;
    nodo = record
        datos: registrodatos;
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

function SumaDigitos(a: integer): integer;

var
    total, digito: integer;

begin
    total := 0;
    while (a <> 0) do
        begin
            // Descompone los digitos
            digito := a mod 10;

            // Suma los digitos al total
            total := total + digito;

            // Elimina el digito que sumamos
            a := a div 10;
        end;
    SumaDigitos := total;
end;

function CodigoSeguridadValido(nodo: ptrnodo): boolean;

var
    codCalculado: integer;

begin
    codCalculado := SumaDigitos(nodo^.datos.dia) + SumaDigitos(nodo^.datos.mes) + SumaDigitos(nodo^.datos.year) + SumaDigitos(nodo^.datos.size) + SumaDigitos(nodo^.datos.archivo);
    
    CodigoSeguridadValido := (nodo^.datos.codSeguridad = codCalculado)
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
    if (act^.datos.size > tamMax1) then
        begin
            // Pasar max1 al max2
            nomMax2 := nomMax1;
            tamMax2 := tamMax1;

            // Actualizar max1
            nomMax1 := act^.datos.nombre;
            tamMax1 := act^.datos.size;
        end
    else if (act^.datos.size > tamMax2) then
        begin
            // Actualizar max2
            nomMax2 := act^.datos.nombre;
            tamMax2 := act^.datos.size;
        end;
end;

procedure InsertarOrdenado(var Lista: ptrnodo; datos: registrodatos);

var
    ant, act, nodo: ptrnodo;

begin
    new(nodo);
    nodo^.datos := datos;
    // Inicializamos ant y act
    ant := nil;
    act := Lista;

    while (act <> nil) and (act^.datos.size >= nodo^.datos.size) do
        begin
            // Recorremos la lista hasta el ultimo o hasta que se llegue a la posicion a insertar
            ant := act;
            act := act^.sig;
        end;
    // Una vez terminado el bucle, se tiene que insertar entre ant y act

    // Si ant es nil estamos al principio de la lista
    if (ant = nil) then
        begin
            nodo^.sig := Lista;
            Lista := nodo;
        end
    else // De otra manera hay que insertar entre ant y act
        begin
            ant^.sig := nodo;
            nodo^.sig := act;
        end;
end;

function Nombre(tipo: integer): string; // Se dispone
begin
    case tipo of
        1: Nombre := 'Texto';
        2: Nombre := 'Imagen';
        3: Nombre := 'Audio';
        4: Nombre := 'Video';
        5: Nombre := 'PDF';
    // Agrega más tipos según tus necesidades
    else
        Nombre := 'Desconocido';
  end;
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

    // Se inicializa los maximos y sus nombres
    tamMax1 := -1;
    tamMax2 := -1;
    nomMax1 := '';
    nomMax2 := '';

    while (act <> nil) do
        begin
            if not (CodigoSeguridadValido(act)) then
                begin
                    // Si el codigo no es valido, informamos el nombre
                    writeln('Se encontro un archivo no valido con el nombre: ', act^.datos.nombre);
                end
            else if (act^.datos.year < 2015) then
                begin
                    // Si es de antes del 2015, llevamos cuenta del maximo tamaño y su nombre (2 maximos)
                    ActualizarMax(act, nomMax1, nomMax2, tamMax1, tamMax2);
                end;
            
            // Para cada archivo, sumamos 1 al arreglo de tipos dependiendo de su tipo
            arregloCantTipos[act^.datos.archivo] := arregloCantTipos[act^.datos.archivo] + 1;

            // Cada archivo lo insertamos en la lista del arreglo de listas en el indice del archivo
            InsertarOrdenado(arregloListaTipos[act^.datos.archivo], act^.datos);

            // Avanzamos en la lista
            act := act^.sig;
            totalArchivos := totalArchivos + 1;
        end;
        // Cuanto termino el bucle, se termino de procesar todos los archivos

        // Informamos los maximos
        writeln('El primer archivo mas grande anterior a 2015 es: ', nomMax1, ' con tamaño ', tamMax1);
        writeln('El segundo archivo mas grande anterior a 2015 es: ', nomMax2, ' con tamaño ', tamMax2);

        // Calculamos e informamos los porcentajes de cada tipo de archivo
        for i := 1 to TIPOS do
            begin
                if (totalArchivos > 0) then
                    writeln('El tipo de archivo ', Nombre(i), ' aparece ', arregloCantTipos[i], ' veces. Eso hace que forme el ', (arregloCantTipos[i] / totalArchivos)*100, '% de los archivos en la lista');
            end;

    // Liberamos memoria de las listas
    for i := 1 to TIPOS do
        LiberarListas(arregloListaTipos[i]);
end;

var
    ListaArchivos: ptrnodo;

begin
    ListaArchivos := nil;
    // CargarLista(ListaArchivos); (Se dispone)
    RecorrerLista(ListaArchivos);
    LiberarListas(ListaArchivos);
end.