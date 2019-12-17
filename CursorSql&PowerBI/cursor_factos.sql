DELIMITER $$
DROP PROCEDURE IF EXISTS cursor_factos;
CREATE DEFINER=`root`@`localhost` PROCEDURE `cursor_factos`()
BEGIN
	declare done boolean default false;
    declare id int;
    declare minutos_ate_alta int;
    declare data_nascimento date;
    declare ID_ESPECIALIDADE int;
    declare ID_LOCAL int;
    declare ID_PROVENIENCIA int;
    declare ID_CAUSA int;
    declare ID_GENERO int;
    declare ID_DATA int;
    
    
    declare cur1 cursor for SELECT DISTINCT GERAL.URG_EPISODIO, TIMESTAMPDIFF(MINUTE, GERAL.DATAHORA_ADM, 
    	GERAL.DATAHORA_ALTA), GERAL.DTA_NASCIMENTO, DE.id_especialidade, DL.id_local, DP.id_proveniencia, DC.id_causa, DG.id_genero, DD.id_data FROM dw_urg.d_especialidade DE,dw_urg.d_local DL, dw_urg.d_proveniencia DP, dw_urg.d_causa DC,dw_urg.d_genero DG,dw_urg.d_data DD, bd_urg.urg_inform_geral GERAL
        WHERE DE.desig_espec= GERAL.ALTA_DES_ESPECIALIDADE AND DL.desig_local=GERAL.DES_LOCAL AND DP.desig_prove = GERAL.DES_PROVENIENCIA AND DC.desig_causa=GERAL.DES_CAUSA AND DG.designacao=GERAL.SEXO AND DD.dataa=GERAL.DATAHORA_ADM;
    declare continue handler for not found set done = true;
    
    open cur1;
    
    read_loop: loop
		fetch cur1 into id, minutos_ate_alta, data_nascimento, ID_ESPECIALIDADE, ID_LOCAL, ID_PROVENIENCIA, ID_CAUSA, ID_GENERO, ID_DATA;
        
        if done then
			leave read_loop;
		end if;
        
        insert into dw_urg.factos_urg(idfactos_urg, minutos_ate_alta, data_nascimento, id_especialidade,id_local, id_proveniencia,id_causa,id_genero,id_data) values (id, minutos_ate_alta, data_nascimento,ID_ESPECIALIDADE, ID_LOCAL, ID_PROVENIENCIA, ID_CAUSA,ID_GENERO,ID_DATA);
	
	end loop;
        
	close cur1;
END$$
call cursor_factos;

