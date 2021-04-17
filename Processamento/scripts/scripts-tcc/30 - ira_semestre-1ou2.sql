SELECT
     i.periodo, 
     a.periodo_letivo, 
     COUNT(*), AVG(ira_calc)
FROM 
     Aluno a, 
     GBAT_AlunoPeriodoIRA i,
     CursoCampus cc
WHERE 
    1 = 1
    AND a.id = i.aluno_id
    AND a.curso_campus_id = cc.id
    AND cc.naoAnalisar = FALSE
    AND i.periodo >= 20141
    AND i.periodo <= 20192
    AND i.periodo >=  CAST(a.ano_letivo__ano || a.periodo_letivo AS INT)
GROUP BY periodo, a.periodo_letivo
ORDER BY periodo, a.periodo_letivo
