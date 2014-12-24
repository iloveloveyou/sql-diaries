--
--  Datafiles
--  Tested on:


SELECT (cpu_count / hyperthread_ratio) AS PhysicalCPUs, 
cpu_count AS logicalCPUs 
FROM sys.dm_os_sys_info