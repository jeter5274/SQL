/*JOIN*/
--개념설명


-- employees department_id = departments department_id 인경우 가져와 *null은 제외됨
select *
from employees, departments
where employees.department_id = departments.department_id;

select  first_name,
        department_name
from employees, departments
where employees.department_id = departments.department_id;

select  em.first_name,
        de.department_name
from employees em, departments de       --별명을 약어로 주고 별명을 통해 정확히 지칭하는게 좋음
where em.department_id = de.department_id;

--JOIN 예제 : 모든 직원이름, 부서이름, 업무명 을 출력하세요
select  em.first_name,
        de.department_name,
        jo.job_title
from employees em, departments de, jobs jo
where em.department_id = de.department_id
and em.job_id = jo.job_id;

select  em.first_name,
        de.department_name,
        jo.job_title,
        em.job_id,
        jo.job_id,
        em.department_id,
        de.department_id
from employees em, departments de, jobs jo
where em.department_id = de.department_id
and em.job_id = jo.job_id;

--LEFT JOIN : 왼쪽에 모든 튜플은 결과테이블에 나타냄
select  em.department_id,
        em.first_name,
        de.department_name
from employees em left outer join departments de --왼쪽테이블인 employees을 기준으로 departments과의 모든 매칭 결과를 보여주고 매칭이 없어도 출력해
on em.department_id = de.department_id;

--오라클에서만 제공해주는 약어 (+)
select  em.department_id,
        em.first_name,
        de.department_name
from employees em, departments de
where em.department_id = de.department_id(+);
--왼쪽 테이블인 employees을 기준으로 departments과의 null을 포함한 모든 매칭을 +할래

--RIGHT JOIN : 오른쪽의 모든 튜플은 결과 테이블에 나타남
select  em.department_id,
        em.first_name,
        de.department_name
from employees em right outer join departments de --오른쪽테이블인 departments을 기준으로 employees과의 모든 매칭결과를 보여주고 매칭이 없어도 출력해
on em.department_id = de.department_id;

--오라클에서만 제공해주는 약어 (+)
select  em.department_id,
        em.first_name,
        de.department_name
from employees em, departments de
where em.department_id(+) = de.department_id;
--오른쪽 테이블인 departments을 기준으로 employees과의 null을 포함한 모든 매칭을 +할래

--RIGHT JOIN -> LEFT JOIN
select  em.department_id,
        em.first_name,
        de.department_name
from departments de left outer join employees em -- right -> left로 변경해서 테이블 선언위치를 변경해도 결과는 같음
on em.department_id = de.department_id;

select  department_id,
        department_name
from departments;

-- FULL OUTER JOIN
select  em.department_id,
        em.first_name,
        de.department_name,
        de.department_id
from departments de full outer join employees em
on em.department_id = de.department_id;

select  em.department_id,
        em.first_name,
        de.department_name,
        de.department_id
from departments de, employees em
where em.department_id(+) = de.department_id(+); -- 이거는 안됌


select  employees.department_id, --별명을 지어주면 별명을 사용하여야 함
        em.first_name,
        de.department_name,
        de.department_id
from departments de, employees em --별명과 본명개념보다, 본명이 변경된다고 생각하면 편함
where em.department_id = de.department_id;

--JOIN 실행순서 체크
select  em.department_id,
        em.first_name,
        de.department_name,
        de.department_id
from departments de, employees em
where em.department_id = de.department_id
order by de.department_id desc;

select  em.department_id,
        em.first_name,
        de.department_name
from departments de, employees em
where em.department_id = de.department_id
order by de.department_id desc; --de.department_id를 select로 불러오지 않았는데도 정상으로 정렬됨
--가상테이블은 from절과 where절을 통해 메모리에 올라오고, select/order by는 메모리의 가상테이블을 통해 실행됨

--SELF JOIN : 같은 테이블을 별명을 달리해서 불러옴
select  em.employee_id,
        em.first_name,
        em.manager_id,
        ma.first_name manager
from employees em, employees ma
where em.manager_id = ma.employee_id;

--SELF JOIN null포함
select  em.employee_id,
        em.first_name,
        em.manager_id,
        ma.first_name manager
from employees em, employees ma
where em.manager_id = ma.employee_id(+);

-- 잘 못된 사용 예
select *
from employees em, locations lo
where em.salary = lo.location_id;