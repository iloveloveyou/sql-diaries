--
--  Emulate GNU basename
--  See also http://www.pythian.com/blog/gnu-basename-in-plsql/
--


select SUBSTR('&full_path', INSTR('&full_path', '&separator', -1) + 1) from dual;
