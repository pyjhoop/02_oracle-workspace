--우선저장

CREATE TABLE TB_PUBLISHER(
    PUB_NO NUMBER CONSTRAINT PUBLISHER_PK PRIMARY KEY,
    PUB_NAME VARCHAR2(30) CONSTRAINT PUBLICHSER_NN NOT NULL,
    PHONE VARCHAR2(14)
);

COMMENT ON COLUMN TB_PUBLISHER.PUB_NO IS '출판사번호';
COMMENT ON COLUMN TB_PUBLISHER.PUB_NAME IS '출판사명';
COMMENT ON COLUMN TB_PUBLISHER.PHONE IS '출판사전화번호';

INSERT INTO TB_PUBLISHER VALUES(1, '손오공 출판사', '010-1111-2222');
INSERT INTO TB_PUBLISHER VALUES(2, '한빛 출판사', '02-3223-3122');
INSERT INTO TB_PUBLISHER VALUES(3, '조은 출판사', '032-2134-2132');

CREATE TABLE TB_BOOK(
    BK_NO NUMBER CONSTRAINT BOOK_PK PRIMARY KEY,
    BK_TITLE VARCHAR2(20) CONSTRAINT BOOK_NN_TITLE NOT NULL,
    BK_AUTHOR VARCHAR2(20) CONSTRAINT BOOK_NN_AUTHOR NOT NULL,
    BK_PRICE NUMBER,
    BK_STOCK NUMBER DEFAULT 1,
    BK_PUB_NO NUMBER CONSTRAINT BOOK_FK REFERENCES TB_PUBLISHER ON DELETE CASCADE
);



COMMENT ON COLUMN TB_BOOK.BK_NO IS '도서번호';
COMMENT ON COLUMN TB_BOOK.BK_TITLE IS '도서명';
COMMENT ON COLUMN TB_BOOK.BK_AUTHOR IS '저자명';
COMMENT ON COLUMN TB_BOOK.BK_PRICE IS '가격';
COMMENT ON COLUMN TB_BOOK.BK_STOCK IS '재고';
COMMENT ON COLUMN TB_BOOK.BK_PUB_NO IS '출판사번호';

INSERT INTO TB_BOOK VALUES(1,'트렌드 코리아','김난도',17100,2,2);
INSERT INTO TB_BOOK VALUES(2,'흔한남매12','흔한남매',13050,1,3);
INSERT INTO TB_BOOK VALUES(3,'천원을 경영','박정부',14400,0,1);
INSERT INTO TB_BOOK VALUES(4,'해방일지','정지아',13500,10,2);
INSERT INTO TB_BOOK VALUES(5,'폴리매스', '피터 홀린스',16200,4,1);

CREATE TABLE TB_MEMBER(
    MEMBER_NO NUMBER CONSTRAINT MEMBER_PK PRIMARY KEY,
    MEMBER_ID VARCHAR2(20) CONSTRAINT MEMBER_UQ UNIQUE,
    MEMBER_PWD VARCHAR2(20) CONSTRAINT MEMBER_NN_PWD NOT NULL,
    MEMBER_NAME VARCHAR2(20) CONSTRAINT MEMBER_NN_NAME NOT NULL,
    GENDER CHAR(1) CONSTRAINT MEMBER_CK_GEN CHECK(GENDER IN ('M','F')),
    ADDRESS VARCHAR2(50),
    PHONE VARCHAR2(20),
    STATUS CHAR(1) CONSTRAINT MEMBER_CK_STA CHECK(STATUS IN('Y','N')),
    ENROLL_DATE DATE DEFAULT SYSDATE CONSTRAINT MEMBER_DATE_NN NOT NULL
);

INSERT INTO TB_MEMBER 
VALUES(1,'QWE123','QWE123','박연준','M',NULL,NULL,'Y','18/10/13');

INSERT INTO TB_MEMBER
VALUES(2,'ASD123','ASDF123','아무개',NULL,'서울 어딘가','010-1111-2222',DEFAULT, '19/11/12');

INSERT INTO TB_MEMBER
VALUES(3,'ZCFEA','AFCVD','박재희','F','인천 어딘가','010-2323-3443','N',DEFAULT);

INSERT INTO TB_MEMBER
VALUES(4,'ADFCV','ASDFER','아몰랑',NULL,NULL,NULL,DEFAULT, '00/09/09');

INSERT INTO TB_MEMBER
VALUES(5,'ZCVADSF','WERC1','아이유','F','서울특별시 광진구',NULL,'N',SYSDATE);

COMMENT ON COLUMN TB_MEMBER.MEMBER_NO IS '회원번호';
COMMENT ON COLUMN TB_MEMBER.MEMBER_ID IS '아이디';
COMMENT ON COLUMN TB_MEMBER.MEMBER_PWD IS '비밀번호';
COMMENT ON COLUMN TB_MEMBER.MEMBER_NAME IS '회원명';
COMMENT ON COLUMN TB_MEMBER.GENDER IS '성별';
COMMENT ON COLUMN TB_MEMBER.ADDRESS IS '주소';
COMMENT ON COLUMN TB_MEMBER.PHONE IS '연락처';
COMMENT ON COLUMN TB_MEMBER.STATUS IS '탈퇴여부';
COMMENT ON COLUMN TB_MEMBER.ENROLL_DATE IS '가입일';

SELECT * FROM TB_MEMBER;

CREATE TABLE TB_RENT(
    RENT_NO NUMBER CONSTRAINT RENT_PK PRIMARY KEY,
    RENT_MEM_NO NUMBER CONSTRAINT RENT_FK_MEM REFERENCES TB_MEMBER ON DELETE SET NULL,
    RENT_BOOK_NO NUMBER CONSTRAINT RENT_FK_BOOK REFERENCES TB_BOOK ON DELETE SET NULL,
    RENT_DATE DATE DEFAULT SYSDATE
);

COMMENT ON COLUMN TB_RENT.RENT_NO IS '대여번호';
COMMENT ON COLUMN TB_RENT.RENT_MEM_NO IS '대여회원번호';
COMMENT ON COLUMN TB_RENT.RENT_BOOK_NO IS '대여도서번호';
COMMENT ON COLUMN TB_RENT.RENT_DATE IS '대여일';

INSERT INTO TB_RENT VALUES(1, 1,1,DEFAULT);
INSERT INTO TB_RENT(RENT_NO,RENT_MEM_NO, RENT_BOOK_NO) VALUES(2,2,2);
INSERT INTO TB_RENT VALUES(3,4,4,'22/12/4');



















