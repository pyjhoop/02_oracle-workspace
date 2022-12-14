-- 저장

/*
    < 트리거 TRIGGER > 
    내가 지정한 테이블 INSERT, UPDATE, DELETE 등 DML문에 의해 변경사항이 생길 때
    (테이블에 이벤트가 발생했을 때)
    자동으로 매번 실행할 내용을 미리 정의해둘 수 있는 객체
    
    EX) 
    회원탈퇴시 기존의 회원테입르에 데이터를 DELETE한 후 곧바로 탈퇴된 회원들만 따로 보관하는 테이블에 자동으로 INSERT 처리를 해야한다.
    신고 회수가 일정 수를 넘었을 때 묵시적으로 해당 회원을 블랙리스트로 처리되게끔
    입출고에 대한 데이터가 기록(INSERT)될 때 마다 해당 상품에 대한 재고수량을 매번 수정(UPDATE)해야 될 때.
   
    * 트리거 종류
    - SQL문의 실행시기에 따른 분류
        > BEFORE TRIGGER : 내가 지정한 테이블에 이벤트가 발생되기 전에 트리거가 실행 
        > AFTER TRIGGER : 내가 지정한 테이블에 이벤트가 발생된 후에 트리거가 실행

    - SQL문에 의해 영향을 받는 각 행에 따른 분류
        > STATEMENT TRIGGER(문장트리거) : 이벤트가 발생한 SQL문에 대해 딱 한번만 트리거 실행
        > ROW TRIGGER(행 트리거) : 해당 SQL문 실행할 때 마다 매번 트리거 실행
                                  (FOR EACH ROW 옵션 기술해야됨)
                                  > :OLD - BEFORE UPDATE(수정전 자료), BEFORE DELETE(삭제전 자료)
                                  > :NEW - AFTER INSERT(추가된 자료), AFTER UPDATE(수정전 자료)
                                  
    * 트리거 생성구문
    [표현식]
    CREATE [OR REPLACE] TRIGGER 트리거명
    BEFORE| AFTER       INSERT | UPDATE| DELETE ON 테이블명
    [FOR EACH ROW] -- 이게 없다면 문장트리거임.
    자동으로 실행할 내용;
     ㄴ DECLARE
            변수선언
        BEGIN   
            실행내용(해당 위에 지정된 이벤트 발생시 묵시적으로(자동으로) 실행할 구문)
        EXCEPTION
            예외처리구문;
        END;
        /
*/
-- EMPLOYEE 테이블에 새로운 행이 INSERT 될 때마다 자동으로 메세지 출력되는 트리거 정의

SET SERVEROUTPUT ON;
CREATE OR REPLACE TRIGGER TRG_EMP
AFTER INSERT ON EMPLOYEE
BEGIN
    DBMS_OUTPUT.PUT_LINE('새로오신걸 환영합니다.');
END;
/
SELECT * FROM EMPLOYEE;

INSERT INTO EMPLOYEE VALUES(904,'박연준','897979','ㅁㅇㄴㄹㅇㄴ','12321','D9','J1','S1',8000000,0.3,DEFAULT,SYSDATE,DEFAULT,'N');

-- 상품 입고 및 출고 관련 예시
-- >> 테스트를 위한 테이블 및 시쿼스를 생성

--1. 상품에 대한 데이터를 보관할 테이블 만들기 TB_PRODUCT
-- 상품번호, 상품명, 브랜드, 가격, 재고수량

CREATE TABLE TB_PRODUCT(
    PCODE NUMBER PRIMARY KEY,
    PNAME VARCHAR2(30) NOT NULL,
    BRANT VARCHAR2(30) NOT NULL,
    PRICE NUMBER,
    STOCK NUMBER DEFAULT 0
);

-- 상품번호 중복 안되게끔 매번 새로운 번호를 발생시키는 시퀀스(SEQ_PCODE)
CREATE SEQUENCE SEQ_PCODE
START WITH 200
INCREMENT BY 5
NOCACHE;
INSERT INTO TB_PRODUCT VALUES(SEQ_PCODE.NEXTVAL, '갤럭시20','삼성',1400000,DEFAULT);
INSERT INTO TB_PRODUCT VALUES(SEQ_PCODE.NEXTVAL, '아이폰14','애플',1300000,10);
INSERT INTO TB_PRODUCT VALUES(SEQ_PCODE.NEXTVAL, '대륙폰','샤오미',600000,20);
SELECT * FROM TB_PRODUCT;

--2. 상품 입출고 상세 이력 테이블(TB_PRODETAIL)
--이력번호, 상품번호, 상품 입출고일, 입출고 수량, 상태(입고/출고)
-- 어떤 상품이 어떤 날짜에 몇개가 입고 및 출고가 되었는지에 대한 데이터를 기록하는 테이블
CREATE TABLE TB_PRODETAIL(
    DCODE NUMBER PRIMARY KEY,
    PCODE NUMBER REFERENCES TB_PRODUCT,
    PDATE DATE NOT NULL,
    AMOUNT NUMBER NOT NULL,
    STATUS CHAR(6) CHECK(STATUS IN('입고','출고'))
);

-- 이력번호로 매번 새로운 번호를 발생시켜서 들어갈 수 있게 도와주는 시퀀스 SEQ_DCODE
CREATE SEQUENCE SEQ_DCODE
NOCACHE;

-- 200번 상품이 오늘날짜로 10개 입고
-- 200번 상품의 재고수량을 10 증가
SELECT * FROM TB_PRODETAIL;
SELECT * FROM TB_PRODUCT;
INSERT INTO TB_PRODETAIL VALUES(SEQ_DCODE.NEXTVAL,200,SYSDATE,10,'입고');
UPDATE TB_PRODUCT
SET STOCK = STOCK +10
WHERE PCODE = 200;
COMMIT;

-- 210번 상품이 오늘 날짜로 5개가 출고됨.
INSERT INTO TB_PRODETAIL VALUES(SEQ_DCODE.NEXTVAL,210,SYSDATE,5,'출고');
UPDATE TB_PRODUCT
SET STOCK = STOCK -5
WHERE PCODE = 210;
COMMIT;

--205번 오늘날짜로 20개 입고
--205번 오늘날짜로 20개 입고
INSERT INTO TB_PRODETAIL VALUES(SEQ_DCODE.NEXTVAL,205,SYSDATE,20,'입고');
UPDATE TB_PRODUCT
SET STOCK = STOCK + 20
WHERE PCODE = 205;



-- TB_PRODETAIL에 INSERT 이벤트 발생시
-- TB_PRODUCT 매번 자동으로 재고수량이 업데이트 되게끔 트리거 정의

/*
    - 상품이 입고된 경우 => 해당 상품 찾아서 재고수량 증가 UPDATE
    UPDATE TB_PRODUCT
    SET STOCK = STOCK + 현재입고된 수량(INSERT된 자료의 AMOUNT값)
    WHERE PCODE = 현재입고된 상품 번호(INSERT된 자료의 PCODE값);
    
    - 상품이 출고된 경우 => 해당 상품 찾아서 재고수량 감소 UPDATE
    UPDATE TB_PRODUCT
    SET STOCK = STOCK - 현재 출고된 수량(INSERT된 자료의 AMOUNT값)
    WHERE PCODE = 현재출고된 상품번호(INSERT된 자료의 PCODE값);
    
*/

-- :NEW 써야함

--210 상품이 오늘 날짜로 7개 출고가됨.
CREATE OR REPLACE TRIGGER TRG_01
AFTER INSERT ON TB_PRODETAIL
FOR EACH ROW
BEGIN
    IF :NEW.STATUS = '출고' 
        THEN UPDATE TB_PRODUCT
                SET STOCK = STOCK - :NEW.AMOUNT
                WHERE PCODE = :NEW.PCODE;
    END IF;
    IF :NEW.STATUS = '입고'
        THEN UPDATE TB_PRODUCT
                SET STOCK = STOCK + :NEW.AMOUNT
                WHERE PCODE = :NEW.PCODE;
    END IF;
END;
/
--200 상품이 오늘 날짜로 100개 입고됨.
SELECT * FROM TB_PRODETAIL;
SELECT * FROM TB_PRODUCT;
INSERT INTO TB_PRODETAIL VALUES(SEQ_DCODE.NEXTVAL,200,SYSDATE,100,'입고');

