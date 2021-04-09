-- ex) 은행 입출금
-- 1. 회원가입 : id, pw, 이름, 전화번호, 이메일
-- 2. 통장 정보 : 통장이름, 통장번호, 이자율, 판매여부
-- 3. 통장개설 : 잔액, 개설날짜, 통장정보, 회원정보, 계좌번호
-- 4. 입출금 : 거래날짜, 거래금액, 거래잔액, 입출금여부
create table member(
	id varchar2(100) constraint member_id_PK primary key,
	pw varchar2(100) constraint member_pw_NN not null,
	name varchar2(100),
	phone varchar2(100),
	email varchar2(100)
);
insert into member
values('id1', 'pw1', 'name1', '010-1111-1111', 'name1@google.com');
insert into member
values('id2', 'pw2', 'name2', '010-2222-2222', 'name2@naver.com');
drop table member;
-------------------------------------------------------------
create table bankbook(
	bookNumber number,
	bookName varchar2(100),
	bookRate number(3,3), -- check
	bookSale varchar2(1), -- Y 판매, N 판매중지
	constraint bankbook_bn_PK primary key(bookNumber)
);
insert into bankbook
values(1, '자유입출금', '0.012', 'Y');
insert into bankbook
values(2, '청약저축', '0.022', 'Y');
insert into bankbook
values(3, 'CMA', '0.03', 'Y');
insert into bankbook
values(4, '정기적금', '0.016', 'Y');
drop table bankbook;
delete bankbook where booknumber = 4;
--------------------------------------------------------------
create table account(
	AccountNumber varchar2(100) constraint account_AN_PK primary key,
	AccountBalance number default 0,
	AccountDate date default sysdate,
	id varchar2(100) constraint account_id_FK references member,
	booknumber number constraint account_bn_FK references bankbook
);
insert into account(accountnumber, id, booknumber)
values('11-111-1111', 'id1', 1);
insert into account(accountnumber, id, booknumber)
values('22-222-2222', 'id2', 2);
delete ACCOUNT;
drop table account;
-----------------------------------------------------------------
--id1의 통장 잔액과, 통장 이름, 통장 계좌번호, 이자율 조회
select A.accountBalance, B.bookName, A.accountNumber, B.bookRate
from account A
inner join bankBook B
on A.bookNumber = B.bookNumber
where A.id = 'id1';
-----------------------------------------------------------------
create table trade(
	tradeNumber number constraint trade_TN_PK primary key,
	accountNumber varchar2(100) constraint trade_AN_FK references account,
	tradeDate date,
	tradeAmount number,
	tradeBalance number,
	tradeIO varchar2(1) -- 입금:I 출금:O
);
drop table trade;
-- 입출금(trade)
-- id1이 입출금 통장에 10만원을 입금
insert into trade(tradeNumber, accountNumber, tradeDate, tradeAmount, tradeBalance, tradeIO)
values(1, '11-111-1111', sysdate, 100000, 100000, 'I');

insert into trade(tradeNumber, accountNumber, tradeDate, tradeAmount, tradeBalance, tradeIO)
values(3, '11-111-1111', sysdate, 80000, 180000, 'I');

insert into trade(tradeNumber, accountNumber, tradeDate, tradeAmount, tradeBalance, tradeIO)
values(4, '11-111-1111', sysdate, 30000, 150000, '0');

update ACCOUNT set accountBalance=100000 where accountNumber = '11-111-1111';
update ACCOUNT set accountBalance=180000 where accountNumber = '11-111-1111';
update ACCOUNT set accountBalance=150000 where accountNumber = '11-111-1111';
-- id1의 입출금 통장의 거래 내역 조회
select * from TRADE
where accountnumber = '11-111-1111';
-- id1이 청약통장 가입
-- 입출금 각각 2번
insert into ACCOUNT(accountNumber, accountBalance, accountDate, ID, bookNumber)
values('33-333-3333', 0, sysdate, 'id1', 2);

insert into trade(tradeNumber, accountNumber, tradeDate, tradeAmount, tradeBalance, tradeIO)
values(5, '33-333-3333', sysdate, 30000, 30000, 'I');
update ACCOUNT set accountBalance=30000 where accountNumber = '33-333-3333';
insert into trade(tradeNumber, accountNumber, tradeDate, tradeAmount, tradeBalance, tradeIO)
values(6, '33-333-3333', sysdate, 20000, 10000, 'O');
update ACCOUNT set accountBalance=10000 where accountNumber = '33-333-3333';
insert into trade(tradeNumber, accountNumber, tradeDate, tradeAmount, tradeBalance, tradeIO)
values(7, '33-333-3333', sysdate, 30000, 40000, 'I');
update ACCOUNT set accountBalance=40000 where accountNumber = '33-333-3333';
insert into trade(tradeNumber, accountNumber, tradeDate, tradeAmount, tradeBalance, tradeIO)
values(8, '33-333-3333', sysdate, 20000, 20000, 'O');

update ACCOUNT set accountBalance=(select tradebalance from TRADE
where accountNumber = '33-333-3333' and tradeNumber = (select max(tradeNumber) from trade)) 
where accountNumber = '33-333-3333';
----------------------------------------------------------------------------------------------
insert into trade(tradeNumber, accountNumber, tradeDate, tradeAmount, tradeBalance, tradeIO)
values(2, '22-222-2222', sysdate, 20000, 20000, 'I');

update ACCOUNT set accountBalance=20000 where accountNumber = '22-222-2222';
------------------------------------------------------------------------------
-- id1의 입출금 통장의 거래내역 조회
select * from trade where accountnumber='11-111-1111' order by tradedate desc;

-- id1의 청약통장에서 입금의 총 합계 조회
select sum(tradeAmount) from TRADE where accountNumber='33-333-3333' and tradeIO='I';

-- id1의 청약통장에서 출금의 총합계 조회 컬럼명을 출금으로 표현
select sum(tradeAmount) 출금 from TRADE where accountNumber='33-333-3333' and tradeIO='O';

-- id1의 청약통장에서 입금의 총합계 (입금) 와 출금의 총합계 (출금)
select sum(tradeAmount) 입출금 from TRADE
where accountNumber='33-333-3333'
group by tradeIO;

-- 통장의 고유번호가 2인 통장에 가입한 회원들의 EMAIL 주소 조회
select M.email from MEMBER M
inner join ACCOUNT A
on M.id = A.id
where A.booknumber = 2;

select email from MEMBER
where id in (select id from ACCOUNT where booknumber = 2);

-- id1이 가입한 통장이름, 계좌번호, 잔액 조회
select B.bookname, A.accountnumber, A.accountbalance
from bankbook B
inner join account A
on B.booknumber = A.booknumber
where A.id = 'id1';

-- 상품의 고유번호,상품명, 상품별 총 계좌 수, 잔액 조회
select A.booknumber, B.bookname, A."count", A."sum" 
from (select booknumber, count(booknumber) "count", sum(accountbalance) "sum"
		from ACCOUNT
		group by booknumber) A
inner join bankbook B
on A.booknumber = B.booknumber;

-- 계좌를 아무도 개설하지 않은 상품명??
-- distinct, outer join
select B.bookname from BANKBOOK B
full join account A
on B.booknumber = A.booknumber
where A.id is null;

select bookname from (select B.*, A.* from bankbook B left join account A
on B.booknumber = A.booknumber) where id is null;
------------------------------------------------------
--trade number 1 증감
insert into trade(tradeNumber, accountNumber, tradeDate, tradeAmount, tradeBalance, tradeIO)
values((select max(tradenumber)+1 from TRADE), '33-333-3333', sysdate, 20000, 40000, 'I');

--Sequence
create sequence trade_seq
start with 10
increment by 1
nomaxvalue
nominvalue
nocycle;

select * from seq;

insert into trade(tradeNumber, accountNumber, tradeDate, tradeAmount, tradeBalance, tradeIO)
values(trade_seq.nextval, '33-333-3333', sysdate, 20000, 100000, 'I');
select trade_seq.nextval from dual;
select trade_seq.currval from dual;

drop sequence trade_seq;
-----------------------------------------------------------------
select * from member;
select * from bankbook;
select * from account;
select * from trade order by tradenumber asc;
select * from user_constraints order by constraint_name asc;
select * from tab;

commit work;
rollback work;
----------------------------------0308----------------------------
alter table member add age number(3,0);
alter table member drop column age;
alter table member rename column mobile to phone;

update member set name='name1';

