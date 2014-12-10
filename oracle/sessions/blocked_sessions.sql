--
--  Blocked sessions
--
--  Tested on: 10g
--


select 
	blocking_session,
	sid, 
	serial#, 
	wait_class,
	seconds_in_wait
from 
	v$session
where 
	blocking_session is not NULL
order by 
	blocking_session;
