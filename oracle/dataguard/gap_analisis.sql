--
--   Average REDO log applied for GAP analysis
--
--   @tested on: 10g
--



set line 200
set PAGESIZE 9999
col day format a15
SELECT A.*, Round(A.Count#*B.AVG#/1024/1024) Daily_Avg_Mb FROM
(SELECT To_Char(First_Time,'YYYY-MM-DD') DAY,
Count(1) Count#, Min(RECID) Min#, Max(RECID) Max# FROM gv$log_history GROUP BY To_Char(First_Time,'YYYY-MM-DD')
ORDER BY 1 DESC) A,(SELECT Avg(BYTES) AVG#, Count(1) Count#, Max(BYTES) Max_Bytes, 
Min(BYTES) Min_Bytes FROM gv$log ) B;

---
Sample output:

DAY                 COUNT#       MIN#       MAX# DAILY_AVG_MB
--------------- ---------- ---------- ---------- ------------
2015-08-13             524      33153      33286       131000
2015-08-12             632      32995      33157       158000
2015-08-11             600      32845      32999       150000
2015-08-10             540      32710      32849       135000
....

