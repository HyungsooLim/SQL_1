-- 사원의 ID가 110번인 사원이 근무하는 부서명?
select department_id from EMPLOYEES
where employee_id = 110;
select department_name from DEPARTMENTS
where department_id = 100;

-- SubQuery 적용
select department_name from DEPARTMENTS
where department_id = (select department_id from EMPLOYEES
where employee_id = 110);

-- 부서ID 70인 부서의 street address
select street_address from LOCATIONS
where location_id = (select location_id from DEPARTMENTS
where department_id = 70);

-- 급여를 가장 많이 받는 사원의 정보
select * from EMPLOYEES
where salary = (select max(salary) from EMPLOYEES);

-- 급여를 가장 적게 받는 사원과 같은 부서에 근무하는 사원들의 정보
select * 
from EMPLOYEES
where department_id = 
	(select department_id 
	from EMPLOYEES
	where salary = 
		(select min(salary) 
		from EMPLOYEES)
	);
	
-- 평균 급여보다 많이 받는 사원들이 근무하는 부서명?
select department_name
from DEPARTMENTS
where department_id in 
	((select department_id
	from EMPLOYEES
	where salary > 
		(select avg(salary)
		from employees)
	));
	
-- Asia(Americas) 지역에 근무하는 사원들의 평균 급여는?
select avg(salary)
from employees
where department_id in(
	select department_id
	from DEPARTMENTS
	where location_id in(
		select location_id
		from LOCATIONS
		where country_id in(
			select country_id
			from COUNTRIES
			where region_id = (
				select region_id
				from REGIONS
				where region_name = 'Americas'
				)
			)
		)
	);
	
-- 사원 id가 100인 사원이 근무하는 region의 이름은?
select region_name from REGIONS where region_id =
	(select region_id from COUNTRIES where country_id =
		(select country_id from LOCATIONS where location_id =	
			(select location_id from DEPARTMENTS where department_id = 
				(select department_id from EMPLOYEES where employee_id = 100)
			)
		)
	)
;

-- 사원 ID 116의 manager가 근무하는 부서명?

select department_name from DEPARTMENTS where department_id =
	(select department_id from EMPLOYEES where employee_id = 
			(select manager_id from employees where employee_id = 116)
	)
;

-- rownum
select * from EMPLOYEES where rownum between 1 and 10;

select salary*12 from EMPLOYEES; --가상의 view

select * from 
(select rownum R, E.* from 
(select * from EMPLOYEES) E)
where R between 1 and 10;

-- 사원 id 120인 사원의 last_name, hire_date, salary, department_id
select last_name, hire_date, salary, department_id
from EMPLOYEES
where employee_id = 120;

select department_name from DEPARTMENTS
where department_id = 50;

-- 사원 id 120인 사원의 last_name, hire_date, salary, department_name
-- join
select E.last_name, E.hire_date, E.salary, D.department_name
from EMPLOYEES E inner join DEPARTMENTS D
--on E.department_id = D.department_id
using (department_id)
where E.employee_id = 120;

select D.*, L.*
from DEPARTMENTS D inner join LOCATIONS L
on d.location_id = L.location_id;

-- LOCATIONS COUNTRIES join
select L.*, C.*
from LOCATIONS L inner join COUNTRIES C
on L.country_id = C.country_id;

-- DEPARTMENTS, LOCATIONS, COUNTRIES join
select D.*, L.*, C.*
from DEPARTMENTS D
inner join LOCATIONS L
on D.location_id = L.location_id
inner join COUNTRIES C
on L.country_id = C.country_id;

-- EMPLOYEES, DEPARTMENTS join
select E.*, D.*
from EMPLOYEES E
inner join DEPARTMENTS D
on E.employee_id = D.manager_id;

-- outer join
select E.*, D.*
from EMPLOYEES E
full join DEPARTMENTS D
on E.employee_id = D.manager_id;

-- 사원의 last_name, salary, 관리자의 last_name, salary
select E.last_name, E.salary, E1.last_name, E1.salary
from EMPLOYEES E
left join EMPLOYEES E1
on E.manager_id = E1.employee_id;

-- 사원 id = 110 의 사원정보, 부서명, 부서의 manager_id, 부서의 location_id
select E.*, D.*
from EMPLOYEES E
inner join DEPARTMENTS D
on E.department_id = D.department_id
where E.employee_id = 110;

-- 부서번호=90 인 부서의 정보와 해당 부서에 근무하는 모든 사원들의 정보 출력
select D.*, E.*
from DEPARTMENTS D
inner join EMPLOYEES E
on D.department_id = E.department_id
where D.department_id = 90;





	