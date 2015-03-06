
Active SQL server connections

1
sp_who
sp_who2

2
SELECT 
    DB_NAME(dbid) as DBName, 
    COUNT(dbid) as NumberOfConnections,
    loginame as LoginName
FROM
    sys.sysprocesses
WHERE 
    dbid > 0
GROUP BY 
    dbid, loginame
;



3
SELECT DB_NAME(dbid) as DBName, 
       COUNT(dbid) as NumberOfConnections, 
       loginame as LoginName 
FROM sys.sysprocesses 
WHERE dbid > 0 
GROUP BY dbid, loginame