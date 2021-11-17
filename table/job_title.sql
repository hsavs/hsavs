CREATE TABLE job_title
(
  job_title_id    NUMBER GENERATED ALWAYS AS IDENTITY PRIMARY KEY
 ,job_title       VARCHAR2 (50) NOT NULL
);

COMMENT ON TABLE job_title IS 'Job Title Data';
