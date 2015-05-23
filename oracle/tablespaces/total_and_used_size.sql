--
-- Query to get total, used and free usage of tablesapces
--
-- @tested on: 10g
--
--


SELECT
       NVL(b.tablespace_name, NVL(a.tablespace_name, 'UNKNOWN'))  tablespace_name,
       kbytes_alloc                                               total,
       kbytes_alloc - NVL(kbytes_free, 0)                         used,
       NVL(kbytes_free, 0)                                        free,
       ((kbytes_alloc - NVL(kbytes_free, 0))
                             / kbytes_alloc) * 100                pct_used,
       NVL(largest, 0)                                            largest

  FROM
      (SELECT SUM(bytes) / 1024                               kbytes_free,
              MAX(bytes) / 1024                               largest,
                                                              tablespace_name
        FROM  sys.dba_free_space
     GROUP BY tablespace_name) a
  
  LEFT JOIN
      (SELECT SUM(bytes) / 1024                               kbytes_alloc,
                                                              tablespace_name
        FROM sys.dba_data_files
     GROUP BY tablespace_name) b

    ON a.tablespace_name = b.tablespace_name

ORDER BY 1
;
