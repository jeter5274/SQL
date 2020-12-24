-- 1. 수업/실습 등 사용한 webdb 계정삭제
drop user webdb cascade;

--2. 복습하기위한 webdb생성
create user webdb identified by webdb;

--3. webdb에 접속권한을 부여
grant resource, connect to webdb;
