DROP TABLE IF EXISTS GBAT_AlunoIntervaloAssistencia;

CREATE TABLE GBAT_AlunoIntervaloAssistencia AS
	SELECT DISTINCT ass.aluno_id, tipo, 
					CAST (SUBSTR(inicio, 7, 4) || 
					((SUBSTR(inicio, 4, 2) + 5) / 6) AS INT) AS periodo_inicio,
					CASE 
						WHEN fim IS NULL THEN 20192
						ELSE 
							CAST (SUBSTR(fim, 7, 4) ||  ((SUBSTR(fim, 4, 2) + 5) / 6) AS INT) 
					END periodo_fim					 
	FROM
		Assitencia ass, Programa prg
	WHERE
		ass.programa_id = prg.id;
		