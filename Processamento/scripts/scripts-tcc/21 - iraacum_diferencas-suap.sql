SELECT
     a.id, (a.ano_letivo__ano || a.periodo_letivo) ingresso ,   
     a.ira, i.ira_calc, a.ira - i.ira_calc
FROM aluno a, GBAT_AlunoPeriodoIRAAcum i
WHERE 
    1 = 1
    AND a.id = i.aluno_id
    AND i.periodo = 20201
    AND ABS(a.ira - i.ira_calc) > 1