# Parcial primera fecha 2016 - 10 de Junio de 2016

## Ejercicio 1

Una empresa intermediaria de venta de productos por internet requiere el procesamiento de las ventas realizadas por los 50 usuarios que mas facturaron durante los primeros meses del año. De cada venta se conoce el codigo de producto, codigo de usuario (1 a 50), fecha de venta, costo unitario y cantidad de producto.

Se dispone de una lista de las ventas ordenadas por fecha. Tambien se dispone de una estructura que se accede por codigo de usuario al nombre del mismo. Se requiere procesar la lista de ventas recorriendola una sola vez para:

- A. Sabiendo que la lista esta ordenada por fecha, informar el monto facturado por dia.

- B. Calcular e informar el nombre de los 2 usuarios que mas facturaron.

Se require: <Para cada venta> --> Arreglo50Users[userindex], HallarMaxEnArreglo() --> i

- C. Generar tres nuevas listas con las ventas separadas por el valor de sus productos. La primera con el precio unitario menor a 500, la segunda de 500 a 10000 y la tercera de 10000 en adelante. Mantener estas listas ordenadas por su original.

Se requiere: <Condicional de productos> --> InsertarOrdenado(Lista, prod^.datos)

> NOTA: Modularizar adecuadamente y liberar memoria de las estructuras dinamicas.

Se requiere: LiberarLista(Lista) --> nil