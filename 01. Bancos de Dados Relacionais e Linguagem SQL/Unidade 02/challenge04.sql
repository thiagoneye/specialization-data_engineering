-- Consulta 01. Liste o número de matrícula e nome dos empregados e seus dependentes, exibindo a coluna 'dependentes' com nome do dependente e o parentesco entre parêntesis.

SELECT e.num_matricula, 
       e.nom_empregado, 
       d.nom_dependente + ' (' + RTRIM(d.dsc_parentesco) +')' AS dependentes
FROM empregado e
JOIN dependente d ON d.num_matricula = e.num_matricula;

-- Consulta 02. Liste os departamentos, com seu respectivos gerentes e a data de início da gerência no formato dia-mês-ano.

SELECT nom_empregado, 
       d.nom_depto, 
       convert(varchar(10),d.dat_inicio_gerente, 105) inicio_gerencia
FROM empregado e 
JOIN departamento d ON e.num_matricula = d.num_matricula_gerente;

-- Consulta 03. Liste os empregados e horas de alocação em cada projeto no formato abaixo:
--    Nome: Rodrigo Moreira Projeto: Migração para SQL 2005 - 10 horas
-- Considere todos os funcionários, incluindo os que não tem projeto.

SELECT 'Nome: '+ nom_empregado + 
       ' Projeto: '+ isnull(nom_projeto, '-')+' - ' + 
       convert (varchar(2), isnull(num_horas,0)) + ' horas' AS Alocacao
FROM empregado e
LEFT JOIN alocacao a ON a.num_matricula = e.num_matricula
LEFT JOIN projeto p ON p.cod_projeto = a.cod_projeto
