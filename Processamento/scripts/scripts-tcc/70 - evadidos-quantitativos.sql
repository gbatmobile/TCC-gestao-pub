-- Evadidos por per�odo.
-- Ap�s selecionar, diminuir um semestre em cada max_periodo
-- pois a evas�o � registrada um semestre posterior ao abandono.

SELECT 
    mp.max_periodo, 
    COUNT(*) 
FROM 
    Aluno a, SituacaoMatricula sm, 
    (SELECT  aluno_id, 
             MAX(CAST((ano_letivo__ano || periodo_letivo) AS INT)) 
             max_periodo
     FROM  MatriculaPeriodo
     GROUP BY aluno_id) mp
     
WHERE
    a.situacao_id = sm.id
    AND a.id = mp.aluno_id
    AND mp.max_periodo >= 20142
    AND mp.max_periodo <= 20201
    AND sm.descricao IN 
    ('Evas�o')
    /*'Cancelado',
     'Cancelamento Compuls�rio',
     'Cancelamento por Desligamento',
     'Cancelamento por Duplicidade',
     'Evas�o',
     'Jubilado'
     ) */ 
GROUP BY mp.max_periodo
ORDER BY mp.max_periodo;

-- Alunos matriculados por periodo
SELECT 
    CAST((ano_letivo__ano || periodo_letivo) AS INT) periodo, 
    COUNT(*) matriculados
FROM 
     MatriculaPeriodo
WHERE
    AND CAST((ano_letivo__ano || periodo_letivo) AS INT) >= 20141
    AND CAST((ano_letivo__ano || periodo_letivo) AS INT) <= 20192
GROUP BY CAST((ano_letivo__ano || periodo_letivo) AS INT);

-- Quantos cursaram pelo menos uma disciplina por per�odo
SELECT sem_cursado, count(*)
FROM 
    (SELECT  DISTINCT aluno_id, quando_cursou sem_cursado
     FROM 
         GBAT_AlunoHistorico h
     ) 
GROUP BY sem_cursado;

-- Quantos semestres foram cursados antes da evas�o.
-- Primeiro select n�o conta os que se evadiram sem nada cursar (7)
SELECT sem_cursados, count(*)
FROM 
    (SELECT aluno_id, 
			MAX(quando_cursou) max_cursado, 
			COUNT(DISTINCT quando_cursou) sem_cursados
     FROM 
         GBAT_AlunoHistorico h
     WHERE 
         situacao_atual = 'Evas�o'
     GROUP BY aluno_id) 
GROUP BY sem_cursados
UNION
	SELECT 0, 6;

