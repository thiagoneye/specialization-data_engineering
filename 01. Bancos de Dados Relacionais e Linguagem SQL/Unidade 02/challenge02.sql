/*
Neste desafio você vai utilizar o SQL Management Studio para fazer algumas consultas juntando dados de tabelas diferentes.
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

-- Consulta 01. Liste o número de matrícula e nome dos empregados e nome e parentesco de todos os dependentes.

SELECT e.nom_empregado AS 'Funcionário', e.num_matricula AS 'Matrícula', d.nom_dependente AS 'Dependente', d.dsc_parentesco AS 'Parentesco'
	FROM empregado e
		JOIN dependente d
		ON e.num_matricula = d.num_matricula;

-- Consulta 02. Liste nome dos departamentos com número de matrícula e nome de todos os funcionários.
-- Ordene o resultado por departamento e nome do empregado.

SELECT d.nom_depto AS 'Departamento', e.nom_empregado AS 'Funcionário', e.num_matricula AS 'Matrícula'
	FROM departamento d
		JOIN empregado e
		ON d.cod_depto = e.cod_depto
			ORDER BY d.nom_depto, e.nom_empregado;

-- Consulta 03. Para cada departamento um dos funcionários tem a função de gerência. Liste nome dos departamentos com número de matrícula e nome do gerente responsável.



-- Consulta 04. Liste o número de matrícula e nome dos supervisores e número de matrícula e nome dos funcionários sob sua supervisão. Ordene os supervisores e empregados em ordem alfabética.

-- Consulta 05. Liste os funcionários dos projetos de BH com o total de horas alocado.  Exibir nome e local do projeto, número de matrícula e nome do empregado e o total de horas alocado.