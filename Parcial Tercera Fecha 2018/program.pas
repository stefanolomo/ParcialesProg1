program MatCon;

// Una empresa de materiales para la construccion esta interesada en hacer una estadistica de los productos que vende. De cada producto se conoce el codigo de producto formado por 15 caracteres,  descripcion, stock minimo, stock anual, y codigo de rubro al que pertenecen (materiales, sanitarios, pinturas, herrajes, etc.).

const
    ALFA_MAYUS = ['A'..'Z'];
    ALFA_MINUS = ['a'..'z'];
    ALFA_DIGIT = ['0'..'9'];

type
    ptrproducto = ^producto;
    producto = record
        codigo: string[15];
        descripcion: string[30];
        minStock: integer;
        anStock: integer;
        rubro: 1..51;
        sig: ptrproducto;
    end;

procedure InsertarProducto(var L: ptrproducto; p: ptrproducto);

var
    ant, act: ptrproducto;

begin
    act := L;
    ant := nil;

    // Recorremos la lista mientras no sea el ultimo
    while (act <> nil) do
        begin
            ant := act;
            act := act^.sig;
        end;
    
    // Cuando sale, llegamos al ultimo nodo y ant es el anterior
    if (ant = nil) then // Estamos en el primer nodo
        begin
            p^.sig := L;
            L := p;
        end
    else // De otra manera estamos insertando en un nodo de la lista
        begin
            // El siguiente del nodo anterior es el nodo a insertar
            ant^.sig := p;
            // Y el siguiente al nodo a insertar es el nodo posterior
            p^.sig := act;
        end;
end;

procedure leerdatos(var p: ptrproducto);

begin
    writeln('Ingresar en codigo del producto (0 para terminar)');
    readln(p^.codigo);
    if (p^.codigo <> '0') then
        begin
            writeln('Ingresar la descripcion del producto');
            readln(p^.descripcion);
            writeln('Ingresar el minimo stock');
            readln(p^.minStock);
            writeln('Ingresar el stock anual');
            readln(p^.anStock);
            writeln('Ingresar el codigo de rubro (de 1 a 51)');
            readln(p^.rubro);
            p^.sig := nil;
        end;
end;

function CumpleCodigo(p: ptrproducto):boolean;

var
    car: char;
    contLet, contNum, i: integer;

begin
    // Se inicializa en 0 los contadores
    contLet := 0;
    contNum := 0;

    for i := 1 to 15 do
        begin
            // El caracter a procesar esta en el indice i
            car := p^.codigo[i];

            // Aumentamos los contadores
            if (car in ALFA_DIGIT) then contNum := contNum + 1;
            if (car in ALFA_MAYUS) then contLet := contLet + 1;
        end;
        
    // El codigo es valido solo si tiene 10 numeros y 5 letras mayusculas
    CumpleCodigo := (contNum = 10) and (contLet = 5);
end;

procedure IngresarProductos(var Lista: ptrproducto);

var
    codigoproducto: string[15];
    p: ptrproducto;

begin
    codigoproducto := '';

    repeat
        // Inicializa el nodo
        new(p);
        leerdatos(p);

        // La variable nroproducto
        codigoproducto := p^.codigo;

        if (codigoproducto <> '0') then
            // Si el nro no es cero, el producto es valido
            begin
                InsertarProducto(Lista, p);
            end
        else
            // Si el nro del producto es 0, liberamos espacio porque la carga terminó
            begin
                dispose(p);
            end;

    until (codigoproducto = '0');
end;

begin
    
end.
