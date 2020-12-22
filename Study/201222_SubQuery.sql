/* Sub Query */

-- 'Den' 보다 급여가 많은 사람의 이름과 급여는?
-- 1. Den의 급여는?
select  first_name,
        salary
from employees
where first_name = 'Den';

-- 2. Den의 급여를 select하여 조건문으로 활용
select  first_name,
        salary
from employees
where salary > (select  salary
                from employees
                where first_name = 'Den');

-- 급여를 적게 받는 사람의 이름, 급여, 사원 번호는?
--1. 가장 적은 급여는?
select min(salary)
from employees;

--2. 가장적은 급여를 조건문으로 활용
select  first_name,
        salary,
        employee_id
from employees
where salary = (select min(salary)
                from employees);

-- 부서번호가 110인 직원의 급여와 같은 모든 직원의 사번, 이름, 급여를 출력하세요
-- 1. 부서번호 110인 직원들의 이름과 급여는?
select  first_name,
        salary
from employees
where department_id = 110;
-- 결과가 다중행임

--2. 부서번호가 110인 직원의 급여를 조건문으로 활용
select  employee_id,
        first_name,
        salary
from employees
where salary in (select  salary
                 from employees
                 where department_id = 110);

-- 각 부서별로 최고급여를 받는 사원의 모든 정보를 출력하세요
-- 1. 각 부서별 최고급여는?
select  department_id,
        max(salary)
from employees
group by department_id;

--2. 최고급여와, 부서아이디가 같을 경우를 출력해야함 (employees 테이블만 보임)
select *
from employees
where (department_id, salary) in (select  department_id,
                                          max(salary)
                                  from employees
                                  group by department_id);
                                  
-- 다른방법 조인하기(두테이블이 연결되어 보임) - 데이터가 많아 질 수록 속도차가 날 것 같음
select *
from employees emp, (select  department_id,
                             max(salary) maxSalary
                     from employees
                     group by department_id) maxsal
where emp.department_id = maxsal.department_id
and emp.salary = maxsal.maxSalary;

-- 부서번호가 110인 직원의 급여 보다 큰 모든 직원의 사번, 이름, 급여를 출력하세요.(or연산--> 8300보다 큰)
--1. 부서번호가 110인 직원의 급여는?
select  department_id,
        first_name,
        salary
from employees
where department_id = 110; -- 12008, 8300

--2. 조건절에 활용
select  employee_id,
        first_name,
        salary
from employees
where salary >any (select salary    --조건 아무거나가 부등호에 만족하면
                   from employees
                   where department_id = 110);

-- 3. 정답확인을 위해 급여가 8300이상인 직원이 몇명인지 확인
select count(*)
from employees
where salary > 8300;

-- 부서번호가 110인 직원의 급여 보다 큰 모든 직원의 사번, 이름, 급여를 출력하세요.(and연산--> 12008보다 큰)
--1. 부서번호가 110인 직원의 급여는?
select  department_id,
        first_name,
        salary
from employees
where department_id = 110; -- 12008, 8300

--2. 조건절에 활용
select  employee_id,
        first_name,
        salary
from employees
where salary >all (select salary    -- 모든 조건이 부등호에 만족하면
                   from employees
                   where department_id = 110);
                   
-- 3. 정답확인을 위해 급여가 12008이상인 직원이 몇명인지 확인
select count(*)
from employees
where salary > 12008;                   


-- 각 부서별로 최고급여를 받는 사원을 출력하되, 테이블 조인을 하세요
-- 1. 각 부서별 최고급여는?
select  department_id,
        max(salary)
from employees
group by department_id;

-- 2. 테이블 조인해서 결과값을 도출
select *
from employees emp, (select  department_id,
                             max(salary) salary
                     from employees
                     group by department_id) depMaxSal --107 * 12 카디젼 프로덕트 생성됨
where emp.department_id = depMaxSal.department_id   --부서아이디가 같은 정보만 가져옴
and emp.salary = depmaxsal.salary; --직원의 급여와 최고 급여가 같은 정보만 가져옴

-- 각 부서별로 최고급여를 받는 사원을 출력하되, 조건비교를 하세요
-- 1. 각 부서별 최고급여는?
select  department_id,
        max(salary)
from employees
group by department_id;

-- 2. where절에 조건문으로 활용
select *
from employees
where (department_id, salary) in (select  department_id,
                                          max(salary)
                                  from employees
                                  group by department_id);
