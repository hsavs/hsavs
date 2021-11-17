Oracle PL/SQL Coding Challenge. Employee Data

Description
A short exercise to achieve the following:
Employee and Deprtment table creation and population.
Package to manage and manipulate employee and department data.
Basic reporting objects 
Unit testing script to verify data created.

Installation instructions
1. git clone repo to local branch \repo, ensuring the following directory structure is created and populated:
repo\develop\
with sub-directories as follows:
table
index
package
package_body
view
report
unittest
scripts
2. Open SQLPlus and connect to an Oracle databse as a user with the following privileges:
   table, create index, create view, create procedure
3. Run repo\develop\scripts\deployment_script_employee.sql
3. Check script output for report results
4. Check dbms_output for unit test results

Notes:
Script developed and tested on Windows and Toad
