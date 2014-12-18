--
--  Increase sequence up to the max+1 of a reference field
--
--  tested on: 10g
--


declare
	l_MaxVal  pls_integer;
	l_Currval pls_integer default - 1;
begin
	select max(id)+1
		into l_MaxVal
		from &table;
	while l_Currval < l_Maxval
	loop
		select &sequence.nextval
			into l_Currval
			from dual;
	end loop;
end;
/