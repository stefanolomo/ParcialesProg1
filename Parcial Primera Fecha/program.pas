program ParcialPrimeraFecha2025;

type
    tipocadena = string[40];
    tipoobra = 1..20;
    tipoconsultorio = 1..12;

    registrodatos = record
        Dni: longint;
        Nombre: tipocadena;
        Apellido: tipocadena;
        ObraSocial: tipoobra;
        Afiliado: longint;
    end;

    ptrnodo = ^nodo;
    nodo = record
        datos: registrodatos;
        sig: ptrnodo;
    end;

    ArrListas = Array[tipoconsultorio] of ptrnodo;
    ArrConsult = Array[tipoconsultorio] of longint;
    cint = set of 1..9;

procedure InsertarOrdenado(var Lista: ptrnodo; datos: registrodatos);

var
    ant, act, nodo: ptrnodo;

begin
    ant := nil;
    act := Lista;

    new(nodo);
    nodo^.datos := datos;

    while (act <> nil) and (act^.datos.Apellido < nodo^.datos.Apellido) do begin
        ant := act;
        act := act^.sig;
    end;

    if (ant = nil) then begin
        nodo^.sig := Lista;
        Lista := nodo;
    end else begin
        ant^.sig := nodo;
        nodo^.sig := act;
    end;
end;

procedure Leerdatos(var datos: registrodatos; var consultorio: tipoconsultorio);

begin
    writeln('>> Ingresar el apellido: ');
    readln(datos.Apellido);
    if (datos.Apellido <> 'ZZZ') then begin
        writeln('>> Ingresar el nombre: ');
        readln(datos.Nombre);
        writeln('>> Ingresar el consultorio: ');
        readln(consultorio);
        writeln('>> Ingresar el DNI: ');
        readln(datos.DNI);
        writeln('>> Ingresar el numero de afiliado: ');
        readln(datos.Afiliado);
        writeln('>> Ingresar la obra social: ');
        readln(datos.ObraSocial);
    end;
end;

procedure CargarListas(var Lista: ArrListas);

var
    datos: registrodatos;
    consultorio: tipoconsultorio;

begin
    repeat    
        Leerdatos(datos, consultorio);

        if (datos.Apellido <> 'ZZZ') then
            InsertarOrdenado(Lista[consultorio], datos);
    until (datos.Apellido = 'ZZZ');
end;

procedure LiberarLista(var Lista: ptrnodo);

var
    act: ptrnodo;

begin
    act := Lista;
    while (Lista <> nil) do begin
        act := Lista;
        Lista := Lista^.sig;
        dispose(act);
    end;
end;

procedure InicializarConsultorios(var ArrCon: ArrListas);

var
    i: longint;

begin
    for i := 1 to 12 do begin
        ArrCon[i] := nil;
    end;
end;

procedure InformarLista (Lista: ptrnodo);

var
    i: longint;
    datos: registrodatos;

begin
    i := 0;

    while (Lista <> nil) do begin
        i := i + 1;
        datos := Lista^.datos;

        writeln('Nodo ', i);

        writeln('Apellido: ', datos.Apellido);
        writeln('DNI: ', datos.DNI);
        writeln('Nombre: ', datos.Nombre);
        writeln('Obra social: ', datos.ObraSocial);
        writeln('Numero de afiliado: ', datos.Afiliado);

        Lista := Lista^.sig;
    end;
    
    writeln('En la lista habia/n ', i, ' elemento/s.');
end;

procedure InformarPaciente(datos: registrodatos);

begin
    writeln('Apellido: ', datos.Apellido);
    writeln('DNI: ', datos.DNI);
    writeln('Nombre: ', datos.Nombre);
    writeln('Obra social: ', datos.ObraSocial);
    writeln('Numero de afiliado: ', datos.Afiliado);
end;

procedure DescomponerDigitos(num: longint; var conj: cint);

var
    digito: longint;

begin
    while (num <> 0) do begin
        digito := num mod 10;

        conj := conj + [digito];

        num := num div 10;
    end;
end;

function CalcularHonorario(consultorio: tipoconsultorio; ObraSocial: tipoobra):longint;

begin
    if ((consultorio mod 2) = 0) then
        CalcularHonorario := consultorio * ObraSocial * 3
    else begin
        CalcularHonorario := consultorio * ObraSocial * 2;
    end;
end;

function AfiliadoValido (Afiliado, DNI: longint): boolean;

var
    conjDNI, conjAf: cint;

begin
    conjAf := [];
    conjDNI := [];

    DescomponerDigitos(Afiliado, conjAf);
    DescomponerDigitos(DNI, conjDNI);

    AfiliadoValido := (conjDNI <= conjAf);
end;

procedure RecorrerLista(var Lista: ptrnodo; consultorio: tipoconsultorio; var Honorarios: ArrConsult);

var
    ant, act, aux: ptrnodo;

begin
    ant := nil;
    act := Lista;

    while (act <> nil) do begin
        if AfiliadoValido(act^.datos.Afiliado, act^.datos.DNI) then begin
            InformarPaciente(act^.datos);

            Honorarios[consultorio] := Honorarios[consultorio] + CalcularHonorario(consultorio, act^.datos.ObraSocial);

            ant := act;
            act := act^.sig;
        end else begin
            aux := act;

            if (ant = nil) then
                Lista := act^.sig
            else
                ant^.sig := act^.sig;
            
            act := act^.sig;
            dispose(aux);
        end;
    end;
end;

procedure InicializarArreglo(var V: ArrConsult);

var
    i: longint;

begin
    for i := 1 to 12 do
        V[i] := 0;
end;

var
    ArregloConsultorios: ArrListas;
    i: longint;
    Honorarios: ArrConsult;

begin
    writeln(' ');
    writeln('╔═╗┬  ┬┌┐┌┬┌─┐┌─┐  ╔╦╗╔╦╗');
    writeln('║  │  ││││││  ├─┤  ║║║ ║║');
    writeln('╚═╝┴─┘┴┘└┘┴└─┘┴ ┴  ╩ ╩═╩╝');
    writeln(' ');

    writeln('La clínica MP gestiona la atención de pacientes en 12 consultorios, cada uno con una lista ordenada alfabéticamente por apellido. De cada paciente se registra nombre, apellido, DNI, obra social (1 a 20), número de afiliado y consultorio al que asiste. Se solicita implementar la carga de pacientes desde teclado, finalizando con apellido ZZZ, insertándolos ordenadamente en la lista correspondiente. Luego, recorrer todas las listas una sola vez para: (A) informar los pacientes cuyo número de afiliado contiene todos los dígitos del DNI, (B) eliminar a los que no cumplen esa condición y (C) calcular la recaudación total por honorarios adicionales para cada consultorio, en base a la obra social y el número de consultorio.');

    writeln(' ');

    InicializarConsultorios(ArregloConsultorios);
    InicializarArreglo(Honorarios);

    CargarListas(ArregloConsultorios);

    for i := 1 to 12 do
        RecorrerLista(ArregloConsultorios[i], i, Honorarios);

    for i := 1 to 12 do begin
        writeln('Para el consultorio ', i, ' la lista es: ');
        InformarLista(ArregloConsultorios[i]);
    end;

    for i := 1 to 12 do begin
        LiberarLista(ArregloConsultorios[i]);
    end;
end.
