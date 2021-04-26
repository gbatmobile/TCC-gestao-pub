SELECT CAST (iramax.ira_calc / 10 AS INT) * 10, count(*)
FROM 
    (SELECT aluno_id, 
            MAX(CASE WHEN quando_cursou > ingresso THEN quando_cursou ELSE ingresso END) max_cursado
     FROM 
         GBAT_AlunoHistorico h
     WHERE 
         situacao_atual = 'Evasão'
     GROUP BY aluno_id) mp
LEFT JOIN     
    GBAT_AlunoPeriodoIRA iramax
  ON
     mp.aluno_id = iramax.aluno_id
     AND  mp.max_cursado = iramax.periodo
WHERE
    1 = 1    
      AND max_cursado >= 20142
      AND max_cursado <= 20201
GROUP BY CAST (iramax.ira_calc / 10 AS INT) * 10;
