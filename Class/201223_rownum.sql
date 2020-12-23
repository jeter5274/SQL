/* rownum */

--예제 : 급여를 가장 많이 받는 5명의 직원의 이름을 출력하시오.

--rownum이 order by보다 먼저 생겨 번호가 섞임
select  rownum,
        employee_id,
        first_name,
        salary
from employees
order by salary desc;

-- 내생각 : 서브쿼리로 정렬하고 로우럼을 붙임
select  rownum,
        emp.employee_id,
        emp.first_name,
        emp.salary
from (select employee_id,
             first_name,
             salary
      from employees
      order by salary desc) emp
where rownum <= 5;

-- 정렬하고 rownum을 사용

select * --테이블을 정렬하는 것으로만 사용
from employees
order by salary desc;

select  rownum,
        o.employee_id,
        o.first_name,
        o.salary
from (select  * --실제로 제대로 쿼리문을 만들때에는 *는 조회만하고, 필요한 컬럼 모두 작성해줌
      from employees
      order by salary desc) o; --salary로 정렬된 employees를 사용
      
select  rownum,
        o.employee_id,
        o.first_name,
        o.salary
from (select  emp.employee_id,
              emp.first_name,
              emp.salary
      from employees emp
      order by salary desc) o
where rownum >= 2 
and rownum <= 5;
--오류 원인 : where절에 조건을 rownum을 사용할 때 rownum 1번이 조건에 맞지않은 경우에는 제외되고 조건에 맞는 첫번째 row를 1로 지정하여 오류 발생

--해결방안 정렬이된 테이블을 SubQuery로 가진 테이블에 rownum을 한 테이블을 SubQuery로 활용
select  orn.rn,
        orn.employee_id,
        orn.first_name,
        orn.salary
from (select  rownum rn,    --별명을 사용해야함
              o.employee_id,
              o.first_name,
              o.salary
      from (select  emp.employee_id,
                    emp.first_name,
                    emp.salary
            from employees emp
            order by salary desc) o) orn
where orn.rn >= 11
and orn.rn <=20;

-- 예제 : 07년에 입사한 직원중 급여가 많은 직원중 3에서 7등의 이름 급여 입사일은? 
--1. 07년에 입사한 직원의 이름 급여 입사일을 급여 내림차순으로 정렬
select  first_name,
        salary,
        hire_date
from employees
where hire_date >= '07/01/01'
and hire_date <= '07/12/31'
order by salary desc;

--02. rownum을 생성
select  rownum,
        h07.first_name,
        h07.salary,
        h07.hire_date
from (select  first_name,
              salary,
              hire_date
      from employees
      where hire_date >= '07/01/01'
      and hire_date <= '07/12/31'
      order by salary desc) h07;
      
--03. rownum을 조건으로 활용하기 위해 h07테이블을 SubQuery로 활용
select  rh07.rn,
        rh07.first_name,
        rh07.salary,
        rh07.hire_date
from (select  rownum rn,
              h07.first_name,
              h07.salary,
              h07.hire_date
      from (select  first_name,
                    salary,
                    hire_date
            from employees
            where hire_date >= '07/01/01'
            and hire_date <= '07/12/31'
            order by salary desc) h07) rh07
where rh07.rn >= 3
and rh07.rn <=7;