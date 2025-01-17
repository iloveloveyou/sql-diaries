--
--   Dimension of DB by tablespace
--
--   @tested on: 10g, 11g
--


set pagesize 2000
column dummy noprint
column aplicacio     format a22      heading "Aplicaci"
column tablespace    format a30      heading "Tablespace"
column total         format 9999999999 heading "Mb.Total"
column ocupat        format 9999999999 heading "Mb.Ocupats"
column lliure        format 9999999999 heading "Mb.Lliures"
column porc_lliure   format 999D99   heading "%Lliure"
break on report
compute sum of total  on report
compute sum of ocupat on report
compute sum of lliure on report


select c.tablespace_name                                                 tablespace,
       round(nvl(total,0)/1024/1024/1024,0)                                   total,
       round(nvl(total,0)/1024/1024/1024,0)-round(nvl(lliure,0)/1024/1024/1024,0)  ocupat,
       round(nvl(lliure,0)/1024/1024/1024,0)                                  lliure,
       round((nvl(lliure,0))*100/(nvl(total,0)),2)                       porc_lliure
from (select sum(bytes) total,tablespace_name from dba_data_files
      group by tablespace_name) a,
     (select sum(bytes) lliure,tablespace_name from dba_free_space 
      group by tablespace_name) b,
     dba_tablespaces c
where c.tablespace_name = b.tablespace_name(+)
  and c.tablespace_name = a.tablespace_name(+)
  and total!=0
--  and round((nvl(lliure,0))*100/(nvl(total,0)),2)<15
order by c.tablespace_name;
