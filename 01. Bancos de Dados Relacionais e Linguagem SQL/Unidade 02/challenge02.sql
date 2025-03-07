/*
Neste desafio voc� vai utilizar o SQL Management Studio para fazer algumas consultas juntando dados de tabelas diferentes.
Acesse o banco de dados bd_empresa e construa consultas SQL conforme solicitado em cada item:
*/

USE bd_empresa;

SP_HELP;

SP_HELP alocacao;
SP_HELP departamento;
SP_HELP departamento_local;
SP_HELP dependente;
SP_HELP empregado;
SP_HELP projeto;

-- Consulta 01. Liste o n�mero de matr�cula e nome dos empregados e nome e parentesco de todos os dependentes.

SELECT e.nom_empregado AS 'Funcion�rio', e.num_matricula AS 'Matr�cula', d.nom_dependente AS 'Dependente', d.dsc_parentesco AS 'Parentesco'
	FROM empregado e
		JOIN dependente d
		ON e.num_matricula = d.num_matricula;

-- Consulta 02. Liste nome dos departamentos com n�mero de matr�cula e nome de todos os funcion�rios.
-- Ordene o resultado por departamento e nome do empregado.

SELECT d.nom_depto AS 'Departamento', e.nom_empregado AS 'Funcion�rio', e.num_matricula AS 'Matr�cula'
	FROM departamento d
		JOIN empregado e
		ON d.cod_depto = e.cod_depto
			ORDER BY d.nom_depto, e.nom_empregado;

-- Consulta 03. Para cada departamento um dos funcion�rios tem a fun��o de ger�ncia. Liste nome dos departamentos com n�mero de matr�cula e nome do gerente respons�vel.



-- Consulta 04. Liste o n�mero de matr�cula e nome dos supervisores e n�mero de matr�cula e nome dos funcion�rios sob sua supervis�o. Ordene os supervisores e empregados em ordem alfab�tica.

-- Consulta 05. Liste os funcion�rios dos projetos de BH com o total de horas alocado.  Exibir nome e local do projeto, n�mero de matr�cula e nome do empregado e o total de horas alocado.