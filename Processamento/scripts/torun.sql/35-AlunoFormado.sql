DROP TABLE IF EXISTS GBAT_AlunoFormado;

CREATE TABLE GBAT_AlunoFormado AS
SELECT ultmatric.*, sm.descricao FROM 
    Aluno a,
    SituacaoMatricula sm,
    (SELECT  aluno_id, MAX(CAST((ano_letivo__ano || periodo_letivo) AS INT))  
		atequandomatriculou
     FROM  MatriculaPeriodo 
     GROUP BY aluno_id) ultmatric
WHERE
    a.id = ultmatric.aluno_id AND
    a.situacao_id = sm.id AND
    sm.descricao LIKE '%Formado%';
	