
--- Este é um exemplo de comentário

SELECT *
	FROM empregado
		WHERE sex_empregado = 'F'
			OR sex_empregado = 'M';

SELECT *
	FROM empregado
		/*WHERE sex_empregado = 'F'
			OR sex_empregado = 'M'*/
		WHERE sex_empregado = 'F';

-- Trocar de Banco de Dados
USE bd_filmes;

-- Acessar Tabela de Outro Banco de Dados
SELECT * FROM bd_filmes..filmes;
SELECT * FROM bd_filmes.dbo.filmes;

-- Lista as Tabelas do Banco de Dados
SP_HELP;

-- Lista os Detalhes de uma Tabela
SP_HELP filmes;