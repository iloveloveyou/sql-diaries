--
--  Statistics staleness
--


USE [<database_name>]
GO

SELECT name AS index_name,
STATS_DATE(OBJECT_ID, index_id) AS StatsUpdated
FROM sys.indexes
--WHERE OBJECT_ID = OBJECT_ID('<table_name>')
GO