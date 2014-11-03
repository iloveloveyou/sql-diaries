--
--   Total, used and free space of tablespaces
--
--   @tested on: 10g
--


SELECT   d.tablespace_name,
         ROUND(SUM(d.BYTES)/4294967296, 2)                           GB_total,
         ROUND(SUM(NVL(f.BYTES, 0))/4294967296, 2)                   GB_free,
         ROUND((SUM(d.BYTES) - SUM(NVL(f.BYTES, 0)))/4294967296, 2)  GB_used
    FROM dba_data_files d JOIN dba_free_space f
      ON d.tablespace_name = f.tablespace_name
GROUP BY d.tablespace_name, d.file_id
ORDER BY d.tablespace_name;