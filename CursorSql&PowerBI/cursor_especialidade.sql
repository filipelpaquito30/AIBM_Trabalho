DELIMITER $$
DROP PROCEDURE IF EXISTS cursor_especialidade;
CREATE DEFINER=`root`@`localhost` PROCEDURE `cursor_especialidade`()
BEGIN
	DECLARE done boolean DEFAULT FALSE;
    declare desig_espec varchar(45);
    declare cur1 cursor for select distinct ALTA_DES_ESPECIALIDADE from bd_urg.urg_inform_geral;
    declare continue handler for not found set done = true;
    
    open cur1;
    
    read_loop: loop
		fetch cur1 into desig_espec;
        
        if done then
			leave read_loop;
		end if;
        
        insert into dw_urg.d_especialidade(desig_espec) values (desig_espec);
	
	end loop;
        
	close cur1;
END$$

CALL cursor_especialidade;
