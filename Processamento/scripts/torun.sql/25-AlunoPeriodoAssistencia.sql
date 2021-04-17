DROP TABLE IF EXISTS GBAT_AlunoPeriodoAssistencia;

CREATE TABLE GBAT_AlunoPeriodoAssistencia AS
	SELECT DISTINCT  quando_cursou AS periodo, per.aluno_id, 
                CASE
                    WHEN tipo IS NOT NULL THEN tipo
                    ELSE "Nenhuma"
                END tipo
	FROM
             (SELECT DISTINCT aluno_id, quando_cursou FROM GBAT_AlunoHistorico) per
	LEFT JOIN 
			(SELECT DISTINCT ass.aluno_id, tipo, inicio, fim,
				CAST (SUBSTR(inicio, 7, 4) || 
	                 ((SUBSTR(inicio, 4, 2) + 5) / 6) AS INT) AS periodo_inicio,
                     CAST (SUBSTR(fim, 7, 4) || 
	                 ((SUBSTR(fim, 4, 2) + 5) / 6) AS INT) AS periodo_fim					 
			 FROM
				Assitencia ass, Programa prg
			WHERE
				ass.programa_id = prg.id) assist
	ON 
		per.aluno_id = assist.aluno_id
		AND per.quando_cursou >= assist.periodo_inicio
		AND (per.quando_cursou <= assist.periodo_fim OR assist.periodo_fim IS NULL);	
