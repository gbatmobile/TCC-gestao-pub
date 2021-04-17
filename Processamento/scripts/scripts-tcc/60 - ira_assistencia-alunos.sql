-- Qtde de alunos com/SEM assistência, por periodo
-- Pode não bater com os que tem IRA, pois alguns 
-- podem ter abandonado/trancado/etc (nao tem IRA).
SELECT 
     pa.periodo, 
     COUNT(a.id)
FROM Aluno a,
     CursoCampus cc,
     GBAT_AlunoPeriodoAssistencia pa
WHERE 
    1 = 1
    AND a.curso_campus_id = cc.id
    AND a.id = pa.aluno_id
	AND cc.naoAnalisar = FALSE
	AND pa.periodo >= 20141
    AND pa.periodo <= 20192 
--	AND pa.tipo != 'Nenhuma'
GROUP BY pa.periodo
ORDER BY pa.periodo;



-- IRA médio IFRN, por período, por tipo de assistencia
SELECT 
      ira.periodo, 
     pa.tipo,
     COUNT(ira_calc), AVG (ira_calc)
FROM Aluno a,
     CursoCampus cc,
     GBAT_AlunoPeriodoAssistencia pa,
     GBAT_AlunoPeriodoIRA ira
WHERE 
    1 = 1
    AND ira.aluno_id = a.id
    AND a.curso_campus_id = cc.id
    AND ira.periodo >= 20141 
    AND ira.periodo <= 20192 
    AND ira.periodo >=  CAST(a.ano_letivo__ano || a.periodo_letivo AS INT)
    AND cc.naoAnalisar = FALSE
    AND a.id = pa.aluno_id
    AND ira.periodo = pa.periodo
GROUP BY ira.periodo, pa.tipo
ORDER BY ira.periodo, pa.tipo;


