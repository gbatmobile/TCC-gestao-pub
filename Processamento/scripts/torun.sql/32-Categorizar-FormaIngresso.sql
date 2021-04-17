ALTER TABLE FormaIngresso 
    ADD COLUMN lista TEXT;
	

UPDATE FormaIngresso  
SET    lista = 'AMPLA'
WHERE  id IN (SELECT id FROM FormaIngresso 
              WHERE descricao IN  (
					'Ampla Concorr�ncia',
					'Sele��o Geral Gradua��o (SISU)',
					'Sele��o Geral Gradua��o Vestibular/ENEM',
					'Processo Seletivo',
					'Sele��o Geral Gradua��o SiSU',
					'Processo Seletivo Simplificado'));

UPDATE FormaIngresso  
SET    lista = 'OUTRA'
WHERE  id IN (SELECT id FROM FormaIngresso 
              WHERE descricao IN  (
					'Interc�mbio',
					'Sele��o Geral T�cnico Subsequente',
					'Conv�nio',
					'Sele��o Diferenciada Gradua��o Vestibular/ENEM',
					'Transfer�ncia de Curso (Interno - mesmo campus)',
					'Sele��o Diferenciada Gradua��o Plataforma Freire',
					'Reingresso',
					'Sele��o Diferenciada Gradua��o SiSU',
					'Convenio',
					'Transfer�ncia Facultativa',
					'Transfer�ncia Intercampi',
					'Reop��o',
					'Transfer�ncia Compuls�ria',
					'Transfer�ncia de Turno',
					'Reabertura de Matr�cula'));					
UPDATE FormaIngresso  
SET    lista = 'L1'
WHERE  id IN (SELECT id FROM FormaIngresso 
              WHERE descricao IN  (
				  'L1 - Renda <= 1,5 / Qualquer Etnia',
				  'L1 - Renda <= 1,5 / Qualquer Etnia (SISU)',
				  'Renda <= 1,5 Qualquer Etnia - (L1)',
				  'Renda <= 1,5 Qualquer Etnia - L1') );

UPDATE FormaIngresso  
SET    lista = 'L2'
WHERE  id IN (SELECT id FROM FormaIngresso 
              WHERE descricao IN  (
					'L2 - Renda <= 1,5 / Autodeclarados PPI', 
					'L2 - Renda <= 1,5 / Autodeclarados PPI (SISU)', 
					'Renda <= 1,5 Autodeclarados PPI - (L2)', 
					'Renda <= 1,5 Autodeclarados PPI - L2', 
					'Renda <= 1,5  Autodeclarados PPI - L2'));

UPDATE FormaIngresso  
SET    lista = 'L3'
WHERE  id IN (SELECT id FROM FormaIngresso 
              WHERE descricao IN  (
					'Qualquer Renda / Qualquer Etnia - (L3)', 
					'Qualquer Renda / Qualquer Etnia - L3', 
					'Qualquer Renda / Qualquer Etnia - L3 (SISU)',
					'L5 - Qualquer Renda / Qualquer Etnia', 
					'L5 - Qualquer Renda / Qualquer Etnia (SISU)' ));	
			  
UPDATE FormaIngresso  
SET    lista = 'L4'
WHERE  id IN (SELECT id FROM FormaIngresso 
              WHERE descricao IN  (
					'Qualquer Renda / Autodeclarados PPI - (L4)', 
					'Qualquer Renda / Autodeclarados PPI - L4', 
					'Qualquer Renda / Autodeclarados PPI - L4 (SISU)',
					'L6 - Qualquer Renda / Autodeclarado PPI', 
					'L6 - Qualquer Renda / Autodeclarado PPI (SISU)'));
					
					
UPDATE FormaIngresso  
SET    lista = 'L9'
WHERE  id IN (SELECT id FROM FormaIngresso 
			  WHERE descricao IN  (				
					'L9 - Renda <= 1,5 / Qualquer Etnia / Deficiente (SISU)', 
					'L9 - Renda <= 1,5 / Qualquer Etnia / Deficiente',
					'Renda <= 1,5 - Pessoas com Defici�ncia (L5)', 
					'Renda <= 1,5 - Pessoas com Defici�ncia - L5 (SISU)'));
				
UPDATE FormaIngresso  
SET    lista = 'L10'
WHERE  id IN (SELECT id FROM FormaIngresso 
              WHERE descricao IN  (
					'Defici�ncia, Renda <= 1,5 Autodeclarados PPI - L6 (SISU)', 
					'L10 - Renda <= 1,5 / Autodeclarados PPI / Deficiente', 
					'L10 - Renda <= 1,5 / Autodeclarados PPI / Deficiente (SISU)'));


UPDATE FormaIngresso  
SET    lista = 'L13'
WHERE  id IN (SELECT id FROM FormaIngresso 
              WHERE descricao IN  (
					'L13 - Qualquer Renda / Qualquer Etnia / Deficiente', 
					'L13 - Qualquer Renda / Qualquer Etnia / Deficiente (SISU)',
					'Defici�ncia, Qualquer Renda / Qualquer Etnia - L7 (SISU)',
					'Defici�ncia, Qualquer Renda / Qualquer Etnia - L7 (SISU)',
					'Pessoas com Defici�ncia (L6)')); 					
					
UPDATE FormaIngresso  
SET    lista = 'L14'
WHERE  id IN (SELECT id FROM FormaIngresso 
              WHERE descricao IN  (
					'L14 - Qualquer Renda / Autodeclarado PPI / Deficiente', 
					'L14 - Qualquer Renda / Autodeclarado PPI / Deficiente (SISU)',
					'Defici�ncia, Qualquer Renda / Autodeclarados PPI - L8 (SISU)'));
					
UPDATE FormaIngresso  					
SET    lista = 'L15'
WHERE  id IN (SELECT id FROM FormaIngresso 
              WHERE descricao IN  (
					'L15 - Deficiente / Qualquer Escola de Origem', 
					'L15 - Deficiente / Qualquer Escola de Origem (SISU)'));
										