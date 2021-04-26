SELECT periodo_cursou_real, COUNT(*), AVG(i.ira_calc)
FROM 
    (SELECT DISTINCT h.aluno_id, h.quando_cursou, h.periodo_cursou_real
     FROM 
        GBAT_AlunoHistorico h
     WHERE
         h.quando_cursou >= h.ingresso     
    ) cursadas,
    (SELECT h.aluno_id, MAX(quando_cursou) max_cursou, 
            COUNT(DISTINCT h.periodo_cursou) max_per
     FROM 
         GBAT_AlunoHistorico h
     WHERE 
         h.quando_cursou >= h.ingresso
         AND situacao_atual = 'Evasão'
     GROUP BY h.aluno_id
     HAVING MAX(quando_cursou) <= 20192
     ) evad,
    Aluno a,
    CursoCampus cc,
    GBAT_AlunoPeriodoIRA i
WHERE
    1 = 1 
    AND cursadas.aluno_id = evad.aluno_id    
    AND evad.aluno_id = a.id
    AND a.curso_campus_id = cc.id
    AND cursadas.aluno_id = i.aluno_id
    
    AND cc.naoAnalisar = FALSE
    AND cursadas.quando_cursou = i.periodo

    AND evad.max_per = COLOCAR_AQUI_O_NUM_PERIODOS (1, 2, 3, ... 12)
	
GROUP BY periodo_cursou_real
ORDER BY periodo_cursou_real
