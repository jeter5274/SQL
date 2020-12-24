-- book테이블 생성
-- number(5)형의 book_id, varchar2(50)형의 title, varchar2(10)형의 author, date형의 pub_date 등 4개 칼럼    
create table book (
    book_id     number(5),
    title       varchar2(50),
    author      varchar2(10),
    pub_date    date
);

-- book 테이블에 VARCHAR2(50)형의 pubs 컬럼 추가
ALTER TABLE book ADD (pubs VARCHAR2(50));

-- book 테이블 title컬럼을 VARCHAR2(100)형으로 변경
ALTER TABLE book MODIFY (title VARCHAR2(100));

-- book 테이블의 title컬럼을 subject컬럼으로 이름변경
ALTER TABLE book RENAME COLUMN title TO subject;

-- book 테이블의 author 컬럼을 삭제
ALTER TABLE book DROP (author);

-- book테이블의 이름을 article로 변경 
RENAME book TO article;

--article테이블 삭제
DROP TABLE article;

-- author테이블 생성(제약조건 추가)
-- number(10)형의 author_id, varchar2(100)형의 author_name, varchar2(500)형의 author_desc 등 3개 컬럼
-- author_name컬럼에는 null값이 올 수 없음
-- primary key는 author_id임
create table author (
    author_id   number(10),
    author_name varchar2(100) not null,
    author_desc varchar2(500),
    primary key(author_id)
);
               

--DML - insert 삽입
--묵시적 방법 (모든 컬럼에 데이터를 넣을 경우에 생략이 가능하다고 보면 됨)
-- 컬럼이 많을 경우에 아래와 같이 나누어 쓰기도 함
insert into author 
values( 1,
        '박경리',
        '토지 작가');
        
-- null을 넣을 경우 아래와 같이 하면 안됨
insert into author 
values( 1, , '토지 작가');
        
--명시적 방법
-- 컬럼의 순서가 달라져도 상관없으나, 데이터를 넣을 때 주의
-- null값을 넣고 싶을 경우에는 컬럼명을 제외
insert into author (author_id, author_name)
values( 2, '이문열');

--명시적 방법 오류사항
--1. author_name에 null값을 넣을 수 없으므로 오류
insert into author (author_id, author_desc)
values( 3, '나 혼자 산다');

--2. primary key인 author_id값이 중복되는 오류
insert into author (author_id, author_name, author_desc)
values( 1, '기안84','나 혼자 산다');

--DML - update 수정
update author
set author_name = '기안84',
    author_desc = '나혼자산다 출연 웹툰작가';
where author_id = 1; --조건절을 작성하지 않는 경우, 모든 row를 바꿈

update author
set author_name = '이문열'
where author_id = 1;

--DML - delete 삭제
delete from author
where author_id = 1; --조건절을 작성하지 않는 경우, 모든 row가 삭제

--실습
delete from author;

insert into author 
values( seq_author_id.nextval,
        '이문열',
        '경북 양양');
        
insert into author 
values( seq_author_id.nextval,
        '박경리',
        '경남 통영');
        
insert into author 
values( seq_author_id.nextval,
        '유시민',
        '17대국회의원');

--번호표 기계 -> 시퀀스
--시퀀스 생성
create sequence seq_author_id
INCREMENT BY 1 
START WITH 1;

--시퀀스를 활용하여 INSERT
insert into author 
values( seq_author_id.nextval,
        '기안84',
        '나혼자산다');
    
-- 시퀀스 조회    
select seq_author_id.currval
from dual;

-- 시퀀스 다음번호 조회 -> +1됨 (강제 실행)
select seq_author_id.nextval
from dual;

-- 시퀀스 조회
select * from user_sequences;

-- 시퀀스 삭제
drop sequence seq_author_id;

select *
from author
order by author_id;