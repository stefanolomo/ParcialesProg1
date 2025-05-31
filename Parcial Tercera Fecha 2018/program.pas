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
        costo: integer;
        sig: ptrproducto;
    end;
    arrRubros = array[1..51] of integer;

procedure InsertarProducto(var L: ptrproducto; p: ptrproducto);

var
    ant, act, nuevo: ptrproducto;

begin
    // Creamos un nodo nuevo con los mismos datos de p
    new(nuevo);
    nuevo^.codigo := p^.codigo;
    nuevo^.descripcion := p^.descripcion;
    nuevo^.minStock := p^.minStock;
    nuevo^.anStock := p^.anStock;
    nuevo^.rubro := p^.rubro;
    nuevo^.costo := p^.costo;
    nuevo^.sig := nil;

    act := L;
    ant := nil;

    // Recorremos la lista mientras no sea el ultimo
    while (act <> nil) and (act^.descripcion < nuevo^.descripcion) do
        begin
            ant := act;
            act := act^.sig;
        end;
    
    // Cuando sale, llegamos al ultimo nodo y ant es el anterior
    if (ant = nil) then // Estamos en el primer nodo
        begin
            nuevo^.sig := L;
            L := nuevo;
        end
    else // De otra manera estamos insertando en un nodo de la lista
        begin
            // El siguiente del nodo anterior es el nodo a insertar
            ant^.sig := nuevo;
            // Y el siguiente al nodo a insertar es el nodo posterior
            nuevo^.sig := act;
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
            writeln('Ingresar el costo del producto');
            readln(p^.costo);
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

procedure InformarMaxRubros(vMaxProd: arrRubros);

var
    max1, max2, rubro1, rubro2, i: integer;

begin
    max1 := -1;
    max2 := -1;
    rubro1 := 0;
    rubro2 := 0;

    for i := 1 to 51 do
        begin
            if vMaxProd[i] > max1 then
                begin
                    // Traspasar los maximos a la segunda posicion
                    max2 := max1;
                    rubro2 := rubro1;

                    // Actualizar los maximos de la posicion 1
                    max1 := vMaxProd[i];
                    rubro1 := i;
                end
            else if vMaxProd[i] > max2 then
                begin
                    max2 := vMaxProd[i];
                    rubro2 := i;
                end;
        end;
    
    // Informar maximos y rubros
    writeln('Rubros con mas productos:');
    writeln('1er Rubro: ', rubro1, ' con ', max1, ' productos.');
    writeln('2do Rubro: ', rubro2, ' con ', max2, ' productos.');
end;

procedure RecorrerLista(Lista: ptrproducto; var Lista1: ptrproducto; var Lista2: ptrproducto; var Lista3: ptrproducto);

var
    act: ptrproducto;
    vMaxProd, vCosto: arrRubros;
    j, i, totProd: integer;
    PromedioProductos, PromedioCosto: real;

begin
    // Inicializa las listas vacias
    Lista1 := nil;
    Lista2 := nil;
    Lista3 := nil;
    totProd := 0;

    // Inicializa las listas en 0
    for i := 1 to 51 do
        begin
            vMaxProd[i] := 0;
            vCosto[i] := 0;
        end;

    act := Lista;

    while (act <> nil) do
        begin
            // Logica para punto D
            if not (CumpleCodigo(act)) then
                begin
                    InsertarProducto(Lista1, act);
                end
            else if (CumpleCodigo(act)) then
                begin
                    if (act^.anStock < act^.minStock) then
                        begin
                            InsertarProducto(Lista2, act);
                        end
                    else
                        begin
                            InsertarProducto(Lista3, act);
                        end;
                end;

            // Logica para almacenar los productos por rubro
            j := act^.rubro;
            vMaxProd[j] := vMaxProd[j] + 1;

            // Logica para informar el nombre acorde al rubro y almacenar totales de cantidad y costo
            writeln('El producto ', act^.descripcion, ' esta en el rubro ', j);
            vCosto[j] := vCosto[j] + act^.costo;
            totProd := totProd + 1;

            // Pasamos al siguiente nodo
            act := act^.sig;
        end;
    // Cuando se sale del while, se termino de recorrer la lista
    // Calculo de promedios:
    if (totProd > 0) then
        begin
            // Informar punto C
            InformarMaxRubros(vMaxProd);

            // --> Promedio en rubro
            PromedioProductos := totProd / 51;

            // --> Costo promedio de rubro
            PromedioCosto := 0;
            for i := 1 to 51 do
                begin
                    if (vMaxProd[i] > 0) then // Le suma al promedio el costo del rubro i dividido por sus productos
                        PromedioCosto := PromedioCosto + (vCosto[i] / vMaxProd[i]);
                end;
            // Dividimos el promedio del costo entre todos los rubros
            PromedioCosto := PromedioCosto / 51;

            // Muestra los resultados
            writeln('Promedio de productos por rubro: ', PromedioProductos:0:2);
            writeln('Promedio de costos por rubro: ', PromedioCosto:0:2);
        end;
    
end;

procedure LiberarListas (var L: ptrproducto);

var aux: ptrproducto;
begin
    while (L <> nil) do
        begin
            aux := L;
            L := L^.sig;
            dispose(aux);
        end;
end;

var
    ListaProductos: ptrproducto;
    Lista1, Lista2, Lista3: ptrproducto;
begin
    ListaProductos := nil;
    IngresarProductos(ListaProductos);
    RecorrerLista(ListaProductos, Lista1, Lista2, Lista3);
    LiberarListas(ListaProductos);
    LiberarListas(Lista1);
    LiberarListas(Lista2);
    LiberarListas(Lista3);
end.

// Codigos de producto válidos:
// 7493740134ARIDF, 8482940361PERDS, 1122334455USAAX --> 10 digitos y 5 mayus
