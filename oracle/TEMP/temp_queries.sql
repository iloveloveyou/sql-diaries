-- 
-- Queries to list, create and extend TEMPShort description
-- 
-- @tested on: 11g, 10g
--
-- views: V$TEMPSEG_USAGE

-- List temp files
set line 200
col file_name format a80
select file_name, tablespace_name, bytes/1024/1024 as "MBs" from dba_temp_files;