CREATE TABLE location
(
  location_id    NUMBER GENERATED ALWAYS AS IDENTITY PRIMARY KEY
 ,location       VARCHAR2 (50)
);

COMMENT ON TABLE location IS 'Department Location Data';
