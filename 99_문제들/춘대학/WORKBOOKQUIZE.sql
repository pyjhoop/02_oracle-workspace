--===========================BASIC SELECT========================================
SELECT * FROM TB_DEPARTMENT;
--1.
SELECT DEPARTMENT_NAME AS "학과 명", CATEGORY AS "계열"
FROM TB_DEPARTMENT;

--2.
SELECT DEPARTMENT_NAME||'의 '|| '정원은 '||CAPACITY||'명 입니다.' AS "학과별 정원"
FROM TB_DEPARTMENT;

--3.
SELECT * FROM TB_STUDENT;
SELECT STUDENT_NAME
FROM TB_STUDENT
WHERE DEPARTMENT_NO = '001' AND SUBSTR(STUDENT_SSN,8,1) = '2' AND ABSENCE_YN = 'Y';

--4.
SELECT STUDENT_NAME
FROM TB_STUDENT
WHERE STUDENT_NO IN('A513079','A513090','A513091','A513110','A513119');

--5.
SELECT * FROM TB_DEPARTMENT;
SELECT DEPARTMENT_NAME, CATEGORY
FROM TB_DEPARTMENT
WHERE CAPACITY BETWEEN 20 AND 30;

--6.
SELECT * FROM TB_PROFESSOR;
SELECT PROFESSOR_NAME
FROM TB_PROFESSOR
WHERE DEPARTMENT_NO IS NULL;

--7.
SELECT * FROM TB_STUDENT;
SELECT STUDENT_NAME
FROM TB_STUDENT
WHERE DEPARTMENT_NO IS NULL;

--8. 
SELECT * FROM TB_CLASS;
SELECT CLASS_NO
FROM TB_CLASS
WHERE PREATTENDING_CLASS_NO IS NOT NULL;

--9.
SELECT DISTINCT CATEGORY
FROM TB_DEPARTMENT;

--10.
SELECT STUDENT_NO, STUDENT_NAME, STUDENT_SSN
FROM TB_STUDENT
WHERE SUBSTR(STUDENT_NO,1,2) = 'A2' AND ABSENCE_YN = 'N' AND STUDENT_ADDRESS LIKE '%전주%';
--==============================ADDITIONAL SELECT=================================
--1.
SELECT STUDENT_NO AS "학번", STUDENT_NAME AS "이름", TO_CHAR(ENTRANCE_DATE,'RRRR-MM-DD') AS "입학년도"
FROM TB_STUDENT
WHERE DEPARTMENT_NO = '002'
ORDER BY 3;

--2.
SELECT PROFESSOR_NAME, PROFESSOR_SSN
FROM TB_PROFESSOR
WHERE PROFESSOR_NAME NOT LIKE '___';

--3.
SELECT PROFESSOR_NAME AS "교수이름", 
EXTRACT(YEAR FROM SYSDATE)- EXTRACT(YEAR FROM TO_DATE(19||SUBSTR(PROFESSOR_SSN,1,6),'RRMMDD') )AS "나이"
FROM TB_PROFESSOR
WHERE SUBSTR(PROFESSOR_SSN,8,1) = '1'
ORDER BY 2;

--4.
SELECT SUBSTR(PROFESSOR_NAME,2,2) 
FROM TB_PROFESSOR;

--5.ENDTRANC - STUDENT
SELECT STUDENT_NO, STUDENT_NAME
FROM TB_STUDENT
WHERE EXTRACT(YEAR FROM ENTRANCE_DATE) - EXTRACT(YEAR FROM TO_DATE(SUBSTR(STUDENT_SSN,1,6),'RRMMDD')) > '19';

--6
SELECT TO_CHAR(TO_DATE(20201225),'DAY') FROM DUAL;

--7.
--TO_DATE('99/10/11','YY/MM/DD'): 20991011의미
-- TO_DATE('49/10/11','YY/MM/DD') : 20491011의미
--TO_DATE('99/10/11','RR/MM/DD') : 19991011의미
--TO_DATE('49/10/11','RR/MM/DD') : 20491011의미

--8.
SELECT STUDENT_NO, STUDENT_NAME
FROM TB_STUDENT
WHERE SUBSTR(STUDENT_NO,1,1) != 'A';

--9.
SELECT ROUND(AVG(POINT),1) AS "평점"
FROM TB_GRADE
WHERE STUDENT_NO = 'A517178';

--10. 
SELECT DEPARTMENT_NO AS "학과번호", COUNT(*)AS "학생수"
FROM TB_STUDENT
GROUP BY DEPARTMENT_NO
ORDER BY 1;

--11.
SELECT COUNT(*)
FROM TB_STUDENT
WHERE COACH_PROFESSOR_NO IS NULL;

--12.
SELECT SUBSTR(TERM_NO,1,4) AS "년도", ROUND(AVG(POINT),1) AS "년도 별 평점"
FROM TB_GRADE
WHERE STUDENT_NO = 'A112113'
GROUP BY SUBSTR(TERM_NO,1,4);

--13.
SELECT DEPARTMENT_NO AS "학과코드명", COUNT(DECODE(ABSENCE_YN,'Y','*')) AS "휴학생 수"
FROM TB_STUDENT
GROUP BY DEPARTMENT_NO
ORDER BY 1;

--14
SELECT STUDENT_NAME AS "동일이름", COUNT(*) AS "동명인 수"
FROM TB_STUDENT
GROUP BY STUDENT_NAME
HAVING COUNT(*) >=2
ORDER BY 1;

--15
SELECT NVL(SUBSTR(TERM_NO,1,4),' ') AS "년도", 
NVL(SUBSTR(TERM_NO,5,2),' ') AS "학기", 
ROUND(AVG(POINT),1) AS "평점"
FROM TB_GRADE
WHERE STUDENT_NO = 'A112113'
GROUP BY ROLLUP(SUBSTR(TERM_NO,1,4), SUBSTR(TERM_NO,5,2));
--==========================
--1
SELECT STUDENT_NAME AS "학생 이름", STUDENT_ADDRESS AS "주소지"
FROM TB_STUDENT
ORDER BY STUDENT_NAME;
--2
SELECT STUDENT_NAME, STUDENT_SSN
FROM TB_STUDENT
WHERE ABSENCE_YN = 'Y'
ORDER BY STUDENT_SSN DESC;

--3
SELECT STUDENT_NAME AS "학생이름", STUDENT_NO AS "학번", STUDENT_ADDRESS AS "거주지 주소"
FROM TB_STUDENT
WHERE SUBSTR(STUDENT_ADDRESS,1,3) IN ('강원도','경기도') AND STUDENT_NO LIKE '9%'
ORDER BY STUDENT_NAME;

--4
SELECT * FROM TB_DEPARTMENT;
SELECT * FROM TB_PROFESSOR;
SELECT PROFESSOR_NAME, PROFESSOR_SSN
FROM TB_PROFESSOR
WHERE DEPARTMENT_NO = '005'
ORDER BY PROFESSOR_SSN;

--5
SELECT * FROM TB_GRADE;
SELECT * FROM TB_CLASS;
SELECT STUDENT_NO, TO_CHAR(POINT,'9.99') AS "POINT"
FROM TB_GRADE
WHERE TERM_NO = '200402' AND CLASS_NO = 'C3118100'
ORDER BY POINT DESC, STUDENT_NO;

--6
SELECT * FROM TB_STUDENT;
SELECT * FROM TB_DEPARTMENT;

SELECT STUDENT_NO, STUDENT_NAME, TB_DEPARTMENT.DEPARTMENT_NAME
FROM TB_STUDENT INNER JOIN TB_DEPARTMENT ON TB_STUDENT.DEPARTMENT_NO = TB_DEPARTMENT.DEPARTMENT_NO
ORDER BY 2;

--7
SELECT * FROM TB_CLASS;

SELECT CLASS_NAME, TB_DEPARTMENT.DEPARTMENT_NAME
FROM TB_CLASS INNER JOIN TB_DEPARTMENT ON TB_CLASS.DEPARTMENT_NO = TB_DEPARTMENT.DEPARTMENT_NO;

--8
SELECT * FROM TB_PROFESSOR;
SELECT * FROM TB_CLASS_PROFESSOR;

SELECT CLASS_NAME, PROFESSOR_NAME
FROM TB_CLASS
JOIN TB_CLASS_PROFESSOR USING(CLASS_NO)
JOIN TB_PROFESSOR USING(PROFESSOR_NO)
ORDER BY 2;

SELECT CLASS_NAME, PROFESSOR_NAME FROM TB_CLASS 
JOIN TB_CLASS_PROFESSOR USING(CLASS_NO)
JOIN TB_PROFESSOR USING(PROFESSOR_NO);
--9 
SELECT * FROM tb_department;
SELECT* FROM TB_CLASS;
SELECT * FROM TB_PROFESSOR;
SELECT * FROM TB_CLASS_PROFESSOR;

SELECT CLASS_NAME, PROFESSOR_NAME
FROM TB_CLASS C, TB_PROFESSOR P, TB_DEPARTMENT D, TB_CLASS_PROFESSOR C1
WHERE C.CLASS_NO = C1.CLASS_NO
AND C1.PROFESSOR_NO = P.PROFESSOR_NO
AND P.DEPARTMENT_NO = D.DEPARTMENT_NO
AND CATEGORY = '인문사회';

--10
SELECT * FROM tb_department;  --DEPARTMENT_NO
SELECT* FROM TB_CLASS;
SELECT * FROM TB_GRADE; --
SELECT * FROM TB_STUDENT;  --DEPARMENT_NO

SELECT STUDENT_NO AS "학번",STUDENT_NAME AS "학생 이름", ROUND(AVG(POINT),1) AS "전체 평점"
FROM TB_GRADE G
JOIN TB_STUDENT USING(STUDENT_NO)
JOIN TB_DEPARTMENT USING(DEPARTMENT_NO)
WHERE DEPARTMENT_NAME = '음악학과'
GROUP BY STUDENT_NAME, STUDENT_NO
ORDER BY STUDENT_NO;

--11
SELECT * FROM tb_department;
SELECT* FROM TB_CLASS;
SELECT * FROM TB_GRADE;
SELECT * FROM TB_STUDENT;
SELECT * FROM TB_PROFESSOR;
SELECT DEPARTMENT_NAME AS "학과이름", STUDENT_NAME AS "학생이름", PROFESSOR_NAME AS "지도교수이름"
FROM TB_DEPARTMENT D, TB_STUDENT S, TB_PROFESSOR P
WHERE S.DEPARTMENT_NO = D.DEPARTMENT_NO
AND S.COACH_PROFESSOR_NO = P.PROFESSOR_NO
AND STUDENT_NO = 'A313047';


--12
SELECT * FROM tb_department;
SELECT* FROM TB_CLASS;
SELECT * FROM TB_GRADE;
SELECT * FROM TB_STUDENT;
SELECT * FROM TB_PROFESSOR;

SELECT STUDENT_NAME, TERM_NO  AS "TERM_NAME"
FROM TB_STUDENT S
JOIN TB_GRADE G USING(STUDENT_NO)
JOIN TB_CLASS C USING(CLASS_NO)
WHERE CLASS_NAME = '인간관계론'
AND SUBSTR(TERM_NO,1,4) = '2007';


--13
SELECT * FROM tb_department;
SELECT* FROM TB_CLASS;
SELECT * FROM TB_GRADE;
SELECT * FROM TB_STUDENT;
SELECT * FROM TB_PROFESSOR;
SELECT * FROM TB_CLASS_PROFESSOR;

SELECT CLASS_NAME, DEPARTMENT_NAME
FROM TB_CLASS C, TB_CLASS_PROFESSOR C1,TB_DEPARTMENT D
WHERE C.CLASS_NO = C1.CLASS_NO(+)
AND C.DEPARTMENT_NO = D.DEPARTMENT_NO
AND PROFESSOR_NO IS NULL
AND CATEGORY = '예체능';

--14.
SELECT * FROM tb_department;
SELECT* FROM TB_CLASS;
SELECT * FROM TB_GRADE;
SELECT * FROM TB_STUDENT;
SELECT * FROM TB_PROFESSOR;
SELECT * FROM TB_CLASS_PROFESSOR;

SELECT STUDENT_NAME AS "학생이름", NVL(PROFESSOR_NAME,'지도교수 미지정') AS "지도교수"
FROM TB_STUDENT S, TB_DEPARTMENT D, TB_PROFESSOR P
WHERE S.DEPARTMENT_NO = D.DEPARTMENT_NO(+)
AND S.COACH_PROFESSOR_NO = P.PROFESSOR_NO(+)
AND DEPARTMENT_NAME = '서반아어학과';

--15
SELECT * FROM tb_department;
SELECT* FROM TB_CLASS;
SELECT * FROM TB_GRADE;
SELECT * FROM TB_STUDENT;
SELECT * FROM TB_PROFESSOR;
SELECT * FROM TB_CLASS_PROFESSOR;

SELECT S.STUDENT_NO, S.STUDENT_NAME, D.DEPARTMENT_NAME, ROUND(AVG(POINT),3)
FROM TB_STUDENT S, TB_DEPARTMENT D, TB_GRADE G
WHERE G.STUDENT_NO = S.STUDENT_NO
AND S.DEPARTMENT_NO = D.DEPARTMENT_NO
AND ABSENCE_YN = 'N'
GROUP BY S.STUDENT_NO, S.STUDENT_NAME, D.DEPARTMENT_NAME
HAVING AVG(POINT) >= 4.0;

--16
SELECT * FROM tb_department;
SELECT* FROM TB_CLASS;
SELECT * FROM TB_GRADE;
SELECT * FROM TB_STUDENT;
SELECT * FROM TB_PROFESSOR;
SELECT * FROM TB_CLASS_PROFESSOR;

SELECT C.CLASS_NO, C.CLASS_NAME, ROUND(AVG(POINT),7)
FROM TB_CLASS C, TB_GRADE G,TB_DEPARTMENT D
WHERE G.CLASS_NO = C.CLASS_NO
AND C.DEPARTMENT_NO = D.DEPARTMENT_NO
AND DEPARTMENT_NAME = '환경조경학과'
AND CLASS_TYPE LIKE '전공%'
GROUP BY C.CLASS_NO, C.CLASS_NAME;

--17. 
SELECT * FROM tb_department;
SELECT* FROM TB_CLASS;
SELECT * FROM TB_GRADE;
SELECT * FROM TB_STUDENT;
SELECT * FROM TB_PROFESSOR;
SELECT * FROM TB_CLASS_PROFESSOR;

SELECT STUDENT_NAME, STUDENT_ADDRESS
FROM TB_STUDENT
WHERE DEPARTMENT_NO =(SELECT DEPARTMENT_NO FROM TB_STUDENT
WHERE STUDENT_NAME = '최경희');

--18
SELECT * FROM tb_department;
SELECT* FROM TB_CLASS;
SELECT * FROM TB_GRADE;
SELECT * FROM TB_STUDENT;
SELECT * FROM TB_PROFESSOR;
SELECT * FROM TB_CLASS_PROFESSOR;

SELECT STUDENT_NO, STUDENT_NAME
FROM TB_GRADE G
JOIN TB_STUDENT USING(STUDENT_NO)
GROUP BY STUDENT_NO, STUDENT_NAME;

SELECT STUDENT_NO, STUDENT_NAME, AVG(POINT)
FROM TB_STUDENT
JOIN TB_GRADE USING(STUDENT_NO)
WHERE DEPARTMENT_NO = '001'
GROUP BY STUDENT_NO, STUDENT_NAME;

SELECT STUDENT_NO, STUDENT_NAME
FROM (SELECT STUDENT_NO, STUDENT_NAME, AVG(POINT)
      FROM TB_STUDENT
      JOIN TB_GRADE USING(STUDENT_NO)
      WHERE DEPARTMENT_NO = '001'
      GROUP BY STUDENT_NO, STUDENT_NAME
      ORDER BY AVG(POINT) DESC)
WHERE ROWNUM = 1;

--19
SELECT * FROM tb_department;
SELECT* FROM TB_CLASS;
SELECT * FROM TB_GRADE;
SELECT * FROM TB_STUDENT;
SELECT * FROM TB_PROFESSOR;
SELECT * FROM TB_CLASS_PROFESSOR;

SELECT CATEGORY
FROM TB_DEPARTMENT
WHERE DEPARTMENT_NAME = '환경조경학과';

SELECT DEPARTMENT_NAME AS "계열 학과명", ROUND(AVG(POINT),1) AS "전공평점"
FROM TB_DEPARTMENT
JOIN TB_CLASS USING(DEPARTMENT_NO)
JOIN TB_GRADE USING(CLASS_NO)
WHERE CATEGORY = '자연과학'
GROUP BY DEPARTMENT_NAME;

-----------------------------------DDL---------------------------------
--1. 
CREATE TABLE TB_CATEGORY(
    NAME VARCHAR2(10),
    USE_YN CHAR(1) DEFAULT 'Y'
);
DROP TABLE TB_CATEGORY;
--2
CREATE TABLE TB_CLASS_TYPE(
    NO VARCHAR2(5) PRIMARY KEY,
    NAME VARCHAR2(10)
);

--3
ALTER TABLE TB_CATEGORY ADD PRIMARY KEY(NAME);

--4
ALTER TABLE TB_CLASS_TYPE MODIFY NAME NOT NULL;

--5
ALTER TABLE TB_CATEGORY MODIFY  NAME VARCHAR2(20);

ALTER TABLE TB_CLASS_TYPE
MODIFY NAME VARCHAR2(20)
MODIFY NO VARCHAR2(10);

--6
ALTER TABLE TB_CATEGORY RENAME COLUMN NAME TO CATEGORY_NAME;
ALTER TABLE TB_CLASS_TYPE RENAME COLUMN NAME TO CLASS_TYPE_NAME;
ALTER TABLE TB_CLASS_TYPE RENAME COLUMN NO TO CLASS_TYPE_NO;

--7
ALTER TABLE TB_CATEGORY  RENAME CONSTRAINT SYS_C007254 TO PK_CATEGORY_NAME;
ALTER TABLE TB_CLASS_TYPE RENAME CONSTRAINT SYS_C007253 TO PK_CLASS_TYPE_NO;

--8
INSERT INTO TB_CATEGORY VALUES ('공학','Y');
INSERT INTO TB_CATEGORY VALUES ('자연과학','Y');
INSERT INTO TB_CATEGORY VALUES ('의학','Y');
INSERT INTO TB_CATEGORY VALUES ('예체능','Y');
INSERT INTO TB_CATEGORY VALUES ('인문사회','Y');
COMMIT;

--9
SELECT * FROM TB_DEPARTMENT;
SELECT * FROM TB_CATEGORY;
ALTER TABLE TB_DEPARTMENT ADD CONSTRAINT FK_DEPARTMENT_CATEGORY FOREIGN KEY(CATEGORY) REFERENCES TB_CATEGORY;

--10
--안배움
SELECT * FROM TB_STUDENT;
GRANT CREATE VIEW TO WORKBOOK;
CREATE OR REPLACE VIEW VW_STU_GEN_INFO
AS SELECT STUDENT_NO 학번, STUDENT_NAME 학생이름, STUDENT_ADDRESS 주소
    FROM TB_STUDENT;
SELECT * FROM VW_STU_GEN_INFO;

--11
SELECT * FROM TB_STUDENT
WHERE COACH_PROFESSOR_NO IS NULL;
SELECT * FROM TB_PROFESSOR;

CREATE OR REPLACE VIEW VW_INTERVIEW
AS SELECT STUDENT_NAME 학생이름,DEPARTMENT_NAME 학과이름, NVL(PROFESSOR_NAME,'없음') 지도교수이름
    FROM TB_STUDENT
    JOIN TB_DEPARTMENT USING(DEPARTMENT_NO)
    LEFT JOIN TB_PROFESSOR ON(COACH_PROFESSOR_NO = PROFESSOR_NO)
    ORDER BY 2;
    
SELECT * FROM VW_INTERVIEW;

--12
CREATE OR REPLACE VIEW VW_STU_NUM
AS SELECT DEPARTMENT_NAME, COUNT(*) AS STUDENT_COUNT
    FROM TB_STUDENT
    JOIN TB_DEPARTMENT USING(DEPARTMENT_NO)
    GROUP BY DEPARTMENT_NAME;

SELECT * FROM VW_STU_NUM;

--13
SELECT * FROM VW_STU_GEN_INFO;
UPDATE VW_STU_GEN_INFO
SET 학생이름 = '박연준'
WHERE 학번 = 'A213046';

SELECT * FROM VW_STU_GEN_INFO
WHERE 학번 = 'A213046';

--14
-- VIEW를 만들때 WITH READ ONLY 옵션을 포함시켜주면 된다.

--15 -- 2007,2008, 2009
SELECT * FROM TB_CLASS;
SELECT * FROM TB_DEPARTMENT;
SELECT CLASS_NO, COUNT(*) 
FROM TB_GRADE
GROUP BY CLASS_NO
ORDER BY COUNT(*) DESC;

SELECT * FROM TB_GRADE
ORDER BY TERM_NO DESC;
--1995~2009

SELECT CLASS_NO, COUNT(*)
FROM TB_GRADE
JOIN TB_STUDENT USING(STUDENT_NO)
WHERE SUBSTR(TERM_NO,1,4) IN('2004','2005','2006')
GROUP BY CLASS_NO
ORDER BY COUNT(*) DESC;

SELECT CLASS_NO AS "과목번호", CLASS_NAME AS "과목이름", COUNT(*) AS "누적수강생수(명)"
FROM TB_GRADE
JOIN TB_CLASS USING(CLASS_NO)
JOIN TB_DEPARTMENT USING(DEPARTMENT_NO)
WHERE SUBSTR(TERM_NO,1,4) BETWEEN '2005'AND '2009'
GROUP BY CLASS_NO, CLASS_NAME
ORDER BY COUNT(STUDENT_NO) DESC;

SELECT *
FROM (SELECT CLASS_NO AS "과목번호", CLASS_NAME AS "과목이름", COUNT(*) AS "누적수강생수(명)"
        FROM TB_GRADE
        JOIN TB_CLASS USING(CLASS_NO)
        JOIN TB_DEPARTMENT USING(DEPARTMENT_NO)
        WHERE SUBSTR(TERM_NO,1,4) BETWEEN '2005'AND '2009'
        GROUP BY CLASS_NO, CLASS_NAME
        ORDER BY COUNT(*) DESC)
WHERE ROWNUM <=3;

ROLLBACK;
--------------------------------------DML--------------------------------------
--1.
SELECT * FROM TB_CLASS_TYPE;
INSERT INTO TB_CLASS_TYPE VALUES(01,'전공필수');
INSERT INTO TB_CLASS_TYPE VALUES(02,'전공선택');
INSERT INTO TB_CLASS_TYPE VALUES(03,'교양필수');
INSERT INTO TB_CLASS_TYPE VALUES(04, '교양선택');
INSERT INTO TB_CLASS_TYPE VALUES(05,'논문지도');

--2
SELECT * FROM TB_STUDENT;
CREATE TABLE TB_GENERAL_STUDENT
AS SELECT STUDENT_NO AS "학번", STUDENT_NAME AS "학생이름", STUDENT_ADDRESS AS "주소"
    FROM TB_STUDENT;

SELECT * FROM TB_GENERAL_STUDENT;

--3
SELECT * FROM TB_PROFESSOR;

CREATE TABLE TB_KOREAN_DEPARTMENT
AS SELECT STUDENT_NO AS "학번", STUDENT_NAME AS "학생이름",EXTRACT(YEAR FROM TO_DATE(SUBSTR(STUDENT_SSN,1,6))) AS "출샌년도",
    PROFESSOR_NAME AS "교수이름"
    FROM TB_STUDENT
    JOIN TB_PROFESSOR ON(PROFESSOR_NO = COACH_PROFESSOR_NO);

SELECT * FROM TB_KOREAN_DEPARTMENT;

--4
SELECT * FROM TB_DEPARTMENT;
UPDATE TB_DEPARTMENT
SET CAPACITY = ROUND(CAPACITY*1.1);

--5
UPDATE TB_STUDENT
SET STUDENT_ADDRESS = '서울시 종로구 숭인동 181-21'
WHERE STUDENT_NO = 'A413042';

SELECT STUDENT_ADDRESS FROM TB_STUDENT WHERE STUDENT_NO = 'A413042';

--6
SELECT * FROM TB_STUDENT;

UPDATE TB_STUDENT
SET STUDENT_SSN = SUBSTR(STUDENT_SSN,1,6);

--7
SELECT * FROM TB_GRADE;
SELECT * FROM TB_STUDENT;
SELECT * FROM TB_DEPARTMENT;
SELECT * FROM TB_CLASS;

SELECT POINT
FROM TB_STUDENT
JOIN TB_GRADE USING(STUDENT_NO)
JOIN TB_CLASS C USING(CLASS_NO)
JOIN TB_DEPARTMENT D ON(C.DEPARTMENT_NO = D.DEPARTMENT_NO)
WHERE DEPARTMENT_NAME = '의학과'
AND STUDENT_NAME = '김명훈'
AND TERM_NO = '200501';

UPDATE (SELECT POINT
        FROM TB_STUDENT
        JOIN TB_GRADE USING(STUDENT_NO)
        JOIN TB_CLASS C USING(CLASS_NO)
        JOIN TB_DEPARTMENT D ON(C.DEPARTMENT_NO = D.DEPARTMENT_NO)
        WHERE DEPARTMENT_NAME = '의학과'
        AND STUDENT_NAME = '김명훈'
        AND TERM_NO = '200501')
SET POINT = '3.5';

--8
SELECT * FROM TB_GRADE; -- 5036행
SELECT * FROM TB_STUDENT;
SELECT * 
FROM TB_STUDENT
JOIN TB_GRADE USING(STUDENT_NO)
WHERE ABSENCE_YN = 'Y';
-- 성적테이블에서 휴학생일 경우 삭제

DELETE FROM TB_GRADE
WHERE STUDENT_NO IN(SELECT STUDENT_NO
                    FROM TB_STUDENT
                    WHERE ABSENCE_YN = 'Y');
SELECT * FROM TB_GRADE; --4553행
ROLLBACK;
