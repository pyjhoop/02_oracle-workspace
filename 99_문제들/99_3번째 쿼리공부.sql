-- ����
-- ���� 1
-- CREATE USER TEST IDENTIFIED BY 1234; TLFGOD
-- USER TEST��(��) �����Ǿ����ϴ�.
-- �����Ϸ��ϴµ� �����߻���.
-- ������ : ���������� �߰� ���� ������ �ο����� �ʾұ� ������.
-- ��ġ�� ���� : GRANT CONNECT, RESOURCE TO TEST;

-- ���� 2 ����
CREATE TABLE TB_JOB(
    JOB_CODE NUMBER PRIMARY KEY,
    JOB_NAME VARCHAR2(10) NOT NULL

);

CREATE TABLE TB_EMP(
    EMP_NO NUMBER PRIMARY KEY,
    EMP_NAME VARCHAR2(10) NOT NULL,
    JOB_NO NUMBER REFERENCES TB_JOB(JOB_CODE)
);

-- ���� �� ���̺��� �ִٴ� �����Ͽ� 
-- �� ���̺� �����ؼ� EMP_NO, EMP_NAME, JOB_NO, JOB_NAME �÷��� ��ȸ�Ҳ���
-- �̶� ������ SQL�� 
SELECT EMP_NO, EMP_NAME, JOB_NO, JOB_NAME
FROM TB_EMP
JOIN TB_JOB USING(JOB_NO); -- �����߻���
-- �� �߻�������?
-- ON���� �ٲٸ� ��.
-- ������: JOB_NO �÷��� TB_EMP���� ���������� TB_JOB���� �������� �ʱ� ������ USING���� �ȵȴ�.
-- �ذ᳻�� : USING(JOB_NO) �� ON(JOB_NO = JOB_CODE)�� �ٲٸ� �ȴ�.

--------------------------------------------------------------------------------
-- ���̺� ���������ؼ� ������ Ÿ��(CHAR, VARCHAR2)������
-- ����Ŭ ��ü(SEQUENCT, VIEW,...)���� ����
-- ��������  -> ���������� �߰��Ϸ��� �Ѵ�. �߰��ϴ� ALTER�� �ۼ��ض�.
-- DCL ����? GRANT, REVOKE
-- Ŀ�� �ѹ� ����?

-- ���� 3(JOIN ����)

-- �Ʒ��� SQL������ �μ��� �����հ谡 15000000�� �ʰ��ϴ� �μ��� ��ȸ�� ���̴�.
-- �� ����� �ùٸ��� �ʴٰ� �� �� �׿��ΰ� ��ġ����
SELECT DEPT_CODE, SUM(SALARY)
FROM EMPLOYEE
WHERE SALARY>2800000
GROUP BY DEPT_CODE; -- WHERE �����ϰ� HAVING�� 1500���� �ʰ��ϴ� ���� �־��


SELECT DEPT_CODE, SUM(SALARY)
FROM EMPLOYEE
GROUP BY DEPT_CODE
HAVING SUM(SALARY) > 15000000;

-- ���� 4 �������� ����
CREATE TABLE QUIZE4(
    QNO NUMBER PRIMARY KEY,
    QNAME VARCHAR2(10),
    SCORE NUMBER
);

INSERT INTO QUIZE4 VALUES(1,'����1��',30);
INSERT INTO QUIZE4 VALUES(1,'����2��',50); -- ������ �߻��� �� ������ ������? PRIMARY KEY����������

-- JOIN => DECODE
-- J7�� ����� �޿��� 10% 
-- J6�� ����� �޿��� 15% �λ��Ѵ�.
SELECT EMP_NAME, JOB_CODE, SALARY,
DECODE(JOB_CODE,'J7',SALARY*1.1,'J6',SALARY*1.15,'J5',SALARY*1.2,SALARY*1.05) AS "�λ�� �޿�" -- ����Ʈ�� �׳� �������� ���� �ظ��� ��
FROM EMPLOYEE;

--'21/09/28' ���ڿ��� '2021-09-28'�� �ٲٴ°�.
-- '210908' �� 2021�� 9�� 8�� FM���

-- �ʱް����� �߱ް����� CASE WHEN THEN���� ����
--SELECT CASE WHEN SALARY > 15000 THEN '��ް�����' 
SELECT * FROM EMPLOYEE;
SELECT EMP_ID, EMP_NAME, CASE WHEN SALARY >6000000 THEN '��� ������'
WHEN SALARY >4000000 THEN '�߱ް�����'
ELSE '�ʱ� ������'
END
FROM EMPLOYEE;


/*
    1. DBMS�� ����?
    - �����ͺ��̽��� �����ϰ� ��ϴ� �ý���
    2. DDL�� ����? �װ� ����?
    - CREATE ��ü�� �����Ѵ�. ALTER ��ü�� �����Ѵ�. DROP ��ü�� �����Ѵ�.
    3. NUMBER �ڷ����� �� �� �� �ִ���? ����, �Ǽ�  ���� �ٰ���.
    - 
    4. CHAR(10) �ǹ�
    5. INNER JOIN : �����̺� ���� �����Ͱ� �־�� �����°�.
    -�����Ű�� �÷��� ���� ��ġ�ϴ� ��鸸 ���εǼ� ��ȸ -> ��ġ�ϴ� ���� ���� ���� ��ȸ���� ����
    6. OUTER JOIN: �����Ͱ� NULL�̶� ������ ��.
    -�� ���̺��� ���ν� ��ġ���� �ʴ� �൵ ���Խ��Ѽ� ��ȸ ����
    ��, �ݵ�� LEFT/RIGHT ���� �ؾߵ�!!!(������ �Ǵ� ���̺� ����)
    7. SUBSTR: ���ڿ� �����ϴ� ��.
    8. ���̺�? �����͸� ǥ�� ���·� ǥ���� ��.
    9. RESULTSET? SELECT �� ����� ǥ�� ���·� ǥ���ؼ� �����ִ� ��.
    10. UPPER() �빮�ڷ� �ٲٴ� ��
    11. MINUS, INTERSECT �ǹ̴�? 
    12. INITCAP: ù���ڸ� �빮�ڷ� �ٲ��ִ� �Լ�
    13. TRIM(): �翷�� ������ �������� ����� ���� ����.
    14. UNION, UNIONALL ����? ���Ͽ��� �ߺ����� �ȳ����� ���� �ߺ����� ���´�.
     < ���� ������ == SET OPERATION >
    
    �������� �������� ������ �ϳ��� ���������� ����� ������
    
    - UNION     : (OR����)������ (�� �������� ������ ������� ���� �� �ߺ��Ǵ� ���� �ѹ��� ����������)
    - INTERSECT : (AND����)������(�� ������ ������ ��� ���� �ߺ��� �����)
    - UNION ALL : ������ + ������(�ߺ��Ǵ� �κ��� 2�� ǥ���� �� ����)
    - MINUS     : ������(���� ������� ���� ������� �� ������)

    15. DECODE : ����� �Լ���  
    16. CONCAT() >=> ||
    17. ROLLUP()? �����Լ��� �׷��Լ��� ����� �������� �հ踦 ���ϱ� ���� �Լ�
    18. RANK OVER(), DENSE_RANK OVER() ������
    * ���� �ű�� �Լ�(WINDOW FUNCTION)
    RANK() OVER(���ı���)  |  DENSE_RANK() OVER(���ı���)
    
    - RANK() OVER(���ı���): ������ ���� ������ ����� ������ �ο��� ��ŭ �ǳʶٰ� ���� ���
                            EX) ���� 1���� 2�� �״��� ���� 3�� 
    
    - DENSE_RANK() OVER(���ı���) : ������ ������ �ִٰ� �ص� �� ���� ����� ������ 1�� ������Ŵ
                                  EX) ���� 1���� 2���̶� �� ���� ������ 2���� ��
    >> �� �Լ��� ������ SELECT�������� ��� ����!!!
*/

































