CREATE OR REPLACE VIEW v_department_salaries
AS
    SELECT e.department_id, d.department_name, SUM (e.salary) AS total_salary
      FROM employee e JOIN department d ON d.department_id = e.department_id
  GROUP BY e.department_id, d.department_name;
/
