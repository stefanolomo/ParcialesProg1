
Program ClinicaMP;

Type 
    ptrnodo =   ^nodo;
    nodo =   Record
        DNI:   integer;
        Nombre:   string[10];
        Apellido:   string[10];
        NroAf:   integer;
        ObraSoc:   1..20;
        sig:   ptrnodo;
    End;
    vConsultorio =   array[1..12] Of ptrnodo;
    conj = set of 0..9;
    vHonorarios = array[1..12] Of integer;

Procedure InicializarListas(Var VectListas: vConsultorio);

Var 
    i:   integer;

Begin
    For i := 1 To 12 Do
        VectListas[i] := Nil;
End;

Procedure InsertarOrdenado(Var L: ptrnodo; p: ptrnodo);

Var 
    ant, act:   ptrnodo;
Begin
    act := L;
    ant := Nil;


    // Recorre la lista mientras no sea el ultimo y el apellido sea menor al que queremos insertar
    While (act <> Nil) And (act^.Apellido < p^.Apellido) Do
        Begin
            ant := act;
            act := act^.sig;
        End;

    // Si tenemos que insertar en el primero de la lista (el anterior es nil) hacemos el enganche con el resto de la lista
    If (ant = Nil) Then
        Begin
            p^.sig := L;
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

Procedure leerdatos(Var p: ptrnodo);

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
    p:   ptrnodo;
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
                readln(consultorio);
                InsertarOrdenado(VectorCons[consultorio], p);    
            end
        else
            // De otra manera, el apellido es ZZZ entonces liberamos la memoria ya que se terminó de ingresar pacientes
            dispose(p);
    until (apellido = 'ZZZ');
End;

procedure DescomponerNros(Num: integer; var ConjuntoDigitos: conj);

var
    digito: integer;
 
begin
    ConjuntoDigitos := [];
    while (Num <> 0) do
        begin
            digito := Num mod 10;
            ConjuntoDigitos := ConjuntoDigitos + [digito];
            Num := Num div 10;
        end;
end;

function DNIenNroAfiliado(DNI: integer; Afiliado: integer): boolean;

var
    conjuntoDNI: conj;
    conjuntoAfiliado: conj;

begin
    // Descompone los numeros del dni y del afiliado
    DescomponerNros(DNI, conjuntoDNI);
    DescomponerNros(Afiliado, conjuntoAfiliado);

    // Si los digitos del DNI estan en el Nro de afiliado, es verdadero
    DNIenNroAfiliado := (conjuntoDNI <= conjuntoAfiliado)
end;

procedure EliminarPacienteNroAfiliado(Afiliado: Integer; var Lista: ptrnodo);

var
    ant, act: ptrnodo;

begin
    // El actual es la cabeza de lista, y el anterior es nil
    act := Lista;
    ant := nil;
    
    // Recorre la lista mientras haya nodos y el no hayamos encontrado al Afiliado que buscamos
    while (act <> nil) and (act^.NroAf <> Afiliado) do
        begin
            ant := act;
            act := act^.sig;
        end;
    //Cuando salimos, o no hay mas nodos o encontramos al que buscamos

    // Si act es un nodo valido, entonces lo eliminamos
    if (act <> nil) then
        begin
            // Si es el primer nodo (anterior es nil), cambiamos la lista a el siguiente nodo
            if (ant = nil) then
                begin
                    Lista := act^.sig;
                    // Eliminamos act ya que no forma parte de la lista
                    dispose(act);
                end
            // De otra manera, es un nodo adentro de la lista entonces tenemos que enganchar el anterior con el siguiente
            else
                begin
                    ant^.sig := act^.sig;
                    // Eliminamos act ya que no forma parte de la lista
                    dispose(act);
                end;
        end;
end;

// En el parcial se dispone de esta funcion
function CalcularHonorarios(consultorio: integer; ObraSoc: integer):integer;
begin
    case ObraSoc of
        1..7: CalcularHonorarios := 100 * consultorio;
        8..11: CalcularHonorarios := 70 * consultorio;
        12: CalcularHonorarios := 350 * consultorio
    else
        CalcularHonorarios := 500 * consultorio
    end;
end;

procedure RecorrerEstructura(var VectorCons: vConsultorio; var VectorHonorarios: vHonorarios);

var
    i: integer;
    Lista, aux: ptrnodo;

begin
    for i := 1 to 12 do
        begin
            VectorHonorarios[i] := 0;
            Lista := VectorCons[i];
            while (Lista <> nil) do
                begin
                    if (DNIenNroAfiliado(Lista^.DNI, Lista^.NroAf)) then
                        begin
                            // Imprime el nombre y apellido
                            writeln(Lista^.Nombre);
                            writeln(Lista^.Apellido);

                            aux := Lista;

                            // Continua al siguiente nodo
                            Lista := Lista^.sig;

                            // Elimina el nodo
                            EliminarPacienteNroAfiliado(aux^.NroAf, VectorCons[i]);
                        end
                    else
                        begin
                            // Suma al total de los honorarios del consultorio los honorarios del paciente
                            VectorHonorarios[i] := VectorHonorarios[i] + CalcularHonorarios(i, Lista^.ObraSoc);

                            // Continua al siguiente nodo
                            Lista := Lista^.sig;
                        end;
                    
                end;
        end;
end;

procedure ImprimirPacientes(VectorCons: vConsultorio);
var
    i: integer;
    p: ptrnodo;
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
    vectHonorarios: vHonorarios;
    i: integer;

Begin
    InicializarListas(ArregloListas);
    IngresoPacientes(ArregloListas);
    RecorrerEstructura(ArregloListas, vectHonorarios);
    for i := 1 to 12 Do writeln('Los honorarios de la clinica ', i, ' son: ', vectHonorarios[i]);
    ImprimirPacientes(ArregloListas);
End.
