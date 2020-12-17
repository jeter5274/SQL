select * from employees;

select * 
from departments;

--원하는 컬럼 조회하기
select employee_id, first_name, last_name from employees;

--1.테이블 명 확인
select * from employees;

--2. 컬럼 설정(도움을 받을 수 있음)
select employee_id, first_name, last_name from employees;

--일반적으로 절별로 줄바꿈해서 사용함
select employee_id, first_name, last_name
from employees;

--원하는 컬럼이 많은 경우도 있어서, 컬럼을 줄바꿈해서 들여쓰기를 맞춰 각각 써줌 -> 앞으로 이렇게 할 것
select employee_id,
       first_name,
       last_name
from employees;

--사원의 이름(first_name)과 전화번호 입사일 연봉을 출력하시오
select first_name,
       phone_number,
       hire_date,
       salary
from employees;

--사원의 이름(first_name)과 성(last_name) 급여, 전화번호, 이메일, 입사일을 출력하세요
select first_name,
       last_name,
       salary,
       phone_number,
       email,
       hire_date
from employees;

--컬럼의 순서대로 출력되므로, 본인이 원하는 순서대로 설정할 수 있음
select salary,
       first_name,
       last_name,
       hire_date,
       phone_number,
       email
from employees;

--컬럼을 중복출력할 수 있음
select salary,
       salary,
       first_name,
       last_name,
       hire_date,
       phone_number,
       email
from employees;

--컬럼명을 내 맘대로(별명) 지정하기 -> 실제 데이터가 변경되는 것은 아님
select employee_id as empNo, --정석 문법, as생략 가능
       first_name "f-name", --대소문자 구분, 공백, 특수문자 등은 ""로 작성
       salary "연봉" --한글같은 경우에는 예외사항이 발생할 수 있어 ""하는 것이 좋음
from employees;

--사원의 이름(first_name)과 전화번호 입사일 급여 로 표시되도록 출력하세요
select first_name "이름",
       phone_number "전화번호",
       hire_date "입사일",
       salary "급여"
from employees;

--사원의 사원번호 이름(first_name) 성(last_name) 급여 전화번호 이메일 입사일로 표시되도록 출력하세요
select employee_id "사원번호",
       first_name "이름",
       last_name "성",
       salary "급여",
       phone_number "전화번호",
       email "이메일",
       hire_date "입사일"
from employees;

--연결 연산자(Concatenation)로 컬럼들 붙이기
select first_name || last_name
from employees;

select first_name ||' '|| last_name as fullname
from employees;

select first_name ||' hire date is '|| hire_date as fullname
from employees;

--산술연산자 사용하기
select first_name, salary
from employees;

select first_name, 
       salary,
       salary*12
from employees;

select first_name, 
       salary,
       salary*12,
       (salary+300)*12
from employees;
/*
--[Error 발생] ORA-01722: invalid number
--문자열은 산술연산되지 않는다
select job_id*first_name
from employees;
*/

select first_name || '-' || last_name "성명",
       salary "급여",
       salary*12 "연봉",
       salary*12+5000 "연봉2",
       phone_number "전화번호"
from employees;

-- select 문 -> where절
select first_name
from employees
where department_id = 10;

-- 연봉이 15000 이상인 사원들의 이름과 연봉을 출력하세요
select first_name,
       salary
from employees
where salary >= 15000;

-- 07/01/01 일 이후에 입사한 사원들의 이름과 입사일을 출력하세요
select first_name,
       hire_date
from employees
where hire_date >= '07/01/01';

--이름이 Lex인 직원의 연봉을 출력하세요
select salary
from employees
where first_name = 'Lex';

--조건이 2개이상 일때 한꺼번에 조회하기
select first_name, 
       salary
from employees
where salary >= 14000 
and salary <=17000;

--연봉이 14000 이하이거나 17000 이상인 사원의 이름과 연봉을 출력하세요
select first_name, 
       salary
from employees
where salary <= 14000
or salary >=17000;

--입사일이 04/01/01 에서 05/12/31 사이의 사원의 이름과 입사일을 출력하세요
select first_name,
       hire_date
from employees
where hire_date >= '04/01/01'
and hire_date <= '05/12/31';

--between 연산 : 연봉이 14000 이상 17000이하인 사원의 이름과 연봉을 구하시오
select first_name, 
       salary
from employees
where salary between 14000 and 17000;

--between 연산 같은 표현
select first_name, 
       salary
from employees
where salary >= 14000 
and salary <=17000;

--in 연산자
select first_name,
       last_name,
       salary
from employees
where first_name in ('Neena', 'Lex', 'John');

--in 연산자와 같은 표현
select first_name,
       last_name,
       salary
from employees
where first_name = 'Neena'
or first_name = 'Lex'
or first_name = 'John';

-- 연봉이 2100, 3100, 4100, 5100 인 사원의 이름과 연봉을 구하시오
select first_name,
       salary
from employees
where salary in (2100, 3100, 4100, 510);

--like연산자
select  first_name,
        last_name,
        salary
from employees
where first_name like 'L%';

select  first_name,
        last_name,
        salary
from employees
where first_name like 'A%';

select  first_name,
        last_name,
        salary
from employees
where first_name like '%a';

select  first_name,
        last_name,
        salary
from employees
where first_name like '%am%';

select  first_name,
        last_name,
        salary
from employees
where first_name like '_a%';

select  first_name,
        last_name,
        salary
from employees
where first_name like '_a___';

select  first_name,
        last_name,
        salary
from employees
where first_name like '___a%';

-- 이름에 am 을 포함한 사원의 이름과 연봉을 출력하세요
select  first_name,
        salary
from employees
where first_name like '%am%';

-- 이름의 두번째 글자가 a 인 사원의 이름과 연봉을 출력하세요
select  first_name,
        salary
from employees
where first_name like '_am%';


-- 이름의 네번째 글자가 a 인 사원의 이름을 출력하세요
select  first_name
from employees
where first_name like '___a%';

-- 이름이 4글자인 사원중 끝에서 두번째 글자가 a인 사원의 이름을 출력하세요
select  first_name
from employees
where first_name like '__a_';

-- null
-- 직원테이블에서 급여가 13000에서 15000사이인
-- 직원의 이름, 금여, 커미션, 급여*커미션 출력
select  first_name,
        salary,
        commission_pct,
        salary*commission_pct 
from employees
where salary BETWEEN 13000 and 15000;

select *
from employees
where commission_pct is null;

-- 커미션비율이 있는 사원의 이름과 연봉 커미션비율을 출력하세요
select  first_name,
        salary,
        commission_pct
from employees
where commission_pct is not null;

--담당매니저가 없고 커미션비율이 없는 직원의 이름을 출력하세요
select first_name
from employees
where manager_id is null and commission_pct is null;

--PK
select email, employee_id
from employees
where employee_id = 110; 

/*
select 문
    select 절 - 보여줘
    from 절 - 테이블을
    where 절 - 조건에 맞춰서
    order by 절 - 정렬해가지고
*/

--order by 절
select  first_name,
        salary
from employees
where salary >= 9000
order by salary desc;

select *
from employees
order by salary desc;

--부서번호를 오름차순으로 정렬하고 부서번호, 급여, 이름을 출력하세요
select  department_id,
        salary,
        first_name
from employees
order by department_id asc;

-- 급여가 10000 이상인 직원의 이름 급여를 급여가 큰직원부터 출력하세요
select  first_name,
        salary
from employees
where salary >= 10000
order by salary desc;

--부서번호를 오름차순으로 정렬하고 부서번호가 같으면 급여가 높은 사람부터 부서번호 급여 이름을 출력하세요  
select  department_id,
        salary,
        first_name
from employees
order by department_id asc, salary desc;
