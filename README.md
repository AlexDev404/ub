# UB Database

Database constructed from the ["sources/schools_data.xlsx"](sources/schools_data.xlsx) file

## To Bootstrap

1. Clone this repository
2. Create a new database in PostgreSQL `CREATE DATABASE <DB_NAME>`
3. Login to the database from the queries folder and run `\i migration.sql` to run the migration
4. Run the test query by running `\i tests/query.sql` to check to see if everything is working as expected
