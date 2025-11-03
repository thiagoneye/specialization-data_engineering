-- Consulta 01. Listar a quantidade de empregados com idade média por supervisor.

SELECT sup.nom_empregado, 
       count(*) AS qtd_empregado, 
       AVG( YEAR(getdate()) - YEAR(e.dat_nascimento)) AS idade_media
FROM empregado e
JOIN empregado sup on sup.num_matricula = e.num_matricula_supervisor
GROUP BY sup.nom_empregado;

-- Consulta 02. Listar nome dos departamentos com nomes dos empregados e a quantidade de dependentes, se houver.

SELECT nom_depto, 
       nom_empregado, 
       COUNT (dp.num_matricula) AS qtd_dependente
FROM departamento d
JOIN empregado e on e.cod_depto = d.cod_depto
LEFT JOIN dependente dp on dp.num_matricula = e.num_matricula
GROUP BY  nom_depto, nom_empregado
ORDER BY nom_depto, nom_empregado;

-- Consulta 03. Listar somente os locais e a quantidade de projetos onde houver mais de 2 projetos alocados.

SELECT nom_local, 
       COUNT(*) qtd_projeto
FROM projeto p
GROUP BY nom_local
HAVING COUNT(*) > 2;
