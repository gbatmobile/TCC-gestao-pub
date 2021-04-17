ALTER TABLE CursoCampus 
    ADD COLUMN diretoria             TEXT;
	
UPDATE CursoCampus  SET diretoria = "DIAC"
    WHERE descricao_historico IN ('Licenciatura em Espanhol',
                                  'Licenciatura em Física',
                                  'Licenciatura em Geografia',
                                  'Licenciatura em Matemática')
    AND diretoria__setor__uo_id IN (
            SELECT id FROM UnidadeOrganizacional WHERE sigla = 'CNAT');
			
UPDATE CursoCampus  SET diretoria = "DIATINF"
    WHERE descricao_historico IN ('Tecnologia em Gestão Pública',
                                'Tecnologia em Análise e Desenvolvimento de Sistemas',
                                'Tecnologia em Comércio Exterior',
                                'Tecnologia em Redes de Computadores')
    AND diretoria__setor__uo_id IN (
            SELECT id FROM UnidadeOrganizacional WHERE sigla = 'CNAT');		
			
			
UPDATE CursoCampus  SET diretoria = "DIACIN"
    WHERE descricao_historico IN ('Engenharia de Energia')
    AND diretoria__setor__uo_id IN (
            SELECT id FROM UnidadeOrganizacional WHERE sigla = 'CNAT');
			
UPDATE CursoCampus  SET diretoria = "DIAREN"
    WHERE descricao_historico IN ('Tecnologia em Gestão Ambiental',
								  'Engenharia Sanitária e Ambiental')
    AND diretoria__setor__uo_id IN (
            SELECT id FROM UnidadeOrganizacional WHERE sigla = 'CNAT');		

UPDATE CursoCampus  SET diretoria = "DIACON"
    WHERE descricao_historico IN ('Tecnologia em Construção de Edifícios',
								  'Engenharia Civil')
    AND diretoria__setor__uo_id IN (
            SELECT id FROM UnidadeOrganizacional WHERE sigla = 'CNAT');					

