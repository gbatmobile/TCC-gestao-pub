 DROP TABLE IF EXISTS GBAT_AlunoPeriodoIRAAcum;

CREATE TABLE GBAT_AlunoPeriodoIRAAcum AS
	SELECT a.id AS aluno_id,
		   a.matriz_id,
		   CAST (mp1.ano_letivo__ano || mp1.periodo_letivo AS INT) AS periodo, 
		   COUNT(d.id) AS num_disciplinas,
		   SUM(d.ch_hora_relogio) AS carga_horaria,
                    1.0 * SUM(n2.media_final * d.ch_hora_relogio) / SUM(d.ch_hora_relogio) AS ira_calc
	  FROM 
		   Aluno a,
		   (SELECT aluno_id, ano_letivo__ano, periodo_letivo, COUNT(*) as ndisp
			FROM MatriculaPeriodo mp, Notas n1
			WHERE mp.id = n1.matricula_periodo_id
			GROUP BY  aluno_id, ano_letivo__ano, periodo_letivo
			) mp1,
		   matriculaPeriodo mp2,
		   Notas n2,
		   Disciplina d,
		   SituacaoDisciplina s
	  WHERE 1 = 1
		   AND mp1.aluno_id = a.id
		   AND mp2.aluno_id = a.id
		   AND ((mp2.ano_letivo__ano < mp1.ano_letivo__ano) 
				OR ((mp2.ano_letivo__ano = mp1.ano_letivo__ano) AND (mp2.periodo_letivo <= mp1.periodo_letivo)))
		   AND mp2.id = n2.matricula_periodo_id 
		   AND n2.disciplina_id = d.id 
		   AND n2.situacao_id = s.id 
		   AND s.descricao IN ("Aprovado", "Reprovado", "Reprovado por falta", "Aprovado/Reprovado no Módulo")
		   AND NOT (s.descricao = "Aprovado" AND n2.media_final = 0) -- Disciplinas que não entram no IRA (ver melhor)
	       AND (mp2.ano_letivo__ano <> 2020 OR s.descricao = "Aprovado" OR n2.percentual_frequencia IS NULL)
--	       AND a.id in  (767515020601) --, 626728295261, 623167850697, 622788664745, 623410418181, 617301620969)
	  GROUP BY 
		   a.id, a.matriz_id, CAST (mp1.ano_letivo__ano || mp1.periodo_letivo AS INT);
	  -- HAVING SUM(d.ch_hora_relogio) > 0;
