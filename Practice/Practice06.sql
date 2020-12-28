--테이블/시퀀스 삭제
drop table book;
drop table author;
drop sequence seq_author;
drop sequence seq_book;

-- author 테이블 생성
create table author(
    author_id   number(5),
    author_name varchar2(100) not null,
    author_desc varchar2(500),
    primary key (author_id)
);
-- 확인
select *
from author;

-- book 테이블 생성
create table book(
    book_id number(10),
    title varchar2(100) not null,
    pubs varchar2(100),
    pub_date date,
    author_id number(10),
    primary key (book_id),
    constraint book_fk foreign key (author_id)
    references author(author_id)
);
-- 확인
select *
from book;

-- book sequence 생성
create sequence seq_book
increment by 1
start with 1; 

--확인
select *
from user_sequences;

-- author sequence 생성
create sequence seq_author
increment by 1
start with 1; 

--확인
select *
from user_sequences;

-- author테이블 데이터 삽입
insert into author
values (seq_author.nextval, '이문열', '경북 양양');

insert into author
values (seq_author.nextval, '박경리', '경상남도 통영');

insert into author
values (seq_author.nextval, '유시민', '17대 국회의원');

insert into author
values (seq_author.nextval, '기안84', '기안동에서 산 84년생');

insert into author
values (seq_author.nextval, '강풀', '알쓸신잡'); --잘 못 입력해서, 추후 수정

insert into author
values (seq_author.nextval, '김영하', '알쓸신잡');

--확인
select *
from author;

--강풀 정보 수정
update author
set author_desc = '온라인 만화가 1세대'
where author_name = '강풀';

--확인
select *
from author;

--book테이블 데이터 삽입
insert into book
values (seq_book.nextval, '우리들의 일그러진 영웅', '다림', '1998-02-22', 1);

insert into book
values (seq_book.nextval, '삼국지', '민음사', '2002-03-01', 1);

insert into book
values (seq_book.nextval, '토지', '마로니에북스', '2012-08-15', 2);

insert into book
values (seq_book.nextval, '유시민의 글쓰기 특강', '생각의길', '2015-04-01', 3);

insert into book
values (seq_book.nextval, '패션왕', '중앙북스(books)', '2012-02-22', 4);

insert into book
values (seq_book.nextval, '순정만화', '재미주의', '2011-08-03', 5);

insert into book
values (seq_book.nextval, '오직두사람', '문학동네', '2017-05-04', 6);

insert into book
values (seq_book.nextval, '26년', '재미주의', '2012-02-04', 5);

--확인
select *
from book;

-- PPT처럼 출력하기
-- 방법1 EQUI JOIN
select  bo.book_id,
        bo.title,
        bo.pubs,
        to_char(bo.pub_date, 'YYYY-MM-DD') pub_date,
        bo.author_id,
        au.author_name,
        au.author_desc
from book bo, author au
where bo.author_id = au.author_id;

-- 방법2 left outer join
select  bo.book_id,
        bo.title,
        bo.pubs,
        to_char(bo.pub_date, 'YYYY-MM-DD') pub_date,
        bo.author_id,
        au.author_name,
        au.author_desc
from book bo left outer join author au
on bo.author_id = au.author_id;

-- 강풀의 author_desc 정보를 ‘서울특별시’ 로 변경해 보세요
update author 
set author_desc = '서울특별시'
where author_name = '강풀';

--확인 : 강풀의 2개 책의 정보가 모두 변하여 출력하는 것을 확인
select  bo.book_id,
        bo.title,
        bo.pubs,
        to_char(bo.pub_date, 'YYYY-MM-DD') pub_date,
        bo.author_id,
        au.author_name,
        au.author_desc
from book bo left outer join author au
on bo.author_id = au.author_id;

select  bo.book_id,
        bo.title,
        bo.pubs,
        to_char(bo.pub_date, 'YYYY-MM-DD') pub_date,
        bo.author_id,
        au.author_name,
        au.author_desc
from book bo full outer join author au
on bo.author_id = au.author_id;

-- author 테이블에서 기안84 데이터를 삭제해 보세요
-- ORA-02292: integrity constraint (WEBDB.BOOK_FK) violated - child record found 발생
-- book테이블에서 외래키로 기안84의 정보를 불러오는 곳이 있어서 오류가 발생함
delete author
where author_name = '기안84';

-- book에서 패션왕을 지우고, 기안84의 정보를 지워봄
delete book
where title = '패션왕';

--확인
select *
from book;

-- 기안84의 정보 삭제
delete author
where author_name = '기안84';

--확인
select *
from author;

--지워짐을 확인 할 수 있음

--데이터 복구
insert into book
values (sep_book.nextval, '패션왕', '중앙북스(books)', '2012-02-22', 4);
-- 기안 84의 정보가 지워졌으므로, 오류가 발생함

insert into author
values (sep_author.nextval, '기안84', '기안동에서 산 84년생');

insert into book
values (sep_book.nextval, '패션왕', '중앙북스(books)', '2012-02-22', 4);
--기안84의 정보를 추가했지만 시퀀스로 인해서 author_id가 변경되어 오류남


insert into book
values (sep_book.nextval, '패션왕', '중앙북스(books)', '2012-02-22', (select author_id
                                                                    from author
                                                                    where author_name = '기안84'));

--확인 : 서브쿼리가 적용되는 것을 확인할 수 있었음
select  bo.book_id,
        bo.title,
        bo.pubs,
        to_char(bo.pub_date, 'YYYY-MM-DD') pub_date,
        bo.author_id,
        au.author_name,
        au.author_desc
from book bo left outer join author au
on bo.author_id = au.author_id;                                                                    
 
--데이터를 DB에 저장
commit;
