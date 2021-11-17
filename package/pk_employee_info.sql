CREATE OR REPLACE PACKAGE pk_employee_info
AS
  /*******************************************************************************
  ** Package to manage employee information
  ** Created 13/11/2021 Helen Savigar
  *******************************************************************************/

  -- Receive job title, look up job title ID
  FUNCTION f_get_job_title_id (p_job_title IN job_title.job_title%TYPE)
    RETURN NUMBER;

  -- Receive location, look up location ID
  FUNCTION f_get_location_id (p_location IN location.location%TYPE)
    RETURN NUMBER;

  -- Receive department name, look up department ID
  FUNCTION f_get_department_id (p_department IN department.department_name%TYPE)
    RETURN NUMBER;

  -- Receive employee ID, return salary
  FUNCTION f_get_salary (p_employee_id IN employee.employee_id%TYPE)
    RETURN NUMBER;

  -- Receive employee ID, check employee ID exists
  FUNCTION f_employee_found (p_employee_id IN employee.employee_id%TYPE)
    RETURN NUMBER;

  -- Procedure called to insert employees
  -- Receives all table column values, having received them from a front end screen where IDs have been looked up
  PROCEDURE pr_insert_employee (p_employee_id     IN     employee.employee_id%TYPE
                               ,p_first_name      IN     employee.first_name%TYPE
                               ,p_last_name       IN     employee.last_name%TYPE
                               ,p_job_title_id    IN     employee.job_title_id%TYPE
                               ,p_manager_id      IN     employee.manager_id%TYPE
                               ,p_date_hired      IN     employee.date_hired%TYPE
                               ,p_salary          IN     employee.salary%TYPE
                               ,p_department_id   IN     employee.department_id%TYPE
                               ,p_response           OUT VARCHAR2);

  -- Procedure called to insert employees
  -- Looks up foreign key IDs
  PROCEDURE pr_insert_employee (p_employee_id       IN     employee.employee_id%TYPE
                               ,p_employee_name     IN     VARCHAR2
                               ,p_job_title         IN     job_title.job_title%TYPE
                               ,p_manager_id        IN     employee.manager_id%TYPE
                               ,p_date_hired        IN     employee.date_hired%TYPE
                               ,p_salary            IN     employee.salary%TYPE
                               ,p_department_name   IN     department.department_name%TYPE DEFAULT NULL
                               ,p_department_id     IN     department.department_id%TYPE DEFAULT NULL
                               ,p_response             OUT VARCHAR2);

  -- Procedure called to enhance employee's salries by a given percent
  -- Receives employee_id and enhancement percentage
  PROCEDURE pr_enhance_salary (p_employee_id IN employee.employee_id%TYPE, p_enhance_percent IN NUMBER, p_response OUT VARCHAR2);

  -- Procedure called to transfer an employee to a given department
  -- Receives employee_id and either department name or department ID
  PROCEDURE pr_transfer_dept (p_employee_id       IN     employee.employee_id%TYPE
                             ,p_department_name   IN     department.department_name%TYPE DEFAULT NULL
                             ,p_department_id     IN     department.department_id%TYPE DEFAULT NULL
                             ,p_response             OUT VARCHAR2);
END;
/
