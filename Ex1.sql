-- 네이버 사전 만드렁
-- 1. 네이버 회원 로그인 : id, pw, 이름, 생년월일, 전화번호, 성별
-- 2. 사전 : 단어, 뜻, 연관 단어, 예문, 숙어
-- 3. 단어장(MyDic) : 단어(FK), 뜻, 연관 단어, 예문, 숙어

-- MEMBERS table 생성 -------------------------------------------
create table members(
	id varchar2(100) constraint members_id_PK primary key,
	pw varchar2(100) constraint members_pw_NN not null,
	name varchar2(50) constraint members_name_NN not null,
	birth date default sysdate,
	phone varchar2(50),
	sex varchar2(1) constraint members_sex_C check(sex in('M', 'F')) -- M/F
);
insert into MEMBERS
values('id1', 'pw1', 'name1', '92/08/29', '010-1111-1111', 'M');
delete MEMBERS where id='id2';
drop table members;
select * from MEMBERS;
-- KORDIC table 생성 --------------------------------------------
create table kordic(
	wordNumber number constraint kordic_wordNumber_PK primary key,
	word varchar2(100) constraint kordic_word_NN not null,
	meaning varchar2(500) constraint kordic_meaning_NN not null,
	related varchar2(100) default null,
	example varchar2(500) default null,
	idiom varchar2(500) default null
);
drop table kordic;
select * from kordic;
insert into kordic(wordNumber, word, meaning, related, example, idiom)
values(kordic_seq.nextval, 'word1', 'meaning1', null, null, null);
-- KORDIC sequence 생성 ------------------------------------------
create sequence kordic_seq
nomaxvalue
nominvalue;
select * from user_sequences;
-- MyDic table 생성 ---------------------------------------------- ?
create table mydic(
	wordNumber number,
	word varchar2(100) constraint kordic_word_NN not null,
	meaning varchar2(500) constraint kordic_meaning_NN not null,
	related varchar2(100) default null,
	example varchar2(500) default null,
	idiom varchar2(500) default null
);




