-- 
-- Own user sessions on the database
-- 
-- Tested on: 10g, 11g
--
SELECT SYS_CONTEXT('USERENV','SESSION_USER') FROM dual;
