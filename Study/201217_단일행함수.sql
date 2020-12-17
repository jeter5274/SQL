/***단일행 함수***/

/**문자함수**/

--부서ID가 100인 직원의 이메일, 첫문자만 대문자인 이메일, 부서ID를 출력하세요
select  email,
        initcap(email), --이니셜의 캡을 정한다 이닛캡
        department_id
from employees
where department_id=100;

--부서ID가 100인 직원의 이름, 소문자이름, 대문자 이름으로 출력하세요
select  first_name,
        lower(first_name),
        upper(first_name)
from employees
where department_id=100;

--부서ID가 100인 직원의 이름, 이름의 첫번째부터 3글자, 이름의 뒤에서 3번째부터 2글자를 출력하세요
select  first_name,
        substr(first_name,1,3),
        substr(first_name,-3,2)
from employees
where department_id = 100;

--직원의 이름, 10글자 이름의 왼쪽공백을 *, 10글자 이름의 오른쪽공백을 *로 출력하세요
select  first_name,
        LPAD(first_name, 10, '*'), --패드를 10개만 깔아놓고 나머지는 자르는데 모자라면 왼쪽에 *을 채우자
        RPAD(first_name, 10, '*') --패드를 10개만 깔아놓고 나머지는 자르는데 모자라면 오른쪽에 *을 채우자
from employees;

--부서ID가 100인 직원의 이름, 이름 중 a를 '*'로 변경한 내용을 출력하세요
select  first_name,
        replace(first_name, 'a', '*')
from employees;

--부서ID가 100인 직원의 이름, 이름의 두번째부터 세번째를 '***'로 변경한 내용을 출력하세요
select  first_name,
        replace(first_name, substr(first_name, 2, 3), '***')
from employees
where department_id=100;

/* 강의자료의 문자함수 종류 중에 예제에 없는 함수 Test해보기 */
-- CONCAT(s1,s2)문자열 결함
select  first_name,
        last_name,
        concat(first_name, last_name)
from employees;

select  first_name,
        last_name,
        concat(first_name, ' ', last_name) --세개는 안돼
from employees;

select  first_name,
        last_name,
        concat(concat(first_name, ' '), last_name) --요러케는 되넹
from employees;

-- LTRIM(s,c) 문자열 왼쪽 c문자열 제거
select LTRIM('LTRIM', 'L')
from dual;

select LTRIM('LTRIM', 'T') --소용없음
from dual;

select LTRIM('LTRIM', 'M') --소용없음
from dual;
-- RTRIM(s,c) 문자열 오른쪽 c문자열 제거
select RTRIM('RTRIM', 'M')
from dual;

select RTRIM('RTRIM', 'L') --소용없음
from dual;

select RTRIM('RTRIM', 'T') --소용없음
from dual;

-- CHR(n) ASCII값이 n인 문자 반환
select CHR(65)
from dual;

-- TRANSLATE(s,from,to) s에서 from 문자열의 각 문자를 to문자열의 각 문자로 변환
select TRANSLATE('HelloWorld', 'World', 'Warld') --hello의 o도 a로 바뀜, 그래서 각 순번에 맞는 문자를 전체에서 변경함
from dual;

select TRANSLATE('HelloWorld', 'World', 'abcdefg') --오류는 없지만 상응하는 문자가 없으니 로직에러라 볼 수 있는건가?
from dual;

-- ASCII(s) ASCII값 반환
select ASCII('A')
from dual;

-- INSTR(s1,s2,m,n) 문자열 검색, s1의 m번째부터 s2 문자열이 나타나는 n번째 위치 반환
-- 이해가 안됨 다시 찾아봐야할 듯
select instr('HelloWorld', 'World', 1, 1) 
from dual;

-- LENGTH(s)문자열 길이 반환
select length('HelloWorld') 
from dual;

/**숫자함수**/
--123.456을 소수점 2째자리 수 까지 반올림하여 출력해보세요 (가상테이블 활용 dual)
select round(123.456, 2)
from dual;

--123.456의 1의 자리까지 반올림하여 출력해 보세요 (가상테이블 활용 dual)
select round(123.456, 1)
from dual;

--123.456의 1의자리를 반올림해보세요 (가상테이블 활용 dual)
select round(123.456, -1)
from dual;

--123.456을 소수점 2째자리 수 까지 출력해보세요 (가상테이블 활용 dual)
select trunc(123.456, 2)
from dual;

--123.456의 소수점을 제외하고 출력해 보세요 (가상테이블 활용 dual)
select trunc(123.456, 0)
from dual;

--123.456의 1의자리를 버림해서 출력해보세요 (가상테이블 활용 dual)
select trunc(123.456, -1)
from dual;

/* 강의자료의 숫자함수 종류 중에 예제에 없는 함수 Test해보기 */
--ABS(n) 절대값 ABS(-5) 5
select abs(-1)
from dual;

--CEIL(n) n 보다 크거나 같은 최소 정수 CEIL(-2.4) -2
select ceil(-102.23002923)
from dual;

--FLOOR(n) n 보다 작거나 같은 최대 정수 FLOOR(-2.4) -3
select floor(-102.23002923)
from dual;

--MOD(m,n) 나머지 MOD(13,2) 1
select mod(10, 3)
from dual;

--POWER(m,n) m의 n승  POWER(2,3) 8
select power(2,10)
from dual;

--SIGN(n) 부호 (1, 0, -1) SIGN(-10) -1 양수면 1, 음수면 -1, 0이면 0을 출력한다
select sign(-102.23002923)
from dual;

select sign(102.23002923)
from dual;

/**날짜함수**/
-- 현재날짜를 가상테이블에서 출력하세요
select sysdate
from dual;

-- 현재날짜를 직원테이블에서 출력하세요 처리방식을 생각해보는게 관건임
select sysdate
from employees;

-- 부서ID가 110인 직원들의 근속개월을 출력하세요
select  abs(round(months_between(hire_date, sysdate), 0))
from employees;

select  round(months_between(sysdate, hire_date), 0)
from employees;

/* 강의자료의 날짜함수 종류 중에 예제에 없는 함수 Test해보기 */
--ADD_MONTHS(d,n) d날짜에 n달 더함 ADD_MONTHS ('11-JAN-94',6) '11-JUL-94‘
select add_months(sysdate, 1)
from dual;

--LAST_DAY(d) d의 달의 마지막 날 LAST_DAY('01-FEB-95') '28-FEB-95‘
--수업시간에 했음
select last_day(sysdate)
from dual;

--NEW_TIME(d,z1,z2) z1타임존의 d에서 z2타임존의 날짜 생성 
-- 이해가 안됨 다시 찾아봐야할 듯
select NEW_TIME(sysdate, 'AST', 'PST')
from dual;

--NEXT_DAY(d,day) d날 후의 첫 day요일의 날짜 NEXT_DAY ('01-SEP-95','FRIDAY') '08-SEP-95‘
select next_day(sysdate, '수요일')
from dual;

--ROUND(d,fmt)fmt에 따른 날짜반올림 ROUND(SYSDATE,'MONTH') 01-AUG-95
select round(sysdate, 'month') -- 1개월을 반올림하여 다음달 1일을 출력했음
from dual;

--ROUND(SYSDATE ,'YEAR') 01-Jan-96
select round(sysdate, 'year') -- 1년을 반올림해도 지금이 12월이라...같아보여
from dual;

select round(sysdate, 'day') -- 17일이니까 20일로 나옴
from dual;

--TRUNC(d,fmt)fmt에 따른 날짜내림 TRUNC(SYSDATE ,'MONTH') 01-JUL-95
select trunc(sysdate, 'month') -- 1개월을 내림하여 이번달 1일을 출력했음
from dual;

--TRUNC(SYSDATE ,'YEAR') 01-JAN-95
select trunc(sysdate, 'year') -- 1년을 내림하여 이번해 1일을 출력했음
from dual;

select trunc(sysdate, 'day') -- 17일데 13이나왓어 뭘까?
from dual;

/**변환함수**/
-- 부서아이디가 110인 직원의 이름, 연봉 SAL로 표기하여 출력하되, 연봉의 $표시와 천단위, 그리고 소숫점2째자리까지 출력하세요
select  first_name,
        to_char(salary*12, '$999,999.99') SAL
from employees
where department_id = 110;

-- 오늘 날짜와, 오늘 날짜의 양식을 2020-12-17 16:36:55와 같은 형식으로 출력하세요 (가상테이플 활용)
select  sysdate,
        to_char(sysdate, 'YYYY-MM-DD HH24:MI:SS')
from dual;

/* TO_NUMBER(s,fmt)와 TO_DATE(s,fmt)해보기 */
--TO_NUMBER(s,fmt)
--하는법 찾아보기
--TO_DATE(s,fmt)해보기
--하는법 찾아보기

/**일반함수**/
-- 직원의 커미션비율과 커미션 없을때 0으로 출력하는 커미션비율을 출력하세요
select  commission_pct,
        nvl(commission_pct, 0)
from employees;

-- 직원의 커미션비율과 커미션 있을때는 100으로, 없을때는 0으로 출력하는 커미션비율을 출력하세요
select  commission_pct,
        nvl2(commission_pct, 100, 0)
from employees;