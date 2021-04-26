-- Alunos com grande decréscimo de IRA mesmo com assistência.
SELECT s.descricao, count(*) 
FROM GBAT_AlunoAssistenciaIRAAcum a, MatriculaPeriodo mp, SituacaoMatriculaPeriodo s
WHERE 
	a.aluno_id = mp.aluno_id
	AND s.id = mp.situacao_id
	AND CAST ((mp.ano_letivo__ano || mp.periodo_letivo) AS INT) = a.periodo_fim
	AND  ira_dif <= -21
GROUP BY s.descricao

-- Alunos com IRAAcum ao final da assistência 
SELECT distinct aluno_id -- , periodo, ira_calc 
FROM 
    GBAT_AlunoPeriodoIRAAcum i,
    (SELECT distinct aluno_id, periodo_fim  
     FROM GBAT_AlunoIntervaloAssistencia
	 WHERE periodo_fim >= periodo_inicio) a
WHERE 
    i.aluno_id = a.aluno_id
    AND i.periodo = a.periodo_fim
    AND ira_calc > 75
	
	
-- Alunos com ação assistencial por periodo de fim
SELECT DISTINCT aluno_id, periodo_fim FROM GBAT_AlunoIntervaloAssistencia
       WHERE periodo_fim >= periodo_inicio;
	   
-- Alunos que ao fim da ação assistencial tinham IRA
-- A contagem da query anterior - esta dá a qtde de alunos que não
-- fecharam o semestre final da assistência com notas.
SELECT distinct (a.aluno_id)
FROM (SELECT DISTINCT aluno_id, periodo_fim FROM GBAT_AlunoIntervaloAssistencia
       WHERE periodo_fim >= periodo_inicio ) a,
	(SELECT DISTINCT aluno_id, periodo FROM GBAT_AlunoPeriodoIRAAcum) i
WHERE i.aluno_id = a.aluno_id
AND periodo_fim = periodo;