CREATE INDEX emp_job_title_ix
  ON employee (job_title_id);

CREATE INDEX emp_department_ix
  ON employee (department_id);

CREATE INDEX emp_manager_ix
  ON employee (manager_id);