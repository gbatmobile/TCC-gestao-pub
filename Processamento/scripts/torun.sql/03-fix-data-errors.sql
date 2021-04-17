INSERT INTO SituacaoDisciplina 
SELECT * FROM SituacaoMatriculaPeriodo
WHERE id IN ( SELECT DISTINCT(n.situacao_id) FROM Notas n 
              WHERE n.situacao_id NOT IN (SELECT id FROM SituacaoDisciplina));
			  
UPDATE Programa 
SET tipo = 'Outro'
WHERE tipo IS NULL;
			  