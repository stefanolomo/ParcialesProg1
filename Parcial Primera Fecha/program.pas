
Program ClinicaMP;

Type 
    prtnodo =   ^nodo;
    nodo =   Record
        DNI:   integer;
        Nombre:   string[10];
        Apellido:   string[10];
        NroAf:   integer;
        ObraSoc:   1..20;
        sig:   prtnodo;
    End;
    vConsultorio =   array[1..12] Of prtnodo;

Procedure InicializarListas(Var VectListas: vConsultorio);

Var 
    i:   integer;

Begin
    For i := 1 To 12 Do
        VectListas[i] := Nil;
End;

Procedure InsertarOrdenado(Var L: prtnodo; p: prtnodo);

Var 
    ant, act:   prtnodo;
Begin
    act := L;
    ant := Nil;


    // Recorre la lista mientras no sea el ultimo y el apellido sea menor al que queremos insertar
    While (act <> Nil) And (act^.Apellido < p^Apellido) Do
        Begin
            ant := act;
            act := act^.sig;
        End;

    // Si la lista esta vacia, lo inserta normalmente
    If (ant = Nil) Then
        Begin
            p^.sig := Nil;
            L := p;
        End;

    // De otra manera, la lista tiene cosas: ant es el nodo anterior a la posicion a insertar y act es el nodo posterior
    Else
        Begin
            // El siguiente del nodo anterior es le nodo a insertar
            ant^.sig := p;
            // Y el siguiente al nodo a insertar es el nodo posterior
            p^.sig := act;
        End;
End;

Procedure leerdatos(Var p: prtnodo);

Begin
    readln(p^.DNI);
    readln(p^.Nombre);
    readln(p^.Apellido);
    readln(p^.NroAf);
    readln(p^.ObraSoc);
End;

Procedure IngresoPacientes (Var VectorCons: vConsultorio);

Var 
    p:   prtnodo;
    consultorio:   1..12;
    apellido: string[10];

Begin
    apellido := '';
    repeat
        new(p);
        leerdatos(p);
        apellido := p^.Apellido;
        if (apellido <> 'ZZZ') then
            begin
                read(consultorio);
                InsertarOrdenado(VectorCons[consultorio], p);    
            end
        else
            dispose(p)
    until (apellido = 'ZZZ');
End;

Begin

End.
