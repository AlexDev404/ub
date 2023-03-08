-- SELECT S.student_id, D.district
-- FROM students AS S 
-- INNER JOIN districts AS D 
-- ON S.district_id = D.district_id
-- WHERE D.district = 'CAYO'
-- LIMIT 15;

SELECT S.student_id, C.course_title, SC.course_grade
FROM students AS S 
INNER JOIN student_courses AS SC
ON S.student_id = SC.student_id
INNER JOIN courses AS C 
ON SC.course_id = C.course_id
ORDER BY SC.course_grade ASC
LIMIT 30;