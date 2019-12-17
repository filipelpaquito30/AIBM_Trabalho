DELIMITER $$
DROP PROCEDURE IF EXISTS cursor_data;
CREATE DEFINER=`root`@`localhost` PROCEDURE `cursor_data`()
BEGIN
	DECLARE done boolean DEFAULT FALSE;
    declare dataa DATETIME;
    declare cur1 cursor for select distinct DATAHORA_ADM from bd_urg.urg_inform_geral;
    declare continue handler for not found set done = true;
    
    open cur1;
    
    read_loop: loop
		fetch cur1 into dataa;
        
        if done then
			leave read_loop;
		end if;
        
        insert into dw_urg.d_data (dataa) values (dataa);
	
	end loop;
        
	close cur1;
END$$

CALL cursor_data;
