--------------------------------------------------------------------------------
--  Helen Savigar 13/11/2021 Deployment script for exercise
--  Run this script from a sql session connected to an Oracle DB
--  as a user with at least the following privileges:
--  create table, create index, create view, create procedure
--  Objects will be created, Reports will be run and unit tests performed
--  Check script and dbms_output for outcome
--  Disclosure: script developed tested only on Windows
--------------------------------------------------------------------------------

----------------------------------------------------
-- Non-Repeatable run code
----------------------------------------------------

--------------------------------------------------------------------------------
--  object creation
--------------------------------------------------------------------------------

---------------
-- tables
---------------

@"\repo\develop\table\location.sql"

@"\repo\develop\table\department.sql"

@"\repo\develop\table\job_title.sql"

@"\repo\develop\table\employee.sql"

--------------------------------------------------------------------------------
--  data population
--------------------------------------------------------------------------------

SET DEFINE OFF

INSERT INTO location (location)
     VALUES ('London');

INSERT INTO location (location)
     VALUES ('Cardiff');

INSERT INTO location (location)
     VALUES ('Edinburgh');

INSERT INTO location (location)
     VALUES ('Belfast');

---------------------------------------------

INSERT INTO job_title (job_title)
     VALUES ('CEO');

INSERT INTO job_title (job_title)
     VALUES ('Manager');

INSERT INTO job_title (job_title)
     VALUES ('Salesperson');

INSERT INTO job_title (job_title)
     VALUES ('Engineer');

INSERT INTO job_title (job_title)
     VALUES ('Secretary');

--------------------------------------------

MERGE INTO department d
     USING (SELECT 1 AS department_id, 'Management' AS department_name, location_id
              FROM location
             WHERE location = 'London') l
        ON (l.department_id = d.department_id)
WHEN MATCHED
THEN
  UPDATE SET d.department_name = l.department_name, d.location_id = l.location_id
WHEN NOT MATCHED
THEN
  INSERT     (d.department_id, d.department_name, d.location_id)
      VALUES (l.department_id, l.department_name, l.location_id);

MERGE INTO department d
     USING (SELECT 2 AS department_id, 'Engineering' AS department_name, location_id
              FROM location
             WHERE location = 'Cardiff') l
        ON (l.department_id = d.department_id)
WHEN MATCHED
THEN
  UPDATE SET d.department_name = l.department_name, d.location_id = l.location_id
WHEN NOT MATCHED
THEN
  INSERT     (d.department_id, d.department_name, d.location_id)
      VALUES (l.department_id, l.department_name, l.location_id);

MERGE INTO department d
     USING (SELECT 3 AS department_id, 'Research & Development' AS department_name, location_id
              FROM location
             WHERE location = 'Edinburgh') l
        ON (l.department_id = d.department_id)
WHEN MATCHED
THEN
  UPDATE SET d.department_name = l.department_name, d.location_id = l.location_id
WHEN NOT MATCHED
THEN
  INSERT     (d.department_id, d.department_name, d.location_id)
      VALUES (l.department_id, l.department_name, l.location_id);

MERGE INTO department d
     USING (SELECT 4 AS department_id, 'Sales' AS department_name, location_id
              FROM location
             WHERE location = 'Belfast') l
        ON (l.department_id = d.department_id)
WHEN MATCHED
THEN
  UPDATE SET d.department_name = l.department_name, d.location_id = l.location_id
WHEN NOT MATCHED
THEN
  INSERT     (d.department_id, d.department_name, d.location_id)
      VALUES (l.department_id, l.department_name, l.location_id);


-------------------------------------------------------------

MERGE INTO employee e
     USING (SELECT 90001           AS employee_id
                  ,'John'          AS first_name
                  ,'Smith'         AS last_name
                  ,job_title_id
                  ,NULL            AS manager_id
                  ,'01-jan-1995'   AS date_hired
                  ,100000          AS salary
                  ,1               AS department_id
              FROM job_title
             WHERE job_title = 'CEO') j
        ON (e.employee_id = j.employee_id)
WHEN MATCHED
THEN
  UPDATE SET e.first_name = j.first_name
            ,e.last_name = j.last_name
            ,e.job_title_id = j.job_title_id
            ,e.manager_id = j.manager_id
            ,e.date_hired = j.date_hired
            ,e.salary = j.salary
            ,e.department_id = j.department_id
WHEN NOT MATCHED
THEN
  INSERT     (e.employee_id
             ,e.first_name
             ,e.last_name
             ,e.job_title_id
             ,e.manager_id
             ,e.date_hired
             ,e.salary
             ,e.department_id)
      VALUES (j.employee_id
             ,j.first_name
             ,j.last_name
             ,j.job_title_id
             ,j.manager_id
             ,j.date_hired
             ,j.salary
             ,j.department_id);

MERGE INTO employee e
     USING (SELECT 90002           AS employee_id
                  ,'Jimmy'         AS first_name
                  ,'Willis'        AS last_name
                  ,job_title_id
                  ,90001           AS manager_id
                  ,'23-sep-2003'   AS date_hired
                  ,52500           AS salary
                  ,4               AS department_id
              FROM job_title
             WHERE job_title = 'Manager') j
        ON (e.employee_id = j.employee_id)
WHEN MATCHED
THEN
  UPDATE SET e.first_name = j.first_name
            ,e.last_name = j.last_name
            ,e.job_title_id = j.job_title_id
            ,e.manager_id = j.manager_id
            ,e.date_hired = j.date_hired
            ,e.salary = j.salary
            ,e.department_id = j.department_id
WHEN NOT MATCHED
THEN
  INSERT     (e.employee_id
             ,e.first_name
             ,e.last_name
             ,e.job_title_id
             ,e.manager_id
             ,e.date_hired
             ,e.salary
             ,e.department_id)
      VALUES (j.employee_id
             ,j.first_name
             ,j.last_name
             ,j.job_title_id
             ,j.manager_id
             ,j.date_hired
             ,j.salary
             ,j.department_id);

MERGE INTO employee e
     USING (SELECT 90003           AS employee_id
                  ,'Roxy'          AS first_name
                  ,'Jones'         AS last_name
                  ,job_title_id
                  ,90002           AS manager_id
                  ,'11-feb-2017'   AS date_hired
                  ,35000           AS salary
                  ,4               AS department_id
              FROM job_title
             WHERE job_title = 'Salesperson') j
        ON (e.employee_id = j.employee_id)
WHEN MATCHED
THEN
  UPDATE SET e.first_name = j.first_name
            ,e.last_name = j.last_name
            ,e.job_title_id = j.job_title_id
            ,e.manager_id = j.manager_id
            ,e.date_hired = j.date_hired
            ,e.salary = j.salary
            ,e.department_id = j.department_id
WHEN NOT MATCHED
THEN
  INSERT     (e.employee_id
             ,e.first_name
             ,e.last_name
             ,e.job_title_id
             ,e.manager_id
             ,e.date_hired
             ,e.salary
             ,e.department_id)
      VALUES (j.employee_id
             ,j.first_name
             ,j.last_name
             ,j.job_title_id
             ,j.manager_id
             ,j.date_hired
             ,j.salary
             ,j.department_id);

MERGE INTO employee e
     USING (SELECT 90004           AS employee_id
                  ,'Selwyn'        AS first_name
                  ,'Field'         AS last_name
                  ,job_title_id
                  ,90003           AS manager_id
                  ,'20-may-2015'   AS date_hired
                  ,32000           AS salary
                  ,4               AS department_id
              FROM job_title
             WHERE job_title = 'Salesperson') j
        ON (e.employee_id = j.employee_id)
WHEN MATCHED
THEN
  UPDATE SET e.first_name = j.first_name
            ,e.last_name = j.last_name
            ,e.job_title_id = j.job_title_id
            ,e.manager_id = j.manager_id
            ,e.date_hired = j.date_hired
            ,e.salary = j.salary
            ,e.department_id = j.department_id
WHEN NOT MATCHED
THEN
  INSERT     (e.employee_id
             ,e.first_name
             ,e.last_name
             ,e.job_title_id
             ,e.manager_id
             ,e.date_hired
             ,e.salary
             ,e.department_id)
      VALUES (j.employee_id
             ,j.first_name
             ,j.last_name
             ,j.job_title_id
             ,j.manager_id
             ,j.date_hired
             ,j.salary
             ,j.department_id);

MERGE INTO employee e
     USING (SELECT 90006           AS employee_id
                  ,'Sarah'         AS first_name
                  ,'Phelps'        AS last_name
                  ,job_title_id
                  ,90001           AS manager_id
                  ,'21-mar-2015'   AS date_hired
                  ,45000           AS salary
                  ,2               AS department_id
              FROM job_title
             WHERE job_title = 'Manager') j
        ON (e.employee_id = j.employee_id)
WHEN MATCHED
THEN
  UPDATE SET e.first_name = j.first_name
            ,e.last_name = j.last_name
            ,e.manager_id = j.manager_id
            ,e.date_hired = j.date_hired
            ,e.job_title_id = j.job_title_id
            ,e.salary = j.salary
            ,e.department_id = j.department_id
WHEN NOT MATCHED
THEN
  INSERT     (e.employee_id
             ,e.first_name
             ,e.last_name
             ,e.job_title_id
             ,e.manager_id
             ,e.date_hired
             ,e.salary
             ,e.department_id)
      VALUES (j.employee_id
             ,j.first_name
             ,j.last_name
             ,j.job_title_id
             ,j.manager_id
             ,j.date_hired
             ,j.salary
             ,j.department_id);

MERGE INTO employee e
     USING (SELECT 90005           AS employee_id
                  ,'David'         AS first_name
                  ,'Hallett'       AS last_name
                  ,job_title_id
                  ,90006           AS manager_id
                  ,'17-apr-2018'   AS date_hired
                  ,40000           AS salary
                  ,2               AS department_id
              FROM job_title
             WHERE job_title = 'Engineer') j
        ON (e.employee_id = j.employee_id)
WHEN MATCHED
THEN
  UPDATE SET e.first_name = j.first_name
            ,e.last_name = j.last_name
            ,e.job_title_id = j.job_title_id
            ,e.manager_id = j.manager_id
            ,e.date_hired = j.date_hired
            ,e.salary = j.salary
            ,e.department_id = j.department_id
WHEN NOT MATCHED
THEN
  INSERT     (e.employee_id
             ,e.first_name
             ,e.last_name
             ,e.job_title_id
             ,e.manager_id
             ,e.date_hired
             ,e.salary
             ,e.department_id)
      VALUES (j.employee_id
             ,j.first_name
             ,j.last_name
             ,j.job_title_id
             ,j.manager_id
             ,j.date_hired
             ,j.salary
             ,j.department_id);

MERGE INTO employee e
     USING (SELECT 90007           AS employee_id
                  ,'Louise'        AS first_name
                  ,'Harper'        AS last_name
                  ,job_title_id
                  ,90006           AS manager_id
                  ,'01-jan-2013'   AS date_hired
                  ,47000           AS salary
                  ,2               AS department_id
              FROM job_title
             WHERE job_title = 'Engineer') j
        ON (e.employee_id = j.employee_id)
WHEN MATCHED
THEN
  UPDATE SET e.first_name = j.first_name
            ,e.last_name = j.last_name
            ,e.job_title_id = j.job_title_id
            ,e.manager_id = j.manager_id
            ,e.date_hired = j.date_hired
            ,e.salary = j.salary
            ,e.department_id = j.department_id
WHEN NOT MATCHED
THEN
  INSERT     (e.employee_id
             ,e.first_name
             ,e.last_name
             ,e.job_title_id
             ,e.manager_id
             ,e.date_hired
             ,e.salary
             ,e.department_id)
      VALUES (j.employee_id
             ,j.first_name
             ,j.last_name
             ,j.job_title_id
             ,j.manager_id
             ,j.date_hired
             ,j.salary
             ,j.department_id);

MERGE INTO employee e
     USING (SELECT 90009           AS employee_id
                  ,'Gus'           AS first_name
                  ,'Jones'         AS last_name
                  ,job_title_id
                  ,90001           AS manager_id
                  ,'15-May-2018'   AS date_hired
                  ,50000           AS salary
                  ,3               AS department_id
              FROM job_title
             WHERE job_title = 'Manager') j
        ON (e.employee_id = j.employee_id)
WHEN MATCHED
THEN
  UPDATE SET e.first_name = j.first_name
            ,e.last_name = j.last_name
            ,e.job_title_id = j.job_title_id
            ,e.manager_id = j.manager_id
            ,e.date_hired = j.date_hired
            ,e.salary = j.salary
            ,e.department_id = j.department_id
WHEN NOT MATCHED
THEN
  INSERT     (e.employee_id
             ,e.first_name
             ,e.last_name
             ,e.job_title_id
             ,e.manager_id
             ,e.date_hired
             ,e.salary
             ,e.department_id)
      VALUES (j.employee_id
             ,j.first_name
             ,j.last_name
             ,j.job_title_id
             ,j.manager_id
             ,j.date_hired
             ,j.salary
             ,j.department_id);

MERGE INTO employee e
     USING (SELECT 90008           AS employee_id
                  ,'Tina'          AS first_name
                  ,'Hart'          AS last_name
                  ,job_title_id
                  ,90009           AS manager_id
                  ,'28-jul-2013'   AS date_hired
                  ,45000           AS salary
                  ,3               AS department_id
              FROM job_title
             WHERE job_title = 'Engineer') j
        ON (e.employee_id = j.employee_id)
WHEN MATCHED
THEN
  UPDATE SET e.first_name = j.first_name
            ,e.last_name = j.last_name
            ,e.job_title_id = j.job_title_id
            ,e.manager_id = j.manager_id
            ,e.date_hired = j.date_hired
            ,e.salary = j.salary
            ,e.department_id = j.department_id
WHEN NOT MATCHED
THEN
  INSERT     (e.employee_id
             ,e.first_name
             ,e.last_name
             ,e.job_title_id
             ,e.manager_id
             ,e.date_hired
             ,e.salary
             ,e.department_id)
      VALUES (j.employee_id
             ,j.first_name
             ,j.last_name
             ,j.job_title_id
             ,j.manager_id
             ,j.date_hired
             ,j.salary
             ,j.department_id);

MERGE INTO employee e
     USING (SELECT 90010           AS employee_id
                  ,'Mildred'       AS first_name
                  ,'Hall'          AS last_name
                  ,job_title_id
                  ,90001           AS manager_id
                  ,'12-oct-1996'   AS date_hired
                  ,35000           AS salary
                  ,1               AS department_id
              FROM job_title
             WHERE job_title = 'Secretary') j
        ON (e.employee_id = j.employee_id)
WHEN MATCHED
THEN
  UPDATE SET e.first_name = j.first_name
            ,e.last_name = j.last_name
            ,e.job_title_id = j.job_title_id
            ,e.manager_id = j.manager_id
            ,e.date_hired = j.date_hired
            ,e.salary = j.salary
            ,e.department_id = j.department_id
WHEN NOT MATCHED
THEN
  INSERT     (e.employee_id
             ,e.first_name
             ,e.last_name
             ,e.job_title_id
             ,e.manager_id
             ,e.date_hired
             ,e.salary
             ,e.department_id)
      VALUES (j.employee_id
             ,j.first_name
             ,j.last_name
             ,j.job_title_id
             ,j.manager_id
             ,j.date_hired
             ,j.salary
             ,j.department_id);

COMMIT;

---------------
-- index
---------------

@"\repo\develop\index\location_index.sql"

@"\repo\develop\index\department_index.sql"

@"\repo\develop\index\job_title_index.sql"

@"\repo\develop\index\employee_index.sql"

---------------
-- package
---------------

@"\repo\develop\package\pk_employee_info.sql"

---------------
-- package_body
---------------

@"\repo\develop\package_body\pk_employee_info.sql"

---------------
-- view
---------------

@"\repo\develop\view\v_department_employees.sql"

@"\repo\develop\view\v_department_salaries.sql"

----------------------------------------------------
-- Repeatable run code
----------------------------------------------------

---------------
-- reports
---------------

@"\repo\develop\report\total_salaries_by_dept.sql"

@"\repo\develop\report\employees_by_dept.sql"

---------------
-- unittests
---------------

@"\repo\develop\unittest\unittest_employees.sql"
