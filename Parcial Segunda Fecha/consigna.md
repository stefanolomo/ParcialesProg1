# Parcial Segunda Fecha - 18 de Junio de 2025

## Ejercicio 1

Se dispone de una lista con los equipos participantes del proximo mundial de clubes ordenados por pais al que pertenecen. De cada equipo se conoce el codigo de equipo, nombre, pais de origen, director tecnico, y los 30 jugadores convocados. De cada jugador se conoce su numero, valor en dolares y numero de camiseta (1 a 99).

Se requiere recorrer la lista una sola vez para:

1. Generar una nueva lista que contenga para cada pais, el nombre del pais de origen y el valor total en dolares de sus equipos (el valor de cada equipo es la suma de los valores de sus jugadores)

2. Calcular la frecuencia de cada numero de camiseta

3. Informar los dos numeros de camiseta mas usados

4. Informar el nombre y codigo de equipo cuyo codigo sea capicua (puede haber mas de uno).

> NOTA: Liberar memoria de todas las estructuras dinamicas, escribir el programa principal, modularizar solucion.

## Ejercicio 2

Analice el codigo correspondiente a un modulo que agrega al final en una lista doblemente enlazada. Indique VERDADERO en el caso de que la seccion de codigo haga correctamente los enganches de la lista. En caso contrario indique FALSO y justifique.

``` pascal
    type
        PNodo = ^TNodo;
        TNodo = record
            dato: integer;
            ant: PNodo;
            sig: PNodo;
        end;
        
        TListaDoble = record
            primero: PNodo;
            ultimo: PNodo;
        end;

*****************************

    nuevo^.sig := nil;
    if (lista.primero = nil) then begin
        nuevo^.ant := nil;
        lista.primero := nuevo;
        lista.ultimo := nuevo;
    end else begin
        lista.ultimo^.sig := nuevo;
        nuevo^.ant := lista.ultimo;
        nuevo^.ultimo := nil; [!! *ERROR]
    end;
```

> El error esta en la anteultima linea. Para hacer el enganche correctamente, se debe reemplazar la linea marcada con * por 'lista.ultimo := nuevo' ya que se necesita actualizar el puntero de ultimo de lista a nuevo que pasa a ser el ultimo nodo.
