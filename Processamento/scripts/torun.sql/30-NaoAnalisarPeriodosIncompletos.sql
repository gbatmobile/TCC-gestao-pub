ALTER TABLE CursoCampus 
    ADD COLUMN naoAnalisar             BOOLEAN DEFAULT (FALSE);
	
UPDATE CursoCampus  SET naoAnalisar = True
    WHERE descricao_historico = 'Tecnologia em Design de Moda'
    AND diretoria__setor__uo_id IN (
            SELECT id FROM UnidadeOrganizacional WHERE sigla = 'CA');
			
UPDATE CursoCampus  SET naoAnalisar = True
    WHERE descricao_historico = 'Tecnologia em Sistemas para Internet'
    AND diretoria__setor__uo_id IN (
            SELECT id FROM UnidadeOrganizacional WHERE sigla = 'CANG');
			
UPDATE CursoCampus  SET naoAnalisar = True
    WHERE descricao_historico = 'Licenciatura em Matemática'
    AND diretoria__setor__uo_id IN (
            SELECT id FROM UnidadeOrganizacional WHERE sigla = 'CM');

UPDATE CursoCampus  SET naoAnalisar = True
    WHERE descricao_historico = 'Engenharia Civil'
    AND diretoria__setor__uo_id IN (
            SELECT id FROM UnidadeOrganizacional WHERE sigla = 'CNAT');
			
UPDATE CursoCampus  SET naoAnalisar = True
    WHERE descricao_historico = 'Engenharia Sanitária e Ambiental'
    AND diretoria__setor__uo_id IN (
            SELECT id FROM UnidadeOrganizacional WHERE sigla = 'CNAT');
			
UPDATE CursoCampus  SET naoAnalisar = True
    WHERE descricao_historico = 'Licenciatura em Geografia'
    AND diretoria__setor__uo_id IN (
            SELECT id FROM UnidadeOrganizacional WHERE sigla = 'JC');
			
UPDATE CursoCampus  SET naoAnalisar = True
    WHERE descricao_historico = 'Tecnologia em Análise e Desenvolvimento de Sistemas'
    AND diretoria__setor__uo_id IN (
            SELECT id FROM UnidadeOrganizacional WHERE sigla = 'NC');

UPDATE CursoCampus  SET naoAnalisar = True
    WHERE descricao_historico = 'Licenciatura em Matemática'
    AND diretoria__setor__uo_id IN (
            SELECT id FROM UnidadeOrganizacional WHERE sigla = 'SPP');
			
UPDATE CursoCampus  SET naoAnalisar = True
    WHERE descricao_historico = 'Curso Superior de Licenciatura em Formação Pedagógica para Graduados não Licenciados (em Rede)'
    AND diretoria__setor__uo_id IN (
            SELECT id FROM UnidadeOrganizacional WHERE sigla = 'ZL');

			