CREATE OR REPLACE PACKAGE BODY pk_employee_info
AS
  /*******************************************************************************
  ** Package to manage employee information
  ** Created 13/11/2021 Helen Savigar
  *******************************************************************************/

  -- Receive job title, look up job title ID
  FUNCTION f_get_job_title_id (p_job_title IN job_title.job_title%TYPE)
    RETURN NUMBER
  IS
    l_job_title_id   NUMBER;
  BEGIN
    SELECT t.job_title_id
      INTO l_job_title_id
      FROM job_title t
     WHERE UPPER (t.job_title) = UPPER (p_job_title);

    RETURN l_job_title_id;
  EXCEPTION
    WHEN NO_DATA_FOUND
    THEN
      RETURN NULL;
  END;

  -- Receive location, look up location ID
  FUNCTION f_get_location_id (p_location IN location.location%TYPE)
    RETURN NUMBER
  IS
    l_location_id   NUMBER;
  BEGIN
    SELECT l.location_id
      INTO l_location_id
      FROM location l
     WHERE UPPER (l.location) = UPPER (p_location);

    RETURN l_location_id;
  EXCEPTION
    WHEN NO_DATA_FOUND
    THEN
      RETURN NULL;
  END;

  -- Receive department name, look up department ID
  FUNCTION f_get_department_id (p_department IN department.department_name%TYPE)
    RETURN NUMBER
  IS
    l_department_id   NUMBER;
  BEGIN
    SELECT d.department_id
      INTO l_department_id
      FROM department d
     WHERE UPPER (d.department_name) = UPPER (p_department);

    RETURN l_department_id;
  EXCEPTION
    WHEN NO_DATA_FOUND
    THEN
      RETURN NULL;
  END;

  -- Receive employee ID, return salary
  FUNCTION f_get_salary (p_employee_id IN employee.employee_id%TYPE)
    RETURN NUMBER
  IS
    l_salary   NUMBER;
  BEGIN
    SELECT e.salary
      INTO l_salary
      FROM employee e
     WHERE e.employee_id = p_employee_id;

    RETURN l_salary;
  EXCEPTION
    WHEN NO_DATA_FOUND
    THEN
      RETURN NULL;
  END;

  -- Receive employee ID, check employee ID exists
  FUNCTION f_employee_found (p_employee_id IN employee.employee_id%TYPE)
    RETURN NUMBER
  IS
    l_found   NUMBER := 0;
  BEGIN
    SELECT COUNT (*)
      INTO l_found
      FROM employee e
     WHERE e.employee_id = p_employee_id;

    RETURN l_found;
  EXCEPTION
    WHEN OTHERS
    THEN
      RETURN 0;
  END;

  -- Procedure called to insert employees
  -- Receives all table column values, where IDs have already been looked up

  PROCEDURE pr_insert_employee (p_employee_id     IN     employee.employee_id%TYPE
                               ,p_first_name      IN     employee.first_name%TYPE
                               ,p_last_name       IN     employee.last_name%TYPE
                               ,p_job_title_id    IN     employee.job_title_id%TYPE
                               ,p_manager_id      IN     employee.manager_id%TYPE
                               ,p_date_hired      IN     employee.date_hired%TYPE
                               ,p_salary          IN     employee.salary%TYPE
                               ,p_department_id   IN     employee.department_id%TYPE
                               ,p_response           OUT VARCHAR2)
  IS
  BEGIN
    INSERT INTO employee (employee_id
                                  ,first_name
                                  ,last_name
                                  ,job_title_id
                                  ,manager_id
                                  ,date_hired
                                  ,salary
                                  ,department_id)
         VALUES (p_employee_id
                ,p_first_name
                ,p_last_name
                ,p_job_title_id
                ,p_manager_id
                ,p_date_hired
                ,p_salary
                ,p_department_id);

    p_response := 'OK';
  EXCEPTION
    WHEN DUP_VAL_ON_INDEX
    THEN
      p_response := 'Unable to create Employee Record. Employee ID already exists';
    WHEN OTHERS
    THEN
      p_response := SUBSTR ('Unable to create Employee Record. ' || SQLERRM, 1, 100);
  END;

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
                               ,p_response             OUT VARCHAR2)
  IS
    l_job_title_id    job_title.job_title_id%TYPE;
    l_department_id   department.department_id%TYPE;
    l_response        VARCHAR2 (100);
  BEGIN
    l_department_id := NVL (p_department_id, f_get_department_id (p_department_name)); -- if department_id not supplied, look it up based on department name
    l_job_title_id := f_get_job_title_id (p_job_title);                            -- look up job title id based on the Job title provided

    CASE
      WHEN p_employee_id IS NULL
      THEN
        l_response := 'Unable to create Employee Record. Employee ID is null';
      WHEN p_employee_name IS NULL
      THEN
        l_response := 'Unable to create Employee Record. Employee name is null';
      WHEN length(p_employee_name) > 50
      THEN
        l_response := 'Unable to create Employee Record. Employee name max length is 50';
      WHEN p_job_title IS NULL
      THEN
        l_response := 'Unable to create Employee Record. Job title is null';
      WHEN p_date_hired IS NULL
      THEN
        l_response := 'Unable to create Employee Record. Date hired is null';
      WHEN p_salary IS NULL
      THEN
        l_response := 'Unable to create Employee Record. Salary is null';
      WHEN l_department_id IS NULL
      THEN
        l_response := 'Unable to create Employee Record. Department not found';
      WHEN l_job_title_id IS NULL
      THEN
        l_response := 'Unable to create Employee Record. Job title not found';
      ELSE                                                                --  we have all the values we need, proceed with record creation
        pr_insert_employee (p_employee_id     => p_employee_id
                           ,p_first_name      => SUBSTR (p_employee_name, 1, INSTR (p_employee_name, ' ') - 1) -- split employee name by occurrence of space
                           ,p_last_name       => SUBSTR (p_employee_name, INSTR (p_employee_name, ' ', -1) + 1)
                           ,p_job_title_id    => l_job_title_id
                           ,p_manager_id      => p_manager_id
                           ,p_date_hired      => p_date_hired
                           ,p_salary          => p_salary
                           ,p_department_id   => l_department_id
                           ,p_response        => l_response);
    END CASE;

    p_response := l_response;
  END;

  -- Procedure called to enhance employee's salries by a given percent
  -- Receives employee_id and enhancement percentage

  PROCEDURE pr_enhance_salary (p_employee_id IN employee.employee_id%TYPE, p_enhance_percent IN NUMBER, p_response OUT VARCHAR2)
  IS
  BEGIN
    CASE
      WHEN f_employee_found (p_employee_id) = 1
      THEN
        UPDATE employee e
           SET e.salary = e.salary + (e.salary * (p_enhance_percent / 100))
         WHERE e.employee_id = p_employee_id;

        p_response := 'OK';
      ELSE
        p_response := 'Unable to enhance Salary. Employee ID not found';
    END CASE;
  EXCEPTION
    WHEN OTHERS
    THEN
      p_response := SUBSTR ('Unable to enhance Salary. ' || SQLERRM, 1, 100);
  END;

  -- Procedure called to transfer an employee to a given department
  -- Receives employee_id and either department name or department ID

  PROCEDURE pr_transfer_dept (p_employee_id       IN     employee.employee_id%TYPE
                             ,p_department_name   IN     department.department_name%TYPE DEFAULT NULL
                             ,p_department_id     IN     department.department_id%TYPE DEFAULT NULL
                             ,p_response             OUT VARCHAR2)
  IS
    l_department_id   department.department_id%TYPE;
  BEGIN
    l_department_id := NVL (p_department_id, f_get_department_id (p_department_name)); -- if department_id not supplied, look it up based on department name

    CASE
      WHEN f_employee_found (p_employee_id) != 1
      THEN
        p_response := 'Unable to transfer Employee. Employee ID not found';
      WHEN l_department_id IS NULL
      THEN
        p_response := 'Unable to transfer Employee. Department not found';
      ELSE
        UPDATE employee e
           SET e.department_id = l_department_id
         WHERE e.employee_id = p_employee_id;

        p_response := 'OK';
    END CASE;
  EXCEPTION
    WHEN OTHERS
    THEN
      p_response := SUBSTR ('Unable to enhance Salary. ' || SQLERRM, 1, 100);
  END;
END;
/
