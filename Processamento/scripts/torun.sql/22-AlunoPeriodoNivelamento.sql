DROP TABLE IF EXISTS GBAT_AlunoPeriodoNivelamento;

CREATE TABLE GBAT_AlunoPeriodoNivelamento AS
	SELECT a.id AS aluno_id, 
             CAST (a.ano_letivo__ano || a.periodo_letivo AS INT) AS ingresso,
             CAST (mp.ano_letivo__ano || mp.periodo_letivo AS INT) AS periodo_ref
	FROM aluno a, MatriculaPeriodo mp
	WHERE a.id = mp.aluno_id 
		  AND (a.id, a.matriz_id, 
			   CAST (mp.ano_letivo__ano || mp.periodo_letivo AS INT)) 
				NOT IN
					(SELECT d.aluno_id, matriz_id, d.periodo_ref
						FROM GBAT_AlunoPeriodoDesnivelamento d);