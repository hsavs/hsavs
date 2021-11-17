CREATE UNIQUE INDEX fb_job_title_ix
  ON job_title (UPPER (job_title));
