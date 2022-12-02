--�켱����

/*
    *��������(SUBQUERY)
    - �ϳ��� SQL�� �ȿ� ���Ե� �Ǵٸ� SELECT��
    - ���� SQL���� ���� ���� �������ϴ� ������  
*/

--���� �������� ���� 1
-- ���ö ����� ���� �μ��� ���� ����� ��ȸ �ϰ����!!



--1. ���� ���ö ����� �μ��ڵ带 ��ȸ�ؾ���.
SELECT DEPT_CODE 
FROM EMPLOYEE
WHERE EMP_NAME = '���ö'; --D9�ΰ� �˾Ƴ�!!

--2. �μ��ڵ尡 D9�� ����� ��ȸ
SELECT EMP_NAME
FROM EMPLOYEE
WHERE DEPT_CODE = 'D9';

--> ���� 2�ܰ踦 �ϳ��� ����������!!!
SELECT EMP_NAME
FROM EMPLOYEE
WHERE DEPT_CODE 
= (SELECT DEPT_CODE 
    FROM EMPLOYEE
    WHERE EMP_NAME = '���ö');

-- ������������ �־����� �Ⱥ��� ���� ������Ѽ� Ȯ�� �� ��ü ������ �����Ѵ�.

-- ���� �������� ���� 2
-- �� ������ ��� �޿����� �� ���� �޿��� �޴� ������� ���, �̸�, �����ڵ�, �޿� ��ȸ
SELECT AVG(SALARY)
FROM EMPLOYEE;

SELECT EMP_ID, EMP_NAME, JOB_CODE, SALARY
FROM EMPLOYEE
WHERE SALARY > (SELECT AVG(SALARY)
FROM EMPLOYEE);


--1. �������� ��� �޿��� ��ȸ
SELECT AVG(SALARY)
FROM EMPLOYEE; -- 3047662.60869565217391304347826086956522

--2. �ݾ� �̻�޴� ������� �ñ��ϴ�.
SELECT EMP_ID, EMP_NAME, JOB_CODE, SALARY
FROM EMPLOYEE
WHERE SALARY >= 3047662;
                
-- ���� �� �ܰ踦 �ϳ��� ���������� 
SELECT EMP_ID, EMP_NAME, JOB_CODE, SALARY
FROM EMPLOYEE
WHERE SALARY >= (SELECT AVG(SALARY)
                FROM EMPLOYEE);
                
---------------------------------------------------------------------------------
/*
    * ���������� ����
    ���������� ������ ������� �� �� �� ���̳Ŀ� ���� �з���
    
    -- ������ �������� :���������� ��ȸ ������� ������ ������ 1���� �� (�� �� �ѿ�)
    -- ������ �������� : ���������� ��ȸ ������� ���� ���� �� (������ �ѿ�) => �������� ���ö 2���� ��
    -- ���߿� �������� : ���������� ��ȸ ������� �� �������� �÷��� �������� ��(�� �� ������)
    -- ������ ���߿� �������� : ���������� ��ȸ ������� ������ �������� ��
    
    >> ���������� ������ ���Ŀ� ���� �������� �տ� �ٴ� �����ڰ� �޶���!!!
*/

/*
    1. ������ �������� (SINGLE ROW SUBQUERY)
    ���������� ��ȸ ������� ������ ������ 1���� ��(���� �ѿ�)
    �Ϲ� �� ������ ��� ����...
    =, !=, ^=, <>. >, <, >=, <= ��밡��.
    **A�� ���� �����ڵ��� ** Ű����
*/

--1. �� ������ ��ձ޿����� �޿��� �� ���� �޴� ������� �����, �����ڵ�, �޿� ��ȸ
SELECT EMP_NAME, JOB_CODE, SALARY
FROM EMPLOYEE
WHERE SALARY < (SELECT AVG(SALARY)
                FROM EMPLOYEE);

SELECT EMP_NAME, JOB_CODE, SALARY
FROM EMPLOYEE
WHERE SALARY < (SELECT AVG(SALARY)
                FROM EMPLOYEE);
                
--2. ���� �޿��� �޴� ����� ���, �̸�, �޿�, �Ի���
SELECT EMP_ID, EMP_NAME, SALARY, HIRE_DATE
FROM EMPLOYEE
WHERE SALARY = (SELECT MIN(SALARY)
                FROM EMPLOYEE);

SELECT EMP_ID, EMP_NAME, SALARY, HIRE_DATE
FROM EMPLOYEE
WHERE SALARY = (SELECT MIN(SALARY)
                FROM EMPLOYEE);            

--3. ���ö ����� �޿����� �� ���� �޴� ������� ���, �̸�, �μ��ڵ�, �޿� ��ȸ
SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE SALARY = (SELECT SALARY
                FROM EMPLOYEE
                WHERE EMP_NAME = '���ö');


SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE SALARY > (SELECT SALARY
                FROM EMPLOYEE
                WHERE EMP_NAME = '���ö');
--����Ŭ ���� ����
SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY,DEPT_TITLE
FROM EMPLOYEE,DEPARTMENT
WHERE DEPT_CODE = DEPT_ID
AND SALARY > (SELECT SALARY
              FROM EMPLOYEE
              WHERE EMP_NAME = '���ö');

--ANSI ����
SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY,DEPT_TITLE
FROM EMPLOYEE
JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID)
WHERE SALARY > (SELECT SALARY
                FROM EMPLOYEE
                WHERE EMP_NAME = '���ö');
                
--4. �μ��� �޿����� ���� ū �μ��� �μ��ڵ�, �޿� �� ��ȸ
--4_1. ���� �μ��� �޿��� �߿����� ���� ū �� �ϳ��� ��ȸ
 SELECT  MAX(SUM(SALARY))
 FROM EMPLOYEE
 GROUP BY DEPT_CODE; --17700000��
 
 --�μ��� �޿� ���� 17700000�� �μ� ��ȸ
 SELECT DEPT_CODE, SUM(SALARY)
 FROM EMPLOYEE
 GROUP BY DEPT_CODE
 HAVING SUM(SALARY) = 17700000;
 
  SELECT DEPT_CODE, SUM(SALARY)
 FROM EMPLOYEE
 GROUP BY DEPT_CODE
 HAVING SUM(SALARY) = ( SELECT  MAX(SUM(SALARY))
                        FROM EMPLOYEE
                        GROUP BY DEPT_CODE);
                        
-- ������ ����� ���� �μ������� ���, �����, ����, �Ի���, �μ���
-- ��, �������� ����

-- ����Ŭ ���뱸��
SELECT EMP_ID, EMP_NAME, PHONE, HIRE_DATE, DEPT_TITLE
FROM EMPLOYEE, DEPARTMENT
WHERE DEPT_CODE = DEPT_ID
AND DEPT_CODE = (SELECT DEPT_CODE
                 FROM EMPLOYEE
                 WHERE EMP_NAME = '������')
AND EMP_NAME !='������';

-- ANSI���� �� �÷��� ������ USING�� ����� ���� ����.
SELECT EMP_ID, EMP_NAME, PHONE, HIRE_DATE, DEPT_TITLE
FROM EMPLOYEE
JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID)
WHERE DEPT_CODE = (SELECT DEPT_CODE
                 FROM EMPLOYEE
                 WHERE EMP_NAME = '������')
AND EMP_NAME !='������';

----------------------------------------------------------------------------------
/*
    2. ������ �������� (MULTI ROW SUBQUERY)
    ���������� ������ ������� ���� �� �϶� (�÷��� �Ѱ�)
    
    - IN �������� : �������� ����� �߿��� �Ѱ��� ��ġ�ϴ� ���� �ִٸ�
    - > ANY �������� : �������� ����� �߿��� "�Ѱ���" Ŭ ���
    - < ANY �������� : �������� ����� �߿��� "�Ѱ���" ���� ���
    
        �񱳴�� > ANY (��1, ��2, ��3)
        �񱳴�� >��1 OR �񱳴�� > ��2 OR �񱳴�� > ��3 �̷��� ���� �ϳ��� ũ�� �ȴ�.
    
    - > ALL �������� : �������� "���"������� ���� Ŭ���
    - < ALL �������� : �������� "���"������� ���� ���� ���
    ANY�� �����߿� �ϳ��� �۰ų� ũ�� ������ ALL�� ��� ������ �۰ų� ���ƾ� �Ѵ�.
    �񱳴�� >��1 AND �񱳴�� > ��2 AND �񱳴�� > ��3
*/

--1. ����� �Ǵ� ������ ����� ���� ������ ������� ���, �����, �����ڵ�, �޿�

--1-1 ����İ��Ǵ� ������ ����� � �������� ��ȸ�� �غ�.
SELECT JOB_CODE
FROM EMPLOYEE
WHERE EMP_NAME IN('�����','������'); --J3, J7

--1-2 J3, J7������ ����� ��ȸ
SELECT EMP_ID, EMP_NAME, JOB_CODE, SALARY
FROM EMPLOYEE
WHERE JOB_CODE IN ('J3','J7');

--���� �δܰ踦 �ϳ��� ����������
SELECT EMP_ID, EMP_NAME, JOB_CODE, SALARY
FROM EMPLOYEE
WHERE JOB_CODE IN(SELECT JOB_CODE
                  FROM EMPLOYEE
                  WHERE EMP_NAME IN('�����','������'));     -- =�̶�� ���� ������ ����. �ֳĸ� ���������� ��ȸ��� �����̴�.
                  --���࿡ ������� ������ ���ð� ������ ���������� IN���� ����.
-- ** Ű���尡 �߿��� ������ ������������ IN��** A �Ǵ� B�� �����ڵ� �� ���� **

-- ��� => �븮 => ���� => ���� => ����....
--2. �븮�����ӿ��� �ұ��ϰ� ���� ���� �޿��� �� �ּ� �޿����� ���� �޴� ���� ��ȸ(���, �̸�, ����, �޿�)

--2_1 ���� ������ ������� �޿���ȸ
SELECT SALARY 
FROM EMPLOYEE E, JOB J
WHERE E.JOB_CODE = J.JOB_CODE
AND JOB_NAME = '����';

--2_2 ������ �븮�̸鼭 �޿����� ���� ��ϵ� �� �߿� �ϳ��� ū ���
SELECT EMP_ID, EMP_NO, JOB_NAME, SALARY
FROM EMPLOYEE
JOIN JOB USING(JOB_CODE)
WHERE JOB_NAME = '�븮'
AND SALARY > ANY ('2200000','2500000','3760000'); --���߿� �ϳ��� ū �븮�� �޿��� ã�����.

--���� �� �ܰ踦 �ϳ��� ���������� �ۼ�
SELECT EMP_ID, EMP_NO, JOB_NAME, SALARY
FROM EMPLOYEE
JOIN JOB USING(JOB_CODE)
WHERE JOB_NAME = '�븮'
AND SALARY > ANY (SELECT SALARY 
FROM EMPLOYEE E, JOB J
WHERE E.JOB_CODE = J.JOB_CODE
AND JOB_NAME = '����');

--���������� �غ���
SELECT EMP_ID, EMP_NO, JOB_NAME, SALARY
FROM EMPLOYEE
JOIN JOB USING(JOB_CODE)
WHERE JOB_NAME = '�븮'
AND SALARY > (SELECT min(SALARY) 
                  FROM EMPLOYEE E, JOB J
                  WHERE E.JOB_CODE = J.JOB_CODE
                  AND JOB_NAME = '����');
                  
--3. ���� �����ӿ��� �ұ��ϰ� ���� ������ ������� ��� �޿����ٵ� �� ���� �޴� ������� ���, �����, ���޸�, �޿�
SELECT EMP_ID, EMP_NAME, JOB_NAME, SALARY
FROM EMPLOYEE
JOIN JOB USING(JOB_CODE)
WHERE JOB_NAME = '����'
AND SALARY > ALL(SELECT SALARY
                 FROM EMPLOYEE
                 JOIN JOB USING(JOB_CODE)
                 WHERE JOB_NAME = '����');
                 
----------------------------------------------------------------------------------
/*
    3. ���߿� ��������
    ������� �� �������� ������ �÷����� �������� ���
*/

--1. ������ ����� ���� �μ��ڵ�, ���� �����ڵ忡 �ش��ϴ� ����� ��ȸ(�����, �μ��ڵ�, �����ڵ�, �Ի���)
-->> ������ ���������ε� �����ϱ���!
SELECT EMP_NAME, DEPT_CODE, JOB_CODE, HIRE_DATE
FROM EMPLOYEE
WHERE DEPT_CODE = (SELECT DEPT_CODE
                   FROM EMPLOYEE   
                   WHERE EMP_NAME = '������')
AND JOB_CODE = (SELECT JOB_CODE
                FROM EMPLOYEE
                WHERE EMP_NAME = '������');

-->> ���߿� ���������� �����ڴ�.
SELECT EMP_NAME, DEPT_CODE, JOB_CODE, HIRE_DATE
FROM EMPLOYEE
WHERE (DEPT_CODE, JOB_CODE) = (SELECT DEPT_CODE, JOB_CODE
                               FROM EMPLOYEE
                               WHERE EMP_NAME = '������'); --D5, J5 => ���� �߿��ϰ� ������ "��" �������!!!
                               
--�ڳ��� ����� ���� �����ڵ�, ���� ����� ������ �ִ� ������� ���, �����, �����ڵ�, ������   
SELECT EMP_ID, EMP_NAME, JOB_CODE, MANAGER_ID
FROM EMPLOYEE
WHERE (JOB_CODE, MANAGER_ID) = (SELECT JOB_CODE, MANAGER_ID
                                FROM EMPLOYEE
                                WHERE EMP_NAME = '�ڳ���');
                                
----------------------------------------------------------------------------------
/*
    4. ������ ���߿� ��������
    �������� ��ȸ ������� ������ �������� ���
*/
--1. �� ���޺� �ּұ޿��� �޴� ��� ��ȸ(���, �����, �����ڵ�, �޿�)
--1_1 �� ���޺� �ּұ޿� ��ȸ
SELECT JOB_CODE, MIN(SALARY)
FROM EMPLOYEE
GROUP BY JOB_CODE;

SELECT EMP_ID, EMP_NAME, JOB_CODE, SALARY
FROM EMPLOYEE
WHERE JOB_CODE = 'J2' AND SALARY='3700000'
    OR JOB_CODE = 'J7' AND S...;


--���������� �����ؼ� �غ���!!!
SELECT EMP_ID, EMP_NAME, JOB_CODE, SALARY
FROM EMPLOYEE
WHERE (JOB_CODE, SALARY) IN(SELECT JOB_CODE, MIN(SALARY)
                            FROM EMPLOYEE
                            GROUP BY JOB_CODE);
--2. �� �μ��� �ְ� �޿��� �޴� ������� ���, �����, �μ��ڵ� ,�޿�
-- 1. �� �μ��� �ְ� �޿��� �˻� => ���� ��, ���� ���� ����. ���������ν� ����ϸ� ��.
SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE (DEPT_CODE, SALARY) IN(SELECT DEPT_CODE, MAX(SALARY)
                             FROM EMPLOYEE
                             GROUP BY DEPT_CODE);

---------------------------------------------------------------------------------
/*
    5. �ζ��κ�(INLINE - VIEW)
    ���������� ������ ����� ��ġ ���̺�ó�� ���!!!
*/

-- ������� ���, �̸�, ���ʽ� ���� ����(��Ī �ο�: ����), �μ��ڵ� ��ȸ
-- �� ���ʽ� ���� ������ 3000���� �̻��� ����鸸 ��ȸ, ���ʽ� ���� ������ ���� NULL�� ������ �ʵ���!!!
SELECT EMP_ID, EMP_NAME, (SALARY + SALARY*NVL(BONUS,0))*12 AS "����", DEPT_CODE
FROM EMPLOYEE
WHERE (SALARY + SALARY*NVL(BONUS,0))*12 >= 30000000; --WHERE���� �ٷ� ��Ī�� ��� ����

SELECT EMP_ID, EMP_NAME, (SALARY + SALARY*NVL(BONUS,0))*12 AS "����", DEPT_CODE
FROM EMPLOYEE;
-- �̰� ��ġ �����ϴ� ���̺� ���� ����� �� ����!! �װ� �ζ��� ��!!!

SELECT *
FROM (SELECT EMP_ID, EMP_NAME, (SALARY + SALARY*NVL(BONUS,0))*12 AS "����", DEPT_CODE
FROM EMPLOYEE)
WHERE ���� >= 30000000;


SELECT EMP_NAME, DEPT_CODE, ����
FROM (SELECT EMP_ID, EMP_NAME, (SALARY + SALARY*NVL(BONUS,0))*12 AS "����", DEPT_CODE
FROM EMPLOYEE)
WHERE ���� >= 30000000;

SELECT EMP_NAME, DEPT_CODE, ����, --MANAGER_ID �̰� ���̺� ���⿡ ������.
FROM (SELECT EMP_ID, EMP_NAME, (SALARY + SALARY*NVL(BONUS,0))*12 AS "����", DEPT_CODE
FROM EMPLOYEE)
WHERE ���� >= 30000000;

-->> �ζ��� �並 �ַ� ����ϴ� �� => TOP-N �м�(���� ��� �����ְ� ������ => BEST��ǰ!!)
--�� ������ �޿��� ���� ���� ���� 5�� ��ȸ
-- * ROWNUM : ����Ŭ���� �������ִ� �÷�, ��ȸ�� ������� 1���� ������ �ο����ִ� �÷�

SELECT ROWNUM, EMP_NAME, SALARY
FROM EMPLOYEE
ORDER BY SALARY DESC;
--FROM --> SELECT ROWNUM(�̶� ������ �ο���!!) -> ����
--�հ� �� �̻���....
SELECT ROWNUM, EMP_NAME, SALARY
FROM EMPLOYEE
WHERE ROWNUM <=5;
ORDER BY SALARY DESC; -- �������� ����� ��ȸ���� ���� ���ĵǱ� ���� 5���� �߷����� ���ĵǱ� ������

-- ORDER BY���� �� ����� ����� ������ ROWNUM �ο� �� 5�� �߷�����!!!
SELECT ROWNUM, EMP_NAME, SALARY
FROM (SELECT EMP_NAME, SALARY
      FROM EMPLOYEE
      ORDER BY SALARY DESC)
WHERE ROWNUM <= 5;

SELECT ROWNUM,E.*
FROM (SELECT EMP_NAME, SALARY
      FROM EMPLOYEE
      ORDER BY SALARY DESC) E
WHERE ROWNUM <= 5;
--�ζ��� �信�� ��Ī�� �����ϰ� E.*�� ROWNU�� ���� ����� �� �ִ�.

--�ζ��� �信�� ��Ī�� �����ϰ� E.*�� ROWNU�� ���� ����� �� �ִ�.
SELECT ROWNUM, E.*
FROM (SELECT EMP_NAME, SALARY, HIRE_DATE
      FROM EMPLOYEE
      ORDER BY HIRE_DATE DESC) E
WHERE ROWNUM <=5;

-- �� �μ��� ��ձ޿��� ���� 3���� �μ� ��ȸ(�μ��ڵ�, ��ձݾ�) => ��ձ޿� ��Ī ���
SELECT ROUND(AVG(SALARY))
FROM EMPLOYEE
GROUP BY DEPT_CODE
ORDER BY 1;

SELECT ROWNUM, E.*
FROM (SELECT DEPT_CODE, ROUND(AVG(SALARY)) AS "��ձ޿�"
      FROM EMPLOYEE
      GROUP BY DEPT_CODE 
      ORDER BY 2 DESC) E
WHERE ROWNUM <=3;

--------------------------------------------------------------------------------
/*
    * ���� �ű�� �Լ�(WINDOW FUNCTION)
    RANK() OVER(���ı���)  |  DENSE_RANK() OVER(���ı���)
    
    - RANK() OVER(���ı���): ������ ���� ������ ����� ������ �ο��� ��ŭ �ǳʶٰ� ���� ���
                            EX) ���� 1���� 2�� �״��� ���� 3�� 
    
    - DENSE_RANK() OVER(���ı���) : ������ ������ �ִٰ� �ص� �� ���� ����� ������ 1�� ������Ŵ
                                  EX) ���� 1���� 2���̶� �� ���� ������ 2���� ��
    >> �� �Լ��� ������ SELECT�������� ��� ����!!!
*/
-- �޿��� ���� ����� ������ �Űܼ� ��ȸ
SELECT EMP_NAME, SALARY,RANK() OVER(ORDER BY SALARY DESC)
FROM EMPLOYEE;
-- ���� 19�� 2�� �� ���� ������ 21=> ������ ������ ��ȸ�� ����� ����.

SELECT EMP_NAME, SALARY,DENSE_RANK() OVER(ORDER BY SALARY DESC)
FROM EMPLOYEE;
--���� 19�� �� ���� ������ 20�� ���� => ������ ������ ��ȸ�� ������ �ٸ� �� ����.

-- ���� 5�� ��ȸ
SELECT EMP_NAME, SALARY,RANK() OVER(ORDER BY SALARY DESC) "����"
FROM EMPLOYEE;
--WHERE RANK() OVER(ORDER BY SALARY DESC) <=5;

-- �ζ��κ並 �� �� �ۿ� ����!!!
SELECT *
FROM (SELECT EMP_NAME, SALARY,RANK() OVER(ORDER BY SALARY DESC) "����"
FROM EMPLOYEE)   --1
WHERE ���� <=5;  --2





