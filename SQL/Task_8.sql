-- MS SQL Server

/*==================================================================================================================================================*/
/* --- --- Подготовка исходных данных / Preperation of source data --- --- */
/*==================================================================================================================================================*/

	/* --- #clients --- */
		
		IF OBJECT_ID('tempdb.dbo.#clients', 'U') IS NOT null
		DROP TABLE #clients;

		CREATE TABLE #clients (
			  id TINYINT IDENTITY(1, 1)
			, FIO VARCHAR(64));

		INSERT INTO #clients VALUES
			('Иванов Иван Иванович'),
			('Сергеев Сергей Сергеевич'),
			('Сидоров Сидор Сидорович');

	/* --- #orders --- */
		
		IF OBJECT_ID('tempdb.dbo.#orders', 'U') IS NOT null
		DROP TABLE #orders;

		CREATE TABLE #orders (
			  id TINYINT IDENTITY(1, 1)
			, client_id TINYINT
			, total_sum MONEY);

		INSERT INTO #orders VALUES
			(1, 5000.00), (1, 2000.00), (1, 255000.00), (1, 30000.00), (1, 45000.00), (1, 99000.00),
			(2, 10000.00), (2, 11000.00), (2, 12000.00), (2, 6000.00), (2, 7000.00), (2, 1000.00),
			(3, 25000.00), (3, 80000.00), (3, 74000.00), (3, 64000.00), (3, 33000.00), (3, 72000.00);

/*==================================================================================================================================================*/
/* --- --- Задание / Task --- --- */
/*==================================================================================================================================================*/

	-- Вывести ФИО с максимальной суммой заказа

	/* --- SUBQUERY --- */
	
		/* TOP 1 WITH TIES */
		SELECT TOP 1 WITH TIES
			  (SELECT c.FIO FROM #clients c WHERE c.id = o.client_id) AS "ФИО"
			, o.total_sum
		FROM #orders o
		ORDER BY o.total_sum DESC;
	
		/* WHERE */
		SELECT
			  (SELECT c.FIO FROM #clients c WHERE c.id = o.client_id) AS "ФИО"
			, o.total_sum
		FROM #orders o
		WHERE o.total_sum = (SELECT MAX(total_sum) FROM #orders);

	/* --- JOIN --- */

		/* TOP 1 WITH TIES */
		SELECT TOP 1 WITH TIES
			  c.FIO
			, o.total_sum
		FROM #orders o
			LEFT JOIN #clients c ON o.client_id = c.id
		ORDER BY o.total_sum DESC;

		/* WHERE */
		SELECT
			  c.FIO
			, o.total_sum
		FROM #orders o
			LEFT JOIN #clients c ON o.client_id = c.id
		WHERE o.total_sum = (SELECT MAX(total_sum) FROM #orders);

/*==================================================================================================================================================*/
/* --- --- Удалить временные таблицы / Delete temporary tables --- --- */
/*==================================================================================================================================================*/

	IF OBJECT_ID('tempdb.dbo.#clients', 'U') IS NOT null DROP TABLE #clients;
	IF OBJECT_ID('tempdb.dbo.#orders', 'U') IS NOT null DROP TABLE #orders;