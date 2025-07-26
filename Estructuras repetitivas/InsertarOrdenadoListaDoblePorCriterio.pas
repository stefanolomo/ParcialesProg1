
Program InsertarOrdenadoDobleEnlaze;

Procedure InsertarOrdenadoDobleEnlace(Var Lista: ListaDoble; datos: registrodatos);

Var 
    ant, act, nodo:   ptrnodo;

Begin
    new(nodo);
    nodo^.datos := datos;
    nodo^.sig := Nil;
    nodo^.ant := Nil;

    act := Lista.pri;
    ant := Nil;

    While (act <> Nil) And (act^.datos.criterio < nodo^.datos.criterio) Do Begin
        ant := act;
        act := act^.sig;
    End;

    If (ant = Nil) Then Begin
        // Insertar al principio
        nodo^.sig := Lista.pri;

        If Lista.pri <> Nil Then
            Lista.pri^.ant := nodo
        Else
            Lista.ult := nodo;

        // era lista vacía
        Lista.pri := nodo;
    End Else Begin
        // Insertar entre ant y act o al final
        nodo^.sig := act;
        nodo^.ant := ant;
        ant^.sig := nodo;

        If (act <> Nil) Then
            act^.ant := nodo
        Else
        Lista.ult := nodo;
        // insertar al final
    End;
End;
