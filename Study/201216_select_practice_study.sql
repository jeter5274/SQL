-- 사원의 모든 데이터를 출력하세요 (employees)
select *
from employees;

-- 부서(departments)의 모든 데이터를 출력하세요
select *
from departments;

-- 직원들의 사번, 이름, 성 을 출력하세요
select  employee_id,
        first_name,
        last_name
from employees;

-- 사원의 이름(fisrt_name)과 전화번호 입사일 월급을 출력하세요
select  first_name,
        phone_number,
        hire_date,
        salary
from employees;

-- 사원의 이름(first_name)과 성(last_name) 월급, 전화번호, 이메일, 입사일을 출력하세요
select  first_name,
        last_name,
        salary,
        phone_number,
        email,
        hire_date
from employees;

-- 사원의 사번, 이름, 월급을 empNo, E-name, 월급으로 표기하여 출력하세요
select  employee_id as "empNo",
        first_name "E-name",
        salary 월급
from employees;

-- 사원의 이름(fisrt_name)과 전화번호 입사일 급여 로 표시되도록 출력하세요
select  first_name 이름,
        phone_number 전화번호,
        hire_date 입사일,
        salary 급여
from employees;

-- 사원의 사원번호 이름(first_name) 성(last_name) 급여 전화번호 이메일 입사일로 표시되도록 출력하세요
select  first_name 이름,
        last_name 성,
        salary 급여,
        phone_number 전화번호,
        email 이메일,
        hire_date 입사일
from employees;

-- 사원의 이름, 성을 출력하세요
select  first_name,
        last_name
from employees;

-- 사원의 이름과 성을 한 컬럼에 출력하세요
select  first_name || last_name
from employees;

-- 사원의 이름과 성을 사이에 공백을 넣어 한 컬럼에 출력하세요
select  first_name || ' ' || last_name
from employees;

-- 사원의 이름과 입사일 사이에 hire data is 문자열을 넣어 한 컬럼에 출력하세요
select  first_name || ' hire data is ' || hire_date
from employees;

-- 사원의 이름, 월급을 출력하세요
select  first_name,
        salary
from employees;

-- 사원의 이름, 월급, 연봉을 출력하세요
select  first_name,
        salary
from employees;

-- 사원의 이름, 월급, 연봉, 월급이 300 인상되었을 때의 연봉 을 출력하세요
select  first_name 이름,
        salary 월급,
        salary*12 연봉,
        (salary+130)*12 "월급+300시 연봉"
from employees;

-- 사원의 직무에 12를 곱해보고 오류를 분석해보세요
select job_id*12    --문자열에 숫자를 곱하여 숫자가 아니라는 오류발생
from employees;

/* 전체직원의 정보를 다음과 같이 출력하세요
    성명(first_name last_name)
        성과 이름사이에 ? 로 구분 ex) William-Gietz
    급여
    연봉(급여*12)
    연봉2(급여*12+5000)
    전화번호
*/
select  first_name || '-' || last_name 성명,
        salary 급여,
        salary*12 연봉,
        salary*12+5000 연봉2,
        phone_number 전화번호
from employees;

-- 부서가 10인 사원의 이름을 출력하세요
select  first_name
from employees
where department_id = 10;

-- 월급이 15000 이상인 사원들의 이름과 월급을 출력하세요
select  first_name,
        salary
from employees
where salary >= 15000;

-- 07/01/01 일 이후에 입사한 사원들의 이름과 입사일을 출력하세요
select  first_name,
        hire_date
from employees
where hire_date > '07/01/01'; -- '07-01-01', '07:01:01' 도 가능함

-- 이름이 Lex인 직원의 연봉을 출력하세요
select salary*12
from employees
where first_name = 'Lex';

-- 급여가 14000이상이고 17000이하인 직원의 이름과 급여를 출력하세요
select  first_name,
        salary
from employees
where salary >= 14000
and salary <= 17000;

-- 급여가 14000 이하이거나 17000 이상인 사원의 이름과 급여을 출력하세요
select  first_name,
        salary
from employees
where salary <= 14000
or salary >= 17000;

-- 입사일이 04/01/01 에서 05/12/31 사이의 사원의 이름과 입사일을 출력하세요
select  first_name,
        hire_date
from employees
where hire_date between '04/01/01'
and '05/12/31';

-- 급여가 14000에서 17000사이인 직원의 이름과 급여를 출력하세요
select  first_name,
        salary
from employees
where salary between 14000 
and 17000;

-- 사원 중 Neena, Lex, John의 이름과 성, 급여를 출력하세요
select  first_name,
        salary
from employees
where first_name in('Neena', 'Lex', 'John');

-- 월급이 2100, 3100, 4100, 5100 인 사원의 이름과 월급을 구하시오
select  first_name,
        salary
from employees
where salary in(2100, 3100, 4100, 5100);

-- L로 시작하는 이름을 가진 사원의 이름, 성, 급여를 출력하세요
select  first_name,
        last_name,
        salary
from employees
where first_name like 'L%';

-- 이름에 am 을 포함한 사원의 이름과 연봉을 출력하세요
select  first_name,
        salary*12
from employees
where first_name like '%am%';

-- 이름의 두번째 글자가 a 인 사원의 이름과 연봉을 출력하세요
select  first_name,
        salary*12
from employees
where first_name like '_a%';

-- 이름의 네번째 글자가 a 인 사원의 이름을 출력하세요
select first_name
from employees
where first_name like '___a%';

-- 이름이 4글자인 사원중 끝에서 두번째 글자가 a인 사원의 이름을 출력하세요
select first_name
from employees
where first_name like '__a_';

-- 급여가 13000에서 15000사이인 직원의 이름, 급여, 커미션비율, 급여와 커미션비율 곱을 출력하세요
select  first_name,
        salary,
        commission_pct,
        salary*commission_pct
from employees
where salary between 13000 
and 15000;

-- 커피션비율이 없는 사원의 이름, 급여, 커미션비율를 출력하세요
select  first_name,
        salary,
        commission_pct
from employees
where commission_pct is null;

-- 커미션비율이 있는 사원의 이름과 연봉 커미션비율을 출력하세요
select  first_name,
        salary*12,
        commission_pct
from employees
where commission_pct is not null;

-- 담당매니저가 없고 커미션비율이 없는 직원의 이름을 출력하세요
select first_name
from employees
where manager_id is null
and commission_pct is null;

-- 직원의 이름, 급여를 급여 내림차순으로 출력하세요
select  first_name,
        salary
from employees
order by salary desc;

-- 급여가 9000이상인 직원의 이름, 급여를 급여 내림차순으로 출력하세요
select  first_name,
        salary
from employees
where salary >= 9000
order by salary desc;

-- 부서번호를 오름차순으로 정렬하고 부서번호, 급여, 이름을 출력하세요
select  department_id,
        salary,
        first_name
from employees
order by department_id asc; --asc생략 가능

-- 급여가 1000 이상인 직원의 이름 급여를 급여가 큰직원부터 출력하세요
select  first_name,
        salary
from employees
where salary >= 1000
order by salary desc;

-- 부서번호를 오름차순으로 정렬하고 부서번호가 같으면 급여가 높은 사람부터 부서번호 급여 이름을 출력하세요  
select  department_id,
        salary,
        first_name
from employees
order by department_id asc, salary desc;

