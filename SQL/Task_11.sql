-- MS SQL Server

/*==================================================================================================================================================*/
/* --- --- Подготовка исходных данных / Preperation of source data --- --- */
/*==================================================================================================================================================*/
	
	/* --- ##receipts --- */

		-- Type – это тип чека:
		-- - V  – чек продажи
		-- - PO – товарный чек

		IF OBJECT_ID('tempdb.dbo.##receipts', 'U') IS NOT null
		DROP TABLE ##receipts;

		CREATE TABLE ##receipts (
			  chek SMALLINT
			, date DATE
			, sum MONEY
			, shop SMALLINT
			, type VARCHAR(3));

		INSERT INTO ##receipts VALUES
			(351, CONVERT(DATE, '17.03.2019', 104), 5990,   100, 'V'),
			(46,  CONVERT(DATE, '19.03.2019', 104), 49990,  135, 'V'),
			(25,  CONVERT(DATE, '18.03.2019', 104), 310190, 35,  'V'),
			(8,	  CONVERT(DATE, '17.03.2019', 104), 67990,  46,  'PO'),
			(83,  CONVERT(DATE, '23.02.2019', 104), 76590,  762, 'V'),
			(141, CONVERT(DATE, '20.03.2019', 104), 59900,  700, 'V'),
			(333, CONVERT(DATE, '23.03.2019', 104), 31900,  100, 'V'),
			(546, CONVERT(DATE, '27.01.2019', 104), 56390,  46,  'PO'),
			(351, CONVERT(DATE, '17.03.2019', 104), 5990,   25,  'V'),
			(46,  CONVERT(DATE, '18.03.2019', 104), 49990,  46,  'V'),
			(25,  CONVERT(DATE, '18.03.2019', 104), 310190, 46,  'V'),
			(8,   CONVERT(DATE, '20.03.2019', 104), 67990,  100, 'V'),
			(83,  CONVERT(DATE, '20.03.2019', 104), 76590,  100, 'V'),
			(141, CONVERT(DATE, '20.03.2019', 104), 59900,  46,  'V'),
			(333, CONVERT(DATE, '17.03.2019', 104), 31900,  25,  'V'),
			(546, CONVERT(DATE, '23.03.2019', 104), 56390,  100, 'V');

/*==================================================================================================================================================*/
/* --- --- Задание / Task --- --- */
/*==================================================================================================================================================*/

	-- Посчитайте сумму продаж каждого магазина по дням.
	
	SELECT
		  shop
		, date
		, SUM(sum) AS "sum"
	FROM ##receipts
	GROUP BY date, shop
	ORDER BY shop ASC, date ASC;

/*==================================================================================================================================================*/
/* --- --- Удалить временные таблицы / Delete temporary tables --- --- */
/*==================================================================================================================================================*/

	IF OBJECT_ID('tempdb.dbo.##receipts', 'U') IS NOT null DROP TABLE ##receipts;