--
--  Datafiles
--  Tested on:

USE [master]
GO

SELECT 
  DB_NAME([database_id]) [database_name]
, [file_id]
, [type_desc] [file_type]
, [name] [logical_name]
, [physical_name]
FROM sys.[master_files]
WHERE [database_id] IN (DB_ID('<DB_NAME>'))
ORDER BY [type], DB_NAME([database_id]);