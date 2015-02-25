--
-- Prevision of usage
--
-- @Test om: 10g, 11g
--

set line 180
col "%Used" format a10
col "%Proy_1s" format a10
col "%Proy_1m" format a10
col tsname format a25
select tsname,
round(tablespace_size*t2.block_size/
1024/1024/1024,2) GB_TSize,
round(tablespace_usedsize*t2.block_size/1024/1024/1024,2) GB_TUsed,
round((tablespace_size-tablespace_usedsize)*t2.block_size/1024/1024/1024,2) GB_TFree,
round(val1*t2.block_size/1024/1024/1024,2) "Dif_1h",
round(val2*t2.block_size/1024/1024/1024,2) "Dif_1d",
round(val3*t2.block_size/1024/1024/1024,2) "Dif_1s",
round(val4*t2.block_size/1024/1024/1024,2) "Dif_1m",
round((tablespace_usedsize/tablespace_size)*100)||'%' "%Used",
round(((tablespace_usedsize+val3)/tablespace_size)*100)||'%' "%Proy_1s",
round(((tablespace_usedsize+val4)/tablespace_size)*100)||'%' "%Proy_1m",
case when ((((tablespace_usedsize+val3)/tablespace_size)*100 < 80) and
          (((tablespace_usedsize+val4)/tablespace_size)*100 < 80)) then 'NORMAL'
     when ((((tablespace_usedsize+val3)/tablespace_size)*100 between 80 and 90) 
             or
          (((tablespace_usedsize+val4)/tablespace_size)*100 between 80 and 90)) 
    then 'WARNING'
else 'CRITICAL' end STATUS
from
(select distinct tsname,
rtime,
tablespace_size,
tablespace_usedsize,
tablespace_usedsize-first_value(tablespace_usedsize) 
over (partition by tablespace_id order by rtime rows 1 preceding) val1,
tablespace_usedsize-first_value(tablespace_usedsize) 
over (partition by tablespace_id order by rtime rows 24 preceding) val2,
tablespace_usedsize-first_value(tablespace_usedsize) 
over (partition by tablespace_id order by rtime rows 168 preceding) val3,
tablespace_usedsize-first_value(tablespace_usedsize) 
over (partition by tablespace_id order by rtime rows 720 preceding) val4
from (select t1.tablespace_size, t1.snap_id, t1.rtime,t1.tablespace_id, 
             t1.tablespace_usedsize-nvl(t3.space,0) tablespace_usedsize
     from dba_hist_tbspc_space_usage t1,
          dba_hist_tablespace_stat t2,
          (select ts_name,sum(space) space 
           from recyclebin group by ts_name) t3
     where t1.tablespace_id = t2.ts#
      and  t1.snap_id = t2.snap_id
      and  t2.tsname = t3.ts_name (+)) t1,
dba_hist_tablespace_stat t2
where t1.tablespace_id = t2.ts#
and t1.snap_id = t2.snap_id) t1,
dba_tablespaces t2
where t1.tsname = t2.tablespace_name
and rtime = (select max(rtime) from dba_hist_tbspc_space_usage)
and t2.contents = 'PERMANENT'
order by Status asc, "Dif_1h" desc,"Dif_1d" desc,"Dif_1s" desc, "Dif_1m" desc;


-- example output

TSNAME                      GB_TSIZE   GB_TUSED   GB_TFREE     Dif_1h     Dif_1d     Dif_1s     Dif_1m %Used      %Proy_1s   %Proy_1m   STATUS
------------------------- ---------- ---------- ---------- ---------- ---------- ---------- ---------- ---------- ---------- ---------- --------
XXXXXXXXXXXX                    2.98        2.8        .18          0          0          0          0 94%        94%        94%        CRITICAL
SYSTEM                          2.93       1.04       1.89          0        .01        .01        .02 36%        36%        36%        NORMAL
YYYYYYYYYYYY                      .2        .03        .16          0          0          0          0 16%        16%        16%        NORMAL
USERS                              0          0          0          0          0          0          0 26%        26%        26%        NORMAL

----
