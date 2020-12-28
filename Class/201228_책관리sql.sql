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

-- book sequence 생성
create sequence seq_book
increment by 1
start with 1; 

-- author sequence 생성
create sequence seq_author
increment by 1
start with 1; 

-- author테이블 데이터 삽입
insert into author values (seq_author.nextval, '이문열', '경북 양양');
insert into author values (seq_author.nextval, '박경리', '경상남도 통영');
insert into author values (seq_author.nextval, '유시민', '17대 국회의원');
insert into author values (seq_author.nextval, '기안84', '기안동에서 산 84년생');
insert into author values (seq_author.nextval, '강풀', '온라인 만화가 1세대');
insert into author values (seq_author.nextval, '김영하', '알쓸신잡');

--book테이블 데이터 삽입
insert into book values (seq_book.nextval, '우리들의 일그러진 영웅', '다림', '1998-02-22', 1);
insert into book values (seq_book.nextval, '삼국지', '민음사', '2002-03-01', 1);
insert into book values (seq_book.nextval, '토지', '마로니에북스', '2012-08-15', 2);
insert into book values (seq_book.nextval, '유시민의 글쓰기 특강', '생각의길', '2015-04-01', 3);
insert into book values (seq_book.nextval, '패션왕', '중앙북스(books)', '2012-02-22', 4);
insert into book values (seq_book.nextval, '순정만화', '재미주의', '2011-08-03', 5);
insert into book values (seq_book.nextval, '오직두사람', '문학동네', '2017-05-04', 6);
insert into book values (seq_book.nextval, '26년', '재미주의', '2012-02-04', 5);

--데이터를 DB에 저장
commit;

-- author 데이터 확인
select *
from author;

-- book 데이터 확인
select *
from book;

-- 전체 데이터 확인
select  bo.book_id, bo.title, bo.pubs, bo.pub_date, bo.author_id, au.author_name, au.author_desc
from book bo right outer join author au
on bo.author_id = au.author_id;
