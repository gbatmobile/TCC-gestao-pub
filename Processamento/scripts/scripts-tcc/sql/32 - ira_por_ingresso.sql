SELECT p.ingresso, p.pperiodo, AVG(i.ira_calc)
FROM
    (SELECT DISTINCT aluno_id,
                    ingresso, 
                    CASE 
                         WHEN periodo_cursou >= 10 THEN 10
                         WHEN periodo_cursou  >  0 THEN periodo_cursou 
                         WHEN periodo_cursou <= 0 THEN 1
                    END  pperiodo,
                    quando_cursou
     FROM GBAT_AlunoHistorico
     WHERE
         quando_cursou >= ingresso) p,
     Aluno a, 
     GBAT_AlunoPeriodoIRA i,
     CursoCampus cc
WHERE
    a.id = i.aluno_id
    AND a.curso_campus_id = cc.id
    AND i.aluno_id = p.aluno_id
    AND cc.naoAnalisar = FALSE
    AND i.periodo >= 20141
    AND i.periodo <= 20192
    AND i.periodo >=  CAST(a.ano_letivo__ano || a.periodo_letivo AS INT)
    AND i.periodo = p.quando_cursou 
GROUP BY
    p.ingresso, p.pperiodo
ORDER BY p.ingresso, p.pperiodo