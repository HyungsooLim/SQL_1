-- member FullStack ------------------------------------------------
select * from tab;

select * from MEMBER;

drop table MEMBER;

select * from ACCOUNT;
drop table ACCOUNT;



drop table TRADE;
select * from TRADE;


delete MEMBER where id='id3';

commit work;

select * from MEMBER
where id='id1' and pw='pw2';

insert into MEMBER
values('id3', 'pw3', 'name3', '010-3333-3333', 'name3@google.com');

-- bankbook FullStack -----------------------------------------------
select * from BANKBOOK;

delete BANKBOOK where booknumber=45;

commit work;

select * from BANKBOOK 
where bookname=

create sequence bankbook_seq
start with 5
nomaxvalue
nominvalue

insert into BANKBOOK
values(bankbook_seq.nextval, , , )

select * from seq;
-- 테이블 수정
update BANKBOOK set bookName='정기예금', bookRate=0.01 where bookNumber=30;


-- ACCOUNT FullStack -------------------------------------------------------
select * from ACCOUNT;

insert into ACCOUNT
values('44-444-4444', 0, sysdate, 'id1', 3);


--description
-------------------------------------------------------------------
select * from tab;
