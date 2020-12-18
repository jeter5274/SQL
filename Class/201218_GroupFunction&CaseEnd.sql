
/*그룹함수*/

--그룹함수 AVR()
--평균의 결과는 1개의 row만 남게되어 다수의 row를 가진 다른 데이터 포맷이 달라 표현 불가 오류
select  avg(salary), 
        first_name
from employees;

select  avg(salary)
from employees;

--그룹함수 - count()
select count(*) --null포함
from employees;

select count(commission_pct)    --commission_pct의 null제외
from employees;

select count(*)
from employees
where salary > 16000;

--그룹함수 - sum()
select sum(salary)
from employees;

select  sum(salary),    --오류
        first_name
from employees;

select  sum(salary),    --그룹함수를 여러개사용하는 것은 오류가 안남
        count(*)
from employees;

--그룹함수 AVR() 심화
select  count(*),
        sum(salary),
        avg(salary)
from employees;

-- null일떄 0으로 변환
select  count(*),
        sum(salary),
        avg(nvl(salary,0))
from employees;

-- 그룹함수 - max() / min()
select max(salary)
from employees;

select min(salary)
from employees;

--정렬이 필요한 경우 많은 연산을 수행하여야 한다.
select  max(salary),
        min(salary),
        count(*)
from employees;

/*GROUP BY 절*/
select  department_id,
        salary
from employees
order by department_id asc;

select  department_id,      --오류 107대1
        avg(salary)
from employees
order by department_id asc;


select  department_id,
        avg(salary)
from employees
group by department_id;

--GROUP BY 절 – 자주하는 오류
select  department_id,
        count(*),
        su,m(salary),
        job_id          --그룹화 될 수 없는 데이터라서 오류가 발생함
from employees
group by department_id;

select  department_id,
        job_id,
        count(*),
        sum(salary),
        avg(salary)
from employees
group by department_id, job_id;

--GROUP BY 절 예제
select  department_id,
        count(*),
        sum(salary)
from employees
where sum(salary) > 20000 --그룹함수는 where절에 사용할 수 없음, having사용해야 함
group by department_id;

--HAVING 절
select  department_id,
        count(*),
        sum(salary)
from employees
group by department_id
having sum(salary) >= 20000
and department_id=100;

/*CASE ~ END 문*/

/*사용법
case when 조건식 then 실행내용
     when 조건식 then 실행내용
     when 조건식 then 실행내용
     else 실행내용
end "컬럼명"
*/
select  employee_id,
        salary,
        job_id,
        case    when job_id = 'AC_ACCOUNT' then salary*0.1
                when job_id = 'SA_REP' then salary*0.2
                when job_id = 'ST_CLERK' then salary*0.3
                else salary*0
        end bonus
from employees;

-- DECODE 문 : CASE ~ END문의 다른표현
select  employee_id,
        salary,
        job_id,
        decode(job_id, 'AC_ACCOUNT', salary*0.1, 'SA_REP', salary*0.2, 'ST_CLERK', salary*0.3, salary*0 ) as bonus
from employees;

--CASE ~ END 문 / DECODE() 함수 예제
select  first_name,
        department_id,
        case when department_id <= 50 then 'A-TEAM'
             when department_id <= 100 then 'B-TEAM'
             when department_id <= 150 then 'C-TEAM'
             else '팀없음' 
        end
from employees;

select  first_name,
        department_id,
        decode(department_id, 10, 'A-TEAM', 20, 'A-TEAM', 30, 'A-TEAM', 40, 'A-TEAM', 50, 'A-TEAM',
                              60, 'B-TEAM', 70, 'B-TEAM', 80, 'B-TEAM', 90, 'B-TEAM', 100, 'B-TEAM',
                              110, 'C-TEAM', 120, 'C-TEAM', 130, 'C-TEAM', 140, 'C-TEAM', 150, 'C-TEAM',
                              '팀없음')
from employees;
