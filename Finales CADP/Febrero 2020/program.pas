
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
            if (act <> nil) then begin
                act^.cant := act^.cant + 1;
            end else Begin
                new(nodo);
                nodo^.autor := pub.nombre;
                nodo^.cant := 1;
                nodo^.sig := nil;

                Lista := nodo;
            end;
        End
    Else If (act = Nil) Then
            Begin
                new(nodo);
                nodo^.autor := pub.nombre;
                nodo^.cant := 1;
                nodo^.sig := nil;

                ant^.sig := nodo;
            End
    Else
        Begin
            act^.cant := act^.cant + 1;
        End;
End;

procedure InicializarArrPub (var V: ArrPub);

var
    i: integer;

begin
    for i := 1 to 12 do begin
        V[i] := 0;
    end;
end;

function HallarMaxEnArrPub (V: ArrPub): tipoPub;

var
    i, maxIn: tipoPub;
    max1: integer;

begin
    max1 := -1;

    for i := 1 to 12 do begin
        if (V[i] > max1) then begin
            max1 := V[i];
            maxIn := i;
        end;
    end;

    HallarMaxEnArrPub := maxIn;
end;

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

Procedure Principal(var Lista: ptrnodo);

Var
    pub:   publicacion;
    ArregloPublicaciones: ArrPub;

Begin
    InicializarArrPub(ArregloPublicaciones);
    LeerPublicacion(pub);

    While pub.DNI <> 0 Do Begin
            InsertarAutor(Lista, pub);
            LeerPublicacion(pub);

            ArregloPublicaciones[pub.tipo] := ArregloPublicaciones[pub.tipo] + 1;
        End;

    writeln('El tipo de publicacion mas frecuente es el nro: ', HallarMaxEnArrPub(ArregloPublicaciones));
End;

procedure InformarListaAutores(Lista: ptrnodo);

begin
    while (Lista <> nil) do begin
        writeln('Para el autor ', Lista^.autor, ', se registraron ', Lista^.cant, ' publicaciones diferentes.');

        Lista := Lista^.sig;
    end;
end;

procedure LiberarLista(var Lista: ptrnodo);

var
    aux: ptrnodo;

begin
    while (Lista <> nil) do begin
        aux := Lista;
        Lista := Lista^.sig;
        dispose(aux);
    end;
end;

var
    ListaAutores: ptrnodo;

Begin
    Principal(ListaAutores);

    InformarListaAutores(ListaAutores);
End.
