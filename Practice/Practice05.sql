/*혼합 SQL 문제입니다.*/

/*
문제1.
담당 매니저가 배정되어있으나 커미션비율이 없고, 월급이 3000초과인 직원의 
이름, 매니저아이디, 커미션 비율, 월급 을 출력하세요.
(45건)
*/
select  first_name 이름,
        manager_id 매니저아이디,
        commission_pct 커미션비율,
        salary 월급
from employees
where manager_id is not null
and commission_pct is null
and salary > 3000;

/*
문제2. 
각 부서별로 최고의 급여를 받는 사원의 
직원번호(employee_id), 이름(first_name), 급여(salary), 입사일(hire_date), 전화번호(phone_number), 부서번호(department_id) 를 조회하세요 
-조건절비교 방법으로 작성하세요
-급여의 내림차순으로 정렬하세요
-입사일은 2001-01-13 토요일 형식으로 출력합니다.
-전화번호는 515-123-4567 형식으로 출력합니다.
(11건)
*/
select  employee_id 직원번호,
        first_name 이름,
        salary 급여,
        to_char(hire_date, 'YYYY-MM-DD DAY') 입사일,
        replace(phone_number, '.', '-') 전화번호,
        department_id 부서번호
from employees
where (department_id, salary) in (select department_id,
                                         max(salary)
                                  from employees
                                  group by department_id)
order by salary desc;
                                  
/*
문제3
매니저별 담당직원들의 평균급여 최소급여 최대급여를 알아보려고 한다.
-통계대상(직원)은 2005년 이후(2005년 01월 01일 ~ 현재)의 입사자 입니다.
-매니저별 평균급여가 5000이상만 출력합니다.
-매니저별 평균급여의 내림차순으로 출력합니다.
-매니저별 평균급여는 소수점 첫째자리에서 반올림 합니다.
-출력내용은 매니저아이디, 매니저이름(first_name), 매니저별평균급여, 매니저별최소급여, 매니저별최대급여 입니다.
(9건)
*/
--1. 매니저별 담당직원의 매니저아디이, 매니저이름(제외), 매니저별평균급여, 매니저별최소급여, 매니저별최대급여 출력
--통계대상(직원)은 2005년 이후(2005년 01월 01일 ~ 현재)의 입사자 입니다.
--매니저별 평균급여는 소수점 첫째자리에서 반올림 합니다.
select  manager_id 매니저아이디,
        round(avg(salary), 1) 매니저별평균급여,
        min(salary) 매니저별최소급여,
        max(salary) 매니저별최대급여
from employees
where hire_date >= '05/01/01'
group by manager_id;

--2. 1번테이블에 매니저이름을 추가하기위해 join
--매니저별 평균급여가 5000이상만 출력합니다.
--매니저별 평균급여의 내림차순으로 출력합니다.
--매니저아디이, 매니저이름, 매니저별평균급여, 매니저별최소급여, 매니저별최대급여 출력
select  mansal.manager_id 매니저아이디,
        man.first_name 매니저이름,
        mansal.avgsal 매니저별평균급여,
        mansal.minsal 매니저별최소급여,
        mansal.maxsal 매니저별최대급여
from (select manager_id,
             round(avg(salary), 1) avgsal,
             min(salary) minsal,
             max(salary) maxsal
      from employees
      where hire_date >= '05/01/01'
      group by manager_id) mansal, employees man
where mansal.manager_id = man.employee_id
and mansal.avgsal >= 5000
order by mansal.avgsal desc;



/*
문제4.
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

/*
문제5.
2005년 이후 입사한 직원중에 입사일이 11번째에서 20번째의 직원의 
사번, 이름, 부서명, 급여, 입사일을 입사일 순서로 출력하세요
*/
--1. 2005년 이후 입사한직원의 사번, 이름, 부서명, 급여, 입사일을 입사일 순서로 정렬
select  emp.employee_id,
        emp.first_name,
        dep.department_name,
        emp.salary,
        emp.hire_date
from employees emp, departments dep
where emp.department_id = dep.department_id
and emp.hire_date >= '05/01/01'
order by emp.hire_date asc;

--2. rownum을 넣어줌
select  rownum,
        h05.employee_id,
        h05.first_name,
        h05.department_name,
        h05.salary,
        h05.hire_date
from (select emp.employee_id,
             emp.first_name,
             dep.department_name,
             emp.salary,
             emp.hire_date
      from employees emp, departments dep
      where emp.department_id = dep.department_id
      and emp.hire_date >= '05/01/01'
      order by emp.hire_date asc) h05;

--3. rownum을 조건절에서 사용하기 위해 재정리 : 11번째에서 20번째의 직원 / 사번, 이름, 부서명, 급여, 입사일
select  --rnh05.rn,
        rnh05.employee_id 사번,
        rnh05.first_name 이름,
        rnh05.department_name 부서명,
        rnh05.salary 급여,
        rnh05.hire_date 입사일
from (select rownum rn,
             h05.employee_id,
             h05.first_name,
             h05.department_name,
             h05.salary,
             h05.hire_date
      from (select emp.employee_id,
                   emp.first_name,
                   dep.department_name,
                   emp.salary,
                   emp.hire_date
            from employees emp, departments dep
            where emp.department_id = dep.department_id
            and emp.hire_date >= '05/01/01'
            order by emp.hire_date asc) h05) rnh05
where rnh05.rn >= 11
and rnh05.rn <= 20;

/*
문제6.
가장 늦게 입사한 직원의 이름(first_name last_name)과 연봉(salary)과 근무하는 부서 이름(department_name)은?
*/
-- 1. 가장 늦은 입사일은? -08/04/21
select max(hire_date)
from employees;

-- 2. 직원들의 이름, 연봉, 근무부서이름 테이블 생성
select  emp.first_name || ' ' || emp.last_name 이름,
        emp.salary 연봉,
        dep.department_name 근무부서
from employees emp, departments dep
where emp.department_id = dep.department_id;

-- 3. 조건에 가장 늦은 입사일을 추가 + 문제그림과 마줘 입사일추가
select  emp.first_name || ' ' || emp.last_name 이름,
        emp.salary 연봉,
        dep.department_name 근무부서,
        emp.hire_date
from employees emp, departments dep
where emp.department_id = dep.department_id
and emp.hire_date = (select max(hire_date)
                     from employees);
                     
/*
문제7.
평균연봉(salary)이 가장 높은 부서 직원들의 직원번호(employee_id), 이름(firt_name), 성(last_name)과  업무(job_title), 연봉(salary)을 조회하시오.
*/
--1. 평균연봉이 가장 높은 부서아이디는?
--1-1. 각 부서 중 가장 높은 평균연봉은?
select max(avg(salary))
from employees
group by department_id;

--1-2. 부서별 평균연봉은?
select  department_id,
        avg(salary)
from employees
group by department_id;

--1-3. 1-1/1-2 join
select  depavg.department_id,
        depavg.avgsal
from (select  department_id,
              avg(salary) avgsal
      from employees
      group by department_id) depavg, (select max(avg(salary)) mavgsal
                                       from employees
                                       group by department_id) maxavgsal
where depavg.avgsal = maxavgsal.mavgsal;

--2. employees, 1-3, jobs조인
select  emp.employee_id 사번,
        emp.first_name 이름,
        emp.last_name 성,
        /*
        --그림과 맞춰보기
        emp.salary 급여,
        dmasal.avgsal "avg_salary"
        */
        jobs.job_title 업무,
        emp.salary 연봉
from employees emp, (select  depavg.department_id,
                             depavg.avgsal
                     from (select  department_id,
                                   avg(salary) avgsal
                                   from employees
                                   group by department_id) depavg, (select max(avg(salary)) mavgsal
                                                                    from employees
                                                                    group by department_id) maxavgsal
                     where depavg.avgsal = maxavgsal.mavgsal) dmasal, jobs
where emp.department_id = dmasal.department_id
and emp.job_id = jobs.job_id;

/* rownum 활용하기 */
-- 1. 부서별 평균연봉은?
select  department_id,
        avg(salary)
from employees
group by department_id;

-- 2. 평균연봉 내림차순 rownum 생성
select  rownum,
        depasal.department_id,
        depasal.avgsal
from (select department_id,
             avg(salary) avgsal
      from employees
      group by department_id
      order by avgsal desc) depasal;
      
-- 3. 1번 row만 남겨둠
select  avgsalfirdep.department_id,
        avgsalfirdep.avgsal
from (select rownum rn,
             depasal.department_id,
             depasal.avgsal
      from (select department_id,
                   avg(salary) avgsal
            from employees
            group by department_id
            order by avgsal desc) depasal) avgsalfirdep
where avgsalfirdep.rn = 1;

-- 4. employees, jobs와 조인하여 직원들의 직원번호(employee_id), 이름(firt_name), 성(last_name)과  업무(job_title), 연봉(salary)을 조회
select  emp.employee_id 사번,
        emp.first_name 이름,
        emp.last_name 성,
        jobs.job_title 업무,
        emp.salary 연봉
from employees emp, (select  avgsalfirdep.department_id,
                             avgsalfirdep.avgsal
                     from (select rownum rn,
                                  depasal.department_id,
                                  depasal.avgsal
                           from (select department_id,
                                        avg(salary) avgsal
                                 from employees
                                 group by department_id
                                 order by avgsal desc) depasal) avgsalfirdep
                                 where avgsalfirdep.rn = 1) dmasal, jobs
where emp.department_id = dmasal.department_id
and emp.job_id = jobs.job_id;


/*
문제8.
평균 급여(salary)가 가장 높은 부서는? 
*/
--1. 평균연봉이 가장 높은 부서아이디는?
--1-1. 각 부서 중 가장 높은 평균연봉은?
select max(avg(salary))
from employees
group by department_id;

--1-2. 부서별 평균연봉은?
select  department_id,
        avg(salary)
from employees
group by department_id;

--1-3. 1-1/1-2 join
select  depavg.department_id,
        depavg.avgsal
from (select  department_id,
              avg(salary) avgsal
      from employees
      group by department_id) depavg, (select max(avg(salary)) mavgsal
                                       from employees
                                       group by department_id) maxavgsal
where depavg.avgsal = maxavgsal.mavgsal;

--2. 부서명을 출력하기위해 departments와 join
select dep.department_name
from departments dep, (select  depavg.department_id,
                               depavg.avgsal
                       from (select  department_id,
                                     avg(salary) avgsal
                                     from employees
                                     group by department_id) depavg, (select max(avg(salary)) mavgsal
                                                                      from employees
                                                                      group by department_id) maxavgsal
                       where depavg.avgsal = maxavgsal.mavgsal) dmasal
where dep.department_id = dmasal.department_id

/* rownum 활용하기 */
-- 1. 부서별 평균연봉은?
select  department_id,
        avg(salary)
from employees
group by department_id;

-- 2. 평균연봉 내림차순 rownum 생성
select  rownum,
        depasal.department_id,
        depasal.avgsal
from (select department_id,
             avg(salary) avgsal
      from employees
      group by department_id
      order by avgsal desc) depasal;
      
-- 3. 1번 row만 남겨둠
select  avgsalfirdep.department_id,
        avgsalfirdep.avgsal
from (select rownum rn,
             depasal.department_id,
             depasal.avgsal
      from (select department_id,
                   avg(salary) avgsal
            from employees
            group by department_id
            order by avgsal desc) depasal) avgsalfirdep
where avgsalfirdep.rn = 1;

-- 4. employees, jobs와 조인하여 직원들의 직원번호(employee_id), 이름(firt_name), 성(last_name)과  업무(job_title), 연봉(salary)을 조회
select dep.department_name
from departments dep, (select  avgsalfirdep.department_id,
                               avgsalfirdep.avgsal
                       from (select rownum rn,
                                    depasal.department_id,
                                    depasal.avgsal
                             from (select department_id,
                                          avg(salary) avgsal
                                   from employees
                                   group by department_id
                                   order by avgsal desc) depasal) avgsalfirdep
                                   where avgsalfirdep.rn = 1) dmasal
where dep.department_id = dmasal.department_id;

/*
문제9.
평균 급여(salary)가 가장 높은 지역은? 
*/
-- 1. 지역별 평균 급여 내림차순
select  reg.region_name,
        avg(emp.salary)
from employees emp, departments dep, locations loc, countries cou, regions reg
where emp.department_id = dep.department_id 
and dep.location_id = loc.location_id
and loc.country_id = cou.country_id
and cou.region_id = reg.region_id
group by reg.region_name
order by avg(emp.salary) desc;

-- 2. rownum으로 1번째 열의 지역명만 출력
select rn_ravg.region_name
from (select rownum rn,
             ravg.region_name,
             ravg.regavg
      from (select  reg.region_name,
                    avg(emp.salary) regavg
                    from employees emp, departments dep, locations loc, countries cou, regions reg
            where emp.department_id = dep.department_id 
            and dep.location_id = loc.location_id
            and loc.country_id = cou.country_id
            and cou.region_id = reg.region_id
            group by reg.region_name
            order by avg(emp.salary) desc) ravg) rn_ravg
where rn_ravg.rn = 1;

/*
문제10.
평균 급여(salary)가 가장 높은 업무는? 
*/
--1. 업무별 평균 급여 내림차순
select  jobs.job_title,
        avg(emp.salary)
from employees emp, jobs
where emp.job_id = jobs.job_id 
group by jobs.job_title
order by avg(emp.salary) desc;

-- 2. rownum으로 1번째 열의 업무명만 출력
select rn_javg.job_title
from (select rownum rn,
             javg.job_title
      from (select  jobs.job_title,
                    avg(emp.salary)
            from employees emp, jobs
            where emp.job_id = jobs.job_id 
            group by jobs.job_title
            order by avg(emp.salary) desc) javg) rn_javg
where rn_javg.rn = 1;


