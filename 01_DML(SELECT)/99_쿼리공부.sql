--���� ���� �ϱ�
----------------------------------QUIZ 1--------------------------------------
--���ʽ��� �ȹ����� �μ���ġ�� �� ��� ��ȸ
SELECT *
FROM EMPLOYEE
WHERE BONUS = NULL AND DEPT_CODE != NULL;
--NULL ���� ���� ���������� �� ó���� �ȵȴ�.

--������ : NULL �� ���� ���� �ܼ��� �Ϲ� �񱳿����ڸ� ���� �� �� �� ����.
--�ذ���: IS NULL / IS NOT NULL �����ڸ� �̿��ؼ� ���ؾ��Ѵ�.

--��ġ�� SQL�� 
SELECT *
FROM EMPLOYEE
WHERE BONUS IS NULL AND DEPT_CODE IS NOT NULL;
--------------------------------------------------------------------------------
----------------------------------QUIZ 2--------------------------------------
--�˻��ϰ��� �ϴ� ����
-- JOB_CODE�� J7�̰ų� J6�̸鼭 SALARY���� 200���� �̻��̰� 
-- BONUS�� �ְ� �����̸� �̸��� �ּҴ� _���� 3���ڸ� �ִ� �����
-- EMP_NAME, EMP_NO, JOB_CODE, DEPT_CODE, SALARY, BONUS�� ��ȸ�Ϸ� �Ѵ�.
-- ���������� ��ȸ�� �� �ȴٸ� �������� 2�� �̾�� �Ѵ�.

--���� ������ �����Ű���� �ۼ��� SQL���� �Ʒ��� ����.
SELECT EMP_NAME, EMP_NO, JOB_CODE, DEPT_CODE, SALARY, BONUS
FROM EMPLOYEE
WHERE JOB_CODE = 'J7' OR JOB_CODE = 'J6' AND SALARY > 2000000
AND EMAIL LIKE'___%' AND BONUS IS NULL;
--���� SQL�� ����� ���ϴ� ����� ����� ��ȸ���� �ʴ´�.
--�̶� � ���������� �ִ��� ��� ã�Ƽ� �����Ͻÿ�.
--�׸��� ��ġ�� �Ϻ��� SQL������ �ۼ��� ����!

--������:
--1. AND �����ڰ� �켱������ ���⿡ OR���� ���� ������ �ȴ�. �������� �䱸�� ��� OR�� ���� ������ �Ǿ����.
--2. BONUS�� �ִ°Ÿ� IS NOT NULL
--3. EMAIL���� _�� ���ϵ� ī���̱⿡ ___$_ ESCAPE '$'�� ���� ������ ���ϵ� ī�带 ����������.
--4. ������ ������ ã������ ����.
--5. SALARY�� ������ �̻��� >= �ٲ����.

--��������:
SELECT EMP_NAME, EMP_NO, JOB_CODE, DEPT_CODE, SALARY, BONUS
FROM EMPLOYEE
WHERE JOB_CODE IN('J6','J7') AND SALARY >= 2000000
AND EMAIL LIKE'___$_%' ESCAPE '$' AND BONUS IS NOT NULL 
AND SUBSTR(EMP_NO,8,1) = '2';

SELECT EMP_NAME, EMP_NO, JOB_CODE, DEPT_CODE, SALARY, BONUS
FROM EMPLOYEE
WHERE JOB_CODE IN('J7','J6') AND SALARY >= 2000000
AND BONUS IS NOT NULL AND EMAIL LIKE '___$_%' ESCAPE '$'
AND SUBSTR(EMP_NO,8,1) = '2';




SELECT EMP_NAME, EMP_NO, JOB_CODE, DEPT_CODE, SALARY, BONUS
FROM EMPLOYEE;
------------------------------22.11.28 ���� -----------------------------
SELECT ROUND(12.43) FROM DUAL;
SELECT ROUND(12.3223,1) FROM DUAL;
SELECT ROUND(123.2343,2) FROM DUAL;

--CEIL(NUBER)
SELECT CEIL(12.323)FROM DUAL;
SELECT CEIL ( 124123.24433)FROM DUAL;

-- FLOOR(NUMBER)
SELECT FLOOR(123.323) FROM DUAL;
SELECT FLOOR(1233.34214) FROM DUAL;

-- TRUNC (NUMBER , [���� ��ġ]) 
SELECT TRUNC(123.323) FROM DUAL;
SELECT TRUNC(123.434,1)FROM DUAL;
SELECT TRUNC (123.4324,-1) FROM DUAL;

--��¥ ó�� �Լ�
SELECT SYSDATE FROM DUAL;

--MONTHS_BETWEEN(DATE, DATE) : �� ��¥ ������ �������� ��ȯ => NUMBER ����
SELECT EMP_NAME, TRUNC(MONTHS_BETWEEN(SYSDATE, HIRE_DATE)) AS "������"
FROM EMPLOYEE;

--ADD_MONTHS(DATE, NUMBER): Ư�� ��¥�� �������� ���� ��¥ ����
SELECT EMP_NAME, ADD_MONTHS(HIRE_DATE, 6) AS "6������ ���� ����"
FROM EMPLOYEE;

--NEXT_DAY(DATE, ����(����)): Ư�� ��¥���ķ� ���� ����� ������ ��¥ ��ȯ
--1. �Ͽ��� 7. �����
SELECT NEXT_DAY(SYSDATE,6) FROM DUAL;
SELECT NEXT_DAY(HIRE_DATE,6)FROM EMPLOYEE;

--LAST_DAY(DATE) : �ش� DATE�� ������ ��¥�� ��ȯ����
SELECT LAST_DAY(SYSDATE) FROM DUAL;

--EXTRACT(YEAR FROM DATE) : Ư�� ������ ��ȯ

SELECT EMP_NAME, EXTRACT(YEAR FROM HIRE_DATE) AS "�⵵"
, EXTRACT(MONTH FROM HIRE_DATE) AS "��",
EXTRACT(DAY FROM HIRE_DATE) AS "��"
FROM EMPLOYEE
ORDER BY 2 DESC;

SELECT CEIL(12.32)FROM DUAL;
SELECT FLOOR(123.64) FROM DUAL;

SELECT EMP_NAME, EXTRACT(MONTH FROM HIRE_DATE)
FROM EMPLOYEE;

SELECT LAST_DAY(SYSDATE) FROM DUAL;

SELECT NEXT_DAY(SYSDATE, '��') FROM DUAL;
SELECT ROUND(123.456, -2) FROM DUAL;

SELECT EMP_NAME, EMAIL, PHONE
FROM EMPLOYEE
ORDER BY 3 DESC NULLS LAST;

-- ����ȯ �Լ� �ſ� �߿� 
-- ���ڿ��� �ٲٴ� �Լ� : TO_CHAR(����|��¥,[����])

SELECT TO_CHAR(123445) FROM DUAL;
SELECT TO_CHAR(12345,'999999')FROM DUAL;
SELECT TO_CHAR(12345,'000000')FROM DUAL;
SELECT TO_CHAR(12345,'L999999')FROM DUAL;
SELECT TO_CHAR(12345,'$000000')FROM DUAL;
SELECT TO_CHAR(12345,'L999,999') FROM DUAL;
SELECT TO_CHAR(12345,LTRIM('L999,999')) FROM DUAL;
SELECT SALARY, TO_CHAR(SALARY,'L999,999,999') 
FROM EMPLOYEE;
SELECT TO_CHAR(SYSDATE) FROM DUAL;
--��¥ Ÿ�� => ����Ÿ��
SELECT TO_CHAR(SYSDATE,'AM YY-MM-DD') FROM DUAL;
SELECT TO_CHAR(SYSDATE,'MONTH YY-MM-DD')FROM DUAL;
SELECT TO_CHAR(SYSDATE, 'HH:MI:SS')FROM DUAL;
SELECT TO_CHAR(SYSDATE, 'YYYY-MM-DD DAY DY') FROM DUAL;
SELECT TO_CHAR(SYSDATE, 'MON')FROM DUAL;
SELECT TO_CHAR(SYSDATE, 'YYYY"��" MM"��" DD"��"') FROM DUAL;

--������ ���õ� ����
--YYYY, YY, RR, RRRR, YEAR
--���� ���õ� ����
-- MM, MON, MONTH, RM
--�ϰ� ���õ� ����
-- DD,DDD(���� ���� �ϼ�) , D(�̹��� ���° �������� 1.�Ͽ���)
--���Ͽ� ���� ����
-- DAY, DY

-- TO_DATE: ���� �Ǵ� ���ڸ� ����Ʈ Ÿ������ ����ȯ

SELECT TO_DATE(100101) FROM DUAL;
SELECT TO_DATE(20101010) FROM DUAL;

SELECT TO_DATE(071010) FROM DUAL;-- ���� �߻� 07�� 7�� �ν��� ��.
SELECT TO_DATE('071010')FROM DUAL;

SELECT TO_DATE('140630','YYMMDD') FROM DUAL;
SELECT TO_DATE('140630 153015','YYMMDD HH24:MI:SS') FROM DUAL;

SELECT TO_DATE('140630','YYMMDD') FROM DUAL; -- ���� ���⸦ ��Ÿ��
SELECT TO_DATE(971013,'RRMMDD') FROM DUAL;-- 50 �̻��̸� ���� ����
-- 50 �̸��̸� ���� ����


-------------------------------------------���� 3--------------------------------
-- [������������] CREATE USER ������ IDENTIFIED BY ��й�ȣ;

-- ������ : SCOTT, ���: TIGER ������ �����ϰ� �ʹ�!
-- �̶� �Ϲݻ���� ������ KH������ �����ؼ� CREATE USER SCOTT;�� �����ϴ� ���� �߻�!!!

--������1. ����� ���������� ������ ������ ���������� ����
--������2. SQL���� �߸��Ǿ�����. ������� �Է��ؾ���!!

-- ��ġ����1. ������ ������ �����ؾߵ�!!
-- ��ġ����2. CREATE USER SCOTT IDENTIFIED BY TIGER;
--���� SQL(CREATE)�� ���� �� ������ ���� ������ �Ϸ��� ������ ������
-- �Ӹ� �ƴ϶� �ش� ������ ���̺� ���� ���� �͵� �ȵ�! �� �׷���? ������ ����.

-- ������1. ����� ���� ���� �� �ּ����� ���� �ο��� �ȵƴ�.
-- �ý��� ���� �� ��ü���� ������ �ο��� �ȵǾ��� ������
-- ��ġ����1. GRANT CONNECT, RESOURCE TO SCOTT;
--���迡 ���� �� �ִ�.





