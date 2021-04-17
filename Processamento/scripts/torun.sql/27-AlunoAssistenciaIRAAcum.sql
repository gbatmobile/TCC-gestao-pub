DROP TABLE IF EXISTS GBAT_AlunoAssistenciaIRAAcum;

CREATE TABLE GBAT_AlunoAssistenciaIRAAcum AS
    SELECT  a.*, 
            ira1.periodo periodo_anterior, 
            ira1.ira_calc ira_anterior,
            ira2.ira_calc ira_final,
            CAST (ira2.ira_calc AS INT) - 
            CAST (ira1.ira_calc AS INT) AS ira_dif
    FROM 
        GBAT_AlunoIntervaloAssistencia a,
        GBAT_AlunoPeriodoIRAAcum ira1,
        GBAT_AlunoPeriodoIRAAcum ira2
    WHERE
        1 = 1
		AND a.periodo_fim >= a.periodo_inicio
        AND a.aluno_id = ira1.aluno_id
        AND a.aluno_id = ira2.aluno_id
        AND CASE 
                WHEN a.periodo_inicio % 2 = 1 THEN ((a.periodo_inicio / 10) - 1) * 10 + 2
                ELSE a.periodo_inicio - 1
            END = ira1.periodo
        AND a.periodo_fim = ira2.periodo;
