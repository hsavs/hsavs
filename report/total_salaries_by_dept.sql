--------------------------------------------------------------------------------
--  report of Total Salaries by Department
--------------------------------------------------------------------------------

SET FEEDBACK OFF
SET LINES 100;
SPOOL deptsals.txt
CLEAR BREAK
CLEAR COMPUTE
CLEAR COLUMNS
TTITLE LEFT 'Total Salaries by Department' SKIP 1

  SELECT *
    FROM v_department_salaries v
ORDER BY v.department_id;

SPOOL OFF;
