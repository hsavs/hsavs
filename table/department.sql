CREATE TABLE department
(
  department_id      NUMBER NOT NULL PRIMARY KEY
 ,department_name    VARCHAR2 (50) NOT NULL
 ,location_id        NUMBER NOT NULL
);

COMMENT ON TABLE department IS 'Department Data';
COMMENT ON COLUMN department.location_id IS 'Location ID. Foreign key to location.location_id';

ALTER TABLE department
  ADD CONSTRAINT dept_fk_location FOREIGN KEY (location_id) REFERENCES location (location_id);
