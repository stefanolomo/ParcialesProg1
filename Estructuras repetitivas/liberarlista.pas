Procedure LiberarListas(Var Lista: ptrnodo);

// Procedimiento que libera toda la memoria ocupada por una lista enlazada simple.
// Deja la lista vacía (puntero en nil).

Var 
    aux:   ptrnodo;
    // Puntero auxiliar para guardar el nodo a liberar

Begin
    // Recorremos la lista mientras no sea nil
    While (Lista <> Nil) Do
        Begin
            aux := Lista;
            // Guardamos el nodo actual en aux
            Lista := Lista^.sig;
            // Avanzamos Lista al siguiente nodo
            dispose(aux);
            // Liberamos la memoria ocupada por el nodo guardado en aux
        End;
    // Al finalizar, todos los nodos han sido liberados y Lista queda en nil
End;
