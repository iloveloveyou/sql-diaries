--
--  Blocked Sessions
--  Tested on:


SELECT *
	FROM sys.sysprocesses
	WHERE blocked > 0
GO