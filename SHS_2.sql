create table test(
	num number,
	name varchar2(50),
	contents varchar2(100),
	regDate date
);

create sequence test_seq;

insert into test
values(test_seq.nextval, 'name2', 'contents2', sysdate);

select * from TEST;

commit work;