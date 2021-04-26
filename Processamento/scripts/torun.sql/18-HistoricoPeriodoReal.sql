ALTER TABLE GBAT_AlunoHistorico 
    ADD COLUMN periodo_cursou_real        INT;

UPDATE 
    GBAT_AlunoHistorico 
SET 
    periodo_cursou_real  = per_real.periodo_real
FROM 
    (SELECT h1.aluno_id, h1.disc_id, h1.periodo_cursou, 
		COUNT (DISTINCT h2.periodo_cursou) periodo_real
	FROM
		GBAT_AlunoHistorico h1,
		(SELECT DISTINCT aluno_id, periodo_cursou
		 FROM GBAT_AlunoHistorico
		 WHERE quando_cursou >= ingresso) h2
	WHERE 
		h1.aluno_id = h2.aluno_id 
		AND h2.periodo_cursou <= h1.periodo_cursou
	GROUP BY h1.aluno_id, h1.disc_id, h1.periodo_cursou) per_real
WHERE 
    GBAT_AlunoHistorico.aluno_id = per_real.aluno_id
	AND GBAT_AlunoHistorico.disc_id = per_real.disc_id
	AND GBAT_AlunoHistorico.periodo_cursou = per_real.periodo_cursou;
