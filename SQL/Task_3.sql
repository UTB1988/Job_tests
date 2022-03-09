-- MS SQL SERVER

/* --- --- Подготовка / Preperation --- --- */
	
	/* --- Таблица / Table - 1 - #dataset --- */
		IF OBJECT_ID('tempdb.dbo.#dataset', 'U') IS NOT null
		DROP TABLE #dataset;
		
		CREATE TABLE #dataset (
			key_field VARCHAR(34)
			, field_name VARCHAR(34)
			, field_value VARCHAR(34));
		
		INSERT INTO #dataset VALUES
			('id_001', 'Тур1', 'Абс'),
			('id_002', 'Тур1', 'Ффф'),
			('id_003', 'Тур1', 'Йыс'),
			('id_001', 'Тур2', '1'),
			('id_003', 'Тур2', '2'),
			('id_002', 'Тур3', '-9');

/* --- --- Задание / Task --- --- */
	
	-- Используя таблицу 1, создать и заполнить данными результирующую таблицу.
		
	/* --- Вариация решения / Solution variation - 1 --- */
		SELECT
			DISTINCT(t.key_field)
			, (SELECT t1.field_value FROM #dataset t1 WHERE t1.key_field = t.key_field AND t1.field_name = 'Тур1') AS "Тур1"
			, (SELECT t2.field_value FROM #dataset t2 WHERE t2.key_field = t.key_field AND t2.field_name = 'Тур2') AS "Тур2"
			, (SELECT t3.field_value FROM #dataset t3 WHERE t3.key_field = t.key_field AND t3.field_name = 'Тур3') AS "Тур3"
		FROM #dataset t;
	
	/* --- Вариация решения / Solution variation - 2 --- */
		SELECT DISTINCT
			t.key_field
			, t1.field_value AS "Тур1"
			, t2.field_value AS "Тур2"
			, t3.field_value AS "Тур3"
		FROM #dataset t
		LEFT JOIN #dataset t1 ON t1.key_field = t.key_field AND t1.field_name = 'Тур1'
		LEFT JOIN #dataset t2 ON t2.key_field = t.key_field AND t2.field_name = 'Тур2'
		LEFT JOIN #dataset t3 ON t3.key_field = t.key_field AND t3.field_name = 'Тур3';

/* --- --- Удалить временные таблицы / Delete temporary tables --- --- */
	
	IF OBJECT_ID('tempdb.dbo.#dataset', 'U') IS NOT null
	DROP TABLE #dataset;