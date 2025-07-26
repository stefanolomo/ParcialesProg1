
Program FinalJunio2023;

Type 
    empleado =   Record
        dni:   longint;
        antiguedad:   longint;
        cod_depto:   longint;
        sucursal:   longint;
    End;

    infoDepto =   Record
        sucursal:   longint;
        cod_depto:   longint;
        promedio:   real;
    End;

    lista =   ^nodo;
    nodo =   Record
        dato:   empleado;
        sig:   lista;
    End;

Procedure insertarOrdenado(Var L: lista; e: empleado);

Var 
    act, ant, nue:   lista;
Begin
    new(nue);

    nue^.dato := e;
    nue^.sig := Nil;

    act := L;
    ant := Nil;

    While (act <> Nil) And
          ((act^.dato.sucursal < e.sucursal) Or ((act^.dato.sucursal = e.sucursal) And (act^.dato.cod_depto < e.cod_depto))) Do Begin
            ant := act;
            act := act^.sig;
        End;
        
    If ant = Nil Then
        Begin
            nue^.sig := L;
            L := nue;
        End
    Else
        Begin
            nue^.sig := act;
            ant^.sig := nue;
        End;
End;

Procedure cargarLista(Var L: lista);

Var 
    e:   empleado;
Begin
    L := Nil;
    writeln('Ingrese DNI (0 para terminar): ');
    readln(e.dni);
    While e.dni <> 0 Do
        Begin
            writeln('Antiguedad: ');
            readln(e.antiguedad);
            writeln('Codigo de departamento: ');
            readln(e.cod_depto);
            writeln('Numero de sucursal: ');
            readln(e.sucursal);
            insertarOrdenado(L, e);
            writeln('Ingrese DNI (0 para terminar): ');
            readln(e.dni);
        End;
End;

Procedure promedioMayores(L: lista);

Var 
    max1, max2:   infoDepto;
    actualSucursal, actualDepto:   longint;
    totalAntig, cantEmp:   longint;
    prom:   real;
Begin
    // Inicialización de los máximos
    max1.promedio := -1;
    max2.promedio := -1;

    While L <> Nil Do
        Begin
            actualSucursal := L^.dato.sucursal;

            While (L <> Nil) And (L^.dato.sucursal = actualSucursal) Do
                Begin
                    actualDepto := L^.dato.cod_depto;
                    totalAntig := 0;
                    cantEmp := 0;

                    While (L <> Nil) And (L^.dato.sucursal = actualSucursal) And
                          (L^.dato.cod_depto = actualDepto) Do
                        Begin
                            totalAntig := totalAntig + L^.dato.antiguedad;
                            cantEmp := cantEmp + 1;
                            L := L^.sig;
                        End;
                    prom := totalAntig / cantEmp;
                    // Actualiza los dos mayores promedios
                    If prom > max1.promedio Then
                        Begin
                            max2 := max1;
                            max1.sucursal := actualSucursal;
                            max1.cod_depto := actualDepto;
                            max1.promedio := prom;
                        End
                    Else If prom > max2.promedio Then
                            Begin
                                max2.sucursal := actualSucursal;
                                max2.cod_depto := actualDepto;
                                max2.promedio := prom;
                            End;
                End;
        End;

    writeln('Deptos con mayor antigüedad promedio:');

    writeln('1) Sucursal: ', max1.sucursal, ' Departamento: ', max1.cod_depto,
            ' Promedio: ', max1.promedio:0:2);
    writeln('2) Sucursal: ', max2.sucursal, ' Departamento: ', max2.cod_depto,
            ' Promedio: ', max2.promedio:0:2);
End;

//---------------------- Punto B --------------------------
Procedure eliminarDepto5(Var L: lista);

Var 
    ant, act:   lista;
Begin
    act := L;
    ant := Nil;
    While act <> Nil Do
        Begin
            If act^.dato.cod_depto = 5 Then
                Begin
                    If ant = Nil Then
                        L := act^.sig
                    Else
                        ant^.sig := act^.sig;
                    dispose(act);
                    If ant = Nil Then
                        act := L
                    Else
                        act := ant^.sig;
                End
            Else
                Begin
                    ant := act;
                    act := act^.sig;
                End;
        End;
End;

Procedure imprimirLista(L: lista);
Begin
    While L <> Nil Do
        Begin
            writeln('DNI: ', L^.dato.dni, ' Antiguedad: ', L^.dato.antiguedad,
                    ' Depto: ', L^.dato.cod_depto, ' Sucursal: ', L^.dato.
                    sucursal);
            L := L^.sig;
        End;
End;

Var 
    L:   lista;

Begin
    cargarLista(L);
    writeln('Lista Original:');
    imprimirLista(L);

    promedioMayores(L);

    eliminarDepto5(L);

    writeln('Lista luego de eliminar empleados del depto 5:');
    imprimirLista(L);
End.
