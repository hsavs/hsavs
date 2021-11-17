--------------------------------------------------------------------------------
--  report of Employees by Department
--------------------------------------------------------------------------------

SET FEEDBACK OFF
SET LINES 100;
SPOOL deptemps.txt
CLEAR BREAK
CLEAR COMPUTE
CLEAR COLUMNS
TTITLE LEFT 'Employees by Department' SKIP 1
BREAK ON department_id
COLUMN DEPARTMENT_ID HEADING 'DEPARTMENT|ID'
COLUMN EMPLOYEE_NAME HEADING 'EMPLOYEE|NAME' FORMAT a30 WRAP;
COLUMN JOB_TITLE HEADING 'JOB|TITLE' FORMAT a15 WRAP;
COLUMN MANAGER_ID HEADING 'MANAGER|ID';
COLUMN DATE_HIRED HEADING 'DATE|HIRED';
COLUMN SALARY  HEADING 'SALARY' FORMAT 999,999;

  SELECT v.department_id
        ,v.first_name || ' ' || v.last_name   AS employee_name
        ,v.job_title
        ,v.manager_id
        ,v.date_hired
        ,v.salary
    FROM v_department_employees v
ORDER BY v.department_id, v.employee_id;

SPOOL OFF;
