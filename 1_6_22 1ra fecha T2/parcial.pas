
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
        dia: integer;
        mes: integer;
        year: integer;
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
Begin

End;
