DROP TABLE IF EXISTS GBAT_AlunoGrade;

CREATE TABLE GBAT_AlunoGrade AS
  SELECT a.id AS aluno_id, a.matriz_id, 
       CAST (a.ano_letivo__ano || a.periodo_letivo AS INT) AS ingresso, 
       CAST ((a.ano_letivo__ano  + (a.periodo_letivo + md.periodo - 2) / 2) ||
       ((a.periodo_letivo + md.periodo - 2) % 2) + 1 AS INT) AS quando_cursar,
       md.periodo AS periodo_cursar,
       d.id AS disc_id,
       d.descricao_historico
  FROM 
      Aluno a,
      Matriz_disciplinas md,
      Disciplina d
  WHERE
      a.matriz_id = md.matriz_id
      AND NOT md.optativo 
      AND md.id = d.id
 --     AND aluno_id IN (623772875341, 664811390249)
  ORDER BY aluno_id, periodo_cursar;

CREATE INDEX GradeIdx ON GBAT_AlunoGrade (
    aluno_id,
    matriz_id
);

CREATE INDEX GradeIdx2 ON GBAT_AlunoGrade (
    aluno_id,
    matriz_id,
    disc_id
);