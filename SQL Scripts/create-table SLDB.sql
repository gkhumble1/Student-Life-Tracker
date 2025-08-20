
CREATE DATABASE Student_Life;

USE Student_Life;

CREATE TABLE users (
    user_id INT PRIMARY KEY AUTO_INCREMENT,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    email VARCHAR(100) UNIQUE,
    created_at DATETIME
);

CREATE TABLE courses (
    course_id INT PRIMARY KEY AUTO_INCREMENT,
    code VARCHAR(20),
    title VARCHAR(100),
    term VARCHAR(50),
    instructor VARCHAR(100),
    credits DECIMAL(3,1)
);

CREATE TABLE enrollments (
    enrollment_id INT PRIMARY KEY AUTO_INCREMENT,
    user_id INT,
    course_id INT,
    enrolled_on DATE,
    FOREIGN KEY (user_id) REFERENCES users(user_id),
    FOREIGN KEY (course_id) REFERENCES courses(course_id),
    UNIQUE (user_id, course_id)
);

CREATE TABLE assignments (
    assignment_id INT PRIMARY KEY AUTO_INCREMENT,
    course_id INT,
    name VARCHAR(100),
    type VARCHAR(50),
    due_date DATE,
    weight_pct DECIMAL(5,2),
    FOREIGN KEY (course_id) REFERENCES courses(course_id)
);

CREATE TABLE grades (
    grade_id INT PRIMARY KEY AUTO_INCREMENT,
    user_id INT,
    assignment_id INT,
    score_points DECIMAL(5,2),
    out_of_points DECIMAL(5,2),
    graded_on DATE,
    FOREIGN KEY (user_id) REFERENCES users(user_id),
    FOREIGN KEY (assignment_id) REFERENCES assignments(assignment_id),
    UNIQUE (user_id, assignment_id)
);

CREATE TABLE study_sessions (
    session_id INT PRIMARY KEY AUTO_INCREMENT,
    user_id INT,
    course_id INT,
    session_date DATE,
    minutes INT,
    notes TEXT,
    FOREIGN KEY (user_id) REFERENCES users(user_id),
    FOREIGN KEY (course_id) REFERENCES courses(course_id)
);

CREATE TABLE meetings (
    meeting_id INT PRIMARY KEY AUTO_INCREMENT,
    user_id INT,
    course_id INT NULL,
    meeting_type VARCHAR(50),
    start_time DATETIME,
    location VARCHAR(100),
    notes TEXT,
    FOREIGN KEY (user_id) REFERENCES users(user_id),
    FOREIGN KEY (course_id) REFERENCES courses(course_id)
);
