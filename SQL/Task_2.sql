-- MS SQL SERVER

/*==================================================================================================================================================*/
/* --- --- Подготовка исходных данных / Preperation of source data --- --- */
/*==================================================================================================================================================*/
	
	/* --- #orders --- */
		
		IF OBJECT_ID('tempdb.dbo.#orders', 'U') IS NOT null
		DROP TABLE #orders;
		
		CREATE TABLE #orders (
			  order_number BIGINT IDENTITY(1, 1)
			, order_date DATE NOT null
			, customer_id BIGINT NOT null
			, saleperson_id BIGINT NOT null
			, order_amount INT NOT null);
		
		INSERT INTO #orders VALUES
			('2019-03-10', 5105, 1, 100),
			('2018-12-15', 2166, 2, 125),
			('2019-03-29', 5105, 4, 352),
			('2018-04-18', 2598, 2, 150),
			('2019-01-15', 2166, 1, 253),
			('2018-11-19', 1235, 2, 120),
			('2018-02-28', 5848, 4, 158),
			('2019-03-15', 6844, 1, 250),
			('2019-03-14', 6844, 1, 200),
			('2019-03-15', 6844, 1, 200);

/*==================================================================================================================================================*/
/* --- --- Задание / Task --- --- */
/*==================================================================================================================================================*/
	
	--	Используя таблицу #orders,
	--	вывести в отчёт номера клиентов с суммой и датой последнего заказа.
	
	SELECT
		  t1.customer_id
		, SUM(t1.order_amount) AS "order_amount"
		, t1.order_date
	FROM #orders t1
	WHERE t1.order_date = (SELECT MAX(t2.order_date) FROM #orders t2 WHERE t2.customer_id = t1.customer_id)
	GROUP BY t1.customer_id, t1.order_date
	ORDER BY t1.customer_id;

/*==================================================================================================================================================*/
/* --- --- Удалить временные таблицы / Delete temporary tables --- --- */
/*==================================================================================================================================================*/
	
	IF OBJECT_ID('tempdb.dbo.#orders', 'U') IS NOT null DROP TABLE #orders;