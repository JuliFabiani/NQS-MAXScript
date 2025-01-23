# NQS MAXScripts

En este repositorio voy subiendo los scripts hechos para NQS. Casi todos son 'macroscripts' que una vez registrados se pueden correr por dos formas: agregando un botón en la interfaz, o asignando un atajo.

![alt text](https://i.imgur.com/8rAqvUF.jpeg)

### Instalación

Para instalar y mantener actualizados todos los scripts, se puede usar el archivo .ms que está en INSTALACION_AUTOMÁTICA. Este tiene todos los scripts actualizados y garantiza de que quede todo up-to-date. Igualmente se puede descargar cualquier macroscript (.mcr) e instalarlo de forma individual.

-----
- ### Renombrar por capas (Selección)
Renombra los objetos de la selección según el nombre de la capa en la que estén. Si la capa tiene prefijos son anulados.

![alt text](https://i.imgur.com/973gw9S.png)

-----
- ### Asignar Colores Aleatorios (Selección)
Asigna un color aleatorio a cada objeto de la selección.

![alt text](https://i.imgur.com/jHTCCHZ.png)

-----
- ### Asignar el Mismo Color Aleatorio (Selección)
Asigna un mismo color aleatorio a la selección completa.

![alt text](https://i.imgur.com/TASzl8H.png)

-----
- ### Ceentrar Pivot (Selección)
Ubica en la posición del pivot del primer objeto seleccionado los pivots del resto de la selección.

![alt text](https://i.imgur.com/OiIHVnp.png)

-----
- ### Seleccionar Base-Line (RailClone)
Teniendo un objeto de tipo "RailClone", cambia la selección a las Splines que tenga como guía, y viceversa. Pueden estar seleccionados distintos objetos RailClone, o distintos tipos de objetos (RailClone/Spline/Line).

![alt text](https://i.imgur.com/KvmB3LZ.png)

-----
- ### Colapsar selección/todo a un objeto
Esta es una modificación del [QuickAttach v1.82 de antomor](https://www.scriptspot.com/3ds-max/scripts/quick-attach) donde se puede hacer el attach en un solo click sin ventanas adicionales. Puede usarse con la selección actual o con todos los objetos de la escena (útil para imports con mucha geometría).

-----
- ### G-BufferID Override Checker
Esta es una herramienta para asignar todos los "G-Buffer ID Override" de toda la escena a distintos RenderElements CMasking_ID. Cada ID tiene un RenderElement y un canal (R/G/B) único. Los IDs 1, 2 y 3 corresponden al RenderElement CMasking_GBufID_001. Los IDs 4, 5 y 6 corresponden al RenderElement CMasking_GBufID_002. Y así sucesivamente. Esto garantiza encontrar siempre los mismos IDs en los mismos elementos y en los mismos canales, independientemente de los IDs que estén en uso.

La interfaz ordena los materiales según su G-Buffer ID Override. También tiene la opción de hacer click en el botón con el nombre de cada material para poder seleccionar todos los objetos de la escena que tengan el material.
![alt text](https://i.imgur.com/tR2RsIL.png)
![alt text](https://i.imgur.com/4i7AAdJ.png)
