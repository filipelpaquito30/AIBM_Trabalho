DELIMITER $$
DROP PROCEDURE IF EXISTS cursor_proveniencia;
CREATE DEFINER=`root`@`localhost` PROCEDURE `cursor_proveniencia`()
BEGIN
	DECLARE done boolean DEFAULT FALSE;
    declare desig_prove varchar(45);
    declare cur1 cursor for select distinct DES_PROVENIENCIA from bd_urg.urg_inform_geral;
    declare continue handler for not found set done = true;
    
    open cur1;
    
    read_loop: loop
		fetch cur1 into desig_prove;
        
        if done then
			leave read_loop;
		end if;
        
        insert into dw_urg.d_proveniencia (desig_prove) values (desig_prove);
	
	end loop;
        
	close cur1;
END$$

CALL cursor_proveniencia;

