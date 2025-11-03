-- Consulta 01. Listar os filmes que são do gênero Guerra ou do Gênero Ação.

-- Opção 1
SELECT dsc_filme
FROM filmes f
JOIN filmes_genero fg ON fg.id_filme = f.id_filme
JOIN generos g ON g.id_genero = fg.id_genero
WHERE g.dsc_genero = 'Guerra'
UNION
SELECT dsc_filme
FROM filmes f
JOIN filmes_genero fg ON fg.id_filme = f.id_filme
JOIN generos g ON g.id_genero = fg.id_genero
WHERE g.dsc_genero = 'Ação';

-- Opção 2
SELECT DISTINCT dsc_filme
FROM filmes f
JOIN filmes_genero fg ON fg.id_filme = f.id_filme
JOIN generos g ON g.id_genero = fg.id_genero
WHERE g.dsc_genero IN ('Guerra', 'Ação');

-- Consulta 02. Listar os filmes que são do gênero Guerra e também do Gênero Ação

-- Opção 1
SELECT dsc_filme
FROM filmes f
JOIN filmes_genero fg ON fg.id_filme = f.id_filme
JOIN generos g ON g.id_genero = fg.id_genero
WHERE g.dsc_genero = 'Guerra'
INTERSECT
SELECT dsc_filme
FROM filmes f
JOIN filmes_genero fg ON fg.id_filme = f.id_filme
JOIN generos g ON g.id_genero = fg.id_genero
WHERE g.dsc_genero = 'Ação';

-- Opção 2
SELECT dsc_filme
FROM filmes f
JOIN filmes_genero fg ON fg.id_filme = f.id_filme
JOIN generos g ON g.id_genero = fg.id_genero
WHERE g.dsc_genero = 'Guerra'
AND dsc_filme IN 
     (SELECT dsc_filme
     FROM filmes f
     JOIN filmes_genero fg ON fg.id_filme = f.id_filme
     JOIN generos g ON g.id_genero = fg.id_genero
     WHERE g.dsc_genero = 'Ação');

-- Consulta 03. Listar os filmes que são do gênero Guerra e não são do Gênero Ação

-- Opção 1
SELECT dsc_filme
FROM filmes f
JOIN filmes_genero fg ON fg.id_filme = f.id_filme
JOIN generos g ON g.id_genero = fg.id_genero
WHERE g.dsc_genero = 'Guerra'
EXCEPT
SELECT dsc_filme
FROM filmes f
JOIN filmes_genero fg ON fg.id_filme = f.id_filme
JOIN generos g ON g.id_genero = fg.id_genero
WHERE g.dsc_genero = 'Ação';

-- Opção 2
SELECT dsc_filme
FROM filmes f
JOIN filmes_genero fg ON fg.id_filme = f.id_filme
JOIN generos g ON g.id_genero = fg.id_genero
WHERE g.dsc_genero = 'Guerra'
AND dsc_filme NOT IN 
     (SELECT dsc_filme
     FROM filmes f
     JOIN filmes_genero fg ON fg.id_filme = f.id_filme
     JOIN generos g ON g.id_genero = fg.id_genero
     WHERE g.dsc_genero = 'Ação');
