DROP TABLE IF EXISTS GBAT_AlunoPeriodoIRA;

CREATE TABLE GBAT_AlunoPeriodoIRA AS
SELECT a.id AS aluno_id,
	   a.matriz_id,
       CAST (mp.ano_letivo__ano || mp.periodo_letivo AS INT) AS periodo,
       COUNT(d.id) AS num_disciplinas,
       SUM(d.ch_hora_relogio) AS carga_horaria,
       1.0 * SUM(n.media_final * d.ch_hora_relogio) / SUM(d.ch_hora_relogio) AS ira_calc
  FROM Aluno a,
       CursoCampus c,
       MatriculaPeriodo mp,
       Notas n,
       Disciplina d,
       SituacaoDisciplina s
 WHERE 1 = 1
       AND a.curso_campus_id = c.id
	   AND a.id = mp.aluno_id
       AND mp.id = n.matricula_periodo_id 
       AND n.disciplina_id = d.id 
       AND n.situacao_id = s.id 
	   AND s.descricao IN ("Aprovado", "Reprovado", "Reprovado por falta", "Aprovado/Reprovado no Módulo")
	   AND NOT (s.descricao = "Aprovado" AND n.media_final = 0) -- Disciplinas que não entram no IRA (ver melhor)
	   AND (mp.ano_letivo__ano <> 2020 OR s.descricao = "Aprovado" OR n.percentual_frequencia IS NULL)
--	       AND a.id in  (767515020601) --, 626728295261, 623167850697, 622788664745, 623410418181, 617301620969)
 GROUP BY 
       aluno_id, a.matriz_id, CAST (mp.ano_letivo__ano || mp.periodo_letivo AS INT);