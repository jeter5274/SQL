/** 그룹함수 **/

--직원의 숫자와 커미션비율이 있는 직원의 숫자를 출력하세요
--월급이 16000 초과인 직원의 숫자를 출력하세요
--직원의 숫자와 급여의 합을 출력하세요
--직원의 숫자와 급여이 합, 급여의 평균(null은 버리고 계산하도록)을 출력하세요
--직원의 숫자와 급여의 합, 급여의 평균(null은 0으로 계산하도록) 출력하세요
--직원의 숫자와 가장 많은 급여, 가장 적은 급여를 출력하세요

/** GROUP BY 절**/
--직원의 부서ID와 급여를 출력하고, 부서 오름차순으로 정렬하세요
--직원의 부서별 부서ID와 급여평균을 출력하고, 부서 오름차순으로 정렬하세요
--직원의 부서별 부서ID, 숫자, 급여합계를 출력하세요
--직원의 부서별 부서ID, 직무ID, 숫자, 급여합계를 출력하세요

/** HAVING 절 */
--급여(salary)의 합계가 20000 이상인 부서의 부서 번호와 , 인원수, 급여합계를 출력하세요

/* CASE ~ END 문 & DECODE() */
-- 직원들 중 AC_ACCOUNT, SA_REP, ST_CLERK직무는 각각 10%, 20%, 30% 급여가 인상되었을 때, 직원ID, 급여, 인상급여를 출력하세요
-- 위 예제를 DECODE함수를 통해 작성하시오
-- 직원의 이름, 부서, 팀을 출력하세요 팀은 코드로 결정하며 부서코드가 10~50 이면 ‘A-TEAM’ 60~100이면 ‘B-TEAM’  110~150이면 ‘C-TEAM’ 나머지는 ‘팀없음’ 으로 출력하세요.
-- 위 예제를 DECODE함수를 통해 작성하시오