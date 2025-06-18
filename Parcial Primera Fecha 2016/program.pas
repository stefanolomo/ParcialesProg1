Program parcial;

type
    tipousuario = 1..50;
    tipodia = 1..31;
    tipomes = 1..12;
    registrofecha = record
        dia: tipodia;
        mes: tipomes;
        año: integer;
    end;
    registrodatos = record
        codProducto: integer;
        codUsuario: tipousuario;
        fecha: registrofecha;
        costoUnitario: integer;
        cantProducto: integer;
    end;
    ptrnodo = ^nodo;
    nodo = record
        datos: registrodatos;
        sig: ptrnodo;
    end;

procedure RecorrerLista(Lista: ptrnodo);

var
    act: ptrnodo;

begin
end;

begin
end.