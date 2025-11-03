-- Consulta 01. Listar o nome do empregado e o nome do respectivo departamento para todos os empregados que não estão alocados em projetos, resolver com:

-- a) NOT EXISTS
SELECT nom_empregado, 
       nom_depto
FROM empregado e
JOIN departamento d ON d.cod_depto = e.cod_depto
WHERE NOT EXISTS (SELECT 1 
FROM alocacao a 
WHERE a.num_matricula = e.num_matricula);

-- b) NOT IN
SELECT nom_empregado, 
       nom_depto
FROM empregado e
JOIN departamento d ON d.cod_depto = e.cod_depto
WHERE e.num_matricula NOT IN 
                    (SELECT num_matricula FROM alocacao a);

-- c) LEFT JOIN
SELECT nom_empregado, 
       nom_depto
FROM empregado e
JOIN departamento d ON d.cod_depto = e.cod_depto
LEFT JOIN alocacao a ON a.num_matricula = e.num_matricula 
WHERE a.num_matricula is null;

-- Consulta 02. Listar o empregado, o número de horas e o projeto cuja alocação de horas no projeto é maior do que a média de alocação do referido projeto.

SELECT a.cod_projeto,
       nom_empregado,  
       nom_projeto, 
       media, 
       SUM(num_horas) AS qtd_horas
FROM empregado e
JOIN alocacao a ON a.num_matricula = e.num_matricula
JOIN projeto p ON p.cod_projeto = a.cod_projeto
JOIN (SELECT cod_projeto, AVG (num_horas) media
FROM alocacao a 
GROUP BY cod_projeto) a_media ON a.cod_projeto = a_media.cod_projeto
GROUP BY a.cod_projeto, nom_empregado, nom_projeto, media
HAVING SUM(num_horas) > media;
