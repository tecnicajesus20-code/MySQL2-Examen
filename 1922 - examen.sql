/*
Examen: Gestión de Coworking
Base de datos : Grupo 01
Módulo: triggers - 1922
Archivo: 1922 - examen
Descripción: Crea un trigger SQL que, al insertar una nueva membresía, 
calcule y complete automáticamente la fecha de vencimiento sumando 30 
días a la fecha de inicio.
Requisitos:
- El trigger debe ejecutarse después de insertar (AFTER INSERT) una membresía.
- La fecha de vencimiento debe guardarse en el mismo registro de la membresía.
- Incluye un comentario explicando brevemente cómo funciona el trigger.
*/

-- =====================================================================
--  TRIGGER ESTRUCTURA
-- =====================================================================
-- usamos la base de datos
USE coworking_db;

-- Le heche un vistazo a la tabla membresias
SELECT * FROM membresia; 

-- use el delimiter para poder crear el trigger. 
DELIMITER !

CREATE TRIGGER trg_membresia_30DIAS_fecha_fin
/*AUNQUE EN LOS REQUERIMIENTOS SE PEDIA QUE SE USARA AFTER. 
Debido al modelo de base de datos que el grupo 1 uso no se podia, 
esto ya que las fechas de las membresias se encontraban en esta entidad. 
Y un trigger por limitaciones de el mismo MySQL .
*/
BEFORE INSERT ON membresia -- Por ello la solucion es que sea antes de la insercion para ajustar los datos , y evidentemente en la tabla membresia
FOR EACH ROW -- Aqui solo ajustamos que escuche todas las filas que se inserten

BEGIN -- empezamos el procedimiento para modificar el campo 
	DECLARE v_fechafin DATE;  -- creamos una variable para guardar ahi el nuevo valor de la fecha que luego le daremo (Y como lo que va a guardar es una fecha se usa el tipo de dato DATE)
	
    IF NEW.fecha_inicio IS NULL THEN -- Validamos que se haya ingresado el valor de la fecha de inicio, por que donde no lo se haga no se puede hacer nada. 
        SET NEW.fecha_inicio = CURDATE(); -- Y en caso de que no la ingrese (Sea NULL) pues va a recibir automaticamente el valor de el dia actual.
    END IF;
    
	SELECT 
    DATE_ADD(NEW.fecha_inicio, INTERVAL 30 DAY) INTO  v_fechafin;  -- Usamos el DATE_ADD para sacar el valor de una fecha añadiendole un intervalo de tiempo que en este caso son 30 dias.
    
    SET new.fecha_fin = v_fechafin; -- Por ultimo, se ingresa dentro de el campo recien ingresado (o no necesariamente) de la fecha final de la membresia
    
END! -- terminamos procedimiento 
 
DELIMITER ;

-- =====================================================================
--  INSERT PARA LA PRUEBA DEL TRIGGER 
-- =====================================================================

INSERT INTO membresia (id_usuario, id_tipo, estado, fecha_inicio)  -- insertamos los valores obligatorios por las restricciones de la tabla
VALUES (1, 1, 'Pendiente', NULL ); -- el dato de la fecha inicial esta en NULL para comprobar que el primer bloque funcione


-- =====================================================================
--  CONSULTA DE PRUEBA
-- =====================================================================

SELECT id_membresia, fecha_inicio, fecha_fin 
FROM membresia -- Seleccionamos estos datos de la tabla membresia 
ORDER BY id_membresia DESC  -- ordenamos todos los datos por el ID de el mas alto a el mas bajo (como los id van en auto incremento el ultimo es el mas alto) 
LIMIT 1; -- limitamos la vista a la primera fila (el ultimo dato ingresado)