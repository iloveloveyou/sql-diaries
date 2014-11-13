-- 
-- will show "spaced used total" for a specific Oracle table, essentiall computing the Oracle table size over time:
--
-- @tested on: 11g, 10g

col c1 format a15 heading 'snapshot|date'
col c2 format a25 heading 'table|name'
col c3 format 999,999,999 heading 'space|used|total'
 
select
   to_char(begin_interval_time,'yy/mm/dd hh24:mm')     c1,
   object_name      c2,
   space_used_total c3
from
   dba_hist_seg_stat       s,
   dba_hist_seg_stat_obj   o,
   dba_hist_snapshot       sn
where
   o.owner = 'IGIRECI1'
and
   s.obj# = o.obj#
and
   sn.snap_id = s.snap_id
and
   object_name like 'mTABLE NAME>'
order by
   begin_interval_time;
   
