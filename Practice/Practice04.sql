/*서브쿼리(SUBQUERY) SQL 문제입니다.*/

/*
문제1.
평균 급여보다 적은 급여을 받는 직원은 몇명인지 구하시요.
(56건)
 */
--1. 평균급여는?
select avg(salary)
from employees;

--2. 평균급여보다 적은 급여를 받는 직원 수는?
select count(salary)
from employees
where salary < (select avg(salary)
                from employees);

/*
문제2. 
평균급여 이상, 최대급여 이하의 월급을 받는 사원의 
직원번호(employee_id), 이름(first_name), 급여(salary), 평균급여, 최대급여를 
급여의 오름차순으로 정렬하여 출력하세요 
(51건)
*/
--1. 평균급여는?
select avg(salary)
from employees;

--2. 최대급여는?
select max(salary)
from employees;

--3. 평균급여와, 최대급여의 출력이 필요하므로,  join활용
select  emp.employee_id 직원번호,
        emp.first_name 이름,
        emp.salary 급여,
        avgs.avgsal 평균급여,
        maxs.maxsal 최대급여
from employees emp, (select avg(salary) avgsal
                     from employees) avgs, (select max(salary) maxsal
                                              from employees) maxs --어떻게 이어 써야하지?
where emp.salary >= avgs.avgsal
and emp.salary <= maxs.maxsal;

/*
문제3.
직원중 Steven(first_name) King(last_name)이 소속된 부서(departments)가 있는 곳의 주소를 알아보려고 한다.
도시아이디(location_id), 거리명(street_address), 우편번호(postal_code), 도시명(city), 주(state_province), 나라아이디(country_id) 를 출력하세요
(1건)
 */
--1. 스티븐킹의 부서는?
select department_id
from employees
where first_name = 'Steven'
and last_name = 'King';

--2. 부서 정보와 위치 정보를 조인하고, 스티븐킹의 부서정보를 조건문으로 사용함
select  dep.location_id 도시아이디,
        loc.street_address 거리명,
        loc.postal_code 우편번호,
        loc.city 도시명,
        loc.state_province 주,
        loc.country_id 나라아이디
from departments dep, locations loc
where dep.location_id = loc.location_id
and dep.department_id = (select department_id
                         from employees
                         where first_name = 'Steven'
                         and last_name = 'King');

/*
문제4.
job_id 가 'ST_MAN' 인 직원의 급여보다 작은 직원의
사번,이름,급여를 
급여의 내림차순으로 출력하세요  -ANY연산자 사용
(74건)
*/
--1. job_id 가 'ST_MAN' 인 직원의 급여는?
select  job_id,
        salary
from employees
where job_id = 'ST_MAN';

--2. 1의 내용을 조건문으로 활용 (ANY연산자)
select  employee_id 사번,    
        first_name 이름,
        salary 급여
from employees
where salary <any (select  salary
                   from employees
                   where job_id = 'ST_MAN')
order by salary desc;

/*
문제5. 
각 부서별로 최고의 급여를 받는 사원의 
직원번호(employee_id), 이름(first_name)과 급여(salary) 부서번호(department_id)를 조회하세요 
단 조회결과는 급여의 내림차순으로 정렬되어 나타나야 합니다. 
조건절비교, 테이블조인 2가지 방법으로 작성하세요
(11건)
*/
-- 1. 각 부서별로 최고의 급여는?
select  department_id,
        max(salary) maxsal
from employees
group by department_id;

-- 2-1. 조건비교로 1번 테이블을 활용하기
select  employee_id 직원번호,
        first_name 이름,
        salary 급여,
        department_id 부서번호
from employees
where (department_id, salary) in (select  department_id,
                                         max(salary) maxsal
                                 from employees
                                 group by department_id)
order by salary desc;

-- 2-2. 1번 테이블을 조인하여 활용하기
select  emp.employee_id 직원번호,
        emp.first_name 이름,
        emp.salary 급여,
        emp.department_id 부서번호
from employees emp, (select  department_id,
                             max(salary) maxsal
                     from employees
                     group by department_id) maxs
where emp.department_id = maxs.department_id
and emp.salary = maxs.maxsal;

/*
문제6.
각 업무(job) 별로 연봉(salary)의 총합을 구하고자 합니다. 
연봉 총합이 가장 높은 업무부터 업무명(job_title)과 연봉 총합을 조회하시오 
(19건)
*/
-- 1. 각 업무(job) 별로 연봉(salary)의 총합
select  job_id,
        sum(salary)
from employees
group by job_id;

-- 2. jobs테이블과 조인하여 정보 출력
select  jobs.job_title 업무명,
        sums.sumsal 연봉총합
from jobs, (select  job_id,
                    sum(salary) sumsal
            from employees
            group by job_id) sums
where jobs.job_id = sums.job_id
order by sums.sumsal desc;

/*
문제7.
자신의 부서 평균 급여보다 연봉(salary)이 많은 직원의 직원번호(employee_id), 이름(first_name)과 급여(salary)을 조회하세요 
(38건)
*/
-- 1. 부서 평균 급여는?
select  department_id,
        avg(salary)
from employees
group by department_id;

-- 2. 1번 테이블을 조인해서 활용
select  emp.employee_id 직원번호,
        emp.first_name 이름,
        emp.salary 급여
from employees emp, (select  department_id,
                             avg(salary) avgsal
                     from employees
                     group by department_id) avgs
where emp.department_id = avgs.department_id
and emp.salary > avgs.avgsal;

/*
--rownum 배운 후에 풀것
문제8.
직원 입사일이 11번째에서 15번째의 직원의 사번, 이름, 급여, 입사일을 입사일 순서로 출력하세요
*/


