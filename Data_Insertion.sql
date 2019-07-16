/*INSERT COMMANDS:*/

/*STUDENT: */
INSERT INTO STUDENT(student_university_id, first_name,  last_name,  date_of_birth,    international_yn,  pre_majors_yn, majors_yn, under_represented_group_name	, email,phone,street,	  apartment, city,  state,zip,  resume_location)
VALUES(
(101960001,’Virat’,’Kohli’,02-10-1985,True,True,False,’Asian’,’vk@cs.edu’, 1505666901, “Gandhi Ave”, ‘Apt 1’, ‘Raja Apts’, ‘ABQ’,’NM’,87101,’www.cs.edu/resume/101960001.pdf’),
(101960002,’MS’,Dhoni,12-02-1981,False,True,False,’Asian’,’ms@cs.edu’, 1505621702, ‘Nehru Ave’, ‘Apt 2’, ‘Rani Apts’, ‘ABQ’,’NM’,87106,’www.cs.edu/resume/101960002.pdf’),
(101960003,’Jhon’,’Cena’,03-06-1990,False,True,True,’’,’jc@cs.edu’, 1415621602, ‘Lead Ave’, ‘Apt 9’, ‘RJ Apts’, ‘ABQ’,’NM’,87110,’www.cs.edu/resume/101960003.pdf’),
(101960004,’Randy’,’Ortan’ ,01-01-1991,True,True,True,’’,’ro@cs.edu’, 1765621602, ‘Copper Ave’, ‘Apt 9’, ‘Kings Apts’, ‘ABQ’,’NM’,87109,’www.cs.edu/resume/101960004.pdf’),
(101960005,’Aakarsh’,’Nadella’ ,01-03-1995,True,False,True,’Hispanic’,’an@cs.edu’, 1765621505, ‘Gold Ave’, ‘Apt 9’, ‘Queens Apts’, ‘ABQ’,’NM’,87100,’www.cs.edu/resume/101960005.pdf’)
);













/*DATA INSERTION:*/
/*To insert the data, we create the data for each of the tables in a comma separated value(CSV) file and import them into postgres using the below commands.*/
COPY  STUDENT(student_university_id, first_name,  last_name,  date_of_birth,    international_yn,  pre_majors_yn, majors_yn, under_represented_group_name	, email,phone,street,	  apartment, city,  state,zip,  resume_location)
FROM ‘./STUDENT.csv’  DELIMITER ‘,’ CSV HEADER
\copy  STUDENT(student_university_id, first_name,  last_name,  date_of_birth,    international_yn,  pre_majors_yn, majors_yn, under_represented_group_name , email,phone,street,   apartment, city,  state,zip,  resume_location)
FROM '/STUDENT.csv'  DELIMITER ',' CSV HEADER

\copy  COURSE(course_code,course_name,department,course_fee,online_yn,required_for_major_transition_yn)
FROM './COURSE.csv'  DELIMITER ',' CSV HEADER encoding ‘windows-1251’

\copy  PROGRAM(program_type,concentration,description, total_credits_needed, total_core_credits_needed )
FROM './PROGRAM.csv'  DELIMITER ',' CSV HEADER encoding ‘windows-1251’

\copy  PRE_REQUISITE(course_code,pre_requisite_course_code, minimum_grade_required)
FROM './PRE-REQUISITE.csv'  DELIMITER ',' CSV HEADER encoding ‘windows-1251’

\copy  PROGRAM_REQUIREMENT(program_type, concentration, course_code, minimum_grade_required)
FROM './PROGRAM_REQUIREMENT.csv'  DELIMITER ',' CSV HEADER encoding ‘windows-1251’
\copy  ENROLLED_ON(student_university_id, course_code, semester, year, start_date, end_date, course_status, grade)
FROM './ENROLLED_ON.csv'  DELIMITER ',' CSV HEADER encoding ‘windows-1251’

\copy  SURVEY(survey_type,question)
FROM './SURVEY_ON.csv'  DELIMITER ',' CSV HEADER encoding ‘windows-1251’

\copy  STUDENT_PEER_MENTOR(student_university_id, mentor_id, semester, year)
FROM './ STUDENT_PEER_MENTOR.csv'  DELIMITER ',' CSV HEADER encoding ‘windows-1251’
\copy  GIVES(student_university_id, survey_type, question, survey_date,rating,comment)
FROM './GIVES.csv'  DELIMITER ',' CSV HEADER encoding ‘windows-1251’

\copy  INCIDENT(incident_category, description)
FROM './INCIDENT.csv'  DELIMITER ',' CSV HEADER encoding ‘windows-1251’

\copy  FOLLOW_UP(student_university_id, incident_category, incident_date,incident_time, necessary_action )
FROM './FOLLOW_UP.csv'  DELIMITER ',' CSV HEADER encoding ‘windows-1251’
\copy  OPTS_FOR(student_university_id, program_type, concentration, opted_semester
,year,start_date,end_date, overall_grade,status )
FROM './OPTS_FOR.csv'  DELIMITER ',' CSV HEADER encoding ‘windows-1251’

\copy  ACTIVITY(activity_name, activity_type, organized_by, organizer_mail, organizer_phone)
FROM './ ACTIVITY.csv'  DELIMITER ',' CSV HEADER encoding ‘windows-1251’

\copy  EMPLOYEE(employee_id, ssn, first_name, middle_name, last_name, email, work_experience, salary)
FROM './ EMPLOYEE.csv'  DELIMITER ',' CSV HEADER encoding ‘windows-1251’

copy  FACULTY (employee_id, specialization, research_interest )
FROM './ FACULTY.csv'  DELIMITER ',' CSV HEADER encoding ‘windows-1251’

\copy  ADVISEMENT (student_university_id,employee_id, advisement_type, year, semester)
FROM './ADVISEMENT.csv'  DELIMITER ',' CSV HEADER encoding ‘windows-1251
\copy  TUTORING (course_code,employee_id)
FROM './TUTORING.csv'  DELIMITER ',' CSV HEADER encoding ‘windows-1251
\copy  TAUGHT_BY (course_code,employee_id,semester, year, lecture_hall_name, lecture_room_number, start_time, end_time)
FROM './ TAUGHT_BY.csv'  DELIMITER ',' CSV HEADER encoding ‘windows-1251’;

\copy  TUTOR_STUDENT (student_university_id,employee_id)
FROM './TUTOR_STUDENT.csv'  DELIMITER ',' CSV HEADER encoding ‘windows-1251’;

\copy  STUDENT_PARTICIPATION (student_university_id, activity_name, activity_type, activity_date  , start_time, venue, duration)
FROM './STUDENT_PARTICIPATION.csv'  DELIMITER ',' CSV HEADER encoding ‘windows-1251’;











		         
