/******** GuestBook ********/
--테이블, 시퀀스 삭제
drop table guestbook;
drop sequence seq_guestbook_no;

--테이블 생성
create table guestbook(
    no number,
    name varchar2(80),
    password varchar2(20),
    content varchar2(2000),
    reg_date date,
    primary key (no)
);

--시퀀스 생성
create sequence seq_guestbook_no
increment by 1
start with 1;

-- 데이터 삽입
insert into guestbook values (seq_guestbook_no.nextval, '관리자', '1234', '테스트입니다', sysdate);
insert into guestbook values (seq_guestbook_no.nextval, '아무개', '1234', '테스트입니다2', sysdate);

-- 커밋
commit;

-- 셀렉트 all
select  no,
        name,
        password,
        content,
        reg_date
from guestbook;

--삭제
delete guestbook
where no = 2;

/******** mysite- users ********/
--테이블/시퀀스 삭제
drop table users;
drop sequence seq_user_no;

--테이블 생성 
create table users(
    no number,   --회원식별 번호
    id varchar2(20) unique not null,    --아이디
    password varchar2(20) not null,     --패스워드
    name varchar2(20),     --이름
    gender varchar2(10),    --성별
    primary key(no)
);

--시퀀스 생성
create sequence seq_user_no
increment by 1
start with 1
nocache;                        --내부적으로 속도를 향상하기 위해 숫자를 미리 잡아놓아 껐다가 켰을때 손실되는 숫자가 있는데 이를 안하고 바로 연번으로 찍기위해 사용

-- 데이터 삽입
insert into users values (seq_user_no.nextval, 'admin', '1234', '관리자', '남');
insert into users values (seq_user_no.nextval, 'test', '1234', '테스트', '여');

-- 커밋
commit;

-- 셀렉트 all
select  no,
        id,
        password,
        name,
        gender
from users;

--삭제
delete users
where no = 2;