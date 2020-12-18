/** 그룹함수 **/

--직원의 숫자와 커미션비율이 있는 직원의 숫자를 출력하세요
select  count(*),
        count(commission_pct)
from employees;

--월급이 16000 초과인 직원의 숫자를 출력하세요
select count(*)
from employees
where salary > 16000;

--직원의 숫자와 급여의 합을 출력하세요
select  count(*),
        sum(salary)
from employees;

--직원의 숫자와 급여이 합, 급여의 평균(null은 버리고 계산하도록)을 출력하세요
select  count(*),
        sum(salary),      
        avg(salary)
from employees;

--직원의 숫자와 급여의 합, 급여의 평균(null은 0으로 계산하도록) 출력하세요
select  count(*),
        sum(salary),
        avg(nvl(salary, 0))
from employees;

--직원의 숫자와 가장 많은 급여, 가장 적은 급여를 출력하세요
select  count(*),
        max(salary),
        min(salary)
from employees;

/** GROUP BY 절**/
--직원의 부서ID와 급여를 출력하고, 부서 오름차순으로 정렬하세요
select  department_id,
        salary
from employees
order by department_id asc;

--직원의 부서별 부서ID와 급여평균을 출력하고, 부서 오름차순으로 정렬하세요
select  department_id 부서ID,
        avg(nvl(salary,0)) 급여평균
from employees
group by department_id
order by department_id asc;

--직원의 부서별 부서ID, 숫자, 급여합계를 출력하세요
select  department_id 부서ID,
        count(*) 인원수,
        sum(salary) 급여합계
from employees
group by department_id;

--직원의 부서별 부서ID, 직무ID, 숫자, 급여합계를 출력하세요
select  department_id 부서ID,
        job_id 직무ID, 
        count(*) 인원수,
        sum(salary) 급여합계
from employees
group by department_id, job_id;


/** HAVING 절 */
--급여(salary)의 합계가 20000 이상인 부서의 부서 번호와 , 인원수, 급여합계를 출력하세요
select  department_id 부서번호,
        count(*) 인원수,
        sum(salary) 급여합계
from employees
group by department_id
having sum(salary) >= 2000;

/* CASE ~ END 문 & DECODE() */
-- 직원들 중 AC_ACCOUNT, SA_REP, ST_CLERK직무는 각각 10%, 20%, 30% 급여가 인상되었을 때, 직원ID, 급여, 인상급여를 출력하세요
select  employee_id 직원ID,
        salary 급여,
        case when job_id = 'AC_ACCOUNT' then salary * 0.1
             when job_id = 'SA_REP' then salary * 0.2
             when job_id = 'ST_CLERK' then salary * 0.3
             else salary*0
        end 인상급여
from employees;
-- 위 예제를 DECODE함수를 통해 작성하시오
select  employee_id 직원ID,
        salary 급여,
        decode (job_id, 'AC_ACCOUNT', salary * 0.1, 'SA_REP', salary * 0.2, 'ST_CLERK', salary * 0.3, salary*0) 인상급여
from employees;

-- 직원의 이름, 부서, 팀을 출력하세요 팀은 코드로 결정하며 부서코드가 10~50 이면 ‘A-TEAM’ 60~100이면 ‘B-TEAM’  110~150이면 ‘C-TEAM’ 나머지는 ‘팀없음’ 으로 출력하세요.
select  first_name 이름,
        department_id 부서코드,
        case when department_id <=50 then 'A-TEAM'
             when department_id <=100 then 'B-TEAM'
             when department_id <=150 then 'C-TEAM'
        else '팀없음'
        end 팀
from employees;

-- 위 예제를 DECODE함수를 통해 작성하시오
select  first_name 이름,
        department_id 부서코드,
        decode(department_id, 10, 'A-TEAM', 20, 'A-TEAM', 30, 'A-TEAM', 40, 'A-TEAM', 50, 'A-TEAM',
                              60, 'B-TEAM', 70, 'B-TEAM', 80, 'B-TEAM', 90, 'B-TEAM', 100, 'B-TEAM',
                              110, 'C-TEAM', 120, 'C-TEAM', 130, 'C-TEAM', 140, 'C-TEAM', 150, 'C-TEAM', '팀없음') 팀
from employees;