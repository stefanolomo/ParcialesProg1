program MatCon;

// Una empresa de materiales para la construccion esta interesada en hacer una estadistica de los productos que vende. De cada producto se conoce el codigo de producto formado por 15 caracteres,  descripcion, stock minimo, stock anual, y codigo de rubro al que pertenecen (materiales, sanitarios, pinturas, herrajes, etc.).

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

begin
    
end;
