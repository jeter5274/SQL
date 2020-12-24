-- 숫자형 크기 5인 book_id 문자형 크기 50인 title, 문자형 크기 10인 author, 날짜형인 pub_date 등 4개 컬럼을 가진 book 테이블 생성
create table book (
    book_id     number(5),
    title       varchar2(50),
    author      varchar2(10),
    pub_date    date
);

--확인
select * 
from book;

-- book테이블에 문자형 크기 50인 pubs 칼럼 추가
alter table book add (pubs varchar2(50));

--확인
select * 
from book;

-- title 컬럼의 크기를 50 -> 100으로 변경
alter table book modify (title varchar(100)); -- 테이블 정보에서 확인

-- title 컬럼의 이름을 subject로 변경
alter table book rename column title to subject;

--확인
select * 
from book;

-- author 컬럼을 삭제
alter table book drop (author);

--확인
select * 
from book;

-- book테이블 이름을 article로 변경
rename book to article;

--확인
select * 
from article;

-- article 테이블 삭제
drop table article; --테이블 정보에서 확인

-- 숫자형 크기 10인 author_id, 문자형 크기 100인 author_name, 문자형 크기 500인 author_desc 등 3개의 컬럼을 가진 author테이블을 만드시오, 이때, author_name은 null값이 들어가수 없게, author_id는 프라이머리키로 만드시오
create table author(
    author_id   number(10),
    author_name varchar2(100) not null,
    author_desc varchar2(500),
    primary key (author_id)
);
--확인
select * 
from author;

-- 숫자형 크기 10인 book_id, 문자형 크기 100인 title, 문자형 크기 100인 pubs, 날짜형인 pubs_date, 숫자형 크기 10인 author_id 등 5개 컬럼을 가진 book테이블을 만드시오, 이때, title은 null값이 들어가수 없게, book_id는 프라이머리키로, author_id는 외래키로 author테이블의 author_id를 참조하게 만드시오
create table book(
    book_id     number(10),
    title       varchar2(100) not null,
    pubs        varchar2(100),
    pubs_date   date,
    author_id   number(10),
    primary key (book_id),
    constraint book_fk foreign key (author_id)
    references author(author_id) 
);

--확인
select * 
from book;

-- author테이블에 (1, 박경리, 토지 작가, 20-01-01) 데이터를 삽입하세요
insert into author 
values (1, '박경리', '토지 작가'); --묵시적 방법

--확인
select * 
from author;

-- author테이블에 (2, 이문열) 데이터를 삽입하세요
insert into author (author_id, author_name)
values (2, '이문열'); --명시적 방법

--확인
select * 
from author;

-- author테이블의 author이 1인 데이터의 author_name를 기안84로, author_desc 웹툰 작가로 변경하세요
update author 
set author_name = '기안84', author_desc = '웹툰작가'
where author_id = 1;

--확인
select * 
from author;

-- author테이블의 author이 1인 데이터를 삭제하시오
delete author
where author_id = 1;

--확인
select * 
from author;

-- author테이블의 전체 데이터를 삭제하시오
delete author;

--확인
select * 
from author;

-- author테이블에 시퀀스를 활용하여 테이터 박경리, 토지 작가 / 이문열, 삼국지 작가를 1번, 2번으로 삽입하시오
-- author 시퀀스 생성
create sequence seq_author
increment by 1
start with 1;

insert into author 
values (seq_author.nextval, '박경리', '토지 작가');

insert into author 
values (seq_author.nextval, '이문열', '삼국지 작가');

--확인
select * 
from author;

-- 모든 시퀀스 정보를 조회하시오
select * from user_sequences;

-- 현재 시퀀스 번호를 조회하시오
select seq_author.currval
from dual;

-- 다음 시퀀스 정보를 조회하시오
select seq_author.nextval
from dual;

-- 시퀀스를 삭제하시오
drop sequence seq_author;

-- 확인
select * from user_sequences;