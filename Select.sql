SELECT * FROM COUNTRIES;

SELECT * from employees
WHERE commission_pct is not null;

--Employees salary 10000 이상 20000이하
SELECT *
FROM EMPLOYEES
where salary >= 10000 and salary <= 20000;

select *
from EMPLOYEES
where salary between 10000 and 20000;

-- salary 10000 이상 20000 이하가 아닌 정보
select *
from EMPLOYEES
where salary not between 10000 and 20000;

-- 부서번호가 80번이거나 100번인 사원들 정보
select *
from EMPLOYEES
where department_id = 80 or department_id = 100;

select *
from EMPLOYEES
where department_id in (80,100);

-- 사월들 중에서 first_name이 K로 시작하는 사원들
select *
from EMPLOYEES
where first_name like 'K%';

select *
from COUNTRIES
where country_id like '_K';

-- country_id 중 두글자인 데이터 중에서 U로 시작하는 data
select *
from COUNTRIES
where country_id like 'U_';

select *
from EMPLOYEES
where first_name like '%K%';

-- Employees 
select *
from EMPLOYEES
order by salary desc;

-- 100번 부서에 사원정보 조회, salary 적은순 부터 출력
select *
from EMPLOYEES
where department_id = 100
order by salary asc;

-- 사원정보 조회 salary 10000 이상 20000 이하, 최근 입사한 순으로 출력
select *
from EMPLOYEES
where salary between 10000 and 20000
order by hire_date desc;

-- JAVA 연동 ex들
select *
from COUNTRIES;

select *
from DEPARTMENTS
where department_id=90;

select *
from employees

select *
from employees
where employee_id = 103;

select *
from employees
where first_name like '%st%'
or last_name like '%st%';

----------------------------------

select * from EMPLOYEES;

-- 각 부서별 월급의 합계

select department_id, sum(salary)
from employees
where department_id is not null
group by department_id
having sum(salary)>50000
order by department_id asc;
