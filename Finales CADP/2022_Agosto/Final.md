![](Final_20250812171811835.png)

![](Final_20250812171841331.png)

+ No es posible la utilizacion de variables globales para la comunicación entre los modulos de un programa. [**falso**]

Sí, se puede usar variables globales para la comunicacion entre modulos. Sin embargo, es desaconsejable ya que esto hace mas dificil mantener buenas practicas como lo son la alta cohesion y el bajo acoplamiento entre modulos. Los modulos deberian poder actuar independientemente o dependiendo de otros lo menos posible. Usar variables globales para la comunicacion entre ellos, hace que un cambio hecho por un modulo, pueda afectar el funcionamiento de otro, afectando mantenibilidad y legibilidad.

+ Siempre es posible realizar la eliminacion de un elemento en un vector [**falso**]

No siempre es posible eliminar un elemento en un vector, ya que hay casos especiales que debemos considerar. Por ejemplo, el vector podria estar vacio y no haber nada para eliminar. Tambien podria suceder que haya elementos que el elemento que queremos eliminar no se encuentre en el vector.

+ Un programa modularizado puede no ser correcto [**verdadero**]

Sí, un programa modularizado adecuadamente puede no ser correcto. Por definicion, la correctitud de un programa no depende solamente de si esta modularizado o no. Un programa correcto debe cumplir con los requerimientos propuestos, que pueden incluir otras cosas ademas de estar correctamente modularizado.

+ El acceso a un elemento de una estructura de datos lineal solo es posible mediante un recorrido secuencial [**verdadero**]

Sí, para acceder a un elemento dado en una estructura de datos lineal, se debe pasar por todos los elementos anteriores al que se intenta acceder. Esto es porque en una estructura de datos de este tipo, los elementos solo guardan una relacion anterior-posterior entre sí. Es decir, no es posible acceder a un elemento deseado directamente.

![](Final_20250812172024342.png)

![](Final_20250812172042914.png)

![](Final_20250812172056791.png)