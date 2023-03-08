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
--- Students ---
CREATE TABLE Students (
    student_id int PRIMARY KEY,
    gender char(1) NOT NULL,
    ethnicity_id int REFERENCES ethnicities(ethnicity_id) NOT NULL,
    district_id int REFERENCES districts(district_id) NOT NULL,
    feeder_id int REFERENCES feeders(feeder_id) NOT NULL,
    program_start date,
    --- Optional ---
    program_end date,
    --- Optional ---
    grad_date date,
    --- Optional ---
    program_status_id int REFERENCES program_statuses(program_status_id) NOT NULL,
    created_at timestamp(0) with time zone NOT NULL DEFAULT NOW()
);
--- Courses ---
CREATE TABLE Courses (
    courses_id serial PRIMARY KEY,
    student_id int REFERENCES students(student_id),
    enrolled_semester text NOT NULL,
    course_id int REFERENCES courses(course_id) NOT NULL,
    course_grade text NOT NULL,
    created_at timestamp(0) with time zone NOT NULL DEFAULT NOW()
);
--- Course ---
CREATE TABLE Course (
    course_id serial PRIMARY KEY,
    course_code text NOT NULL,
    course_title text NOT NULL,
    course_credits integer NOT NULL,
    created_at timestamp(0) with time zone NOT NULL DEFAULT NOW()
);
--- Ethnicity ---
CREATE TABLE Ethnicity (
    ethnicity_id int PRIMARY KEY,
    ethnicity text NOT NULL,
    created_at timestamp(0) with time zone NOT NULL DEFAULT NOW()
);
--- Program_Status ---
CREATE TABLE Program_Status (
    program_status_id integer PRIMARY KEY,
    program_status text NOT NULL,
    created_at timestamp(0) with time zone NOT NULL DEFAULT NOW()
);
--- District ---
CREATE TABLE District (
    district_id int PRIMARY KEY,
    district text NOT NULL,
    created_at timestamp(0) with time zone NOT NULL DEFAULT NOW()
);
--- Feeder ---
CREATE TABLE Feeder (
    feeder_id int PRIMARY KEY,
    feeder text NOT NULL,
    created_at timestamp(0) with time zone NOT NULL DEFAULT NOW()
);
--- Start Imports (Start from Top-to-Bottom) ---

--- Students ---
\COPY Students(
    student_id,
    gender,
    ethnicity_id,
    district_id,
    feeder_id,
    program_status_id,
    program_start,
    program_end,
    grad_date
)
FROM '../data/Students.csv' DELIMITER ',' CSV HEADER;

--- Courses ---
\COPY Courses(
    courses_id,
    student_id,
    enrolled_semester,
    course_id,
    course_grade
    )
FROM '../data/Courses.csv' DELIMITER ',' CSV HEADER;

--- Course ---
\COPY Course (
    course_id,
    course_code,
    course_title,
    course_credits
) FROM '../data/Course.csv' DELIMITER ',' CSV HEADER;

--- Ethnicity ---
\COPY Ethnicity(ethnicity_id, ethnicity)
FROM '../data/Ethnicity.csv' DELIMITER ',' CSV HEADER;

--- Program_Status ---
\COPY Program_Status (
    program_status_id,
    program_status
) FROM '../data/Program_Status.csv' DELIMETER ',' CSV HEADER;

--- District ---
\COPY District(district_id, district)
FROM '../data/District.csv' DELIMITER ',' CSV HEADER;

--- Feeder ---
\COPY Feeder(
    feeder_id,
    feeder
) FROM '../data/Feeder.csv' DELIMETER ',' CSV HEADER;

--- FINISH ---