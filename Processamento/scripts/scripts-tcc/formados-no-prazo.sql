-- Alunos (nao) formados no prazo
SELECT a.*, sm.descricao, 
		CASE
			WHEN quandocursou <= quandocursar THEN 'Formado no prazo'
			ELSE 'Formado fora do prazo'
		END
FROM 
    Aluno a,
    SituacaoMatricula sm,
    (SELECT aluno_id, MAX(quando_cursar) quandocursar
     FROM GBAT_AlunoGrade
     GROUP BY aluno_id) ultpermitido,
    (SELECT aluno_id, MAX(quando_cursou) quandocursou
     FROM GBAT_AlunoHistorico
     GROUP BY aluno_id) ultcursado
 WHERE
     a.id = ultpermitido.aluno_id
     AND a.id = ultcursado.aluno_id
     AND a.situacao_id = sm.id
     AND sm.descricao = 'Formado'