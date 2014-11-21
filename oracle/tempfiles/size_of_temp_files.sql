-- 
--  Size of temp files
-- 
--  @tested on: 10g, 11g
--


set line 200
col file_name format a80

select file_name, tablespace_name, bytes/1024/1024 as "MBs" from dba_temp_files;