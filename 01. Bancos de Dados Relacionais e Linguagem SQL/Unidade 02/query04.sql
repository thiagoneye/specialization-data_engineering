
USE bd_empresa;

SELECT *
	FROM departamento;

SELECT *
	FROM departamento_local;



SELECT *
	FROM departamento d
		JOIN departamento_local dl
			ON d.cod_depto = dl.cod_depto;