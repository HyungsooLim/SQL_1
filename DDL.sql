select * from tab;
select * from EX1;

insert into EX1
values(1, 'test', sysdate);

insert into EX1
values(2, null, sysdate);

commit work;

create table point(
	num number primary key,
	name varchar2(200),
	kor number(3) not null,
	eng number(3) check(eng between 0 and 100),
	math number(3),
	total number(3),
	average number(5,2)
);

select * from point;

insert into point values(1, 'st1', 10, 10, 10, 30, 10.0);
insert into point values(2, 'st2', 10, 10, 10, 30, 150.3);

commit work;
rollback work;
-- 컬럼레벨 방식
create table NAVER(
	id varchar2(100) constraint naver_id_PK primary key,
	password varchar2(100),
	name varchar2(100) constraint naver_name_NN not null,
	birth_date date,
	gender varchar(1),                --남자 M, 여자 F, 없으면 null
	email varchar2(100) constraint naver_email_U unique,
	phone_number varchar2(100) constraint naver_phoneNum_U unique
);

create table PICTURE(
	id varchar2(100) constraint picture_id_FK
		references naver on delete cascade,
	fileName varchar2(200)
);

--테이블레벨 방식
create table NAVER(
	id varchar2(100),
	password varchar2(100),
	name varchar2(100) constraint naver_name_NN not null,
	birth_date date,
	gender varchar(1),                --남자 M, 여자 F, 없으면 null
	email varchar2(100),
	phone_number varchar2(100),
	-- 제약조건 설정
	constraint naver_id_PK primary key(id),
	constraint naver_email_U unique(email),
	constraint naver_phonenum_u unique(phone_number)
	-- constraint naver_name_NN not null(name)
);

create table PICTURE(
	id varchar2(100),
	fileName varchar2(200),
	constraint picture_id_FK foreign key(id) references naver
	on delete set null
);

alter table naver drop constraint naver_email_u;
alter table naver add constraint  naver_email_u unique (email);

drop table picture;
drop table naver;
select * from picture;

insert into picture
values('id1', 'id.jpg');

delete naver where id='id1';
delete picture where id='id1';

insert into naver
values('id1', 'pw1', 'name1', '2000-01-01', 'F', 'name1@naver.com', '01011111111');

insert into naver
values('id2', 'pw2', 'name2', '2000-02-02', 'M', 'name1@naver.com', '01022222222');

select * from naver;


select * from departments;

select * from employees where department_id=240;

delete DEPARTMENTS where department_id = 240;

delete EMPLOYEES where department_id = 60;

rollback work;

select constraint_name, constraint_type from user_constraints;

select * from user_constraints;

select * from user_constraints;

drop table EX1;
drop table point;

select * from tab;

commit work;
-----------------------------------------------------
-- 성적관리

-- 학생정보 저장 테이블
-- id, pw, 번호, 이름
-- 성적정보 저장 테이블
-- 국어, 영어, 수학, 총점, 평균
-- 학생이 성적 조회 할때 이름, 번호, 성적들을 조회
create table student(
	id varchar2(100) constraint student_id_PK primary key,
	pw varchar2(100) constraint student_pw_NN not null,
	num number constraint student_num_NN not null,
	name varchar2(100) constraint student_name_NN not null
);

drop table student;

create table grade(
	id varchar2(100) constraint grade_id_FK references student(id),
	kor number(3),
	eng number(3),
	math number(3),
	total number(3),
	average number(5,2)
)

commit work;












