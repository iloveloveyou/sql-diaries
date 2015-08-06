--
--  A wrapper around dbms_workload_repository.awr_report_text()
--  which supports dates
--


CREATE OR REPLACE FUNCTION SYS.AWR_REPORT_TEXT_DATE_INTERVAL(
   l_dbid       IN    NUMBER,
   l_inst_num   IN    NUMBER,
   l_b_date     IN    TIMESTAMP,
   l_e_date     IN    TIMESTAMP,
   l_options    IN    NUMBER DEFAULT 0)
 RETURN awrrpt_text_type_table PIPELINED
IS
  l_bid   NUMBER;
  l_eid   NUMBER;
BEGIN

    select snap_id INTO l_bid from (
    select snap_id from sys.DBA_HIST_SNAPSHOT where 
    dbid = l_dbid and instance_number = l_inst_num
    and begin_interval_time > greatest(startup_time, l_b_date)
    order by begin_interval_time asc
  ) where rownum <= 1;
  
    select snap_id into l_eid from (
    select snap_id from sys.wrm$_snapshot where
    dbid = l_dbid and instance_number = l_inst_num
    and startup_time < begin_interval_time and end_interval_time > l_e_date
    order by snap_id desc
  ) where rownum <= 1;


    for c in (select t.output
                from table (dbms_workload_repository.awr_report_text (l_dbid, l_inst_num, l_bid, l_eid, l_options)) t)
    loop
      pipe row (awrrpt_text_type (c.output));
    end loop;
end;
/
