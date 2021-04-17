-- Matriculas de um aluno por periodo

SELECT 
    a.id, 
    (a.ano_letivo__ano || a.periodo_letivo) as ingresso,
    uo.sigla, cc.descricao_historico, 
    (mp.ano_letivo__ano || mp.periodo_letivo) as periodo,
    sp.descricao
FROM 
    Aluno a, 
    CursoCampus cc,
    unidadeOrganizacional uo,
    MatriculaPeriodo mp,
    SituacaoMatriculaPeriodo sp
WHERE
    1 = 1
    AND a.curso_campus_id = cc.id
    AND cc.diretoria__setor__uo_id = uo.id
    AND a.id = mp.aluno_id
    AND mp.situacao_id = sp.id
    AND a.id IN (389419228213)
ORDER BY a.id, periodo


