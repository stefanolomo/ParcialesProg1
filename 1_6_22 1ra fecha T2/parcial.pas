Program Parcial;

// La provincia de BsAs cuenta con informacion de las personas vacunadas de COVID de cada uno de los 136 partidos que la componen.

// Se dispone de una lista con el registro de cada dia de vacunacion ocurrida en cada partido durante el año pasado. Por cada dia de vacunacion se tiene: dia, mes y año; codigo de partido, codigo de zona de partido (de 1 a 6); y cantidad de vacunados. Tambien se dispone de una estructura que se accede por codigo de partido al nombre de este. Se requiere procesar la lista recorriendola 1 vez para:

// - Se sabe que puede haber registros que no corresponden a el año pasado, eliminarlos

// - Obtener para cada partido el total de personas vacunadas

// - Informar el nombre y cantidad de personas vacunadas de los 2 partidos que mas personas vacunadas tienen

// - Generar 6 listas separadas por codigo de zona. Cada lista debe tener el codigo de partido ordenado de menor a mayor

Const 
    CANT_PARTIDOS =   136;
    CANT_ZONAS =   6;

Type 
    // Registro para cada día de vacunación
    RegistroVacunacion =   Record
        dia:   integer;
        mes:   integer;
        year:   integer;
        codPartido:   1..CANT_PARTIDOS;
        codZona:   1..CANT_ZONAS;
        cantidadVacunados:   integer;
    End;

    // Nodo de la lista enlazada
    ListaVacunacion =   ^NodoVacunacion;
    NodoVacunacion =   Record
        dato:   RegistroVacunacion;
        sig:   ListaVacunacion;
    End;

    NombresPartidos =   array[1..CANT_PARTIDOS] Of string[40];

// Agrega un registro al principio de la lista
Procedure AgregarAlPrincipio(Var L: ListaVacunacion; reg: RegistroVacunacion);

Var 
    nuevo:   ListaVacunacion;
Begin
    New(nuevo);
    nuevo^.dato := reg;
    nuevo^.sig := L;
    L := nuevo;
End;

// Procedimiento para cargar los partidos
Procedure CargarPartidos(Var partidos: NombresPartidos; Var cant: integer);

Var 
    i:   integer;
Begin
    writeln('Ingrese cantidad de partidos a cargar (maximo ', CANT_PARTIDOS,
            '): ');
    readln(cant);
    If (cant > CANT_PARTIDOS) Then
        cant := CANT_PARTIDOS;
    For i := 1 To cant Do
        Begin
            writeln('Ingrese nombre del partido ', i, ': ');
            readln(partidos[i]);
        End;
End;

// Procedimiento para cargar la lista de vacunaciones
Procedure CargarLista(Var L: ListaVacunacion; cantPartidos: integer);

Var 
    reg:   RegistroVacunacion;
Begin
    L := Nil;
    writeln('--- Carga de vacunaciones ---');
    writeln('Para terminar ingrese 0 como codigo de partido');
    Repeat
        write('Codigo de partido (1 a ', cantPartidos, ', 0 para salir): ');
        readln(reg.codPartido);
        If (reg.codPartido = 0) Then break;
        If (reg.codPartido < 1) Or (reg.codPartido > cantPartidos) Then
            Begin
                writeln('Codigo incorrecto.');
                continue;
            End;
        write('Dia: ');
        readln(reg.dia);
        write('Mes: ');
        readln(reg.mes);
        write('Anio: ');
        readln(reg.anio);
        write('Codigo de zona (1 a ', CANT_ZONAS, '): ');
        readln(reg.codZona);
        write('Cantidad vacunados: ');
        readln(reg.cantidadVacunados);
        AgregarAlPrincipio(L, reg);
        writeln('--- Registro cargado ---');
    Until false;
End;

// Procedimiento para mostrar la lista cargada
Procedure MostrarLista(L: ListaVacunacion; partidos: NombresPartidos);
Begin
    writeln('--- Lista de vacunaciones ---');
    While L <> Nil Do
        Begin
            With L^.dato Do
                writeln('Fecha: ', dia, '/', mes, '/', anio, ' | Partido: ',
                        partidos[codPartido], ' (', codPartido, ') | Zona: ',
                        codZona, ' | Vacunados: ', cantidadVacunados);
            L := L^.sig;
        End;
End;

// Procedimiento para liberar la memoria de la lista
Procedure LiberarLista(Var L: ListaVacunacion);

Var 
    aux:   ListaVacunacion;
Begin
    While L <> Nil Do
        Begin
            aux := L;
            L := L^.sig;
            Dispose(aux);
        End;
End;

Var 
    lista:   ListaVacunacion;
    partidos:   NombresPartidos;
    cantPartidos:   integer;

Begin
    CargarPartidos(partidos, cantPartidos);
    CargarLista(lista, cantPartidos);
    MostrarLista(lista, partidos);
    LiberarLista(lista);
End.