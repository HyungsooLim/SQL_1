select * from NOTICE;

insert into NOTICE
values(notice_seq.nextval, 'title2', 'writer2', sysdate, 0, 'contents2');

commit work;