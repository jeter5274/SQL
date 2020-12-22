/* SubQuery */

-- ‘Den’ 보다 급여를 많은 사람의 이름과 급여는?
-- 1. 11000 보다 급여를 많은 사람의 이름과 급여는?
select  employee_id,
        first_name,
        salary
from employees
where salary > 11000;

-- 2. 'Den' 보다 급여 높은 사람
select  employee_id,
        first_name,
        salary
from employees
where first_name = 'Den'; --> 11000

select  employee_id,
        first_name,
        salary
from employees
where salary >  (select salary
                from employees
                where first_name = 'Den');

-- 예제 : 급여를 가장 적게 받는 사람의 이름, 급여, 사원번호는?
-- 1. 가장 적은 급여는?
select min(salary)
from employees;

-- 2. 가장 적은 급여를 받는 사람정보 출력
select  first_name,
        salary,
        employee_id
from employees
where salary = (select min(salary)
                from employees);

-- 예제2 : 평균 급여보다 적게 받는 사람의 이름, 급여를 출력하세요?
-- 1. 평균급여는?
select avg(salary)
from employees;

-- 2. 평균급여보다 적게받은사람의 이름, 급여 출력
select  first_name,
        salary
from employees
where salary < (select avg(salary)
                from employees);

--예제 : 부서번호가 110인 직원의 급여와 같은 모든 직원의 사번, 이름, 급여를 출력하세요

-- 1. 부서번호가 110인 직원의 이름, 급여, ... 리스트 -> 결과, 12008, 8300
select  employee_id,
        first_name,
        salary,
        department_id
from employees
where department_id = 110;

-- 2. 급여가 12008나 8300인 직원
select  employee_id,
        first_name,
        salary,
        department_id
from employees
where salary = 12008
or salary = 8300;

-- 3. 2 -> in으로 표현
select  employee_id,
        first_name,
        salary,
        department_id
from employees
where salary in (12008, 8300);

-- 4. 합치기
select  employee_id,
        first_name,
        salary
from employees
where salary in (select salary
                from employees
                where department_id = 110);

-- 예제 : 각 부서별로 최고급여를 받는 사원을 출력하세요
-- 1. 각 부서별 최고급여
select  department_id,
        max(salary)
from employees
group by department_id;

-- 2. 사원 출력
select  first_name,
        employee_id,
        salary,
        department_id
from employees
where (department_id, salary) in    (select department_id, max(salary)
                                    from employees
                                    group by department_id);
-- in은 칼럼의 포맷을 맞춰주면 여러컬럼을 동시에 사용할 수 있다.(AND로 적용)


--예제 : 부서번호가 110인 직원의 급여 보다 큰 모든 직원의 사번, 이름, 급여를 출력하세요. (or연산--> 8300보다 큰)

select  *
from employees
where department_id = 110; --12008, 8300

select *
from employees
where salary > 12000;

select *
from employees
where salary > 8300;

select  employee_id,
        first_name,
        salary
from employees
where salary >any (select  salary
                  from employees
                  where department_id = 110);
                  
-- SubQuery로 테이블 만들기 -> 조인으로 사용
--1. 각 부서별 최고급여를 받는 사원을 출력
select  department_id,
        max(salary)
from employees
group by department_id;

--2. 직원테이블과 1번에서 생성한 테이블을 join한다
select  emp.employee_id,
        emp.first_name,
        emp.salary,
        emp.department_id empdep_id,
        depmaxsal.department_id depmaxsaldep_id,
        depmaxsal.salary
from employees emp, (select  department_id,
                             max(salary) salary
                     from employees
                     group by department_id) depmaxsal
where emp.department_id = depmaxsal.department_id
and emp.salary = depmaxsal.salary;