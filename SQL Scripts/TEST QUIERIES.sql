USE Student_life;

-- VIEWS

-- 1) Upcoming Assignments
CREATE OR REPLACE VIEW v_upcoming_assignments AS
SELECT a.assignment_id,
c.title AS course_title,
a.name AS assignment_name,
a.due_date
FROM assignments a
JOIN courses c ON a.course_id = c.course_id
WHERE a.due_date >= CURDATE()
ORDER BY a.due_date;

-- 2) Course Performance
CREATE OR REPLACE VIEW v_course_performance AS
SELECT c.title AS course_title,
ROUND(SUM(g.score_points)/SUM(g.out_of_points)*100,2) AS avg_percent
FROM grades g
JOIN assignments a ON g.assignment_id = a.assignment_id
JOIN courses c ON a.course_id = c.course_id
GROUP BY c.title;

-- 3) Study Summary (by user & course)
CREATE OR REPLACE VIEW v_study_summary AS
SELECT u.first_name, u.last_name, c.title AS course_title,
SUM(s.minutes) AS total_minutes,
ROUND(SUM(s.minutes)/60,1) AS total_hours
FROM study_sessions s
JOIN users u ON s.user_id = u.user_id
JOIN courses c ON s.course_id = c.course_id
GROUP BY u.user_id, c.course_id;

-- Sample Queries
	-- Q1. Assignments due in the next 7 days
SELECT c.title AS course_title,
a.name AS assignment_name,
a.type,
a.due_date
FROM assignments a
JOIN courses c ON a.course_id = c.course_id
WHERE a.due_date BETWEEN CURDATE() AND DATE_ADD(CURDATE(), INTERVAL 7 DAY)
ORDER BY a.due_date;

-- Q2. Average grade percentage per course
SELECT c.title AS course_title,
ROUND(SUM(g.score_points)/SUM(g.out_of_points)*100,2) AS avg_percent
FROM grades g
JOIN assignments a ON g.assignment_id = a.assignment_id
JOIN courses c ON a.course_id = c.course_id
GROUP BY c.title
ORDER BY avg_percent DESC;

-- Q3. Study time summary per course
SELECT c.title AS course_title,
SUM(s.minutes) AS total_minutes,
ROUND(SUM(s.minutes)/60,1) AS total_hours
FROM study_sessions s
JOIN courses c ON s.course_id = c.course_id
GROUP BY c.title
ORDER BY total_hours DESC;

-- Q4. Meetings schedule by user and course (upcoming)
SELECT u.first_name,
u.last_name,
c.title AS course_title,
m.meeting_type,
m.start_time,
m.location
FROM meetings m
JOIN users u ON m.user_id = u.user_id
JOIN courses c ON m.course_id = c.course_id
WHERE m.start_time >= CURDATE()
ORDER BY m.start_time;

