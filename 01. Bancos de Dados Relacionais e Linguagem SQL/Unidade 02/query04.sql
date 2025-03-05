
SELECT nom_empregado, num_matricula_supervisor
	FROM empregado
		WHERE num_matricula_supervisor IS NOT NULL;



SELECT nom_dependente, dsc_parentesco
	FROM dependente
		-- WHERE dsc_parentesco LIKE 'filh%';
		-- WHERE dsc_parentesco LIKE '%o';
		WHERE nom_dependente LIKE '%a %';



SELECT nom_empregado, val_salario
	FROM empregado
		-- WHERE nom_empregado IN ('José da Silva', 'João Oliveira');
		WHERE val_salario IN (2000, 2500, 2800, 1700);



SELECT nom_empregado, val_salario
	FROM empregado
		WHERE val_salario >= 2000 AND val_salario <= 3000;



SELECT nom_empregado, val_salario, sex_empregado
	FROM empregado
		ORDER BY sex_empregado, val_salario DESC;



SELECT TOP 5 nom_empregado, val_salario
	FROM empregado
		ORDER BY val_salario DESC;



SELECT DISTINCT TOP 3 nom_local, nom_projeto
	FROM projeto;