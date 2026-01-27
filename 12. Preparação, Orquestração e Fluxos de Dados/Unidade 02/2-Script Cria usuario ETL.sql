/*****===LOGIN COM USUARIO SA ================*/

	---CRIA USER ETL
		USE [master];
		CREATE LOGIN [etl] WITH PASSWORD=N'Pofd@123', DEFAULT_DATABASE=[master], DEFAULT_LANGUAGE=[Português (Brasil)], CHECK_EXPIRATION=OFF, CHECK_POLICY=ON;
	    --Remover a visibilidade de outros bancos de dados
		DENY VIEW ANY DATABASE TO etl;
	 	ALTER SERVER ROLE [dbcreator] ADD MEMBER [etl];	

	   
	
