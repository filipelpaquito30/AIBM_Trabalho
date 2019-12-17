DELIMITER $$
DROP PROCEDURE IF EXISTS cursor_causa;
CREATE DEFINER=`root`@`localhost` PROCEDURE `cursor_causa`()
BEGIN
	DECLARE done boolean DEFAULT FALSE;
    declare desig_causa varchar(45);
    declare cur1 cursor for select distinct DES_CAUSA from bd_urg.urg_inform_geral;
    declare continue handler for not found set done = true;
    
    open cur1;
    
    read_loop: loop
		fetch cur1 into desig_causa;
        
        if done then
			leave read_loop;
		end if;
        
        insert into dw_urg.d_causa (desig_causa) values (desig_causa);
	
	end loop;
        
	close cur1;
END$$

CALL cursor_causa;
