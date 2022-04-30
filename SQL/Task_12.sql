-- MS SQL Server

/*==================================================================================================================================================*/
/* --- --- Подготовка исходных данных / Preperation of source data --- --- */
/*==================================================================================================================================================*/
	
	/* --- ##promos --- */

		IF OBJECT_ID('tempdb.dbo.##promos', 'U') IS NOT null
		DROP TABLE ##promos;

		CREATE TABLE ##promos (
			  promo_name VARCHAR(10)
			, insert_date DATE
			, amount_material TINYINT
			, update_date DATE
			, shop SMALLINT);

		INSERT INTO ##promos VALUES
			('10001_PA', CONVERT(DATE, '17.03.2019', 104), 10, CONVERT(DATE, '17.03.2019', 104), 100),
			('10002_PA', CONVERT(DATE, '17.03.2019', 104), 15, CONVERT(DATE, '17.03.2019', 104), 135),
			('10003_PI', CONVERT(DATE, '17.03.2019', 104), 51, CONVERT(DATE, '18.03.2019', 104), 35),
			('10004_PI', CONVERT(DATE, '18.03.2019', 104), 37, CONVERT(DATE, '18.03.2019', 104), 46),
			('10005_PA', CONVERT(DATE, '18.03.2019', 104), 4,  CONVERT(DATE, '19.03.2019', 104), 762),
			('10006_PI', CONVERT(DATE, '23.03.2019', 104), 9,  CONVERT(DATE, '23.03.2019', 104), 700),
			('10007_PI', CONVERT(DATE, '23.03.2019', 104), 23, CONVERT(DATE, '23.03.2019', 104), 100),
			('10008_PA', CONVERT(DATE, '23.03.2019', 104), 23, CONVERT(DATE, '24.03.2019', 104), 46);

/*==================================================================================================================================================*/
/* --- --- Задание / Task --- --- */
/*==================================================================================================================================================*/

	-- Посчитайте сколько было заведено акций с типом "PA" по датам исключая 18.03.2019

	SELECT
		  insert_date
		, count(*)
	FROM ##promos
	WHERE 1=1
		AND promo_name LIKE '%PA'
		AND NOT insert_date = CONVERT(DATE, '18.03.2019', 104)
	GROUP BY insert_date;

/*==================================================================================================================================================*/
/* --- --- Удалить временные таблицы / Delete temporary tables --- --- */
/*==================================================================================================================================================*/

	IF OBJECT_ID('tempdb.dbo.##receipts', 'U') IS NOT null DROP TABLE ##promos;