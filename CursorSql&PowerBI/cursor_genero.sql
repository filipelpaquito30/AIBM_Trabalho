DELIMITER $$
DROP PROCEDURE IF EXISTS cursor_genero;
CREATE DEFINER=`root`@`localhost` PROCEDURE `cursor_genero`()
BEGIN
	DECLARE done boolean DEFAULT FALSE;
    declare designacao varchar(45);
    declare cur1 cursor for select distinct SEXO from bd_urg.urg_inform_geral;
    declare continue handler for not found set done = true;
    
    open cur1;
    
    read_loop: loop
		fetch cur1 into designacao;
        
        if done then
			leave read_loop;
		end if;
        
        insert into dw_urg.d_genero(designacao) values (designacao);
	
	end loop;
        
	close cur1;
END$$

CALL cursor_genero;