
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
    conj = set of 0..9;

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
    While (act <> Nil) And (act^.Apellido < p^.Apellido) Do
        Begin
            ant := act;
            act := act^.sig;
        End;

    // Si la lista esta vacia, lo inserta normalmente
    If (ant = Nil) Then
        Begin
            p^.sig := Nil;
            L := p;
        End

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
    writeln('Ingresar el DNI del paciente');
    readln(p^.DNI);
    writeln('Ingresar el nombre del paciente');
    readln(p^.Nombre);
    writeln('Ingresar el apellido del paciente');
    readln(p^.Apellido);
    writeln('Ingresar el NRO de afiliado del paciente');
    readln(p^.NroAf);
    writeln('Ingresar la obra social del paciente');
    readln(p^.ObraSoc);
End;

Procedure IngresoPacientes (Var VectorCons: vConsultorio);

Var 
    p:   prtnodo;
    consultorio:   1..12;
    apellido: string[10];

Begin
    // Cadena auxiliar
    apellido := '';
    repeat
        // Inicializa un nodo y lee los datos del paciente
        new(p);
        leerdatos(p);

        // La variable auxiliar es el apellido
        apellido := p^.Apellido;
        
        // Si el apellido es valido...
        if (apellido <> 'ZZZ') then
            begin
                // Le preguntamos el consultorio y lo insertamos ordenado en la lista correspondiente
                writeln('Ingresar el consultorio del paciente: ');
                read(consultorio);
                InsertarOrdenado(VectorCons[consultorio], p);    
            end
        else
            // De otra manera, el apellido es ZZZ entonces liberamos la memoria ya que se terminó de ingresar pacientes
            dispose(p);
    until (apellido = 'ZZZ');
End;

procedure DescomponerDNI (DNI: integer; var ConjuntoDigitos: conj);

var
    digito: integer;
 
begin
    ConjuntoDigitos := [];
    while (DNI <> 0) do
        begin
            digito := DNI mod 10;
            ConjuntoDigitos := ConjuntoDigitos + [digito];
            DNI := DNI div 10;
        end;
end;

procedure RecorrerEstructura(var VectorCons: vConsultorio);
begin
    
end;

procedure ImprimirPacientes(VectorCons: vConsultorio);
var
    i: integer;
    p: prtnodo;
begin
    for i := 1 to 12 do
    begin
        writeln('Consultorio ', i, ':');
        p := VectorCons[i];
        if p = nil then
            writeln('  (Sin pacientes)')
        else
        begin
            while p <> nil do
            begin
                writeln('  Apellido: ', p^.Apellido, ', Nombre: ', p^.Nombre, ', DNI: ', p^.DNI);
                // Agrega aquí otros campos si los tienes, por ejemplo: p^.Edad, etc.
                p := p^.sig;
            end;
        end;
        writeln;
    end;
end;

var
    ArregloListas: vConsultorio;

Begin
    InicializarListas(ArregloListas);
    IngresoPacientes(ArregloListas);
    ImprimirPacientes(ArregloListas);
End.
