
SELECT *
	FROM empregado
		WHERE val_salario >= 2000
			AND sex_empregado = 'M'
			OR sig_uf = 'MG';



SELECT *
	FROM empregado
		WHERE val_salario >= 2000
			AND (sex_empregado = 'M' OR sig_uf = 'MG');