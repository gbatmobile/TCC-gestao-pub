DROP TABLE IF EXISTS GBAT_AlunoHistorico;

CREATE TABLE GBAT_AlunoHistorico AS
SELECT a.id AS aluno_id, sm.descricao situacao_atual,
       CAST (a.ano_letivo__ano || a.periodo_letivo AS INT) AS ingresso,
       a.matriz_id,
	   0 limite_curso,
       CAST (mp.ano_letivo__ano || mp.periodo_letivo AS INT) AS quando_cursou, 
       CAST ((mp.ano_letivo__ano - a.ano_letivo__ano) * 2 +
       (mp.periodo_letivo - a.periodo_letivo + 1) AS INT) AS periodo_cursou,
       ag.quando_cursar,
       d.id AS disc_id, d.descricao_historico,
       d.ch_hora_relogio, 
       n.media_final,
       n.percentual_frequencia,
       sd.descricao AS situacao
  FROM 
      Aluno a,
      SituacaoMatricula sm,
      MatriculaPeriodo mp,
      Notas n,
      SituacaoDisciplina sd,
      Disciplina d
  LEFT JOIN 
      GBAT_AlunoGrade ag
  ON
       a.id = ag.aluno_id
   AND a.matriz_id = ag.matriz_id
   AND d.id = ag.disc_id
  WHERE
      a.id = mp.aluno_id
      AND a.situacao_id = sm.id
      -- 
      AND mp.id = n.matricula_periodo_id
      AND n.situacao_id = sd.id
      AND n.disciplina_id = d.id
      -- AND a.id = 756094831929 -- so opcionais
	  -- AND a.id = 646986862373 -- Jane
	  ;

-- Limite global do curso
UPDATE 
    GBAT_AlunoHistorico 
SET 
    limite_curso  = max_cursar.limite
FROM 
    (SELECT aluno_id, MAX(quando_cursar) as limite
     FROM GBAT_AlunoGrade
     GROUP BY aluno_id) max_cursar
WHERE 
    GBAT_AlunoHistorico.aluno_id = max_cursar.aluno_id;

-- Atualiza disciplinas que nao tem per�odo maximo -- opcionais	
UPDATE 
    GBAT_AlunoHistorico 
SET 
    quando_cursar = limite_curso
WHERE 
    quando_cursar IS NULL;    
	  	  
	  
CREATE INDEX HistoricoIdx ON GBAT_AlunoHistorico (
    aluno_id,
    matriz_id,
    periodo_cursou,
    disc_id
);
