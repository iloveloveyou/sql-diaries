-
-
- @tested on: ora11g, ora10g
-
-- list tempfiles

set line 200
col file_name format a90
select file_name, tablespace_name, bytes/1024/1024 as MBs from dba_temp_files;

-- Add tempfile
alter tablespace temp add tempfile '+DATA_IGC01P_DG04/igc01p03/tempfile/temp11' size 60000M;

-- Resize an existing tempfile
ALTER DATABASE TEMPFILE '+DATA4D/bkgcf1p/tempfile/temp3.dbf' resize 30000M;

