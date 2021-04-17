-- Desnivelados por periodo, curso
SELECT * FROM 
	(SELECT a.matriz_id , cc.descricao_historico, ad.periodo_ref,
			count(*) AS desnivelados
		FROM 
			Aluno a, 
			GBAT_AlunoPeriodoDesnivelamento ad,
			CursoCampus cc
		WHERE
			1 = 1
			AND a.id = ad.aluno_id
			AND a.curso_campus_id = cc.id
		GROUP BY 
		   a.matriz_id , cc.descricao_historico, ad.periodo_ref) desn,
	(SELECT DISTINCT matriz_id, periodo_cursou, COUNT(aluno_id)
		FROM GBAT_AlunoHistorio 
		GROUP BY matriz_id, periodo_cursou) todos
WHERE	
	desn.matriz_id = todos.matriz_id
	AND desn.periodo_ref = todos.periodo_cursou
ORDER BY    
	cc.descricao_historico, ad.periodo_ref;

-- Assitencia aos desnivelados
SELECT d.aluno_id, periodo_ref, ch_desnivel, COUNT (DISTINCT tipo)
  FROM GBAT_AlunoPeriodoDesnivelamento d
  LEFT JOIN
      GBAT_AlunoPeriodoAssistencia a
  ON 
      d.aluno_id = a.aluno_id
  WHeRE 
   a.periodo_inicio <= d.periodo_ref 
   AND ((d.periodo_ref <= a.periodo_fim) OR a.periodo_fim IS NULL)
   AND d.aluno_id = 612807152185
GROUP BY d.aluno_id, periodo_ref, ch_desnivel
ORDER BY d.aluno_id, periodo_ref;

    
-- Alunos por curso
SELECT DISTINCT cc.descricao_historico, count(*)
FROM 
    Aluno a, 
    CursoCampus cc
WHERE
    a.curso_campus_id = cc.id
GROUP BY 
    cc.descricao_historico
    
-- IRA por período
SELECT uo.sigla, 
       CAST (mp.ano_letivo__ano || mp.periodo_letivo AS INT) as periodo, 
       count(*) AS qtde_alunos,
       AVG (ira_calc)
FROM Aluno a, CursoCampus cc, 
     MatriculaPeriodo mp, UnidadeOrganizacional uo,
     GBAT_AlunoPeriodoIRAAcum ira
WHERE a.curso_campus_id = cc.id 
AND a.id = mp.aluno_id
AND cc.diretoria__setor__uo_id = uo.id
AND mp.ano_letivo__ano >= 2014
AND ira.aluno_id = a.id
AND CAST (mp.ano_letivo__ano || mp.periodo_letivo AS INT) = ira.periodo
AND a.ano_letivo__ano = mp.ano_letivo__ano
AND a.periodo_letivo = mp.periodo_letivo
GROUP BY uo.sigla, mp.ano_letivo__ano, mp.periodo_letivo
ORDER BY uo.sigla, mp.ano_letivo__ano, mp.periodo_letivo

-- IRA médio IFRN  por período
SELECT 
	CAST (mp.ano_letivo__ano || mp.periodo_letivo AS INT) as periodo, 
     AVG (ira_calc)
FROM Aluno a,
     MatriculaPeriodo mp,
     GBAT_AlunoPeriodoIRAAcum ira
WHERE 
    a.id = mp.aluno_id
    AND ira.aluno_id = a.id
	AND CAST (mp.ano_letivo__ano || mp.periodo_letivo AS INT) = ira.periodo
    AND mp.ano_letivo__ano >= 2014
--    AND a.id = 466739704837
GROUP BY mp.ano_letivo__ano, mp.periodo_letivo
ORDER BY mp.ano_letivo__ano, mp.periodo_letivo
