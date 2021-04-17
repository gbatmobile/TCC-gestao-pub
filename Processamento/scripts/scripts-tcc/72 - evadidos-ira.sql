SELECT sem_cursados, COUNT(*), 
       AVG(iramin.ira_calc) media_ira_inicio, 
	   MIN(iramin.ira_calc) min_ira_inicio, 
	   MAX(iramin.ira_calc) max_ira_inicio,
       AVG(iramax.ira_calc) media_ira_fim, 
	   MIN(iramax.ira_calc) min_ira_fim, 
	   MAX(iramax.ira_calc) max_ira_fim
FROM 
    (SELECT aluno_id, 
            MIN(CASE WHEN quando_cursou < ingresso THEN ingresso ELSE quando_cursou END) min_cursado,
            MAX(CASE WHEN quando_cursou > ingresso THEN quando_cursou ELSE ingresso END) max_cursado, 
            COUNT(DISTINCT (CASE WHEN quando_cursou > ingresso THEN quando_cursou ELSE ingresso END)) sem_cursados
     FROM 
         GBAT_AlunoHistorico h
     WHERE 
         situacao_atual = 'Evasão'
     GROUP BY aluno_id) mp
LEFT JOIN     
    GBAT_AlunoPeriodoIRA iramin
  ON
     mp.aluno_id = iramin.aluno_id
     AND  mp.min_cursado = iramin.periodo
LEFT JOIN     
    GBAT_AlunoPeriodoIRA iramax
  ON
     mp.aluno_id = iramax.aluno_id
     AND  mp.max_cursado = iramax.periodo
WHERE
	  1 = 1    
      AND max_cursado >= 20141
      AND max_cursado <= 20192
--    AND mp.aluno_id IN (1194152269, 696777323629, 760198962233)
GROUP BY sem_cursados
ORDER BY sem_cursados
;
