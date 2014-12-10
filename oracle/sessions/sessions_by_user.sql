--
--  User sessions on the database
--
--  Tested on: 10g, 11g
--


SELECT
	a.spid pid,
	b.sid,
	b.serial#,
	b.machine,
	b.username,
	b.server,
	b.osuser,
	b.program
FROM v$session b, v$process a
WHERE
	b.paddr = a.addr 
	AND TYPE = 'USER'
ORDER BY spid;
