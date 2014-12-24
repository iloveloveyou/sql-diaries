--
--  Net Connections by Session
--  Tested on:


select
	c.session_id, s.spid, s.net_library, c.client_net_address, c.client_tcp_port, c.local_net_address, c.local_tcp_port, s.hostname, s.loginame, s.program_name, c.encrypt_option, s.login_time
from sys.sysprocesses AS S
INNER JOIN sys.dm_exec_connections as C
on s.spid = c.session_id
order by s.spid