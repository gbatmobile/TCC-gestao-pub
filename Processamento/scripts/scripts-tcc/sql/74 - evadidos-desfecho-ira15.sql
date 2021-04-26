SELECT descricao, count(DISTINCT minira.id)
FROM
    (SELECT a.id, sm.descricao, periodo, ira_calc as ira_calc
    FROM 
        Aluno a, SituacaoMatricula sm, CursoCampus cc
    LEFT JOIN
        GBAT_AlunoPeriodoIRA ira
        ON 
            a.id = ira.aluno_id
    WHERE 
        a.situacao_id = sm.id
        AND a.curso_campus_id = cc.id
        AND cc.naoAnalisar = FALSE
    ) minira
WHERE
    minira.ira_calc < 15
    AND minira.periodo <= 20192
GROUP BY descricao
