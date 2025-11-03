-- Consulta 01. Crie uma view com o nome vw_filmes para listar todos os filmes com descrição, gênero e quantidade de votos.

CREATE VIEW vw_filmes
AS 
  SELECT dsc_filme, 
         dsc_genero, 
         qtd_votos
  FROM filmes f
  JOIN filmes_genero fg ON fg.id_filme = f.id_filme
  JOIN generos g ON g.id_genero = fg.id_genero;

-- Consulta 02. Utilize a view criada para listar:

-- a) 3 gêneros mais votados

SELECT dsc_genero, 
       sum(qtd_votos) AS qtd_votos
FROM vw_filmes
GROUP BY dsc_genero
ORDER BY 2 DESC;

-- b) 3 gêneros mais votados entre aqueles com menos de 600 mil votos

SELECT dsc_genero, 
       sum(qtd_votos) AS qtd_votos
FROM vw_filmes
GROUP BY dsc_genero
HAVING sum(qtd_votos) < 600000
ORDER BY 2 DESC;
