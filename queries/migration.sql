-- UB Database --
-- **NOTE**: Table inline comments are from top-bottom --
-- (meaning the bottom-most comment in a TABLE structure refers to the line --
-- above it) --
DROP TABLE IF EXISTS Students CASCADE;
DROP TABLE IF EXISTS Courses CASCADE;
DROP TABLE IF EXISTS Course CASCADE;
DROP TABLE IF EXISTS Ethnicity CASCADE;
DROP TABLE IF EXISTS Program_Status CASCADE;
DROP TABLE IF EXISTS District CASCADE;
DROP TABLE IF EXISTS Feeder CASCADE;

--- Course ---
CREATE TABLE course (
    course_id serial PRIMARY KEY,
    course_code text NOT NULL,
    course_title text NOT NULL,
    course_credits integer NOT NULL,
    created_at timestamp(0) with time zone NOT NULL DEFAULT NOW()
);
--- Ethnicity ---
CREATE TABLE ethnicities (
    ethnicity_id int PRIMARY KEY,
    ethnicity text NOT NULL,
    created_at timestamp(0) with time zone NOT NULL DEFAULT NOW()
);
--- Program_Status ---
CREATE TABLE program_status (
    program_status_id integer PRIMARY KEY,
    program_status text NOT NULL,
    created_at timestamp(0) with time zone NOT NULL DEFAULT NOW()
);
--- District ---
CREATE TABLE districts (
    district_id int PRIMARY KEY,
    district text NOT NULL,
    created_at timestamp(0) with time zone NOT NULL DEFAULT NOW()
);
--- Feeder ---
CREATE TABLE feeders (
    feeder_id int PRIMARY KEY,
    feeder text NOT NULL,
    created_at timestamp(0) with time zone NOT NULL DEFAULT NOW()
);
--- Students ---
CREATE TABLE students (
    student_id int PRIMARY KEY,
    gender char(1) NOT NULL,
    ethnicity_id int REFERENCES Ethnicity(ethnicity_id) NOT NULL,
    district_id int REFERENCES District(district_id) NOT NULL,
    feeder_id int REFERENCES Feeder(feeder_id) NOT NULL,
    program_start date,
    --- Optional ---
    program_end date,
    --- Optional ---
    grad_date date,
    --- Optional ---
    program_status_id int REFERENCES Program_Status(program_status_id) NOT NULL,
    created_at timestamp(0) with time zone NOT NULL DEFAULT NOW()
);
--- Courses ---
CREATE TABLE students_courses (
    courses_id serial PRIMARY KEY,
    student_id int REFERENCES Students(student_id),
    enrolled_semester text NOT NULL,
    course_id int REFERENCES Course(course_id) NOT NULL,
    course_grade text NOT NULL DEFAULT 'IN_PROGRESS',
    created_at timestamp(0) with time zone NOT NULL DEFAULT NOW()
);

--- Start Imports (Start from Top-to-Bottom) ---
--- Commands must be single-lined
--- Imported in dependent sequence ---
--- DO NOT CHANGE!!!! ---
--- Course ---
\COPY course( course_id, course_code, course_title, course_credits ) FROM '../data/Course.csv' DELIMITER ',' CSV HEADER;
--- Ethnicity ---
\COPY ethnicities(ethnicity_id, ethnicity) FROM '../data/Ethnicities.csv' DELIMITER ',' CSV HEADER;
--- Program_Status ---
\COPY program_status( program_status_id, program_status ) FROM '../data/Program_Status.csv' DELIMITER ',' CSV HEADER;
--- District ---
\COPY districts(district_id, district) FROM '../data/Districts.csv' DELIMITER ',' CSV HEADER;
--- Feeder ---
\COPY feeders( feeder_id, feeder, district_id ) FROM '../data/Feeders.csv' DELIMITER ',' CSV HEADER;
--- Students ---
\COPY students( student_id, gender, ethnicity_id, district_id, feeder_id, program_status_id, program_start, program_end, grad_date ) FROM '../data/Students.csv' DELIMITER ',' CSV HEADER;
--- Courses ---
\COPY student_courses( courses_id, student_id, enrolled_semester, course_id, course_grade ) FROM '../data/Student_Courses.csv' DELIMITER ',' CSV HEADER;
--- FINISH ---