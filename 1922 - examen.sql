
DELIMITER !
 
CREATE TRIGGER trg_membresia_bi_fecha_fin
AFTER INSERT ON membresia
FOR EACH ROW
BEGIN
	DECLARE v_fechafin DATE; 

    IF NEW.fecha_inicio IS NULL THEN
        SET NEW.fecha_inicio = CURDATE();
    END IF;
    
	SELECT 
    DATE_ADD(NEW.fecha_inicio, INTERVAL 30 DAY) INTO  v_fechafin; 
    
    SET new.fecha_fin = v_fechafin;
    
END!
 
DELIMITER ;

