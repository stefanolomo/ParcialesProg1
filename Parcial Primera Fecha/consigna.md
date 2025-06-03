# Parcial primera fecha Programación 1 (28/5/2025) - Tema 2

## Ejercicio 1

La clinica MP desea gestionar  la atencion de pacientes en sus 12 consultorios. Para ello, dispone de una lista de pacientes por cada consultorio, donde los pacientes se encuentran ordenados alfabeticamente por apellido. De cada paciente se registra el numero de DNI, el nombre y el apellido; la obra social a la que pertenece (de 1 a 20); y su numero de afiliado.

Además se dispone de una estructura que contiene los honorarios medicos adicionales que se cobran por cada consulta. Dichos valores dependen tanto del numero de consultorio como la obra social del paciente. Se pide:

1. Implementar el ingreso de nuevos pacientes. Se debe ingresar los datos de cada paciente junto con el consultorio al que concurre desde el teclado. El ingreso finaliza al introducir un paciente cuyo apellido sea 'ZZZ'. Cada paciente debe incorporarse en la lista correspondiente a su consultorio, manteniendo el orden alfabetico por apellido.

2. Finalizada la carga de los pacientes, recorrer la estructura de consultorios una sola vez para:

- A. Informar nombre y apellido de los pacientes que tengan todos los digitos del DNI incluidos en el numero de afiliado. Ej: los digitos _30.120.324_ estan incluidos en el numero de afiliado _102264730_.

> Se necesita: procedimiento para descomponer en un conjunto los nros del DNI y para checkearlo

- B. Eliminar de cada consultorio, los pacientes que no cumplen con el punto A.

> Se necesita: Procedimiento eliminar paciente

- C. Calcular e informar la recaudacion total por honorarios adicionales para cada consultorio.

> Se necesita: Interactuar con la estructura y pasar a cada paciente por la estructura y calcular los honorarios que son la suma del total de pacientes de cada consultorio

NOTA: Liberar la memoria de todas las estructuras dinamicas. Hacer el programa principal. Modalizar la solucion.