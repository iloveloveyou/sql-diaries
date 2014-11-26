--
-- @tested on: 10g, 11g
--
-- Make a report grouping and summing bytes from data_files
--
--
set line 200
Set pagesize 200
col tablespace_name a10
col ALLOCATED_BYTES format 999999999999
col file_name format a60
col free_bytes format 999999999999
BREAK ON tablespace_name SKIP 2
COMPUTE SUM OF allocated_bytes, free_bytes ON tablespace_name
SELECT a.tablespace_name, a.file_name, a.bytes allocated_bytes,
b.free_bytes
FROM dba_data_files a,
(SELECT file_id, SUM(bytes) free_bytes
FROM dba_free_space b GROUP BY file_id) b
WHERE a.file_id=b.file_id
ORDER BY a.tablespace_name;

