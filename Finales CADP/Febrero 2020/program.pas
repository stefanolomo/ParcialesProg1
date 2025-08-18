
Program Final;



// La facultad de informatica organizará el congreso WICC, en donde se expondran trabajos de investigacion. Realizar un programa que lea la informacion de cada publicacion; titulo, nombre del autor, DNI del autor, tipo de publicacion (1..12). La lectura de publicaciones finaliza al ingresar un DNI del autor con valor 0 el cual no debe procesarse. La informacion se lee ordenada por DNI del autor y un autor puede tener varias publicaciones.

// Se pide escribir un programa que:

// - Informar el tipo de publicacion con mayor cantidad de publicaciones.

// - Informar para cada autor la cantidad de publicaciones presentadas.

Type
    cadena30 =   String[30];
    tipoPub =   1..12;

    publicacion =   Record
        titulo, nombre:   cadena30;
        DNI:   integer;
        tipo:   tipoPub;
    End;

    ArrPub =   Array[tipoPub] Of integer;

    ptrnodo =   ^nodo;
    nodo =   Record
        autor:   cadena30;
        cant:   integer;
        sig:   ptrnodo;
    End;

Procedure InsertarAutor(Var Lista: ptrnodo; pub: publicacion);

Var
    ant, act, nodo:   ptrnodo;

Begin
    ant := Nil;
    act := Lista;

    While (act <> Nil) And (act^.autor <> pub.nombre) Do
        Begin
            ant := act;
            act := act^.sig;
        End;

    If (ant = Nil) Then
        Begin
            If (act <> Nil) Then
                Begin
                    act^.cant := act^.cant + 1;
                End
            Else
                Begin
                    new(nodo);
                    nodo^.autor := pub.nombre;
                    nodo^.cant := 1;
                    nodo^.sig := Nil;

                    Lista := nodo;
                End;
        End
    Else If (act = Nil) Then
             Begin
                 new(nodo);
                 nodo^.autor := pub.nombre;
                 nodo^.cant := 1;
                 nodo^.sig := Nil;

                 ant^.sig := nodo;
             End
    Else
        Begin
            act^.cant := act^.cant + 1;
        End;
End;

Procedure InicializarArrPub (Var V: ArrPub);

Var
    i:   integer;

Begin
    For i := 1 To 12 Do
        Begin
            V[i] := 0;
        End;
End;

Function HallarMaxEnArrPub (V: ArrPub):   tipoPub;

Var
    i, maxIn:   tipoPub;
    max1:   integer;

Begin
    max1 := -1;

    For i := 1 To 12 Do
        Begin
            If (V[i] > max1) Then
                Begin
                    max1 := V[i];
                    maxIn := i;
                End;
        End;

    HallarMaxEnArrPub := maxIn;
End;

Procedure LeerPublicacion(Var pub: publicacion);

Begin
    writeln('Ingresar el DNI del autor');
    readln(pub.DNI);

    If pub.DNI <> 0 Then
        Begin
            writeln('Ingrese el nombre del autor');
            readln(pub.nombre);

            writeln('Ingresar el titulo de la publicacion');
            readln(pub.titulo);

            writeln('Ingrese el tipo de publicacion (1 a 12)');
            readln(pub.tipo);
            While Not (pub.tipo In [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12]) Do
                Begin
                    writeln('Ingresar un tipo valido (1 a 12)');
                    readln(pub.tipo);
                End;
        End;
End;

Procedure Principal(Var Lista: ptrnodo);

Var
    pub:   publicacion;
    ArregloPublicaciones:   ArrPub;

Begin
    InicializarArrPub(ArregloPublicaciones);
    LeerPublicacion(pub);

    While pub.DNI <> 0 Do
        Begin
            InsertarAutor(Lista, pub);
            LeerPublicacion(pub);

            ArregloPublicaciones[pub.tipo] := ArregloPublicaciones[pub.tipo] + 1
            ;
        End;

    writeln('El tipo de publicacion mas frecuente es el nro: ',
            HallarMaxEnArrPub(ArregloPublicaciones));
End;

Procedure InformarListaAutores(Lista: ptrnodo);

Begin
    While (Lista <> Nil) Do
        Begin
            writeln('Para el autor ', Lista^.autor, ', se registraron ', Lista^.
                    cant, ' publicaciones diferentes.');

            Lista := Lista^.sig;
        End;
End;

Procedure LiberarLista(Var Lista: ptrnodo);

Var
    aux:   ptrnodo;

Begin
    While (Lista <> Nil) Do
        Begin
            aux := Lista;
            Lista := Lista^.sig;
            dispose(aux);
        End;
End;

Var
    ListaAutores:   ptrnodo;

Begin
    Principal(ListaAutores);

    InformarListaAutores(ListaAutores);
End.
