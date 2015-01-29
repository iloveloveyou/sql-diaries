WITH constraint_tree AS
   (
     SELECT DISTINCT (a.owner || '.' || a.table_name) AS table_name ,
         decode(b.table_name, null, null,(b.owner || '.' || b.table_name)) AS parent_table_name
     FROM (
           select *
           from dba_constraints
           where status='ENABLED' and constraint_type in ('P','R')) a
     LEFT OUTER JOIN (
           select *
           from dba_constraints
           where status='ENABLED' and constraint_type in ('P','R')) b
     ON a.r_constraint_name = b.constraint_name
   )
 SELECT SYS_CONNECT_BY_PATH (table_name, ' >> ') AS path
 FROM constraint_tree
 WHERE LEVEL                            > 1
 AND CONNECT_BY_ISLEAF                  = 1
   START WITH parent_table_name        IS NULL
   CONNECT BY NOCYCLE parent_table_name = PRIOR table_name
 ORDER BY path