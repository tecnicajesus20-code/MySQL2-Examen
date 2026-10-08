# MySQL2-Examen

#### EXAMEN ID - 1922 | KLEIDERSON JESÚS SALCEDO RICO 

##### Contexto 

El coworking ahora cada que se inserte una nueva membresia va a calcular de forma automatica la fecha fin a todas las membresias nuevas.

 #### ¿ Como lo hice ?

Primero que todo hice un escaneo dentro de la tabla membresias, para analizar que datos puedo o mejor dicho debo usar. 

Luego pase a crear un trigger que modificara la tabla ANTES de que los datos se insertaran en esta. Esto debido a que como la tabla que genera la activacion de el trigger es la misma tabla membresia a el momento de insertarse, era IMPOSIBLE para mi modelo de base de datos realizar un diseño distinto de base de datos. 

Luego valide que se estuviera ingresando la fecha_inicio por que si ella resultaba NULL nada funcionaria. 

Para validar que la fecha de inicio fuera siempre != NULL  digite un IF que la validara y que en caso de ser VERDADERO cambiara su valor y le pusiera la fecha actual con el CURDATE ()

Luego use el DATA_ADD para poder agregarle a la fecha actual un intervalo de 30 dias a la fecha. 
Y con la variable v_fechafin inserte dentro de la tabla

# Prueba de consulta

![prueba de consulta](/home/camper/Escritorio/MySQL2-Examen/Pruebas/imagen_prueba.png)



