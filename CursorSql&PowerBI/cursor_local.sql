DELIMITER $$
DROP PROCEDURE IF EXISTS cursor_local;
CREATE DEFINER=`root`@`localhost` PROCEDURE `cursor_local`()
BEGIN
	DECLARE done boolean DEFAULT FALSE;
    declare desig_local varchar(45);
    declare cur1 cursor for select distinct DES_LOCAL from bd_urg.urg_inform_geral;
    declare continue handler for not found set done = true;
    
    open cur1;
    
    read_loop: loop
		fetch cur1 into desig_local;
        
        if done then
			leave read_loop;
		end if;
        
        insert into dw_urg.d_local (desig_local) values (desig_local);
	
	end loop;
        
	close cur1;
END$$

CALL cursor_local;
