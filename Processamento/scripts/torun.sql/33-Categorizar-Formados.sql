INSERT INTO SituacaoMatricula VALUES (971101719, 'Formado no prazo');
INSERT INTO SituacaoMatricula VALUES (971101729, 'Formado fora do prazo');

-- Alunos (nao) formados no prazo, 
-- baseado na última disciplina de histórico. 
-- Foi mudado para última matrícula, abaixo
/*UPDATE Aluno
   SET situacao_id = ns.situacao_id
FROM
 (SELECT a.id, 
         CASE
            WHEN atequandocursou <= atequandocursar THEN 971101719
			ELSE 971101729
         END situacao_id
  FROM 
    Aluno a,
    SituacaoMatricula sm,
    (SELECT aluno_id, MAX(quando_cursar) atequandocursar
     FROM GBAT_AlunoGrade
     GROUP BY aluno_id) ultpermitido,
    (SELECT aluno_id, MAX(quando_cursou) atequandocursou
     FROM GBAT_AlunoHistorico
     GROUP BY aluno_id) ultcursado
  WHERE
     a.id = ultpermitido.aluno_id
     AND a.id = ultcursado.aluno_id
     AND a.situacao_id = sm.id
     AND sm.descricao = 'Formado'
 ) AS ns
WHERE Aluno.id = ns.id;
*/

-- Alunos (nao) formados no prazo, 
-- baseado na última matrícula. 
UPDATE Aluno
   SET situacao_id = ns.situacao_id
FROM
 (SELECT a.id, 
         CASE
            WHEN atequandomatriculou <= atequandocursar THEN 971101719
			ELSE 971101729
         END situacao_id
  FROM 
    Aluno a,
    SituacaoMatricula sm,
    (SELECT aluno_id, MAX(quando_cursar) atequandocursar
     FROM GBAT_AlunoGrade
     GROUP BY aluno_id) ultpermitido,
    (SELECT  aluno_id, MAX(CAST((ano_letivo__ano || periodo_letivo) AS INT))  atequandomatriculou
     FROM  MatriculaPeriodo 
     GROUP BY aluno_id) ultmatric
  WHERE
     a.id = ultpermitido.aluno_id
     AND a.id = ultmatric.aluno_id
     AND a.situacao_id = sm.id
     AND sm.descricao LIKE 'Formado%'
 ) AS ns
WHERE Aluno.id = ns.id;