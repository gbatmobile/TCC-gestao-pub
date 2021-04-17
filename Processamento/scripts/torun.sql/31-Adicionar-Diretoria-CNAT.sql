ALTER TABLE CursoCampus 
    ADD COLUMN diretoria             TEXT;
	
UPDATE CursoCampus  SET diretoria = "DIAC"
    WHERE descricao_historico IN ('Licenciatura em Espanhol',
                                  'Licenciatura em F�sica',
                                  'Licenciatura em Geografia',
                                  'Licenciatura em Matem�tica')
    AND diretoria__setor__uo_id IN (
            SELECT id FROM UnidadeOrganizacional WHERE sigla = 'CNAT');
			
UPDATE CursoCampus  SET diretoria = "DIATINF"
    WHERE descricao_historico IN ('Tecnologia em Gest�o P�blica',
                                'Tecnologia em An�lise e Desenvolvimento de Sistemas',
                                'Tecnologia em Com�rcio Exterior',
                                'Tecnologia em Redes de Computadores')
    AND diretoria__setor__uo_id IN (
            SELECT id FROM UnidadeOrganizacional WHERE sigla = 'CNAT');		
			
			
UPDATE CursoCampus  SET diretoria = "DIACIN"
    WHERE descricao_historico IN ('Engenharia de Energia')
    AND diretoria__setor__uo_id IN (
            SELECT id FROM UnidadeOrganizacional WHERE sigla = 'CNAT');
			
UPDATE CursoCampus  SET diretoria = "DIAREN"
    WHERE descricao_historico IN ('Tecnologia em Gest�o Ambiental',
								  'Engenharia Sanit�ria e Ambiental')
    AND diretoria__setor__uo_id IN (
            SELECT id FROM UnidadeOrganizacional WHERE sigla = 'CNAT');		

UPDATE CursoCampus  SET diretoria = "DIACON"
    WHERE descricao_historico IN ('Tecnologia em Constru��o de Edif�cios',
								  'Engenharia Civil')
    AND diretoria__setor__uo_id IN (
            SELECT id FROM UnidadeOrganizacional WHERE sigla = 'CNAT');					

