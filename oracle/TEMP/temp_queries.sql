-- 
-- Queries to list, create and extend TEMPShort description
-- 
-- @tested on: 11g, 10g
--
-- views: V$TEMPSEG_USAGE

-- List temp files
set line 200
col file_name format a80
select file_name, tablespace_name, bytes/1024/1024 as "MBs" from dba_temp_files


--- extend tempfiles
ALTER DATABASE TEMPFILE '<+DATA4D/bkgcf1p/tempfile/temp3.dbf>' resize 30000M;

-- create  tempfile
alter tablespace temp add tempfile '<+DATA_IGC01P_DG04/igc01p03/tempfile/temp11>' size 60000M;


