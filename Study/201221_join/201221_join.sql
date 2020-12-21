/** JOIN **/

/* EQUI Join */
-- 직원(employees)들의 이름, 부서아이디(employees), 부서명, 부서아이디(departments)를 출럭하세요 (부서가 없는 사람은 제외)
select  emp.first_name,
        emp.department_id,
        dep.department_name,
        dep.department_id
from employees emp, departments dep
where emp.department_id = dep.department_id;

-- 부서가 없는 직원을 제외한 모든 직원의 직원이름, 부서이름, 업무명 을 출력하세요
select  emp.first_name 이름,
        dep.department_name 부서명,
        job.job_title 업무명
from employees emp, departments dep, jobs job
where emp.department_id = dep.department_id
and emp.job_id = job.job_id;


/* left outer join */
-- 부서가 없는 직원을 포함한 모든직원의 부서아이디, 이름, 부서명을 출력하세요
select  emp.department_id,
        emp.first_name,
        dep.department_name
from employees emp left outer join departments dep
on emp.department_id = dep.department_id;

-- 위 예제를 오라클에서 제공하는 약칭으로 출력하세요
select  emp.department_id,
        emp.first_name,
        dep.department_name
from employees emp, departments dep
where emp.department_id = dep.department_id(+);

/* right outer join */
-- 부서원이 없는 부서를 포함하여 모든 부서의 직원들의 부서아이디, 이름, 부서명을 출력하세요
select  emp.department_id,
        emp.first_name,
        dep.department_name
from employees emp right outer join departments dep
on emp.department_id = dep.department_id;

-- 위 예제를 오라클에서 제공하는 약칭으로 출력하세요
select  emp.department_id,
        emp.first_name,
        dep.department_name
from employees emp, departments dep
where emp.department_id(+) = dep.department_id;

/* full outer join */
-- 부서가 없는 직원 포함하여 모든직원의 부서아이디, 이름, 부서명을 출력하세요, 이때 부서원이 없는 부서도 출력하세요
select  emp.department_id,
        emp.first_name,
        dep.department_name
from employees emp full outer join departments dep
on emp.department_id = dep.department_id;

/* self join */
-- 매니저가 있는 직원의 직원아이디, 이름, 매니저아이디, 매니저를 출력하세요
select  emp.employee_id 직원아이디,
        emp.first_name 직원이름,
        emp.manager_id 매니저아이디,
        man.first_name 매니저이름
from employees emp, employees man
where emp.manager_id = man.employee_id;

-- 모든 직원의 직원아이디, 이름, 매니저아이디, 매니저를 출력하세요
select  emp.employee_id 직원아이디,
        emp.first_name 직원이름,
        emp.manager_id 매니저아이디,
        man.first_name 매니저이름
from employees emp left outer join employees man
on emp.manager_id = man.employee_id;

-- 위 예제를 오라클에서 제공하는 약칭으로 출력하세요
select  emp.employee_id 직원아이디,
        emp.first_name 직원이름,
        emp.manager_id 매니저아이디,
        man.first_name 매니저이름
from employees emp, employees man
where emp.manager_id = man.employee_id(+);