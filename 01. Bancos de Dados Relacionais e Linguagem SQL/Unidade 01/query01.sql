SELECT * FROM filmes;

SELECT * FROM generos;

SELECT dsc_genero FROM generos;

SELECT dsc_filme, qtd_votos
	FROM filmes
		WHERE qtd_votos > 10000;

SELECT *
	FROM filmes
		WHERE num_nota_media > 83 AND num_nota_media < 85;