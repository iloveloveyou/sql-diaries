--
--  Constraints
--


SELECT uc.constraint_name
  CHR(10)
   '('
  ucc1.TABLE_NAME
  '.'
  ucc1.column_name
  ')' constraint_source ,
  'REFERENCES'
  CHR(10)
   '('
  ucc2.TABLE_NAME
  '.'
  ucc2.column_name
  ')' references_column
FROM user_constraints uc ,
  user_cons_columns ucc1 ,
  user_cons_columns ucc2
WHERE uc.constraint_name = ucc1.constraint_name
AND uc.r_constraint_name = ucc2.constraint_name
AND ucc1.POSITION        = ucc2.POSITION
--AND uc.constraint_name   = 'constraint_name'
--and ucc2.TABLE_NAME = 'table_name'
--and ucc2.column_name = 'column_name'
ORDER BY ucc1.TABLE_NAME ,
  uc.constraint_name;