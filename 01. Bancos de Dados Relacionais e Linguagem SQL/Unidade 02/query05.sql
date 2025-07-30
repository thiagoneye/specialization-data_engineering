
SELECT num_matricula, nom_empregado, cod_depto, nom_depto
    FROM empregado e
    LEFT JOIN departamento d ON d.cod_depto = e.cod_depto;



SELECT num_matricula, nom_empregado, cod_depto, nom_depto
    FROM empregado e
    RIGHT JOIN departamento d ON d.cod_depto = e.cod_depto;



SELECT num_matricula, nom_empregado, cod_depto, nom_depto
    FROM empregado e
    RIGHT JOIN departamento d ON d.cod_depto = e.cod_depto
    WHERE d.cod_depto IS NULL;



SELECT nom_depto, nom_local
    FROM departamento d
    INNER JOIN departamento_local dl ON d.cod_depto = dl.cod_depto;



SELECT nom_depto, nom_local
    FROM departamento d
    LEFT OUTER JOIN departamento_local dl ON d.cod_depto = dl.cod_depto;

