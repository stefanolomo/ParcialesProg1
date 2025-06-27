program ParcialPrimeraFecha2025;

type
    tipocadena = string[40];
    tipoobra = 1..20;
    tipoconsultorio = 1..12;

    registrodatos = record
        Dni: integer;
        Nombre: tipocadena;
        Apellido: tipocadena;
        ObraSocial: tipoobra;
        Afiliado: integer;
    end;

    ptrnodo = ^nodo;
    nodo = record
        datos: registrodatos;
        sig: ptrnodo;
    end;

    ArrListas = Array[tipoconsultorio] of ptrnodo;
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
    writeln('Ingresar el apellido: ');
    readln(datos.Apellido);
    if (datos.Apellido <> 'ZZZ') then begin
        writeln('Ingresar el nombre: ');
        readln(datos.Nombre);
        writeln('Ingresar el consultorio: ');
        readln(consultorio);
        writeln('Ingresar el DNI: ');
        readln(datos.DNI);
        writeln('Ingresar la obra social: ');
        readln(datos.ObraSocial);
        writeln('Ingresar el numero de afiliado: ');
        readln(datos.Afiliado);
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
    i: integer;

begin
    for i := 1 to 12 do begin
        ArrCon[i] := nil;
    end;
end;

procedure InformarLista (Lista: ptrnodo);

var
    i: integer;
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

procedure DescomponerDigitos(num: integer; var conj: cint);

var
    digito: integer;

begin
    while (num <> 0) do begin
        digito := num mod 10;

        conj := conj + [digito];

        num := num div 10;
    end;
end;

function CalcularHonorario(consultorio: tipoconsultorio; ObraSocial: tipoobra):integer;

begin
    if ((consultorio mod 2) = 0) then
        CalcularHonorario := consultorio * ObraSocial * 3
    else begin
        CalcularHonorario := consultorio * ObraSocial * 2;
    end;
end;

var
    ArregloConsultorios: ArrListas;
    i: integer;

begin
    writeln(' ');
    writeln('╔═╗┬  ┬┌┐┌┬┌─┐┌─┐  ╔╦╗╔╦╗');
    writeln('║  │  ││││││  ├─┤  ║║║ ║║');
    writeln('╚═╝┴─┘┴┘└┘┴└─┘┴ ┴  ╩ ╩═╩╝');
    writeln(' ');

    InicializarConsultorios(ArregloConsultorios);

    CargarListas(ArregloConsultorios);

    for i := 1 to 12 do begin
        writeln('Para el consultorio ', i, ' la lista es: ');
        InformarLista(ArregloConsultorios[i]);
    end;
end.