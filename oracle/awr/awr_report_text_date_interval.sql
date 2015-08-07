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

    SELECT snap_id INTO l_bid FROM (
        SELECT snap_id FROM sys.dba_hist_snapshot
        WHERE
            dbid = l_dbid
            AND instance_number = l_inst_num
            AND begin_interval_time > GREATEST(startup_time, l_b_date)
        ORDER BY begin_interval_time ASC
    ) WHERE rownum <= 1;
  
    SELECT snap_id INTO l_eid FROM (
        SELECT snap_id FROM sys.dba_hist_snapshot
        WHERE
            dbid = l_dbid
            AND instance_number = l_inst_num
            AND startup_time < begin_interval_time AND end_interval_time > l_e_date
        ORDER by snap_id DESC
    ) WHERE rownum <= 1;

    FOR c IN (
        SELECT t.output
            FROM TABLE(DBMS_WORKLOAD_REPOSITORY.AWR_REPORT_TEXT(l_dbid, l_inst_num, l_bid, l_eid, l_options)) t
    )
    LOOP
        PIPE ROW(awrrpt_text_type(c.output));
    END LOOP;
END;
/
