select * 
from author;

insert into author
values (6, '이문열', '경북 양양'); 

commit;
rollback;
insert into author
values (seq_author_id.nextval, '박경리', '경북 통영'); 

select * from author;

delete from author;

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
    
insert into book
values (1, '삼국지', '삼양출판사', '20-01-01', 6); 

select *
from book;