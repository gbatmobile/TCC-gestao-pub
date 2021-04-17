DROP TABLE IF EXISTS GBAT_AlunoPeriodoDesnivelamento;

-- Estabelece se ao FINAL do periodo_ref o aluno esta desnivelado
CREATE TABLE GBAT_AlunoPeriodoDesnivelamento AS
    SELECT p.aluno_id, p.matriz_id, 
        g.ingresso,
        p.periodo_ref, 
		MIN(g.quando_cursar) AS periodo_atras,
        SUM(d.ch_hora_relogio) AS ch_desnivel
--    g.quando_cursar, g.descricao_historico, d.ch_hora_relogio
    FROM 
        (
            SELECT DISTINCT aluno_id, matriz_id, quando_cursou AS periodo_ref
            FROM GBAT_AlunoHistorico
        ) p, 
        GBAT_AlunoGrade g,
        Disciplina d
    WHERE 
        p.aluno_id = g.aluno_id
        AND p.matriz_id = g.matriz_id
        AND g.quando_cursar <= p.periodo_ref
        AND g.disc_id = d.id 
        AND g.disc_id NOT IN 
            (
                SELECT disc_id 
                FROM GBAT_AlunoHistorico h
                WHERE
                    h.aluno_id = p.aluno_id
                    AND h.matriz_id = p.matriz_id					
                    AND h.quando_cursou <= p.periodo_ref
                    AND h.situacao IN ('Aprovado', 'Dispensado')
            )
        -- AND p.aluno_id IN  ( /*623772875341, */ 64748872613 )
    GROUP BY p.aluno_id, p.periodo_ref;
	
-- Insere desnivelamento por falta de optativas
INSERT INTO GBAT_AlunoPeriodoDesnivelamento
    SELECT DISTINCT a.id, a.matriz_id, 
                    h.ingresso, CAST (mp.ano_letivo__ano || mp.periodo_letivo AS INT) periodo_ref, 
					g.max_cursar periodo_atras, 
                    0  ch_desnivel
    FROM Aluno a, GBAT_AlunoHistorico h, MatriculaPeriodo mp,
		 (SELECT aluno_id, MAX(quando_cursar) max_cursar FROM GBAT_AlunoGrade g GROUP BY aluno_id) g
    LEFT JOIN
        GBAT_AlunoPeriodoDesnivelamento desn
    ON     
        a.id = desn.aluno_id 
        AND desn.periodo_ref =  CAST (mp.ano_letivo__ano || mp.periodo_letivo AS INT)
    WHERE a.id = mp.aluno_id
        AND a.id = h.aluno_id
		AND a.id = g.aluno_id 
        AND desn.aluno_id IS NULL
        AND CAST (mp.ano_letivo__ano || mp.periodo_letivo AS INT) > h.limite_curso;

		
CREATE INDEX desn_id_aluno ON GBAT_AlunoPeriodoDesnivelamento (
	aluno_id, matriz_id, periodo_ref 
);
