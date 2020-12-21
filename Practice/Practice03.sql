/* 테이블간 조인(JOIN) SQL 문제입니다. */

/*
문제1.
직원들의 사번(employee_id), 이름(firt_name), 성(last_name)과 부서명(department_name)을 조회하여 부서이름(department_name) 오름차순, 사번(employee_id) 내림차순 으로 정렬하세요.
(106건)
*/
select  emp.employee_id 사번,
        emp.first_name 이름,
        emp.last_name 성,
        dep.department_name 부서명
from employees emp, departments dep
where emp.department_id = dep.department_id
order by dep.department_name asc, emp.employee_id desc;


/*
문제2.
employees 테이블의 job_id는 현재의 업무아이디를 가지고 있습니다.
직원들의 사번(employee_id), 이름(firt_name), 급여(salary), 부서명(department_name), 현재업무(job_title)를 사번(employee_id) 오름차순 으로 정렬하세요.
부서가 없는 Kimberely(사번 178)은 표시하지 않습니다.
(106건)
*/
select  emp.employee_id 사번,
        emp.first_name 이름,
        emp.salary 급여,
        dep.department_name 부서명,
        job.job_title 현재업무
from employees emp, departments dep, jobs job
where emp.department_id = dep.department_id
and emp.job_id = job.job_id
order by emp.employee_id asc;

/*
문제2-1.
문제2에서 부서가 없는 Kimberely(사번 178)까지 표시해 보세요
(107건)
*/
-- 1 left join 후 테이블 열거
select  emp.employee_id 사번,
        emp.first_name 이름,
        emp.salary 급여,
        dep.department_name 부서명,
        job.job_title 현재업무
from employees emp left outer join departments dep
on emp.department_id = dep.department_id, jobs job
where emp.job_id = job.job_id
order by emp.employee_id asc;

-- 2 left join 후 left join : 결과는 같지만 employees의 job_id에 null값이 없어 의미가 없음
select  emp.employee_id 사번,
        emp.first_name 이름,
        emp.salary 급여,
        dep.department_name 부서명,
        job.job_title 현재업무
from employees emp left outer join departments dep
on emp.department_id = dep.department_id left outer join jobs job
on emp.job_id = job.job_id
order by emp.employee_id asc;

-- 3 오라클 약어 1개
select  emp.employee_id 사번,
        emp.first_name 이름,
        emp.salary 급여,
        dep.department_name 부서명,
        job.job_title 현재업무
from employees emp, departments dep, jobs job
where emp.department_id = dep.department_id(+)
and emp.job_id = job.job_id
order by emp.employee_id asc;

-- 4 오라클 약어 2개 : 2번과 마찬가지로 결과는 같지만 employees의 job_id에 null값이 없어 의미가 없음
select  emp.employee_id 사번,
        emp.first_name 이름,
        emp.salary 급여,
        dep.department_name 부서명,
        job.job_title 현재업무
from employees emp, departments dep, jobs job
where emp.department_id = dep.department_id(+)
and emp.job_id = job.job_id(+)
order by emp.employee_id asc;


/*
문제3.
도시별로 위치한 부서들을 파악하려고 합니다.
도시아이디, 도시명, 부서명, 부서아이디를 도시아이디(오름차순)로 정렬하여 출력하세요 
부서가 없는 도시는 표시하지 않습니다.
(27건)
*/
select  loc.location_id 도시아이디,
        loc.city 도시명,
        dep.department_name 부서명,
        dep.department_id 부서아이디
from locations loc, departments dep
where loc.location_id = dep.location_id
order by loc.location_id asc;

/*
문제3-1.
문제3에서 부서가 없는 도시도 표시합니다. 
(43건)
*/
select  loc.location_id 도시아이디,
        loc.city 도시명,
        dep.department_name 부서명,
        dep.department_id 부서아이디
from locations loc left outer join departments dep
on loc.location_id = dep.location_id
order by loc.location_id asc;

/*
문제4.
지역(regions)에 속한 나라들을 지역이름(region_name), 나라이름(country_name)으로 출력하되 지역이름(오름차순), 나라이름(내림차순) 으로 정렬하세요.
(25건)
*/
select  reg.region_name 지역이름,
        cou.country_name 나라이름
from regions reg, countries cou
where reg.region_id = cou.region_id
order by reg.region_name asc, cou.country_name desc;

/*
문제5. 
자신의 매니저보다 채용일(hire_date)이 빠른 사원의 
사번(employee_id), 이름(first_name)과 채용일(hire_date), 매니저이름(first_name), 매니저입사일(hire_date)을 조회하세요.
(37건)
*/
select  emp.employee_id 사번,
        emp.first_name 이름,
        emp.hire_date 채용일,
        man.first_name 매니저이름,
        man.hire_date 매니저입사일
from employees emp, employees man
where emp.manager_id = man.employee_id
and emp.hire_date < man.hire_date;

/*
문제6.
나라별로 어떠한 부서들이 위치하고 있는지 파악하려고 합니다.
나라명, 나라아이디, 도시명, 도시아이디, 부서명, 부서아이디를 나라명(오름차순)로 정렬하여 출력하세요.
값이 없는 경우 표시하지 않습니다.
(27건)
*/
select  cou.country_name 나라명,
        cou.country_id 나라아이디,
        loc.city 도시명,
        loc.location_id 도시아이디,
        dep.department_name 부서명,
        dep.department_id 부서아이디
from countries cou, locations loc, departments dep
where cou.country_id = loc.country_id
and loc.location_id = dep.location_id
order by cou.country_name asc;

/*
문제7.
job_history 테이블은 과거의 담당업무의 데이터를 가지고 있다.
과거의 업무아이디(job_id)가 ‘AC_ACCOUNT’로 근무한 사원의 사번, 이름(풀네임), 업무아이디, 시작일, 종료일을 출력하세요.
이름은 first_name과 last_name을 합쳐 출력합니다.
(2건)
*/
select  emp.employee_id,
        emp.first_name || ' ' || emp.last_name "이름(풀네임)",
        job.job_id 과거업무아이디,
        job.start_date 시작일,
        job.end_date 종료일
from job_history job, employees emp
where job.employee_id = emp.employee_id
and job.job_id = 'AC_ACCOUNT';


/*
문제8.
각 부서(department)에 대해서 부서번호(department_id), 부서이름(department_name), 
매니저(manager)의 이름(first_name), 위치(locations)한 도시(city), 나라(countries)의 이름(countries_name) 그리고 지역구분(regions)의 이름(resion_name)까지 전부 출력해 보세요.
(11건)
*/
select  dep.department_id 부서번호,
        dep.department_name 부서명,
        emp.first_name 매니저이름,
        loc.city 도시,
        cou.country_name 나라,
        reg.region_name 지역
from departments dep, employees emp, locations loc, countries cou, regions reg
where dep.manager_id = emp.employee_id
and dep.location_id = loc.location_id
and loc.country_id = cou.country_id
and cou.region_id = reg.region_id;

/*
문제9.
각 사원(employee)에 대해서 사번(employee_id), 이름(first_name), 부서명(department_name), 매니저(manager)의 이름(first_name)을 조회하세요.
부서가 없는 직원(Kimberely)도 표시합니다.
(106명)
*/
select  emp.employee_id 사번,
        emp.first_name 이름,
        dep.department_name 부서명,
        man.first_name 매니저이름
from employees emp left outer join departments dep
on emp.department_id = dep.department_id, employees man
where emp.manager_id = man.employee_id;


