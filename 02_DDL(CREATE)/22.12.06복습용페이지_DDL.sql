--22-12-06 복습용 페이지
CREATE TABLE MEM_GRADE(
    GRADE_CODE NUMBER PRIMARY KEY,
    GRADE_NAME VARCHAR2(30) NOT NULL
);
INSERT INTO MEM_GRADE VALUES(10,'일반회원');
INSERT INTO MEM_GRADE VALUES(20,'우수회원');
INSERT INTO MEM_GRADE VALUES(30,'특별회원');


-- FOREIGN KEY(외래키) 제약조건
-- 설명 : 다른 테이블에 존재하는 값만 들어와야 되는 특정 컬럼에 부여하는 제약 조건

-- 컬럼레벨방식
--> 컬럼명 자료형[CONSTRAINT 제야조건명] REFERENCES 참조할테이블명[(참조할 컬럼명)]
-- 테이블레벨방식
-->[CONSTRAINT] FOREIGN KEY(컬럼명) REFERENCES 참조할테이블명[(참조할 컬럼명)]

CREATE TABLE MEM(
    MEM_NO NUMBER PRIMARY KEY,
    MEM_ID VARCHAR2(20) NOT NULL UNIQUE,
    MEM_PWD VARCHAR2(20) NOT NULL,
    MEM_NAME VARCHAR2(20) NOT NULL,
    GENDER CHAR(3) CHECK(GENDER IN ('남','여')),
    PHONE VARCHAR2(13),
    EMAIL VARCHAR2(50),
    GRADE_ID NUMBER REFERENCES MEM_GRADE(GRADE_CODE)
    -- FOREIGN KEY(GRADE_ID) REFERENCES MEM_GRADE(GRADE_CODE)
);

INSERT INTO MEM
VALUES(1,'user01','pass02','손흥민','남',null,null,null);
INSERT INTO MEM
VALUES(2,'user02','pass02','황희찬',null,null,null,10);

INSERT INTO MEM
VALUES(3,'user03','pass03','이강인',null,null,null,40);
--ORA-02291: integrity constraint (DDL.SYS_C007115) violated - parent key not found
-- PARENT나왔다? 외래키에 문제가 생겼다.
INSERT INTO MEM
VALUES(3,'user03','pass03','이강인',null,null,null,20);
INSERT INTO MEM
VALUES(4,'user04','pass04','이승후',null,null,null,10);

-- 외래키로 부모와 자식 관계를 맺었는데 부모의 데이터를 삭제하면 어떻게 될까?
-- 자식테이블에서 부모값을 사용하고있으면 삭제 자체가 안됨
-- 삭제제한 옵션이 걸려있음.

-- 그럼 MEM_GRADE에서 CODE 10을 제거해보자
DELETE FROM MEM_GRADE
WHERE GRADE_CODE = '10';
--ORA-02292: integrity constraint (DDL.SYS_C007115) violated - child record found
-- 외래키에 사용되기에 삭제할 수 없다.
--즉, 삭제제한 옵션이 걸려있음.

DELETE FROM MEM_GRADE
WHERE GRADE_CODE = '30';
ROLLBACK;
SELECT * FROM MEM_GRADE;

/*
    자식 테이블 생성시 외래키 제약조건 부여할 때 삭제옵션 지정가능
    * 삭제옵셥 : 부모테이블의 데이터 삭제시 그 데이터를 사용하고 있는 자식 테이블의 값을
                어떻게 처리할건지
    - ON DELETE RESTRICTED(기본값) : 삭제제한 옵션으로, 자식 데이터로 쓰이는 부모데이터는 삭제가 아예안되게끔!!
    - ON DELETE SET NULL : 부모데이터 삭제시 해당 데이터를 쓰고 있는 자식데이터의 값을 NULL로 변경
    - ON DELETE CASCADE : 부모데이터 삭제시 해당 데이터를 쓰고있는 자식데이터도 같이 삭제
*/

DROP TABLE MEM;
-- ON SELETE SET NULL로 바꿔서 테이블을 만들어보자
CREATE TABLE MEM(
    MEM_NO NUMBER PRIMARY KEY,
    MEM_ID VARCHAR2(20) NOT NULL UNIQUE,
    MEM_PWD VARCHAR2(20) NOT NULL,
    MEM_NAME VARCHAR2(20) NOT NULL,
    GENDER CHAR(3) CHECK(GENDER IN ('남','여')),
    PHONE VARCHAR2(13),
    EMAIL VARCHAR2(50),
    GRADE_ID NUMBER REFERENCES MEM_GRADE(GRADE_CODE) ON DELETE SET NULL
);
INSERT INTO MEM 
VALUES(1,'user01','pass02','손흥민','남',null,null,null);

INSERT INTO MEM
VALUES(2,'user02','pass02','황희찬',null,null,null,10);

INSERT INTO MEM
VALUES(3,'user03','pass03','이강인',null,null,null,20);

INSERT INTO MEM
VALUES(4,'user04','pass04','이승후',null,null,null,10);

SELECT * FROM MEM;

--여기서 외래키와 연결된 부모키를 제거해보겠다.
DELETE FROM MEM_GRADE
WHERE GRADE_CODE = '10';
SELECT * FROM MEM_GRADE;
INSERT INTO MEM_GRADE VALUES(10,'일반회원');

DROP TABLE MEM;
ROLLBACK;

-- ON DELETE CASCDE로 바꿔서 테이블을 만들어보자.
CREATE TABLE MEM(
    MEM_NO NUMBER PRIMARY KEY,
    MEM_ID VARCHAR2(20) NOT NULL UNIQUE,
    MEM_PWD VARCHAR2(20) NOT NULL,
    MEM_NAME VARCHAR2(20) NOT NULL,
    GENDER CHAR(3) CHECK(GENDER IN ('남','여')),
    PHONE VARCHAR2(13),
    EMAIL VARCHAR2(50),
    GRADE_ID NUMBER REFERENCES MEM_GRADE(GRADE_CODE) ON DELETE CASCADE
);
INSERT INTO MEM 
VALUES(1,'user01','pass02','손흥민','남',null,null,null);

INSERT INTO MEM
VALUES(2,'user02','pass02','황희찬',null,null,null,10);

INSERT INTO MEM
VALUES(3,'user03','pass03','이강인',null,null,null,20);

INSERT INTO MEM
VALUES(4,'user04','pass04','이승후',null,null,null,10);

SELECT * FROM MEM_GRADE;
SELECT * FROM MEM;
DELETE FROM MEM_GRADE
WHERE GRADE_CODE = '10';

SELECT * FROM MEM;


/*
    < DEFAULT >
    컬럼을 선정하지 않고 INSERT시 NULL이 아닌 다른값을 기본값으로 세팅
    테이블 생성시 설정
    컬럼명 자료명 DEFAULT '기본값' 제약조건 ....
    항상 DEFAULT가 제약조건 보다 앞에 있어야 한다.
    
*/
DROP TABLE MEMBER;

CREATE TABLE MEMBER(
    MEM_NO NUMBER PRIMARY KEY,
    MEM_NAME VARCHAR2(20) NOT NULL,
    MEM_AGE NUMBER,
    HOBBY VARCHAR2(20) DEFAULT '없음',
    ENROLL_DATE DATE DEFAULT SYSDATE
);

INSERT INTO MEMBER VALUES(1,'손흥민',20,'축구','19/12/13');
INSERT INTO MEMBER VALUES(2,'황희찬',NULL,NULL,NULL);
INSERT INTO MEMBER VALUES(3,'이강인',NULL,DEFAULT,DEFAULT);
-- 이렇게 DEFAULT를 사용할거면 굳이? 사용할 필요가 있을까
-- 이런경우에 사용됨.
INSERT INTO MEMBER(MEM_NO, MEM_NAME) VALUES(4,'이승후');

/*
========KH계정==============
    서브쿼리를 이용한 테이블 복사
    
    [표현식]
    CREATE TABLE 테이블명
    AS 서브쿼리;
    
    복제시 NOT NULL을 제외한 제약조건이 복사안되고,
    DEFAULT값도 복사가 안된다. 
    => 추후에 추가하는 방법이 있음.
    
    테이블 복사방법
    1. 전체 값을 복사하기
    2. 테이블 구조만 가져오고 싶다.
    3. 테이블의 특정 컬럼과 산술식 또는 함수식을 가져오고싶다.
*/
CREATE TABLE EMPLOYEE_COPY
AS SELECT *
    FROM EMPLOYEE;

SELECT * FROM EMPLOYEE_COPY;
-- NOT NULL을 제외한 제약조건들이 다 사라짐
-- DEFAULT 값도 사라짐

--2. 컬럼만 가져오고 싶다.
CREATE TABLE EMPLOYEE_COPY2
AS SELECT EMP_ID, EMP_NAME, SALARY, BONUS
    FROM EMPLOYEE
    WHERE 1=0;
-- 이때 누가봐도 FALSE 인 값으 넣는다.

SELECT * FROM EMPLOYEE_COPY2;

-- 산술적용된 컬럼 또는 함수가 적용된 컬럼
CREATE TABLE EMPLOYEE_COPY3
AS SELECT EMP_ID, EMP_NAME, SALARY, SALARY*12 AS "연봉"
    FROM EMPLOYEE;
--이런케이스에서는 별칭을 사용해야 한다.
    
SELECT EMP_ID, 연봉
FROM EMPLOYEE_COPY3;

/*
    테이블 다 생성후에 제약조건 추가 방법 또는 삭제방법
    
    제약조건 추가 방법
    ALTER TABLE 테이블명 변경할 내용
    - PRIMARY KEY : ALTER TABLE 테이블명 ADD PRIMARY KEY(컬럼명);
    - FOREIGN KEY : ALTER TABLE 테이블명 ADD FOREIGN KEY(컬럼명) REFERENCES 참조할테이블명[(참조할컬럼명)]
    - UNIQUE      : ALTER TABLE 테이블명 ADD UNIQUE(컬럼명);
    - CHECK       : ALTER TABLE 테이블명 ADD CHECK(컬럼에 대한 조건식);
    - NOT NULL    : ALTER TABLE 테이블명 MODIFY 컬럼명 NOT NULL;
    
    제약조건 삭제 방법
    --ALTER TABLE '테이블명' DROP CONSTRAINT '제약조건명'
    
*/
-- 서브쿼리를 이용해서 복제한 테이블은 NN 제약조건 빼고 복제 안됨
-- EMPLOYEE_COPY 테이블에 PRIMARY KEY 제약조건 추가 (EMP_ID)
ALTER TABLE EMPLOYEE_COPY ADD PRIMARY KEY(EMP_ID);
ALTER TABLE EMPLOYEE ADD FOREIGN KEY(DEPT_CODE) REFERENCES DEPARTMENT(DEPT_ID);
-- 이렇게 외래키를 해주면 부모에서 선언한 값만이 저장할 수 있다.

-- EMPLOYEE 테이블의 JOB_CODE에 외래키 제약조건 추가 JOB테이블 참조
-- 추가안할시 JOB_CODE에 '집갈래' 이런 쓸데없는 데이터가 들어갈 수 있음.
ALTER TABLE EMPLOYEE ADD FOREIGN KEY(JOB_CODE) REFERENCES JOB;
--EMPLOYEE 테이블의 SAL_LEVEL에 외래키 제약조건 추가 SAL_GRADE테이블 참조
ALTER TABLE EMPLOYEE ADD FOREIGN KEY(SAL_LEVEL) REFERENCES SAL_GRADE;
--DEPARTMENT 테이블의 LOCATION_ID에 외래키 제약조건 추가 LOCATION 테이블 참조
ALTER TABLE DEPARTMENT ADD FOREIGN KEY(LOCATION_ID) REFERENCES LOCATION;


















