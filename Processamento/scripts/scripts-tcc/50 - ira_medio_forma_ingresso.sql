-- IRA médio IFRN, por período, por ingresso
SELECT 
     ira.periodo, 
     fi.lista,
     COUNT(ira_calc), AVG (ira_calc)
FROM Aluno a,
     CursoCampus cc,
     FormaIngresso fi,
     GBAT_AlunoPeriodoIRA ira
WHERE 
    1 = 1
    AND a.forma_ingresso_id = fi.id
    AND a.curso_campus_id = cc.id
    AND ira.aluno_id = a.id
    AND ira.periodo >= 20141 
    AND ira.periodo <= 20192 
	AND ira.periodo >=  CAST(a.ano_letivo__ano || a.periodo_letivo AS INT)
    AND cc.naoAnalisar = FALSE

--    AND a.id = 466739704837
GROUP BY ira.periodo, fi.lista
ORDER BY ira.periodo, fi.lista