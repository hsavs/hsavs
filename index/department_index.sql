CREATE INDEX department_loc_ix
  ON department (location_id);

CREATE UNIQUE INDEX fb_department_ix
  ON department (UPPER (department_name));