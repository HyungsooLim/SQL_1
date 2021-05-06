--COUPON =================================================================================================
create table coupon (
couponNum varchar2(400) constraint COUPON_CPNUM_PK primary key,
id varchar2(100) constraint COUPON_ID_FK references member (id) on delete cascade not null,
disRate number not null,
disPrice number not null,
usage varchar2(10) not null
);

--coupon insert
insert into coupon values ('couponNum1','id1',1,1,'Y');
insert into coupon values ('couponNum2','id2',2,2,'Y');
insert into coupon values ('couponNum3','id3',3,3,'Y');

select * from COUPON order by couponNum desc;

drop table coupon;

commit work;

update COUPON set usage='N' where couponNum='couponNum1';

select count(couponNum) from COUPON

--MEMBER =================================================================================================

select * from MEMBER;

insert into MEMBER
values(member_seq.nextval,'admin','admin','HS','010-6426-0892','admin@gmail.com');

commit work;

select * from XMEMBER;

select * from ADDRESSINFO;

select count(id) from MEMBER;

select * from MEMBER where id like '%3%' order by id desc;

select rowNum, M.* from (select * from MEMBER) M;
-----------------------------------------------------

select xId id, xName name, orderPw pw, M.* from XMEMBER

select X.*, M.* from (select rowNum, XMEMBER.* from XMEMBER) X
full join (select rowNum, MEMBER.* from MEMBER) M
on X.rowNum = M.rowNum;


select rowNum , XMEMBER.* from XMEMBER;
select rowNum , M.* from MEMBER M;

-- ADDRESSINFO ---------------------------------------
select * from ADDRESSINFO where id='id3' order by addressNum desc;

insert into addressInfo values (addr_seq.nextval,'id3',33,'majorAddr33','minorAddr33','addMessage33', null);

commit work;

-- orderInfo------------------------------------------
select * from ADDRESSINFO where orderNum=1;
insert into addressInfo values (addr_seq.nextval,1,'id1',2, 'productName2',200,1,'name1','1123-123','Addr1','phone1','email1','addMessage1');
select count(addressNum) from ADDRESSINFO where orderNum=1;

select P.productName from PRODUCT P
inner join ADDRESSINFO A
on P.productNum = A.productNum
where A.orderNum=1;

commit work;



