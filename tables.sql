-- UB Database --

DROP TABLE IF EXISTS ethnicities CASCADE;
DROP TABLE IF EXISTS districts CASCADE;
DROP TABLE IF EXISTS feeders CASCADE;
DROP TABLE IF EXISTS program_statuses CASCADE;
DROP TABLE IF EXISTS students CASCADE;
DROP TABLE IF EXISTS courses CASCADE;
DROP TABLE IF EXISTS student_courses;

-- Create tables --
CREATE TABLE ethnicities (
    ethnicity_id int PRIMARY KEY,
    ethnicity text NOT NULL,
    created_at timestamp(0) with time zone NOT NULL DEFAULT NOW()
);

\COPY ethnicities(ethnicity_id, ethnicity) FROM 'ethnicity.csv' DELIMITER ',' CSV HEADER;

CREATE TABLE districts (
    district_id int PRIMARY KEY,
    district text NOT NULL,
    created_at timestamp(0) with time zone NOT NULL DEFAULT NOW()
);

\COPY districts(district_id, district) FROM 'district.csv' DELIMITER ',' CSV HEADER;

CREATE TABLE feeders (
    feeder_id int PRIMARY KEY,
    feeder text NOT NULL,
    created_at timestamp(0) with time zone NOT NULL DEFAULT NOW()
);

\COPY feeders(feeder_id, feeder) FROM 'feeder.csv' DELIMITER ',' CSV HEADER;

CREATE TABLE program_statuses (
    program_status_id int PRIMARY KEY,
    program_status text NOT NULL,
    created_at timestamp(0) with time zone NOT NULL DEFAULT NOW()
);

\COPY program_statuses(program_status_id, program_status) FROM 'program_status.csv' DELIMITER ',' CSV HEADER;

CREATE TABLE students (
    student_id int PRIMARY KEY,
    gender char(1) NOT NULL,
    ethnicity_id int REFERENCES ethnicities(ethnicity_id),
    district_id int REFERENCES districts(district_id),
    feeder_id int REFERENCES feeders(feeder_id),
    program_status_id int REFERENCES program_statuses(program_status_id),
    program_start text NOT NULL,
    program_end text NULL,
    grad_date text NULL,
    created_at timestamp(0) with time zone NOT NULL DEFAULT NOW()
);

\COPY students(student_id, gender, ethnicity_id, district_id, feeder_id, program_status_id, program_start, program_end, grad_date) FROM 'students.csv' DELIMITER ',' CSV HEADER;

CREATE TABLE courses (
    course_id int PRIMARY KEY,
    course_code text NOT NULL,
    course_title text NOT NULL,
    course_credits int NOT NULL,
    created_at timestamp(0) with time zone NOT NULL DEFAULT NOW()
);

\COPY courses(course_id, course_code, course_title, course_credits) FROM 'courses.csv' DELIMITER ',' CSV HEADER;

CREATE TABLE student_courses (
    student_course_id int PRIMARY KEY,
    student_id int REFERENCES students(student_id),
    course_id int REFERENCES courses(course_id),
    enrolled_semester text NOT NULL,
    course_grade text NULL,
    created_at timestamp(0) with time zone NOT NULL DEFAULT NOW()
);

\COPY student_courses(student_course_id, student_id, course_id, enrolled_semester, course_grade) FROM 'student_courses.csv' DELIMITER ',' CSV HEADER;