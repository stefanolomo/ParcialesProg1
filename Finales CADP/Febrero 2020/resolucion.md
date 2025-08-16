![](resolucion_20250816185147529.png)

![](resolucion_20250816185227788.png)

![](resolucion_20250816185250227.png)

En el primer writeln _writeln('a= ', a, 'b= ', b, 'c= ', c);_ se imprime basura para la variable _a_ ya que no se le fue asignado ningun valor, 80 para _b_ y 30 para _c_.

En la llamada al modulo Calcular, el writeln adentro del modulo imprime basura para _a_, 0 para _b_ y 10 para _c_.

En el segundo writeln del programa principal se imprime basura para _a_, 0 para _b_ y 10 para _c_.

![](resolucion_20250816190621873.png)

![](resolucion_20250816190647447.png)

![](resolucion_20250816190658240.png)

Las estructuras de control de seleccion vistas son: if _condicion_ then _hacer_, if _condicion_ then _hacer_ else _hacer_, case _variable_ of _casos_: _hacer_.

If

``` pascal
if x > 0 then
  writeln('x es positivo');
```

Se usa para marcar un bloque de codigo a ejecutar si se cumple una condicion o serie de condiciones

If else

```
if x mod 2 = 0 then
  writeln('x es par')
else
  writeln('x es impar');
```

Se usa para marcar los bloques de codigo a ejecutar si se cumple una condicion u otra.

case of

```
case dia of
  1: writeln('Lunes');
  2: writeln('Martes');
  3: writeln('Miércoles');
  4: writeln('Jueves');
  5: writeln('Viernes');
  6: writeln('Sábado');
  7: writeln('Domingo');
else
  writeln('Día inválido');
end;
```

Se usa para especificar que se debe hacer en cada caso del valor de una variable, en este caso, del integer _dia_.

![](resolucion_20250816191105857.png)