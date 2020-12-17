/*단일행 함수*/

--문자함수 – INITCAP(컬럼명)
select  email,
        initcap(email),
        department_id
from employees
where department_id = 100;

select  email,
        initcap('aaaaa'), --문자열도 가능함, 문자열이 헷갈릴때는 별명("") 빼고 다 ''을 쓴다고 생각하기
        department_id
from employees
where department_id = 100;

-- 문자함수 – LOWER(컬럼명) / UPPER(컬럼명)
select  first_name,
        lower(first_name),
        upper(first_name)
from employees;

-- 문자함수 – SUBSTR(컬럼명, 시작위치, 글자수)
select  first_name,
        substr(first_name,3), -- 3번째부터 끝까지
        substr(first_name,2,6),  --띄어쓰기도 포함됨
        substr(first_name,-3,2) --뒤에서부터 3번째에서 2개
from employees
where department_id = 100;

--문자함수 – LPAD(컬럼명, 자리수, ‘채울문자’) /  RPAD(컬럼명, 자리수, ‘채울문자’)
select  first_name,
        lpad(first_name, 10, '*'), --10개 이상은 뒤에가 잘림
        rpad(first_name, 10, '*')  --10개 이상은 뒤에가 잘림
from employees;

--문자함수 – REPLACE (컬럼명, 문자1, 문자2)
select  first_name,
        replace(first_name, 'a', '*****'),
        department_id
from employees
where department_id = 100;

--함수 조합
select  first_name,
        replace(first_name, 'a', '*'),
        substr(first_name, 2, 3),
        replace(first_name, substr(first_name, 2, 4), '****')
from employees
where department_id=100;

--숫자함수 – ROUND(숫자, 출력을 원하는 자리수) 
select *
from dual;

select  round(123.456, 1) r2,
        round(123.456, 0) r0,
        round(123.456, -1) "r-1"  --1의자리 반올림
from dual;

select  salary,
        round(salary, -3) "sR2"
from employees;

-- 숫자함수 – TRUNC(숫자, 출력을 원하는 자리수) 
select  trunc(123.456, 2) as t2,
        trunc(123.456, 0) as t0,
        trunc(123.456, -1) as "t-1"
from dual;

-- 날짜함수 - SYSDATE
select sysdate
from dual;

select  sysdate,
        first_name
from employees;

-- 날짜함수 – MONTH_BETWEEN(d1, d2)
select  sysdate,
        hire_date,
        months_between(sysdate, hire_date) as "workMonth",
        trunc(months_between(sysdate, hire_date), 0) as "근무개월"
from employees
where department_id = 100;

--날짜함수 - LAST_DAY(d1)
select  last_day('20/02/06'),
        last_day(sysdate)
from dual;

-- 변환함수
-- TO_CHAR(숫자, '출력모양') 숫자형  문자형으로 변환하기
select  first_name,
        salary,
        salary*12,
        to_char(salary*12, '$999,999.00'), --0또는9로만 하도록 정해져 있음
        to_char(salary*12, '999,999.00'),
        to_char(salary*12, '999,999'),
        to_char(salary*12, '099,999'),
        to_char(salary*12, '$999999')
from employees
where department_id = 100;

-- TO_CHAR(날짜, ‘출력모양’)  날짜문자형으로 변환하기
select  hire_date,
        to_char(hire_date, 'YYYY-MM-DD HH24:MI:SS')
from employees;


-- 년월일 시분초
select  sysdate,
        to_char(sysdate, 'YYYY-MM-DD HH24:MI:SS')
from dual;

select  first_name,
        hire_date,
        to_char(hire_date, 'YYYY-MM-DD HH24:MI:SS')
from employees;

--일반함수 NVL(컬럼명, null일때값)/NVL2(컬럼명, null아닐때값, null일때 값)
select  first_name,
        commission_pct,
        nvl(commission_pct, 0), --'aaa' 등 문자열을 넣으면 오류 발생함
        nvl2(commission_pct, 100, 0)
from employees;
