--
--Extend and Add datafile in order to extend tablespace
--
-- @tested on: 10g, 11g
--

--List datafiles
set line 200
set pagesize 100
col file_name format a80
col GB format 999
col tablespace_name format a30
select file_name, autoextensible, bytes/1024/1024 as MB, BLOCKS, tablespace_name from dba_data_files where 
tablespace_name like 'SYSTEM'
/


--Extend datafile
alter database datafile '+DATA_DECCXT_DG/deccxt/datafile/sysaux.266.790160995' resize 3000M
/

--Add datafile
alter tablespace SYSTEM add datafile '+DATA' size 400M;
/

