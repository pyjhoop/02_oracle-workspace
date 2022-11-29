-- �켱 ����
/*
    < GROUP BY �� >
    �׷������ ������ �� �ִ� ���� (�ش� �׷���غ��� ���� �׷��� ���� �� ����)
    �������� ������ �ϳ��� �׷����� ��� ó���� �������� ���
    �ش� �÷��� �ߺ��� ������ ������ �ϳ��� �׷����� ����ؼ� ���
*/

SELECT SUM(SALARY)
FROM EMPLOYEE; -- ��ü ������� �ϳ��� �׷����� ��� ������ ���� ���

-- �� �μ��� �� �޿���
SELECT DEPT_CODE, SUM(SALARY)
FROM EMPLOYEE
GROUP BY DEPT_CODE;

-- �� �μ��� �����
SELECT DEPT_CODE,SUM(SALARY), COUNT(*)
FROM EMPLOYEE
GROUP BY DEPT_CODE;
-- DEPT_CODE�� ������ ������ ������ �ϳ��� ��� �������� �׷��� �������

--�������
SELECT DEPT_CODE, SUM(SALARY) --3
FROM EMPLOYEE --1
GROUP BY DEPT_CODE --2
ORDER BY DEPT_CODE; --4 ������ ���� ������

SELECT DISTINCT JOB_CODE
FROM EMPLOYEE;

SELECT JOB_CODE, SUM(SALARY), COUNT(*)
FROM EMPLOYEE
GROUP BY JOB_CODE
ORDER BY JOB_CODE;

-- �� ���޺��� �� �����, ���ʽ��� �޴� �����, �޿� ��, ��� �޿�, �����޿�, �ִ�޿�
-- GROUP BY �ϰ� SELECT �ϸ� �� �׷쿡��~~~ EX) �� �׷쿡�� �ѻ����, �� �׷쿡�� ���ʽ� �޴� �����, �� �׷쿡�� �޿��� ���հ�, �� �׷쿡�� �ּұ޿�...
SELECT JOB_CODE, COUNT(*) AS "�����", COUNT(BONUS) AS "���ʽ� �޴� �����", SUM(SALARY) AS "�޿���"
, MIN(SALARY)AS "�ּ� �޿�", MAX(SALARY) AS "�ִ�޿�", TO_CHAR(TRUNC(AVG(SALARY)),'999,999,999')||'��' AS "��ձ޿�"
FROM EMPLOYEE 
GROUP BY JOB_CODE
ORDER BY 1;

SELECT DEPT_CODE, COUNT(*) AS "�����", COUNT(BONUS) AS "���ʽ� �޴� �����", SUM(SALARY) AS "�޿���"
, MIN(SALARY)AS "�ּ� �޿�", MAX(SALARY) AS "�ִ�޿�", TO_CHAR(TRUNC(AVG(SALARY)),'999,999,999')||'��' AS "��ձ޿�"
FROM EMPLOYEE 
GROUP BY DEPT_CODE
ORDER BY 1;


-- GROUP BY ���� �Լ��� ��� ����!!!
SELECT DECODE(SUBSTR(EMP_NO,8,1),'1','��','2','��'), COUNT(*)
FROM EMPLOYEE
GROUP BY SUBSTR(EMP_NO,8,1); -- 1�Ǵ� 2�� ���� ���̺� �� �������.

-- GROUP BY ���� ���� �÷� ��� ����!!!
SELECT DEPT_CODE, JOB_CODE, COUNT(*), SUM(SALARY)
FROM EMPLOYEE
GROUP BY DEPT_CODE, JOB_CODE --�ΰ��� �ڵ尡 ���� �� ���� ����
ORDER BY DEPT_CODE;

-------------------------------------------------------------------------------
/*
    < HAVING �� >
    �׷쿡 ���� ������ ������ �� ���Ǵ� ����(�ַ� �׷��Լ����� ������ ������ ������ �� ���)
*/

-- �� �μ��� ��� �޿� ��ȸ(�μ��ڵ�, ��ձ޿�)
SELECT DEPT_CODE, FLOOR(AVG(SALARY))
FROM EMPLOYEE
GROUP BY DEPT_CODE
ORDER BY 1;

-- �μ����� ��� �޿��� 300���� �̻��� �μ��鸸 ��ȸ
SELECT DEPT_CODE, FLOOR(AVG(SALARY))
FROM EMPLOYEE
--WHERE FLOOR(AVG(SALARY))>= 3000000 ���� �߻� �׷� �Լ������� ������ �����ϸ� WHERE�������� �ȵȴ�.
GROUP BY DEPT_CODE
ORDER BY 1;

SELECT DEPT_CODE, FLOOR(AVG(SALARY)) -- 4
FROM EMPLOYEE --1
GROUP BY DEPT_CODE --2
HAVING AVG(SALARY) >= 3000000; --3
-- HAVING�� �׷��Լ��� ����(WHERE)������ ��.

-- ���޺� �ѱ޿��� ��, ���޺� �޿��� ���� 1000���� �̻��� ���޸� ��ȸ => �����ڵ�, �޿��� ��ȸ
SELECT JOB_CODE AS "�����ڵ�", TO_CHAR(SUM(SALARY),'L999,999,999') AS "�޿���"
FROM EMPLOYEE
GROUP BY JOB_CODE
HAVING SUM(SALARY) >= 10000000;

-- �μ����� ���ʽ��� �޴� ����� ���� �μ����� ��ȸ �μ��ڵ常 ������ �غ���
SELECT DEPT_CODE
FROM EMPLOYEE
GROUP BY DEPT_CODE
HAVING COUNT(BONUS) = 0;

----------------------------------------------------------------------------------
/*
    < SELECT �� ������� >
    5. SELECT *|��ȸ�ϰ��� �ϴ� �÷� ��Ī | ����� "��Ī" | �Լ��� AS "��Ī"
    1. FROM ��ȸ�ϰ��� �ϴ� ���̺� ��
    2. WHERE ���ǽ�(�����ڸ� ������ ���)
    3. GROUP BY �׷�������� ���� �÷� | �Լ���
    4. HAVING ���ǽ� (�׷��Լ��� ������ ���)
    6. ORDER BY �÷���| ��Ī | ����[ASC|DESC] [NULLS FIRST| NULLS LAST]
*/
---------------------------------------------------------------------------------
/*
    < �����Լ� >
    �׷캰 ����� ������� �߰����踦 ������ִ� �Լ�
    
    ROLL UP
    => GROP BY ���� ����ϴ� �Լ� ������ �࿡ ������ ���� �߰�����
*/
--�� ���޺� �޿���
-- ������ ������ ��ü �� �޿��ձ��� ���� ��ȸ�ϰ� ���� ��
SELECT JOB_CODE,SUM(SALARY)
FROM EMPLOYEE
GROUP BY ROLLUP(JOB_CODE)
ORDER BY 1;
--ROLLUP(): GROUP BY�� ���� ���� �׷��� �߰� ���踦 ������ִ� �Լ�
----------------------------------------------------------------------------------
/*
    < ���� ������ == SET OPERATION >
    
    �������� �������� ������ �ϳ��� ���������� ����� ������
    
    - UNION     : (OR����)������ (�� �������� ������ ������� ���� �� �ߺ��Ǵ� ���� �ѹ��� ����������)
    - INTERSECT : (AND����)������(�� ������ ������ ��� ���� �ߺ��� �����)
    - UNION ALL : ������ + ������(�ߺ��Ǵ� �κ��� 2�� ǥ���� �� ����)
    - MINUS     : ������(���� ������� ���� ������� �� ������)
*/

--1. UNION
-- �μ��ڵ尡 D5�� ��� �Ǵ� �޿��� 300���� �ʰ��� ����� ��ȸ(���, �̸�, �μ��ڵ�, �޿�)
SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE DEPT_CODE = 'D5' --6����(�ڳ���, ������, ���ؼ�, �ɺ��� ,������, ���ȥ)
UNION
SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE SALARY > 3000000;-- 8����(������, ���߱�, ���ö, �����, ������, *�ɺ���,*���ȥ, ������)

-- ���� Ŀ���� ��� �Ʒ�ó�� WHERE���� OR�� �ᵵ �ذ� ����!!
SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE DEPT_CODE = 'D5' OR SALARY > 3000000;


--2. INTERSECT(������)
SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE DEPT_CODE = 'D5' --6����(�ڳ���, ������, ���ؼ�, �ɺ��� ,������, ���ȥ)
INTERSECT
SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE SALARY > 3000000;-- 8����(������, ���߱�, ���ö, �����, ������, *�ɺ���,*���ȥ, ������)

-- �Ʒ�ó���� �ذ� ����
SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE DEPT_CODE = 'D5' AND SALARY > 3000000;
------------------------------------------------------------------------------
--���� ������ ���ǻ���
SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE DEPT_CODE = 'D5' --6����(�ڳ���, ������, ���ؼ�, �ɺ��� ,������, ���ȥ)
UNION
SELECT EMP_ID, EMP_NAME, DEPT_CODE
FROM EMPLOYEE
WHERE SALARY > 3000000;
-- ���������� SELECT���� �ۼ��Ǿ��ִ� �÷������� �����ؾߵ�.

SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE DEPT_CODE = 'D5' --6����(�ڳ���, ������, ���ؼ�, �ɺ��� ,������, ���ȥ)
UNION
SELECT EMP_ID, EMP_NAME, DEPT_CODE, HIRE_DATE
FROM EMPLOYEE
WHERE SALARY > 3000000;
-- �÷� ���� �Ӹ� �ƴ϶� �÷��ڸ����� ������ Ÿ������ ����ؾߵ�!!

SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE DEPT_CODE = 'D5' --6����(�ڳ���, ������, ���ؼ�, �ɺ��� ,������, ���ȥ)
--ORDER BY EMP_NAME
UNION
SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE SALARY > 3000000
ORDER BY EMP_NAME;
-- ORDER BY���� ����ϰ��� �Ѵٸ� �������� ����ؾߵ�
-------------------------------------------------------------------------------
--3. UNION ALL: �������� ���� ����� ������ �� ���ϴ� ������(�ߺ��� ����)

SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE DEPT_CODE = 'D5' --6����(�ڳ���, ������, ���ؼ�, �ɺ��� ,������, ���ȥ)
--ORDER BY EMP_NAME
UNION ALL
SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE SALARY > 3000000
ORDER BY EMP_NAME;

-------------------------------------------------------------------------------
--4. MUNUS : ���� SELECT ������� ���� SELECT ����� �� ������(������)
SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE DEPT_CODE = 'D5' --6����(�ڳ���, ������, ���ؼ�, �ɺ��� ,������, ���ȥ)
--ORDER BY EMP_NAME
MINUS
SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE SALARY > 3000000
ORDER BY EMP_NAME;

-- �Ʒ�ó���� �����ϱ� ��!
SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE DEPT_CODE = 'D5' AND SALARY <= 3000000;













