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
- ### Asignar mismo HUE (Selección)
Asigna el mismo tono al color de todos los objetos seleccionados, variando el brillo y la saturación de forma aleatoria.
![alt text](https://i.imgur.com/UfLPRh3.gif)

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

-----
- ### Clean SG Edit Poly (Selección)
Herramienta para limpiar todos los Smoothing Group de los EDIT POLY que estén en la selección. Esto aplica para los objetos base de tipo Editable Poly, como para los modificadores Edit Poly que pueda haber en algún stack. Aplica solo a Edit Poly, limpiar los SG de Edit Mesh vía MaxScript no es posible si hay un stack de modificadores encima, así que quedó fuera de alcance. Este script funciona solamente con Edit Poly (BaseObject y Modifiers).
![alt text](https://i.imgur.com/r1q2PON.gif)

-----
- ### Extrude Vertex/Segment
Un operador para Splines para poder hacer extrusiones de segmentos y vértices. Si el comando se usa con el primer o último vértice seleccionado, crea un vértice extra en la misma posición y lo deja seleccionado, listo para desplazarlo. Si el comando se usa con un segmento seleccionado, se crean dos vertices en los extremos del segmento (superpuestos a los originales), para que al mover el segmento seleccionado se haga la extrusión.
![alt text](https://i.imgur.com/NFfe5Cm.gif)
