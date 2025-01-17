-- 
--  Top-N largest segments
-- 
--  @tested on: 10g
--


SELECT * FROM
(
	SELECT
		OWNER,
		SEGMENT_NAME,
		SEGMENT_TYPE,
		TABLESPACE_NAME,
		BYTES/1024/1024 "SIZE_MiB"
	FROM DBA_SEGMENTS ORDER BY BYTES DESC
	
) WHERE ROWNUM <= &n;
