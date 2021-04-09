-- 1+1
select 1+1
from dual;

select sysdate
from dual;

-- 단일행 함수
-- nvl = null값 0으로 바꿈
select commission_pct, nvl(commission_pct, 0)
from EMPLOYEES;

--그룹함수
select sum(commission_pct)
from employees;

select count(employee_id)
from employees;

select count(commission_pct)
from employees;

-- 사원들 중 월급을 가장 많이 받는 사람
select *
from EMPLOYEES
where salary = max(salary); -- 그룹함수는 select에 쓸 수 있음

select count(salary), sum(salary), avg(salary), max(salary), min(salary)
from employees;

-- 부서별 월급의 총합계, 평균급여, 사원 수 조회

select sum(salary) / count(salary) as average from employees;

-- 숫자 처리 함수
select abs(-10) from dual;
select floor(commission_pct) from employees
where commission_pct is not null;
select round(3.456, 1) from dual;
select trunc(15.79, 1) from dual;
select 20/5, mod(20, 5) from dual;

-- 문자열 처리 함수
select length('abc') from dual;
select lengthb('abc') from dual;
select length('갉') from dual;
select lengthb('갉') from dual;

select substr('hello world', 1, 3) from dual;
select substr('hello world', -3) from dual;
select instr('hello world', 'w') from dual;

select rpad('hello', 10, '*') from dual;

-- '941226-1234567'
-- '941226-1******'
select rpad(substr('941226-1234567', 1, 8), 14, '*') from dual;

-- Abel -> Ab**
-- Austin -> Au****
select last_name from employees;

select rpad(substr(last_name, 1, 2), length(last_name), '*')
from EMPLOYEES;

select trim('x' from 'xxhelloxxWorldxx') from dual;
select ltrim('00100', '0') from dual;

-- #test -> $test
select replace('#test', '#', '$') from dual;

-- 날짜 데이터 포맷 확인
select value from nls_session_parameters
where parameter='NLS_DATE_FORMAT';

select last_name, hire_date, 
trunc(months_between(sysdate, hire_date), 0)
from employees;

select next_day(sysdate, '토요일') from dual;
select next_day(sysdate, 1) from dual;

select extract(year from sysdate) from dual;
select extract(year from hire_date) as hire_year from employees;

select sysdate, systimestamp, current_date, current_timestamp from dual;

-- 형변환 함수
select to_char(sysdate, 'YYYY*MM*DD') from dual;
select to_char(10000, '99,999') from dual;

select to_number('10,000', '00,000') from dual;

select to_date('2010*03*03', 'YYYY*MM*DD') from dual;
select to_date(20100301, 'YYYYMMDD') from dual;

-- 기타 함수
select count(salary), sum(salary),sum(salary)/count(salary), avg(salary) from employees;
select count(employee_id), sum(commission_pct),sum(commission_pct)/count(commission_pct), avg(commission_pct) from employees;

select count(employee_id), count(commission_pct) from EMPLOYEES;
select avg(commission_pct) from employees;
select sum(commission_pct)/107 from employees;

select avg(nvl(commission_pct, 0)) from employees;

select nvl2(commission_pct, 1, 2) from employees;

-- exercise
-- 1. employees에서 9월에 입사한 직원 조회
select * from employees
where extract(month from hire_date) = 9;
-- alt
select * from employees
where substr(hire_date, 4, 2) = '09';

-- 2. employees에서 07년에 입사한 직원 조회
select * from employees
where extract(year from hire_date) = 2007;

-- 3. 'test@gmail.com', 'iu@daum.net' 각각 ID만 추출
select substr('test@gmail.com', 1, instr('test@gmail.com', '@')-1) ID from dual;

-- 4. employees에서 입사일로부터 15년 이상 근무한 직원 조회
select * from employees
where months_between(sysdate, hire_date) >= 180
order by hire_date desc;




