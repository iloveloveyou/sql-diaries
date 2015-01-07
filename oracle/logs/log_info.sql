--
--  Info about redo logs
--


-- http://dba.stackexchange.com/questions/21805/how-do-i-find-out-the-redo-log-file-max-size-in-oracle-11r2

-- Show Redo Logs info
set linesize 300
column REDOLOG_FILE_NAME format a50
SELECT
    a.GROUP#,
    a.THREAD#,
    a.SEQUENCE#,
    a.ARCHIVED,
    a.STATUS,
    b.MEMBER    AS REDOLOG_FILE_NAME,
    (a.BYTES/1024/1024) AS SIZE_MB
FROM v$log a
JOIN v$logfile b ON a.Group#=b.Group# 
ORDER BY a.GROUP# ASC;