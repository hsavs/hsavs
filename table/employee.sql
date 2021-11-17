CREATE TABLE employee
(
  employee_id      NUMBER PRIMARY KEY
 ,first_name       VARCHAR2 (50) NOT NULL
 ,last_name        VARCHAR2 (50) NOT NULL
 ,job_title_id     NUMBER NOT NULL
 ,manager_id       NUMBER
 ,date_hired       DATE NOT NULL
 ,salary           NUMBER NOT NULL
 ,department_id    NUMBER NOT NULL
);

COMMENT ON TABLE employee IS 'Employee Data';
COMMENT ON COLUMN employee.job_title_id IS 'CURRENT JOB TITLE ID. Foreign key to job_title.job_title_id';
COMMENT ON COLUMN employee.manager_id IS 'MANAGER ID. Foreign key to employee.employee_id';
COMMENT ON COLUMN employee.department_id IS 'Department ID. Foreign key to department.department_id';

ALTER TABLE employee
  ADD CONSTRAINT emp_fk_job_title FOREIGN KEY (job_title_id) REFERENCES job_title (job_title_id);

ALTER TABLE employee
  ADD CONSTRAINT emp_fk_department_id FOREIGN KEY (department_id) REFERENCES department (department_id);
