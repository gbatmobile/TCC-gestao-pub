-- IRA médio IFRN, por período, por campus
SELECT 
     ira.periodo, uo.sigla,
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
    AND ira.periodo <= 20181
	AND periodo >=  CAST(a.ano_letivo__ano || a.periodo_letivo AS INT)
    AND cc.naoAnalisar = FALSE
--    AND a.id = 466739704837
GROUP BY uo.sigla, ira.periodo 
ORDER BY uo.sigla, ira.periodo