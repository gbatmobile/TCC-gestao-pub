SELECT 
     ira.periodo, 
     AVG (ira_calc),
	 COUNT(ira_calc)
FROM Aluno a,
     CursoCampus cc,
     GBAT_AlunoPeriodoIRAAcum ira
WHERE 
    1 = 1
    AND a.curso_campus_id = cc.id
    AND ira.aluno_id = a.id
    AND ira.periodo >= 20141 
    AND ira.periodo <= 20192 
    AND cc.naoAnalisar = FALSE
	AND periodo >=  CAST(a.ano_letivo__ano || a.periodo_letivo AS INT)
--    AND a.id = 466739704837
GROUP BY ira.periodo
ORDER BY ira.periodo