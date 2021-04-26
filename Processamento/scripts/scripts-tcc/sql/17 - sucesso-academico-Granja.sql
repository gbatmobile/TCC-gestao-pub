-- Matriculados em 20202 que estão desnivelados a mais de 4 períodos
SELECT * 
FROM 
    Aluno a,
    SituacaoMatricula sm, GBAT_AlunoPeriodoDesNivelamento d
WHERE
    a.situacao_id = sm.id
    AND sm.descricao LIKE '%Matr%'
    AND a.id = d.aluno_id
    AND d.periodo_ref = 20202
    AND ( CAST ((periodo_ref - periodo_atras) / 5 AS INT) + 
          CAST ((periodo_ref+1)%2 - (periodo_atras+1)%2 AS INT) ) > 4

-- Formados em até quatro semestre após os seis regulares
SELECT f.*, (CAST (a.ano_letivo__ano || a.periodo_letivo AS INT)) ingresso,
 CAST ((atequandomatriculou - (CAST (a.ano_letivo__ano || a.periodo_letivo AS INT))) / 5 AS INT) + 
          CAST ((atequandomatriculou+1)%2 - ((CAST (a.ano_letivo__ano || a.periodo_letivo AS INT))+1)%2 AS INT) atraso
 FROM
   GBAT_AlunoFormado f, Aluno a
WHERE
    a.id = f.aluno_id
    AND CAST ((atequandomatriculou - (CAST (a.ano_letivo__ano || a.periodo_letivo AS INT))) / 5 AS INT) + 
          CAST ((atequandomatriculou+1)%2 - ((CAST (a.ano_letivo__ano || a.periodo_letivo AS INT))+1)%2 AS INT) <= 10

    
-- Alunos com pelo menos um semestre cursado
SELECT aluno_id , count(DISTINCT periodo_cursou) 
FROM GBAT_AlunoHistorico
GROUP BY aluno_id 
HAVING count(DISTINCT periodo_cursou) > 1