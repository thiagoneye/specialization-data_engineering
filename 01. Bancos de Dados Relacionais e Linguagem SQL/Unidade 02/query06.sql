
SELECT nom_empregado AS Nome, nom_cidade + '-' + sig_uf AS nom_cidade
    FROM empregado;



SELECT 'x' + (' ' + nom_depto + ' ') + 'x' AS com_espacos,
    'x' + RTRIM(' ' + nom_depto + ' ') + 'x' AS com_rtrim,
    'x' + LTRIM(' ' + nom_depto + ' ') + 'x' AS com_ltrim,
    'x' + TRIM(' ' + nom_depto + ' ') + 'x' AS com_trim
        FROM departamento
            WHERE nom_depto = 'Compras';



SELECT nom_depto,
    UPPER(nom_depto) AS upper_name,
    LOWER(nom_depto) AS lower_name
        FROM departamento;









