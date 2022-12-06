--22-12-06 복습용 페이지

-- FOREIGN KEY(외래키) 제약조건
-- 설명 : 다른 테이블에 존재하는 값만 들어와야 되는 특정 컬럼에 부여하는 제약 조건

-- 컬럼레벨방식
-->
-- 테이블레벨방식
-->


-- 외래키로 부모와 자식 관계를 맺었는데 부모의 데이터를 삭제하면 어떻게 될까?
-- 자식테이블에서 부모값을 사용하고있으면 삭제 자체가 안됨
-- 삭제제한 옵션이 걸려있음.

/*
    자식 테이블 생성시 외래키 제약조건 부여할 때 삭제옵션 지정가능
    * 삭제옵셥 : 부모테이블의 데이터 삭제시 그 데이터를 사용하고 있는 자식 테이블의 값을
                어떻게 처리할건지
    - ON DELETE RESTRICTED(기본값) : 삭제제한 옵션으로, 자식 데이터로 쓰이는 부모데이터는 삭제가 아예안되게끔!!
    - ON DELETE SET NULL : 부모데이터 삭제시 해당 데이터를 쓰고 있는 자식데이터의 값을 NULL로 변경
    - ON DELETE CASCADE : 부모데이터 삭제시 해당 데이터를 쓰고있는 자식데이터도 같이 삭제
*/

-- ON SELETE SET NULL로 바꿔서 테이블을 만들어보자

-- ON DELETE CASCDE로 바꿔서 테이블을 만들어보자.

/*
    < DEFAULT >
    컬럼을 선정하지 않고 INSERT시 NULL이 아닌 다른값을 기본값으로 세팅
    테이블 생성시 설정
    컬럼명 자료명 DEFAULT '기본값' 제약조건 ....
    
*/

/*
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



















