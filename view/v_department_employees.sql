CREATE OR REPLACE VIEW v_department_employees
AS
    SELECT d.department_id
          ,d.department_name
          ,d.location_id
          ,e.employee_id
          ,e.first_name
          ,e.last_name
          ,j.job_title
          ,e.manager_id
          ,m.first_name || ' ' || m.last_name   AS manager_name
          ,e.date_hired
          ,e.salary
      FROM department d
           JOIN employee e ON e.department_id = d.department_id
           JOIN job_title j ON j.job_title_id = e.job_title_id
           LEFT JOIN employee m
             ON     m.employee_id = e.employee_id
                AND m.manager_id IS NOT NULL
  ORDER BY d.department_id, e.employee_id;
/
