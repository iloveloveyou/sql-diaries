--
--  Roles and privileges granted to a user
--
--  Tested on: 11g
--

SELECT lpad(' ', 2*LEVEL) || granted_role "Roles and privileges" FROM
    (
        SELECT NULL grantee, username granted_role FROM dba_users WHERE username = upper('user')
        UNION
        SELECT grantee, granted_role FROM dba_role_privs
        UNION
        SELECT grantee, privilege FROM dba_sys_privs
    )
START WITH grantee IS NULL CONNECT BY grantee = PRIOR granted_role
/
