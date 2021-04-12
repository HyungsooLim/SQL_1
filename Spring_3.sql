-- 1. NOTICE table 생성 --------------------------------------------
create table NOTICE(
num number constraint notice_num_PK primary key,
title varchar2(200),
writer varchar2(200),
regdate date,
hit number,
contents varchar2(4000)
);

select * from user_constraints;

drop table NOTICE;
-- 2. notice_seq 생성 ----------------------------------------------
create sequence notice_seq;

select * from seq;
drop sequence notice_seq;
-- 3. insert 3개 실행 ----------------------------------------------
insert into NOTICE
values(notice_seq.nextval, 'title2', 'writer2', sysdate, 0, null);

-- 4. select 테스트 ------------------------------------------------
select * from NOTICE;
select title from NOTICE where writer='writer1'
order by regdate desc;

select title, contents from NOTICE;

commit work;
-- 5. delete test ----------------------------------------
delete from NOTICE where num=6;

-- 6. update test ----------------------------------------
update NOTICE set title='title3', writer='writer3' where num=3;

-- 7. paging ---------------------------------------------
-- 10개 조회 160 ~ 151
select * from NOTICE order by num desc;

select * from (
	select rownum R, N.* from (
		select * from NOTICE order by num desc
	) N
)
where R between 1 and 10;

delete NOTICE where num = 157;

select * from member;
select * from BANKBOOK;
select * from ACCOUNT;
-- CMA 가입한 회원의 ID?
--select A.id from ACCOUNT A
--inner join BANKBOOK B
--on A.booknumber = B.booknumber
--where b.bookname='CMA';
select id from account where booknumber=
	(select booknumber from bankbook where bookname='CMA');

select count(num) from notice;

-- bankbook 개수
select count(bookNumber) from BANKBOOK;

-- 10개 조회
select * from (
	select rownum R, B.* from (
		select * from BANKBOOK order by bookNumber desc
	) B
) where r between 1 and 10;

---------------------------------------------------------------
select * from NOTICE order by num desc;
-- writer 컬럼에서 숫자 9가 포함되어 있는 데이터 조회
select * from NOTICE where writer like '%r9%' order by num desc;

----------------------------------------------------------------
-- QnA
create table qna(
num number constraint qna_num_PK primary key,
title varchar2(200),
writer varchar2(200),
regdate date,
hit number,
contents varchar2(4000),
ref number,
step number,
depth number
);

select * from QNA;

create sequence qna_seq;

drop sequence qna_seq;

-- insert test
insert into QNA values(qna_seq.nextval, 't1', 'w1', sysdate, 0, 'c1', 0, 0, 0);

commit work;

---------------------------------------------------------------

select * from QNA order by num desc;

select * from QNA order by ref desc, step asc;

-- 원본글
insert into QNA
values(qna_seq.nextval, 'qt1', 'qw1', sysdate, 0, 'qc1', qna_seq.currval, 0, 0);
insert into QNA
values(qna_seq.nextval, 'qt2', 'qw2', sysdate, 0, 'qc2', qna_seq.currval, 0, 0);

-- 답글
insert into QNA
values(qna_seq.nextval, 'qt1_1', 'qw1_1', sysdate, 0, 'qc_1', 2, 1, 1);
insert into QNA
values(qna_seq.nextval, 'qt1_2', 'qw1_2', sysdate, 0, 'qc_2', 2, 1, 1);

update QNA set step=step+1 where ref=2 and step>0;

drop table QNA;

-- 답 답글
insert into QNA
values(qna_seq.nextval, 'qt1_2_1', 'qw1_2_1', sysdate, 0, 'qc_2_1', 2, 2, 2);

update QNA set step=step+1 where ref=2 and step>1;

commit work;

-- FileUpload -------------------------------------------------------------------
-- 테이블명 : memberFile
-- num			자동증가하는 숫자		PK
-- id			member id				FK
-- fileName		HDD에 저장한 이름
-- originName	서버로upload 할때 이름	
-- fn_seq

select * from MEMBER;

create table memberFile(
num number constraint memberFile_num_PK primary key,
id varchar2(100) constraint memberFile_id_FK references MEMBER on delete cascade,
fileName varchar2(400),
originName varchar2(400)
);

select * from memberFile;
select * from member;

delete from member where id='999';


drop table memberFile;

create sequence fn_seq;
drop sequence fn_seq;
select * from seq;

insert into memberFile
values(fn_seq.nextval, 'id5', 'fn1', 'on1');

delete from MEMBER where id='123456';

commit work;

-- 두 테이블의 데이터를 한번에 조회 ----- JOIN
select * from MEMBER where id='999';
select * from MEMBERFILE where id='999';

select M.*, MF.*
from MEMBER M inner join MEMBERFILE MF
on M.id = MF.id
where M.id = '999';

select M.*, MF.*
from MEMBER M left join MEMBERFILE MF
on M.id = MF.id
--where M.id = 'admin';

-- noticeFiles table --------------------------------------------------------------
-- fileNum		PK sequence
-- num			FK notice cascade
-- fileName
-- originName
-- file_seq

create table noticeFiles(
	fileNum number constraint noticeFiles_fileNum_PK primary key,
	num number constraint noticeFiles_num_FK references NOTICE on delete cascade,
	fileName varchar2(400),
	originName varchar2(400)
);

select * from NOTICE order by num desc;
select * from noticeFiles;

drop table noticeFiles;

create sequence file_seq;
drop sequence file_seq;

insert into noticeFiles
values(file_seq.nextval, 320, 'fn1', 'on1');

commit work;

select max(num) from NOTICE;

-- NOTICE, NOTICEFILES join -----------------------------------
select N.*, NF.*
from NOTICE N inner join NOTICEFILES NF
on 

-- qnaFiles table ----------------------------------------------
-- file_seq 재활용
create table qnaFiles(
	fileNum number constraint qnaFiles_fileNum_PK primary key,
	num number constraint qnaFiles_num_FK references QNA(num) on delete cascade,
	fileName varchar2(400),
	originName varchar2(400)
);
select * from QNA order by num desc;

select * from qnaFiles;

insert into qnaFiles
values(file_seq.nextval, 11, 'fn1', 'on1');

commit work;

select Q.*, QF.*
from QNA Q left join QNAFILES QF
on Q.num = QF.num
where Q.num = 5;

------------------------------------------------------------------------------
-- comment 댓글 테이블
-- commentNum	PK
-- num			notice 글번호 참조 on delete cascade
-- writer
-- contents
-- regDate
-- notice_seq 공유

create table comments(
	commentNum number constraint comments_cn_PK primary key,
	num number constraint comments_num_FK references NOTICE(num) on delete cascade,
	writer varchar2(200),
	contents varchar2(400),
	regDate date
);

select * from comments;

drop table comments;

insert into comments
values(notice_seq.nextval, '321', 'w1', 'c1', sysdate);

insert into comments
values(notice_seq.nextval, '321', 'w2', 'c2', sysdate);

commit work;


select * from NOTICEFILES;

select * from NOTICE order by num desc;

delete from NOTICEFILES
where fileNum = 42

select * from NOTICEFILES where fileNum= 42;









