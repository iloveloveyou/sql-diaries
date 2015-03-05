--
-- Dimensin of all database and its growth
--
-- @Tested on: 10g, 11g
--

set line 200
set heading on
set linesize 5500

SELECT TO_CHAR (sp.begin_interval_time,'DD-MM-YYYY') days,
ts.tsname as TBS_NAME , max(round((tsu.tablespace_size* dt.block_size )/(1024*1024),2) ) cur_size_MB, 
max(round((tsu.tablespace_usedsize* dt.block_size )/(1024*1024),2)) usedsize_MB FROM DBA_HIST_TBSPC_SPACE_USAGE tsu,
DBA_HIST_TABLESPACE_STAT ts, DBA_HIST_SNAPSHOT sp, DBA_TABLESPACES dt
WHERE tsu.tablespace_id= ts.ts#
AND tsu.snap_id = sp.snap_id
AND ts.tsname = dt.tablespace_name
AND ts.tsname NOT IN ('SYSAUX','SYSTEM')
GROUP BY TO_CHAR (sp.begin_interval_time,'DD-MM-YYYY'), ts.tsname
ORDER BY ts.tsname, days;
