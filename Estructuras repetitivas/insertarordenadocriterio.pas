Procedure InsertarOrdenadoCriterio(Var Lista: Puntero; Datos: RegistroDatos);


// Lista es la lista a la que vamos a insertar y es del tipo puntero (puntero al tope de lista)

// Datos es un registro que cada nodo de la lista tiene y en este caso son los datos del nodo que vamos a insertar

Var 

    // Necesitamos dos variables para llevar cuenta de entre cual y cual nodo debemos insertar. Estas variables deben ser del tipo puntero (a un nodo)
    Anterior, Actual:   Puntero;


    // Tambien necesitamos el nuevo nodo a insertar, que debe ser del tipo puntero
    NuevoNodo:   Puntero;

Begin

    // Para inicial, el puntero Anterior va a ser nil ya que estamos al principio de la lista
    Anterior := Nil;


   // Despues, el puntero Actual va a ser la lista, o el primer nodo de la lista
    Actual := Lista;

    // Tenemos que reservar memoria para el nodo a insertar
    new(NuevoNodo);


    // En el registro del nuevo nodo debemos insertar los datos que se le pasan al procedimiento
    NuevoNodo^.Datos := Datos;

    While (Actual <> Nil) And (Actual^.Datos.Criterio < NuevoNodo^.Datos.
          Criterio) Do

        // Mientras el anteior no sea nil, recorremos la lista. Esta condicion nos va a permitir recorrer la lista hasta llegar al punto en el que tenemos que insertar. El criterio se pone como segunda condicion.
        Begin
            // El anterior es el que era el actual
            Anterior := Actual;

            // Y el actual es el siguiente a si mismo
            Actual := Actual^.Siguiente;
        End;


        // Una vez que se sale del bucle while: Hay que insertar entre Anterior y Actual


        // Se contemplan dos condiciones: Hay que insertar al principio de la lista (O esta vacia) o en el medio de los dos nodos

    // Si hay que insertar al principio, Anterior deberia ser nil
    If (Anterior = Nil) Then
        Begin
            // Atras del nuevo nodo tenemos que meter toda la lista
            NuevoNodo^.Siguiente := Lista;

            // Y el primero de la lista ahora pasa a ser NuevoNodo
            Lista := NuevoNodo;
        End
    Else // De otra manera hay que insertar entre Anterior y Actual
        Begin
            // El siguiente al anterior es el nuevo nodo
            Anterior^.Siguiente := NuevoNodo;


            // Y el siguiente al nuevo nodo es el resto de la lista, que esta enlazada con Actual
            NuevoNodo^.Siguiente := Actual;
        End;
End;
