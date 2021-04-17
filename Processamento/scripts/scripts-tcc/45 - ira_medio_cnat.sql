-- IRA médio IFRN, por período, por campus
SELECT 
     ira.periodo, cc.diretoria,
     COUNT(ira_calc), AVG (ira_calc)
FROM Aluno a,
     CursoCampus cc,
	 UnidadeOrganizacional uo,
     GBAT_AlunoPeriodoIRA ira
WHERE 
    1 = 1
    AND a.curso_campus_id = cc.id
	AND cc.diretoria__setor__uo_id = uo.id
    AND ira.aluno_id = a.id
    AND ira.periodo >= 20161 
    AND ira.periodo <= 20182 
	AND uo.sigla = 'CNAT'
    AND cc.naoAnalisar = FALSE
	AND periodo >=  CAST(a.ano_letivo__ano || a.periodo_letivo AS INT)
--    AND a.id = 466739704837
GROUP BY ira.periodo, cc.diretoria
ORDER BY ira.periodo, cc.diretoria