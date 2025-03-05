/*
Neste desafio voc� vai utilizar o SQL Management Studio para fazer algumas consultas utilizando possibilidades de filtros e ordena��o de dados.
Acesse o banco de dados bd_filmes e construa consultas SQL conforme solicitado em cada item.
*/

USE bd_filmes;

SP_HELP;

SP_HELP filmes;
SP_HELP filmes_genero;
SP_HELP generos;


-- Consulta 01. Liste os filmes que est�o sem link de foto considerando tamb�m os registros sem dados.

SELECT *
	FROM filmes
		WHERE dsc_link_foto IS NULL;



-- Consulta 02. Liste nome e data de lan�amento dos filmes que contenham a palavra 'Bela'.

SELECT dsc_filme, dat_lancamento
	FROM filmes
		WHERE dsc_filme LIKE '%Bela%';



-- Consulta 03. Liste apenas os nomes dos filmes que contenham a palavra 'Bela'  retirando os itens duplicados.

SELECT DISTINCT dsc_filme
	FROM filmes
		WHERE dsc_filme LIKE '%Bela%';



-- Consulta 04. Liste a descri��o e a quantidade de votos dos filmes que tiveram mais de 1000 votos, ordenar pela quantidade de votos em ordem decrescente.

SELECT dsc_filme, qtd_votos
	FROM filmes
		WHERE qtd_votos > 1000
			ORDER BY qtd_votos DESC;



-- Consulta 05. Liste os filmes da s�rie '007' com quantidade de votos acima de 3000 ou nota m�dia acima de 65.

SELECT dsc_filme, qtd_votos, num_nota_media
	FROM filmes
		WHERE dsc_filme LIKE '%007%'
			AND (qtd_votos > 3000 OR num_nota_media > 65);



-- Consulta 06. Liste nome e o �ndice de popularidade dos 5 filmes da s�rie '007' com maior popularidade.

SELECT TOP 5 dsc_filme, num_popularidade
	FROM filmes
		WHERE dsc_filme LIKE '%007%'
			ORDER BY num_popularidade DESC;