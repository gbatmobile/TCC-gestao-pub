SELECT descricao, count(*)
FROM
    (SELECT a.id, sm.descricao, MIN(ira_calc) as ira_calc
    FROM 
        Aluno a, SituacaoMatricula sm
    LEFT JOIN
        GBAT_AlunoPeriodoIRA ira
        ON 
            a.id = ira.aluno_id
    WHERE 
        a.situacao_id = sm.id
    GROUP BY a.id, sm.descricao) minira
WHERE
    minira.ira_calc < 15
GROUP BY descricao