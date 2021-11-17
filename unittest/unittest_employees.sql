--------------------------------------------------------------------------------
--  unit test f_get_job_title_id
--------------------------------------------------------------------------------

DECLARE
  PROCEDURE test_f_get_job_title_id (p_in IN job_title.job_title%TYPE, p_expected_result IN NUMBER)
  IS
    lv_result   NUMBER;
  BEGIN
    lv_result := pk_employee_info.f_get_job_title_id (p_in);

    IF NVL (lv_result, -1) = NVL (p_expected_result, -1)
    THEN
      DBMS_OUTPUT.put_line ('test_f_get_job_title_id PASS - ' || p_in);
    ELSE
      DBMS_OUTPUT.put_line ('test_f_get_job_title_id FAIL - ' || p_in);
      DBMS_OUTPUT.put_line ('Expected Result: ' || p_expected_result);
      DBMS_OUTPUT.put_line ('Result: ' || lv_result);
    END IF;
  END;
BEGIN
  -- expected fail conditions
  test_f_get_job_title_id ('Something wrong', NULL);
  test_f_get_job_title_id (NULL, NULL);
  -- expected success conditions
  test_f_get_job_title_id ('CEO', 1);
  test_f_get_job_title_id ('Manager', 2);
  test_f_get_job_title_id ('salesperson', 3);
  test_f_get_job_title_id ('ENGINEER', 4);
END;

--------------------------------------------------------------------------------
--  unit test f_get_location_id
--------------------------------------------------------------------------------

DECLARE
  PROCEDURE test_f_get_location_id (p_in IN location.location%TYPE, p_expected_result IN NUMBER)
  IS
    lv_result   NUMBER;
  BEGIN
    lv_result := pk_employee_info.f_get_location_id (p_in);

    IF NVL (lv_result, -1) = NVL (p_expected_result, -1)
    THEN
      DBMS_OUTPUT.put_line ('test_f_get_location_id PASS - ' || p_in);
    ELSE
      DBMS_OUTPUT.put_line ('test_f_get_location_id FAIL - ' || p_in);
      DBMS_OUTPUT.put_line ('Expected Result: ' || p_expected_result);
      DBMS_OUTPUT.put_line ('Result: ' || lv_result);
    END IF;
  END;
BEGIN
  -- expected fail conditions
  test_f_get_location_id ('Something wrong', NULL);
  test_f_get_location_id (NULL, NULL);
  -- expected success conditions
  test_f_get_location_id ('London', 1);
  test_f_get_location_id ('cardiff', 2);
  test_f_get_location_id ('EDINBURGH', 3);
END;

--------------------------------------------------------------------------------
--  unit test f_get_department_id
--------------------------------------------------------------------------------

DECLARE
  PROCEDURE test_f_get_department_id (p_in IN department.department_name%TYPE, p_expected_result IN NUMBER)
  IS
    lv_result   NUMBER;
  BEGIN
    lv_result := pk_employee_info.f_get_department_id (p_in);

    IF NVL (lv_result, -1) = NVL (p_expected_result, -1)
    THEN
      DBMS_OUTPUT.put_line ('test_f_get_department_id PASS - ' || p_in);
    ELSE
      DBMS_OUTPUT.put_line ('test_f_get_department_id FAIL - ' || p_in);
      DBMS_OUTPUT.put_line ('Expected Result: ' || p_expected_result);
      DBMS_OUTPUT.put_line ('Result: ' || lv_result);
    END IF;
  END;
BEGIN
  -- expected fail conditions
  test_f_get_department_id ('Something wrong', NULL);
  test_f_get_department_id (NULL, NULL);
  -- expected success conditions
  test_f_get_department_id ('Management', 1);
  test_f_get_department_id ('engineering', 2);
  test_f_get_department_id ('SALES', 4);
END;

--------------------------------------------------------------------------------
--  unit test f_get_salary
--------------------------------------------------------------------------------

DECLARE
  PROCEDURE test_f_get_salary (p_in IN employee.employee_id%TYPE, p_expected_result IN NUMBER)
  IS
    lv_result   NUMBER;
  BEGIN
    lv_result := pk_employee_info.f_get_salary (p_in);

    IF NVL (lv_result, -1) = NVL (p_expected_result, -1)
    THEN
      DBMS_OUTPUT.put_line ('test_f_get_salary PASS - ' || p_in);
    ELSE
      DBMS_OUTPUT.put_line ('test_f_get_salary FAIL - ' || p_in);
      DBMS_OUTPUT.put_line ('Expected Result: ' || p_expected_result);
      DBMS_OUTPUT.put_line ('Result: ' || lv_result);
    END IF;
  END;
BEGIN
  -- expected fail conditions
  test_f_get_salary (0, NULL);
  test_f_get_salary (NULL, NULL);
  -- expected success conditions
  test_f_get_salary (90001, 100000);
END;

--------------------------------------------------------------------------------
--  unit test f_employee_found
--------------------------------------------------------------------------------

DECLARE
  PROCEDURE test_f_employee_found (p_in IN employee.employee_id%TYPE, p_expected_result IN NUMBER)
  IS
    lv_result   NUMBER;
  BEGIN
    lv_result := pk_employee_info.f_employee_found (p_in);

    IF NVL (lv_result, -1) = NVL (p_expected_result, -1)
    THEN
      DBMS_OUTPUT.put_line ('test_f_employee_found PASS - ' || p_in);
    ELSE
      DBMS_OUTPUT.put_line ('test_f_employee_found FAIL - ' || p_in);
      DBMS_OUTPUT.put_line ('Expected Result: ' || p_expected_result);
      DBMS_OUTPUT.put_line ('Result: ' || lv_result);
    END IF;
  END;
BEGIN
  -- expected fail conditions
  test_f_employee_found (0, 0);
  test_f_employee_found (NULL, 0);
  -- expected success conditions
  test_f_employee_found (90001, 1);
END;

--------------------------------------------------------------------------------
--  unit test pr_insert_employee
--------------------------------------------------------------------------------

DECLARE
  PROCEDURE test_pr_insert_employee (p_employee_id       IN employee.employee_id%TYPE
                                    ,p_first_name        IN employee.first_name%TYPE
                                    ,p_last_name         IN employee.last_name%TYPE
                                    ,p_job_title_id      IN employee.job_title_id%TYPE
                                    ,p_manager_id        IN employee.manager_id%TYPE
                                    ,p_date_hired        IN employee.date_hired%TYPE
                                    ,p_salary            IN employee.salary%TYPE
                                    ,p_department_id     IN employee.department_id%TYPE
                                    ,p_expected_result   IN VARCHAR2)
  IS
    lv_result   VARCHAR2 (100);
  BEGIN
    pk_employee_info.pr_insert_employee (p_employee_id     => p_employee_id
                                                 ,p_first_name      => p_first_name
                                                 ,p_last_name       => p_last_name
                                                 ,p_job_title_id    => p_job_title_id
                                                 ,p_manager_id      => p_manager_id
                                                 ,p_date_hired      => p_date_hired
                                                 ,p_salary          => p_salary
                                                 ,p_department_id   => p_department_id
                                                 ,p_response        => lv_result);

    IF NVL (SUBSTR (lv_result, 1, INSTR (lv_result, '.')), lv_result) = p_expected_result
    THEN
      DBMS_OUTPUT.put_line ('test_pr_insert_employee PASS - ' || p_employee_id);
    ELSE
      DBMS_OUTPUT.put_line ('test_pr_insert_employee FAIL - ' || p_employee_id);
      DBMS_OUTPUT.put_line ('Expected Result: ' || p_expected_result);
      DBMS_OUTPUT.put_line ('Result: ' || lv_result);
    END IF;
  END;
BEGIN
  -- expected fail conditions
  test_pr_insert_employee (p_employee_id       => NULL
                          ,p_first_name        => 'Fred'
                          ,p_last_name         => 'Bloggs'
                          ,p_job_title_id      => 1
                          ,p_manager_id        => NULL
                          ,p_date_hired        => TRUNC (SYSDATE)
                          ,p_salary            => 1000000
                          ,p_department_id     => NULL
                          ,p_expected_result   => 'Unable to create Employee Record.');
  -- expected success conditions
  test_pr_insert_employee (p_employee_id       => 90011
                          ,p_first_name        => 'Fred'
                          ,p_last_name         => 'Bloggs'
                          ,p_job_title_id      => 1
                          ,p_manager_id        => NULL
                          ,p_date_hired        => TRUNC (SYSDATE)
                          ,p_salary            => 1000000
                          ,p_department_id     => 1
                          ,p_expected_result   => 'OK');
END;


--------------------------------------------------------------------------------
--  unit test overloaded pr_insert_employee - accepts job_title not job_title_id
--  and either department_name or department_id
--------------------------------------------------------------------------------

DECLARE
  lv_count   NUMBER;

  PROCEDURE test_pr_insert_employee (p_employee_id       IN employee.employee_id%TYPE
                                    ,p_employee_name     IN VARCHAR2
                                    ,p_job_title         IN job_title.job_title%TYPE
                                    ,p_manager_id        IN employee.manager_id%TYPE
                                    ,p_date_hired        IN employee.date_hired%TYPE
                                    ,p_salary            IN employee.salary%TYPE
                                    ,p_department_name   IN department.department_name%TYPE DEFAULT NULL
                                    ,p_department_id     IN department.department_id%TYPE DEFAULT NULL
                                    ,p_expected_result   IN VARCHAR2)
  IS
    lv_result   VARCHAR2 (100);
  BEGIN
    pk_employee_info.pr_insert_employee (p_employee_id       => p_employee_id
                                                 ,p_employee_name     => p_employee_name
                                                 ,p_job_title         => p_job_title
                                                 ,p_manager_id        => p_manager_id
                                                 ,p_date_hired        => p_date_hired
                                                 ,p_salary            => p_salary
                                                 ,p_department_name   => p_department_name
                                                 ,p_department_id     => p_department_id
                                                 ,p_response          => lv_result);

    DBMS_OUTPUT.put_line ('test_pr_insert_employee Response - ' || p_employee_id || ' - ' || lv_result);

    IF NVL (SUBSTR (lv_result, 1, INSTR (lv_result, '.')), lv_result) = p_expected_result
    THEN
      DBMS_OUTPUT.put_line ('test_pr_insert_employee PASS - ' || p_employee_id);
    ELSE
      DBMS_OUTPUT.put_line ('test_pr_insert_employee FAIL - ' || p_employee_id);
      DBMS_OUTPUT.put_line ('Expected Result: ' || p_expected_result);
      DBMS_OUTPUT.put_line ('Result: ' || lv_result);
    END IF;
  END;
BEGIN
  DELETE FROM employee e
        WHERE e.last_name = 'Bloggs';

  -- expected fail conditions
  test_pr_insert_employee (p_employee_id       => NULL                                                                   -- cannot be null
                          ,p_employee_name     => 'Fred Bloggs'
                          ,p_job_title         => 'Manager'
                          ,p_manager_id        => NULL
                          ,p_date_hired        => TRUNC (SYSDATE)
                          ,p_salary            => 1000000
                          ,p_department_name   => 'Engineering'
                          ,p_department_id     => NULL
                          ,p_expected_result   => 'Unable to create Employee Record.');

  test_pr_insert_employee (p_employee_id       => 90011
                          ,p_employee_name     => NULL                                                                   -- cannot be null
                          ,p_job_title         => 'Manager'
                          ,p_manager_id        => NULL
                          ,p_date_hired        => TRUNC (SYSDATE)
                          ,p_salary            => 1000000
                          ,p_department_name   => 'Engineering'
                          ,p_department_id     => NULL
                          ,p_expected_result   => 'Unable to create Employee Record.');

  test_pr_insert_employee (p_employee_id       => 90012
                          ,p_employee_name     => 'Fred Bloggs'
                          ,p_job_title         => NULL                                                                   -- cannot be null
                          ,p_manager_id        => NULL
                          ,p_date_hired        => TRUNC (SYSDATE)
                          ,p_salary            => 1000000
                          ,p_department_name   => 'Engineering'
                          ,p_department_id     => NULL
                          ,p_expected_result   => 'Unable to create Employee Record.');

  test_pr_insert_employee (p_employee_id       => 90013
                          ,p_employee_name     => 'Fred Bloggs'
                          ,p_job_title         => 'Manager'
                          ,p_manager_id        => NULL
                          ,p_date_hired        => NULL                                                                   -- cannot be null
                          ,p_salary            => 1000000
                          ,p_department_name   => 'Engineering'
                          ,p_department_id     => NULL
                          ,p_expected_result   => 'Unable to create Employee Record.');

  test_pr_insert_employee (p_employee_id       => 90014
                          ,p_employee_name     => 'Fred Bloggs'
                          ,p_job_title         => 'Manager'
                          ,p_manager_id        => NULL
                          ,p_date_hired        => TRUNC (SYSDATE)
                          ,p_salary            => NULL                                                                   -- cannot be null
                          ,p_department_name   => 'Engineering'
                          ,p_department_id     => NULL
                          ,p_expected_result   => 'Unable to create Employee Record.');

  test_pr_insert_employee (p_employee_id       => 90015
                          ,p_employee_name     => 'Fred Bloggs'
                          ,p_job_title         => 'Manager'
                          ,p_manager_id        => NULL
                          ,p_date_hired        => TRUNC (SYSDATE)
                          ,p_salary            => 1000000
                          ,p_department_name   => NULL                                                              -- cannot both be null
                          ,p_department_id     => NULL                                                              -- cannot both be null
                          ,p_expected_result   => 'Unable to create Employee Record.');

  test_pr_insert_employee (p_employee_id       => 90016
                          ,p_employee_name     => 'Ayesha'                        -- must contain a space to separate first and last names
                          ,p_job_title         => 'Manager'
                          ,p_manager_id        => NULL
                          ,p_date_hired        => TRUNC (SYSDATE)
                          ,p_salary            => 200000
                          ,p_department_id     => 2
                          ,p_expected_result   => 'Unable to create Employee Record.');

  test_pr_insert_employee (p_employee_id       => 90017
                          ,p_employee_name     => 'A very very very very very very very very very very very long name'         -- too long
                          ,p_job_title         => 'Manager'
                          ,p_manager_id        => NULL
                          ,p_date_hired        => TRUNC (SYSDATE)
                          ,p_salary            => 200000
                          ,p_department_id     => 2
                          ,p_expected_result   => 'Unable to create Employee Record.');

  -- expected success conditions

  test_pr_insert_employee (p_employee_id       => 90018
                          ,p_employee_name     => 'Fred Bloggs'
                          ,p_job_title         => 'Manager'
                          ,p_manager_id        => NULL
                          ,p_date_hired        => TRUNC (SYSDATE)
                          ,p_salary            => 1000000
                          ,p_department_name   => 'Engineering'
                          ,p_department_id     => NULL
                          ,p_expected_result   => 'OK');

  test_pr_insert_employee (p_employee_id       => 90019
                          ,p_employee_name     => 'Wilma Flintstone'
                          ,p_job_title         => 'Salesperson'
                          ,p_manager_id        => NULL
                          ,p_date_hired        => TRUNC (SYSDATE)
                          ,p_salary            => 2000000
                          ,p_department_name   => 'Management'
                          ,p_expected_result   => 'OK');

  test_pr_insert_employee (p_employee_id       => 90020
                          ,p_employee_name     => 'Barney Rubble'
                          ,p_job_title         => 'Engineer'
                          ,p_manager_id        => NULL
                          ,p_date_hired        => TRUNC (SYSDATE)
                          ,p_salary            => 2000000
                          ,p_department_id     => 2
                          ,p_expected_result   => 'OK');

  SELECT COUNT (*)
    INTO lv_count
    FROM employee e
   WHERE     e.employee_id > 90010
         AND e.date_hired = TRUNC (SYSDATE);

  CASE
    WHEN lv_count = 0
    THEN
      DBMS_OUTPUT.put_line ('test_pr_insert_employee FAIL - Employee records not created');
    WHEN lv_count > 3
    THEN
      DBMS_OUTPUT.put_line ('test_pr_insert_employee FAIL - Too many Employee Records created');
    ELSE
      DBMS_OUTPUT.put_line ('test_pr_insert_employee PASS - 3 Employee records created');
  END CASE;
END;

--------------------------------------------------------------------------------
--  unit test pr_enhance_salary
--------------------------------------------------------------------------------

DECLARE
  lv_salary   NUMBER;

  PROCEDURE test_pr_enhance_salary (p_employee_id       IN employee.employee_id%TYPE
                                   ,p_enhance_percent   IN NUMBER
                                   ,p_expected_result   IN VARCHAR2)
  IS
    lv_result   VARCHAR2 (100);
  BEGIN
    pk_employee_info.pr_enhance_salary (p_employee_id       => p_employee_id
                                                ,p_enhance_percent   => p_enhance_percent
                                                ,p_response          => lv_result);

    DBMS_OUTPUT.put_line ('test_pr_enhance_salary - ' || p_employee_id || ' - ' || lv_result);

    IF NVL (SUBSTR (lv_result, 1, INSTR (lv_result, '.')), lv_result) = p_expected_result
    THEN
      DBMS_OUTPUT.put_line ('test_pr_enhance_salary PASS - ' || p_employee_id);
    ELSE
      DBMS_OUTPUT.put_line ('test_pr_enhance_salary FAIL - ' || p_employee_id);
      DBMS_OUTPUT.put_line ('Expected Result: ' || p_expected_result);
      DBMS_OUTPUT.put_line ('Result: ' || lv_result);
    END IF;
  END;
BEGIN
  -- expected fail conditions
  test_pr_enhance_salary (p_employee_id => NULL, p_enhance_percent => 10, p_expected_result => 'Unable to enhance Salary.');
  test_pr_enhance_salary (p_employee_id => 90001, p_enhance_percent => NULL, p_expected_result => 'Unable to enhance Salary.');  
  -- expected success conditions
  test_pr_enhance_salary (p_employee_id => 90001, p_enhance_percent => 10, p_expected_result => 'OK');
  test_pr_enhance_salary (p_employee_id => 90001, p_enhance_percent => -10, p_expected_result => 'OK');
  test_pr_enhance_salary (p_employee_id => 90002, p_enhance_percent => 0, p_expected_result => 'OK');

  FOR get_recs IN (SELECT *
                     FROM employee e)
  LOOP
    test_pr_enhance_salary (p_employee_id => get_recs.employee_id, p_enhance_percent => 10, p_expected_result => 'OK');

    SELECT salary
      INTO lv_salary
      FROM employee e
     WHERE e.employee_id = get_recs.employee_id;

    CASE
      WHEN lv_salary != get_recs.salary + (get_recs.salary * (10 / 100))
      THEN
        DBMS_OUTPUT.put_line ('test_pr_enhance_salary cursor FAIL - ' || get_recs.employee_id);
      ELSE
        DBMS_OUTPUT.put_line ('test_pr_enhance_salary cursor PASS - ' || get_recs.employee_id);
    END CASE;
  END LOOP;
END;

--------------------------------------------------------------------------------
--  unit test pr_r_transfer_dept
--------------------------------------------------------------------------------

DECLARE
  lv_department   NUMBER;

  PROCEDURE test_pr_transfer_dept (p_employee_id       IN employee.employee_id%TYPE
                                  ,p_department_name   IN department.department_name%TYPE DEFAULT NULL
                                  ,p_department_id     IN department.department_id%TYPE DEFAULT NULL
                                  ,p_expected_result   IN VARCHAR2)
  IS
    lv_result   VARCHAR2 (100);
  BEGIN
    pk_employee_info.pr_transfer_dept (p_employee_id       => p_employee_id
                                               ,p_department_name   => p_department_name
                                               ,p_department_id     => p_department_id
                                               ,p_response          => lv_result);

    DBMS_OUTPUT.put_line ('pr_r_transfer_dept - ' || p_employee_id || ' - ' || lv_result);

    IF NVL (SUBSTR (lv_result, 1, INSTR (lv_result, '.')), lv_result) = p_expected_result
    THEN
      DBMS_OUTPUT.put_line ('test_pr_transfer_dept PASS - ' || p_employee_id);
    ELSE
      DBMS_OUTPUT.put_line ('test_pr_transfer_dept FAIL - ' || p_employee_id);
      DBMS_OUTPUT.put_line ('Expected Result: ' || p_expected_result);
      DBMS_OUTPUT.put_line ('Result: ' || lv_result);
    END IF;
  END;
BEGIN
  -- expected fail conditions
  test_pr_transfer_dept (p_employee_id       => NULL
                        ,p_department_name   => 'Engineering'
                        ,p_department_id     => NULL
                        ,p_expected_result   => 'Unable to transfer Employee.');
  test_pr_transfer_dept (p_employee_id       => 90001
                        ,p_department_name   => NULL
                        ,p_department_id     => NULL
                        ,p_expected_result   => 'Unable to transfer Employee.');
  -- expected success conditions
  test_pr_transfer_dept (p_employee_id       => 90001
                        ,p_department_name   => 'Engineering'
                        ,p_department_id     => NULL
                        ,p_expected_result   => 'OK');
  test_pr_transfer_dept (p_employee_id       => 90002
                        ,p_department_name   => NULL
                        ,p_department_id     => 4
                        ,p_expected_result   => 'OK');

  FOR get_recs IN (SELECT *
                     FROM employee e)
  LOOP
    test_pr_transfer_dept (p_employee_id       => get_recs.employee_id
                          ,p_department_name   => NULL
                          ,p_department_id     => 3
                          ,p_expected_result   => 'OK');

    SELECT department_id
      INTO lv_department
      FROM employee e
     WHERE e.employee_id = get_recs.employee_id;

    CASE
      WHEN lv_department != 3
      THEN
        DBMS_OUTPUT.put_line ('test_pr_transfer_dept cursor FAIL - ' || get_recs.employee_id);
      ELSE
        DBMS_OUTPUT.put_line ('test_pr_transfer_dept cursor PASS - ' || get_recs.employee_id);
    END CASE;
  END LOOP;
END;

ROLLBACK;