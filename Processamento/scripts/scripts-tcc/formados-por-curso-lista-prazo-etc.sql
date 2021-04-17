SELECT sigla, descricao_historico, 
       CASE
           WHEN sm.descricao LIKE 'Formado %' THEN sm.descricao
           ELSE 'Outros'
       END situacao, 
       fi.lista lista,
--       matriculas,
--       ((maxper / 10 - CAST(ano_letivo__ano AS INT)) * 2 + 
--       maxper % 10 - CAST(periodo_letivo AS INT) + 1) AS periodos_curso,
       count(*) qtde_alunos
FROM 
    Aluno a, SituacaoMatricula sm, 
    CursoCampus cc, UnidadeOrganizacional uo,
    FormaIngresso fi,
    (SELECT aluno_id, COUNT(*) matriculas, 
            MAX (CAST(ano_letivo__ano || periodo_letivo AS INT)) maxper 
     FROM MatriculaPeriodo
     GROUP BY aluno_id) mp
WHERE sm.id = a.situacao_id
    AND cc.id = a.curso_campus_id
    AND cc.diretoria__setor__uo_id = uo.id
    AND a.forma_ingresso_id = fi.id 
    AND a.id = mp.aluno_id
    AND CAST (a.ano_letivo__ano || a.periodo_letivo AS INT) < 20181
    AND situacao LIKE 'Formado%'
GROUP BY sigla, descricao_historico, situacao, lista --,matriculas, periodos_curso
ORDER BY sigla, descricao_historico, situacao, lista --,matriculas, periodos_curso