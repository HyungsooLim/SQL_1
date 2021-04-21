--coupon =================================================================================================
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