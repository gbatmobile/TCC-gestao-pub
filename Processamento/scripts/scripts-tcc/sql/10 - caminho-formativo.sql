-- Matriculados em 2020.2
-- Aluno 693554243037 já evadido
-- não matriculado em 20202 e matriculado em 20211
SELECT * 
FROM Aluno a, SituacaoMatricula sm, MatriculaPeriodo mp
WHERE
    a.situacao_id = sm.id
    AND sm.descricao = 'Matriculado'
    AND a.id = mp.aluno_id
    AND mp.ano_letivo__ano = 2020
    AND mp.periodo_letivo = 2
	AND NOT( a.ano_letivo__ano = '2020' AND a.periodo_letivo = '2')
    /* Descomentar para desnivelados ao final 2020.1
       AND (a.id IN (SELECT aluno_id FROM GBAT_AlunoPeriodoDesnivelamento niv 
                     WHERE periodo_ref = 20201 )
	        OR a.id NOT IN (SELECT aluno_id FROM GBAT_AlunoPeriodoNivelamento niv 
                            WHERE periodo_ref = 20201 ))
	*/
	/* Descomentar para nivelados ao final 2020.1
      AND a.id IN (SELECT aluno_id FROM GBAT_AlunoPeriodoNivelamento niv 
                   WHERE periodo_ref = 20201 )
	*/;