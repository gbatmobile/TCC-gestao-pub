SELECT 
    uo.descricao, uo.sigla,
	cc.descricao_historico, 
    COUNT(DISTINCT (cc.descricao_historico)) AS num_cursos, 
	MIN(DISTINCT (a.ano_letivo__ano || a.periodo_letivo)) ingresso,
	MAX(DISTINCT (mp.ano_letivo__ano || mp.periodo_letivo)) ult_mat,
    COUNT (DISTINCT (a.id)) AS num_alunos
FROM 
    Aluno a, 
    CursoCampus cc,
    unidadeOrganizacional uo,
    MatriculaPeriodo mp
WHERE
    1 = 1
    AND a.curso_campus_id = cc.id
    AND cc.diretoria__setor__uo_id = uo.id
    AND a.id = mp.aluno_id
--    AND (mp.ano_letivo__ano || mp.periodo_letivo) >= '20141'
--    AND (mp.ano_letivo__ano || mp.periodo_letivo) <= '20192'
GROUP BY uo.descricao, uo.sigla, cc.descricao_historico