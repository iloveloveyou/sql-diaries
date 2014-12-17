--
--  Last Run Queries by Session
--  Tested on:


SELECT conn.session_id, sson.host_name, sson.login_name, 
	sqltxt.text, sson.login_time,  sson.status
FROM sys.dm_exec_connections conn
INNER JOIN sys.dm_exec_sessions sson 
ON conn.session_id = sson.session_id
CROSS APPLY sys.dm_exec_sql_text(most_recent_sql_handle) AS sqltxt
ORDER BY conn.session_id