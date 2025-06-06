# Parcial Segunda Fecha Prog. I Tema 1 (28 Nov 2018)

## Ejercicio 1

Se desea implementar algunas estadisticas sobre una lista de archivos. De cada archivo se conoce el nombre, fecha de creacion (dia, mes y año); codigo de seguridad, tamaño en bytes y un valor numerico que representa el tipo de archivo.

Se dispone de una estructura que permite acceder por valor del tipo de archivo al nombre de los 110 tipos existentes. Se require procesar una vez la lista para:

- A. Informar los nombres de los archivos cuyo codigo de seguridad no sea valido. Un codigo valido cumple que la suma de cada digito del dia, mes, año, tipo de archivo y tamaño coincide con el codigo de seguridad.

- B. Para los archivos anteriores a 2015, informar el nombre y el tamaño de los dos archivos mas grandes.

- C. Teniendo en cuenta la cantidad de archivos, informar para todos los tipos de archivo el nombre y el porcentaje total que representa en la lista.

- D. Crear 110 nuevas listas separando los archivos de la lista original por su tipo de manera que queden ordenadas por tamaño de los archivos.

NOTA: Modularizar adecuadamente y liberar las estructuras dinamicas