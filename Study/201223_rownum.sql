/* rownum */

-- 직원의 이름, 급여에 rownum를 출력하시오
select  rownum,
        first_name,
        salary
from employees;

-- 직원의 이름, 급여에 rownum를 급여 내림차순으로 출력하시오
select  rownum,
        first_name,
        salary
from employees
order by salary desc;

-- 직원의 급여가 높은 순으로 이름, 급여 rownum을 출력하시오
select  rownum,
        oem.first_name,
        oem.salary
from (select first_name,
            salary
      from employees
      order by salary desc) oem;
      
-- 급여를 가장 많이 받는 5명의 직원의 이름을 출력하시오
select  roem.rn,
        roem.first_name,
        roem.salary
from (select  rownum rn,
              oem.first_name,
              oem.salary
      from (select first_name,
                   salary
            from employees
            order by salary desc) oem) roem
where roem.rn <= 5;

-- 07년에 입사한 직원중 급여가 많은 직원중 3에서 7등의 이름 급여 입사일은? 
select  roh07em.rn,
        roh07em.first_name,
        roh07em.salary,
        roh07em.hire_date
from (select  rownum rn,
              oh07em.first_name,
              oh07em.salary,
              oh07em.hire_date
      from (select  first_name,
                    salary,
                    hire_date
            from employees
            where hire_date >= '07/01/01'
            and hire_date <= '07/12/31'
            order by salary desc) oh07em) roh07em
where roh07em.rn >= 3
and roh07em.rn <= 7;
      