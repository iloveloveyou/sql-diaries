--
-- @tested on: 10g, 11g
--
-- Query to get total, used and free usage of tablesapces
--

column "Tablespace" format a30
column "Used MB"    format 99,999,999
column "Free MB"    format 99,999,999
column "Total MB"   format 99,999,999
col host_name format a20
col instacen_name format a30


select
   fs.tablespace_name                          "Tablespace",
   (df.totalspace - fs.freespace)              "Used MB",
   fs.freespace                                "Free MB",
   df.totalspace                               "Total MB",
   round(100 * (fs.freespace / df.totalspace)) "Pct. Free"
from
   (select
      tablespace_name,
      round(sum(bytes) / 1048576) TotalSpace
   from
      dba_data_files where tablespace_name like 'SYS%'
   group by
      tablespace_name
   ) df,
   (select
      tablespace_name,
      round(sum(bytes) / 1048576) FreeSpace
   from
      dba_free_space where tablespace_name like 'SYS%'
      group by
      tablespace_name
   ) fs
where
   df.tablespace_name = fs.tablespace_name order by "Pct. Free" Desc
/
