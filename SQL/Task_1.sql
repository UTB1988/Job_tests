-- MS SQL SERVER

/* --- --- Подготовка / Preperation --- --- */
	
	/* --- Таблица / Table - 1 - #salepersons --- */
		IF OBJECT_ID('tempdb.dbo.#salepersons', 'U') IS NOT null
		DROP TABLE #salepersons;
		
		CREATE TABLE #salepersons (
			saleperson_id BIGINT IDENTITY(1, 1)
			, name VARCHAR(256) NOT null
			, age TINYINT NOT null);
		
		INSERT INTO #salepersons VALUES
			('Bob',	 34),
			('Nick', 57),
			('Ken',	 41),
			('Joe',	 28);
	
	/* --- Таблица / Table - 2 - #orders --- */
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

/* --- --- Задание / Task --- --- */
	
	-- Используя Таблицы 1 и 2, вывести в отчёт имена продавцов и общую сумму заказов,
	-- у которых общая сумма заказов больше 500
	
	SELECT t1.name, SUM(t2.order_amount) AS "order_amount"
	FROM #salepersons t1
	INNER JOIN #orders t2 ON t1.saleperson_id = t2.saleperson_id
	GROUP BY t1.name
	HAVING SUM(t2.order_amount) > 500;

/* --- --- Удалить временные таблицы / Delete temporary tables --- --- */
	
	IF OBJECT_ID('tempdb.dbo.#salepersons', 'U') IS NOT null
	DROP TABLE #salepersons;
	
	IF OBJECT_ID('tempdb.dbo.#orders', 'U') IS NOT null
	DROP TABLE #orders;