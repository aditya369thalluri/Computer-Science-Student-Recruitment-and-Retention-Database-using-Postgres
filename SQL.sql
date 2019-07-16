//COMMANDS:

//STUDENT:

CREATE TABLE “STUDENT” (
    student_university_id numeric(10) primary key,
    first_name varchar(100) not null,          
    last_name	varchar(100) not null,  
    middle_name			  varchar(100),
    date_of_birth		         date not null CHECK(date_of_birth<current_date),
    international_yn	                boolean not null,
    pre_majors_yn		         boolean,
    majors_yn			         boolean,
    under_represented_group_name	  varchar(50),
    email				  varchar(100) not null,
    phone				  numeric (10),
    street				  varchar(50),
    apartment				  varchar(50),
    city			  	  varchar(100),
    state				  varchar(50),
    zip				  numeric (5),
    resume_location		         varchar(200)        
    

);




//COURSE:

CREATE TABLE “COURSE” (
    course_code varchar(10) primary key,
    course_name varchar(100) not null,          
    credit_hours	numeric(2)  DEFAULT 0 CHECK(course_fee>=0),
    department varchar(5),
    course_fee numeric(10,5) DEFAULT 0  CHECK(course_fee>=0),
    online_yn boolean,
    required_for_major_transition_yn boolean not null,
);

//0PROGRAM:

CREATE TABLE “PROGRAM” (
program_type varchar(50),
    concentration varchar(100),          
    description	varchar(200),
    total_credits_needed integer DEFAULT 0 CHECK(total_credits_needed>=0),
    total_core_credits_needed integer DEFAULT 0 CHECK(total_core_credits_needed>=0),
    primary key(program_type, concentration),
   constraint credits_check CHECK(total_credits_needed>= total_core_credits_needed)
);

Create domain GRADE varchar(15) NOT NULL CHECK(VALUE IN (‘A’,’B’,’C’,’D’,’F’,’W’));




CREATE TABLE “PRE_REQUISITE” (
course_code varchar(10),
    pre_requisite_course_code varchar(10) references COURSE(course_code),          
    minimum_grade_required	grade,
primary key(course_code, pre_requisite_course_code)

);

CREATE TABLE “PROGRAM_REQUIREMENT” (
program_type varchar(50) ,
concentration varchar(100),          
course_code varchar(10),
minimum_grade_required   grade,
primary key(program_type , concentration ,course_code),
foreign key(program_type , concentration) references PROGRAM(program_type , concentration)

);


Create domain SEMESTER varchar(15) NOT NULL CHECK(VALUE IN (‘fall’,’spring’,’’summer”));

Create domain COURSE_STATUS varchar(20) NOT NULL CHECK(VALUE IN (‘registered’,’completed’,’withdrawn’,’failed’));







CREATE TABLE “ENROLLED_ON” (
student_university_id numeric(10) references STUDENT(student_university_id),
course_code varchar(10) references COURSE(course_code),
semester  semester,
year numeric(4) CHECK(year>0),
start_date date DEFAULT current_date,
end_date date,
course_status course_status,
grade grade,
primary key(student_university_id, course_code, semester  , year),
constraint course_enrolled_dates CHECK(start_date<end_date)
);

Create domain SURVEY varchar(20) NOT NULL CHECK(VALUE IN (‘pre-major’,’major’,’exit’));

CREATE TABLE “SURVEY” (
survey_type  survey,
question varchar(400),
primary key(survey_type, question)
);

Create table “STUDENT_PEER_MENTOR” (
student_university_id  numeric(10) references STUDENT(student_university_id),
mentor_id numeric(10) references STUDENT(student_university_id),
semester semester,
year    numeric(4) CHECK(year>0)
primary key(student_university_id, semester, year)
);
Create table “GIVES” (
student_university_id  numeric(10) references STUDENT(student_university_id),
survey_type  survey_type,
question varchar(400),
survey_date date DEFAULT current_date,
rating  integer CHECK(0<=rating<=5),
comment varchar(200),
foreign key(survey_type, question) references SURVEY(survey_type, question),
primary key(student_university_id, survey_type, question, survey_date)
);

Create table “INCIDENT” (
incident_category varchar(20),
description        varchar(200),
primary key(incident_category)
); 

Create table “FOLLOW_UP” (
student_university_id  numeric(10) references STUDENT(student_university_id),
incident_category varchar(20) references INCIDENT(incident_category),
incident_date date CHECK(incident_date<=current_date),
incident_time time,
necessary_action varchar(200),
primary key(student_university_id, incident_category, incident_category, incident_time)
);




Create table “OPTS_FOR” (
student_university_id  numeric(10) references STUDENT(student_university_id),
program_type varchar(50) ,
concentration varchar(100),   
opted_semester semester,
opted_year numeric(4) CHECK(opted_year>0),
start_date date DEFAULT current_date,
end_date date,
overall_grade grade,
status varchar(20) ,
primary key(student_university_id, program_type, concentration, opted_semester, opted_year),
foreign key(program_type , concentration) references PROGRAM(program_type , concentration),
constraint program_dates_check CHECK(start_date<end_date)       
);
















//INSERT COMMANDS:

//STUDENT: 
INSERT INTO STUDENT(student_university_id, first_name,  last_name,  date_of_birth,    international_yn,  pre_majors_yn, majors_yn, under_represented_group_name	, email,phone,street,	  apartment, city,  state,zip,  resume_location)
VALUES(
(101960001,’Virat’,’Kohli’,02-10-1985,True,True,False,’Asian’,’vk@cs.edu’, 1505666901, “Gandhi Ave”, ‘Apt 1’, ‘Raja Apts’, ‘ABQ’,’NM’,87101,’www.cs.edu/resume/101960001.pdf’),
(101960002,’MS’,Dhoni,12-02-1981,False,True,False,’Asian’,’ms@cs.edu’, 1505621702, ‘Nehru Ave’, ‘Apt 2’, ‘Rani Apts’, ‘ABQ’,’NM’,87106,’www.cs.edu/resume/101960002.pdf’),
(101960003,’Jhon’,’Cena’,03-06-1990,False,True,True,’’,’jc@cs.edu’, 1415621602, ‘Lead Ave’, ‘Apt 9’, ‘RJ Apts’, ‘ABQ’,’NM’,87110,’www.cs.edu/resume/101960003.pdf’),
(101960004,’Randy’,’Ortan’ ,01-01-1991,True,True,True,’’,’ro@cs.edu’, 1765621602, ‘Copper Ave’, ‘Apt 9’, ‘Kings Apts’, ‘ABQ’,’NM’,87109,’www.cs.edu/resume/101960004.pdf’),
(101960005,’Aakarsh’,’Nadella’ ,01-03-1995,True,False,True,’Hispanic’,’an@cs.edu’, 1765621505, ‘Gold Ave’, ‘Apt 9’, ‘Queens Apts’, ‘ABQ’,’NM’,87100,’www.cs.edu/resume/101960005.pdf’)
);













//DATA INSERTION:
//To insert the data, we create the data for each of the tables in a comma separated value(CSV) file and import them into postgres using the below commands.
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











		         



//QUERIES:
//Query 1: : Given a student, show all the necessary information to describe how far along is that student in their program of study
SELECT STUDENT.student_university_id AS “StudentID”
	,first_name AS “FirstName”
	,last_name AS “LastName”
	,program_type AS “ProgramType”
	,concentration AS “Concentration”
	,OPTS_FOR.start_date AS “ProgramStartDate”
	,sum(COURSE.credit_hours) AS “CreditHoursApproved”
	,count(DISTINCT (
			ENROLLED_ON.semester
			,ENROLLED_ON.year
			)) AS “SemestersRegistered”
	,overall_grade AS “OverallGrade”
	,OPTS_FOR.STATUS AS “ProgramStatus”
FROM STUDENT
INNER JOIN OPTS_FOR ON STUDENT.student_university_id = OPTS_FOR.student_university_id
INNER JOIN ENROLLED_ON ON STUDENT.student_university_id = ENROLLED_ON.student_university_id
INNER JOIN COURSE ON COURSE.course_code = ENROLLED_ON.course_code
WHERE course_status = ”completed”
	AND STUDENT.student_university_id = 101960001
GROUP BY STUDENT.student_university_id
	,program_type
	,concentration
	,OPTS_FOR.start_date
	,overall_grade
	,OPTS_FOR.STATUS

 





//Query 2: 
//1.	Total number of students who are premajors.
SELECT count(*)
FROM STUDENT
WHERE pre_majors_yn = True
	AND majors_yn = False

 

//2.	Total number of students who are majors (or enrolled in the MSc or the PhD program)
SELECT count(*)
FROM STUDENT
WHERE majors_yn = True

 

//3.	Total number of students who entered the program this year.
SELECT count(*)
FROM OPTS_FOR
WHERE extract(year FROM start_date) = 2019

 




//4.	Total number of students who are active, i.e. enrolled in course for the current semester
SELECT count(DISTINCT student_univesity_id)
FROM ENROLLED_ON
WHERE year = 2019
	AND semester = ‘spring’

 

//5.	Total number of students in the program of study
SELECT program_type AS ProgramType
	,concentration AS Concentration
	,count(*) AS NumberOfStudents
FROM OPTS_FOR
GROUP BY program_type
	,concentration;

 

//6.	How many students graduated this year
SELECT count(*)
FROM OPTS_FOR
WHERE extract(year FROM end_date) = 2019
     





//7.	How many students in each category belong to under-represented groups
SELECT under_represented_group_name
	,count(*) AS NumberOfStudents
FROM STUDENT
GROUP BY under_represented_group_name;

 

//Query 3: List of students who participated in a specific activity of recruitment/retention. Provide the total number of students by gender.
SELECT R1.student_university_id AS "StudentID"
	,first_name AS "FirstName"
	,last_name AS "LastName"
	,activity_name AS "ActivityName"
	,activity_date AS "ActivityDate"
FROM STUDENT_PARTICIPATION R1
INNER JOIN STUDENT R2 ON R1.student_university_id = R2.student_university_id
WHERE R1.activity_type = 'recruitment'
	AND activity_name = 'Career fair';

 

SELECT activity_name AS "ActivityName"
	,activity_date AS "ActivityDate"
	,R2.gender AS "Gender"
	,count(*) AS "Count"
FROM STUDENT_PARTICIPATION R1
INNER JOIN STUDENT R2 ON R1.student_university_id = R2.student_university_id
WHERE R1.activity_type = 'recruitment'
	AND activity_name = 'Career fair'
GROUP BY activity_name
	,activity_date
	,gender
 


//Query 4: List the names of the tutors, the student mentors, and the faculty mentors, provide the total of persons in each category. For tutors, list the courses they are able to tutor for. For mentors, indicate how many students they are mentoring and the list of students mentors.
SELECT CONCAT (
		first_name
		,last_name
		) AS "Name"
	,'Tutor' AS "Type"
FROM TUTORING
INNER JOIN EMPLOYEE ON TUTORING.employee_id = EMPLOYEE.employee_id

UNION

SELECT CONCAT (
		first_name
		,last_name
		) AS "Name"
	,'Student Mentor' AS "Type"
FROM STUDENT_PEER_MENTOR
INNER JOIN STUDENT ON STUDENT_PEER_MENTOR.mentor_id = STUDENT.student_university_id

UNION

SELECT CONCAT (
		first_name
		,last_name
		) AS "Name"
	,'Faculty Mentor' AS "Type"
FROM EMPLOYEE
INNER JOIN ADVISEMENT ON EMPLOYEE.employee_id = ADVISEMENT.employee_id
	AND advisement_type = 'mentoring'
ORDER BY "Type";
 
 

SELECT CONCAT (
		first_name
		,last_name
		) AS “TutorName”
	,course_name AS “TutorCourse”
FROM Tutoring
INNER JOIN EMPLOYEE ON TUTORING.employee_id = EMPLOYEE.employee_id
INNER JOIN COURSE ON Tutoring.course_code = COURSE.course_code

 

SELECT CONCAT (
		first_name
		,last_name
		) AS "FacultyMentorName"
	,count(*) AS "StudentCount"
FROM ADVISEMENT
INNER JOIN EMPLOYEE ON ADVISEMENT.employee_id = EMPLOYEE.employee_id
WHERE advisement_type = '
mentoring'
GROUP BY first_name
	,last_name;
 

SELECT CONCAT (
		first_name
		,last_name
		) AS “Student Mentor”
FROM STUDENT_PEER_MENTOR NATURAL
INNER JOIN STUDENT
 

//Query 5: 
Select * from GIVES where extract(year from survey_date)=2018
 


//Query 6: 
Select  course_name, grade, count(grade) from ENROLLED_ON INNER JOIN COURSE ON ENROLLED_ON.course_code = COURSE.course_code  where year = 2018 and semester=’spring’ group by course_name, grade order by course_name, grade
 
//Query 7 : 
Given a faculty member, list the names of the students they advise and any details about the advisement given.

SELECT DISTINCT CONCAT (
		first_name
		,last_name
		) AS "FacultyAdvisedStudents"
FROM ADVISEMENT
INNER JOIN STUDENT ON ADVISEMENT.student_university_id = STUDENT.student_university_id
WHERE employee_id = 1012345868;
 

//Query 8 : List the faculty members who do not advise nor mentor any student.

SELECT EMPLOYEE.*
FROM FACULTY
INNER JOIN EMPLOYEE ON FACULTY.employee_id = EMPLOYEE.employee_id
WHERE EMPLOYEE.employee_id NOT IN (
		SELECT employee_id
		FROM ADVISEMENT
		);
 

//Query 9: List the tutors with their names and courses they are able to tutor for
SELECT CONCAT (
		first_name
		,last_name
		) AS “TutorName”
	,course_name AS “TutorCourse”
FROM Tutoring
INNER JOIN EMPLOYEE ON TUTORING.employee_id = EMPLOYEE.employee_id
INNER JOIN COURSE ON Tutoring.course_code = COURSE.course_code

 

//Query 10: : List the information about the tutors who belong to under-represented groups.
SELECT CONCAT (
		first_name
		,last_name
		) AS "Tutor"
	,under_represented_group_name
FROM TUTOR_STUDENT
INNER JOIN STUDENT ON STUDENT.student_university_id = TUTOR_STUDENT.student_university_id
WHERE und er_represented_group_name <> NULL
	OR under_represented_group_name <> '';
 

//Query 11. 
Select * from STUDENT where student_university_id  in (SELECT e1.student_university_id from ENROLLED_ON e1 INNER JOIN ENROLLED_ON e2 ON e1. student_university_id = e2. student_university_id where e1.semester = e2.semester and e1.year= e2.year and (e1.course_code,e2.course_code) in (select course_code,pre_requisite_course_code from PRE_REQUISITE))

 





















CREATE TABLE “COURSE” (
	course_code VARCHAR(10) PRIMARY KEY
	,course_name VARCHAR(100) NOT NULL
	,credit_hours NUMERIC(2) DEFAULT 0 CHECK (course_fee >= 0)
	,department VARCHAR(5)
	,course_fee NUMERIC(10, 5) DEFAULT 0 CHECK (course_fee >= 0)
	,online_yn boolean
	,required_for_major_transition_yn boolean NOT NULL
	,
	);

CREATE TABLE “PROGRAM” (
	program_type VARCHAR(50)
	,concentration VARCHAR(100)
	,description VARCHAR(200)
	,total_credits_needed INT DEFAULT 0 CHECK (total_credits_needed >= 0)
	,total_core_credits_needed INT DEFAULT 0 CHECK (total_core_credits_needed >= 0)
	,PRIMARY KEY (
		program_type
		,concentration
		)
	,CONSTRAINT credits_check CHECK (total_credits_needed >= total_core_credits_needed)
	);

CREATE domain GRADE VARCHAR(15) NOT NULL CHECK (
	VALUE IN (
		‘A’
		,’B’
		,’C’
		,’D’
		,’F’
		,’W’
		)
	);

CREATE TABLE “PRE_REQUISITE” (
	course_code VARCHAR(10)
	,pre_requisite_course_code VARCHAR(10) REFERENCES COURSE(course_code)
	,minimum_grade_required grade
	,PRIMARY KEY (
		course_code
		,pre_requisite_course_code
		)
	);

CREATE TABLE “PROGRAM_REQUIREMENT” (
	program_type VARCHAR(50)
	,concentration VARCHAR(100)
	,course_code VARCHAR(10)
	,minimum_grade_required grade
	,PRIMARY KEY (
		program_type
		,concentration
		,course_code
		)
	,FOREIGN KEY (
		program_type
		,concentration
		) REFERENCES PROGRAM(program_type, concentration)
	);

CREATE domain SEMESTER VARCHAR(15) NOT NULL CHECK (
	VALUE IN (
		‘fall’
		,’spring’
		,’’summer”
		)
	);

CREATE domain COURSE_STATUS VARCHAR(20) NOT NULL CHECK (
	VALUE IN (
		‘registered’
		,’completed’
		,’withdrawn’
		,’failed’
		)
	);

CREATE TABLE “ENROLLED_ON” (
	student_university_id NUMERIC(10) REFERENCES STUDENT(student_university_id)
	,course_code VARCHAR(10) REFERENCES COURSE(course_code)
	,semester semester
	,year NUMERIC(4) CHECK (year > 0)
	,start_date DATE DEFAULT CURRENT_DATE
	,end_date DATE
	,course_status course_status
	,grade grade
	,PRIMARY KEY (
		student_university_id
		,course_code
		,semester
		,year
		)
	,CONSTRAINT course_enrolled_dates CHECK (start_date < end_date)
	);

CREATE domain SURVEY VARCHAR(20) NOT NULL CHECK (
	VALUE IN (
		‘pre - major’
		,’major’
		,’exit’
		)
	);

CREATE TABLE “SURVEY” (
	survey_type survey
	,question VARCHAR(400)
	,PRIMARY KEY (
		survey_type
		,question
		)
	);

CREATE TABLE “STUDENT_PEER_MENTOR” (
	student_university_id NUMERIC(10) REFERENCES STUDENT(student_university_id)
	,mentor_id NUMERIC(10) REFERENCES STUDENT(student_university_id)
	,semester semester
	,year NUMERIC(4) CHECK (year > 0) PRIMARY KEY (
		student_university_id
		,semester
		,year
		)
	);

CREATE TABLE “GIVES” (
	student_university_id NUMERIC(10) REFERENCES STUDENT(student_university_id)
	,survey_type survey_type
	,question VARCHAR(400)
	,survey_date DATE DEFAULT CURRENT_DATE
	,rating INT CHECK (0 <= rating <= 5)
	,comment VARCHAR(200)
	,FOREIGN KEY (
		survey_type
		,question
		) REFERENCES SURVEY(survey_type, question)
	,PRIMARY KEY (
		student_university_id
		,survey_type
		,question
		,survey_date
		)
	);

CREATE TABLE “INCIDENT” (
	incident_category VARCHAR(20)
	,description VARCHAR(200)
	,PRIMARY KEY (incident_category)
	);

CREATE TABLE “FOLLOW_UP” (
	student_university_id NUMERIC(10) REFERENCES STUDENT(student_university_id)
	,incident_category VARCHAR(20) REFERENCES INCIDENT(incident_category)
	,incident_date DATE CHECK (incident_date <= CURRENT_DATE)
	,incident_time TIME
	,necessary_action VARCHAR(200)
	,PRIMARY KEY (
		student_university_id
		,incident_category
		,incident_category
		,incident_time
		)
	);

CREATE TABLE “OPTS_FOR” (
	student_university_id NUMERIC(10) REFERENCES STUDENT(student_university_id)
	,program_type VARCHAR(50)
	,concentration VARCHAR(100)
	,opted_semester semester
	,opted_year NUMERIC(4) CHECK (opted_year > 0)
	,start_date DATE DEFAULT CURRENT_DATE
	,end_date DATE
	,overall_grade grade
	,STATUS VARCHAR(20)
	,PRIMARY KEY (
		student_university_id
		,program_type
		,concentration
		,opted_semester
		,opted_year
		)
	,FOREIGN KEY (
		program_type
		,concentration
		) REFERENCES PROGRAM(program_type, concentration)
	,CONSTRAINT program_dates_check CHECK (start_date < end_date)
	);



