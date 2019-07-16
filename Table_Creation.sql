/*COMMANDS:*/

/*STUDENT:*/

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




/*COURSE:*/

CREATE TABLE “COURSE” (
    course_code varchar(10) primary key,
    course_name varchar(100) not null,          
    credit_hours	numeric(2)  DEFAULT 0 CHECK(course_fee>=0),
    department varchar(5),
    course_fee numeric(10,5) DEFAULT 0  CHECK(course_fee>=0),
    online_yn boolean,
    required_for_major_transition_yn boolean not null,
);

/*PROGRAM:*/

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










