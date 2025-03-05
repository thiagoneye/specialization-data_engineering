-- Question 01

SELECT id_filme, dsc_filme, qtd_votos, num_nota_media
	FROM filmes
	WHERE dsc_filme = 'Matrix';

-- Question 02

SELECT id_filme, dsc_filme, qtd_votos, num_nota_media
	FROM filmes
	WHERE qtd_votos < 1000
		AND num_nota_media > 80
		AND num_nota_media < 90;

-- Question 03

SELECT * FROM empregado;

SELECT * FROM departamento;

SELECT * FROM projeto;

-- Question 04

SELECT * FROM projeto WHERE nom_local = 'BH';

-- Question 05

SELECT * FROM empregado WHERE sex_empregado = 'M' AND sig_uf = 'MG';