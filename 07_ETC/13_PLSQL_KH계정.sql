--����
/*
    < PL / SQL >
    PROCEDURE LANGUAGE EXTENSION TO SQL
    
    ����Ŭ ��ü�� ����Ǿ��ִ� ������ ���
    SQL ���峻���� ������ ����, ����ó��(IF), �ݺ�ó��(LOOP,FOR,WHILE) �����Ͽ� SQL�� ������ ����
    �ټ��� SQL���� �ѹ��� ���� ����(BLOCK ����) + ����ó���� ����
    
    * PL / SQL ����
    - [�����] : DECLARE�� ����, ������ ����� ���� �� �ʱ�ȭ �ϴ� �κ�
    - �����   : BEGIN���� ����, ������ �־����!! SQL�� �Ǵ� ���(���ǹ�, �ݺ���) ���� ������ ����ϴ� �κ�
    - [����ó����] : EXCEPTION���� ����, ���� �߻��� �ذ��ϱ� ���� ������ �̸� ����ص� �� �ִ� ����
*/
-- �����ϰ� ȭ�鿡 HELLO ORACLE ���!
SET SERVEROUTPUT ON;

BEGIN 
-- System.out.prinln("hello oracle");
    DBMS_OUTPUT.PUT_LINE('HELLO ORACLE');
END;
/
-- /�� �Ἥ ���� �ϳ� �����ٴ� ���� �˷��� PLSQL�� �������� ������.

-------------------------------------------------------------------------------
/*
    1. DECLARE �����
    ���� �� ��� �����ϴ� ���� (����� ���ÿ� �ʱ�ȭ�� ����)
    �Ϲ�Ÿ�Ժ���, ���۷���Ÿ�Ժ���, ROWŸ�Ժ���
    
    1_1. �Ϲ�Ÿ�Ժ��� ���� �� �ʱ�ȭ
         [ǥ����] ������[CONSTANT -> ����� ��] �ڷ��� [:= ��];
*/

DECLARE 
    EID NUMBER;
    ENAME VARCHAR2(20);
    PI CONSTANT NUMBER := 3.14;
BEGIN
    --EID := 800;
   -- ENAME := '���峲';
    EID := &��ȣ;
    ENAME :='&�̸�';
    
    DBMS_OUTPUT.PUT_LINE('EID : '|| EID);
    DBMS_OUTPUT.PUT_LINE('ENAME : '|| ENAME);
    DBMS_OUTPUT.PUT_LINE('PI : ' || PI);
END;
/
--------------------------------------------------------------------------------
-- 1_2) ���۷��� Ÿ�� ���� ���� �� �ʱ�ȭ(� ���̺��� � �÷��� ������ Ÿ���� �����ؼ� �� Ÿ������ ����)
-- [ǥ����] ������ ���̺��.�÷���%TYPE;

DECLARE
    EID EMPLOYEE.EMP_ID%TYPE;
    ENAME EMPLOYEE.EMP_NAME%TYPE;
    SAL EMPLOYEE.SALARY%TYPE;
BEGIN
--    EID := '300';
--    ENAME := '�ڿ���';
--    SAL := 3000000;

--  ����� 200���� ����� ���, �����, �޿� ��ȸ�ؼ� �� ������ ����
    SELECT EMP_ID, EMP_NAME, SALARY
    INTO EID, ENAME, SAL
    FROM EMPLOYEE
    --WHERE EMP_ID = 201;
    WHERE EMP_ID = &���;
    
    DBMS_OUTPUT.PUT_LINE('EID : '||EID);
    DBMS_OUTPUT.PUT_LINE('ENAME : '||ENAME);
    DBMS_OUTPUT.PUT_LINE('SAL : '||SAL);
END;
/

----------------------------------�ǽ�����------------------------------------------
/*
    ���۷���Ÿ�� ������ EID, ENAME, JCODE, SAL, DTITLE�� �����ϰ� 
    �� �ڷ����� EMPLOYEE, DEPARTMENT ���̺��� �����ϵ���
    
    ����ڰ� �Է��� ����� ����� ���, �����, �����ڵ�, �޿�, �μ��� ��ȸ ����  �������� ��Ƽ� ���
*/
-- �Ϲ� Ÿ�� ���� EID NUMBER; OR EID NUMBER := 201;
-- ���۷���Ÿ�� ���� ���� : EID EMPLOYEE.EMP_ID%TYPE;
-- ����ο��� �Է��� �ް� ������ EID = &���;



DECLARE
    EID EMPLOYEE.EMP_ID%TYPE;
    ENAME EMPLOYEE.EMP_NAME%TYPE;
    JCODE EMPLOYEE.JOB_CODE%TYPE;
    SAL EMPLOYEE.SALARY%TYPE;
    DTITLE DEPARTMENT.DEPT_TITLE%TYPE;
BEGIN
    SELECT EMP_ID, EMP_NAME, JOB_CODE, SALARY, DEPT_TITLE
    INTO EID, ENAME, JCODE, SAL, DTITLE
    FROM EMPLOYEE
    JOIN DEPARTMENT ON(DEPT_ID = DEPT_CODE)
    WHERE EMP_ID = &���;
    
    DBMS_OUTPUT.PUT_LINE('��� : '||EID);
    DBMS_OUTPUT.PUT_LINE('����� : '|| ENAME);
    DBMS_OUTPUT.PUT_LINE('�����ڵ� : ' || JCODE);
    DBMS_OUTPUT.PUT_LINE('�޿� : ' || SAL);
    DBMS_OUTPUT.PUT_LINE('�μ��� : ' || DTITLE);
END;
/
------------------------------------------------------------------------------
-- 1_3) ROWŸ�� ���� ����
-- ���̺��� �� �࿡ ���� ��� �÷����� �Ѳ����� ���� �� �ִ� ����
-- [ǥ����] ������ ���̺��%ROWTYPE
-- ������ * �� ��ü���� ��ȸ�ؾ���.

DECLARE
    E EMPLOYEE%ROWTYPE;
BEGIN
    SELECT *  -- ��� �÷��� �ش��ϴ� ���� �־����
    INTO E
    FROM EMPLOYEE
    WHERE EMP_ID = &���;
    
--    DBMS_OUTPUT.PUT_LINE(E); 
    DBMS_OUTPUT.PUT_LINE('����� : ' || E.EMP_NAME);
    DBMS_OUTPUT.PUT_LINE('�޿� : ' || E.SALARY);
    DBMS_OUTPUT.PUT_LINE('���ʽ� : ' || NVL(E.BONUS,0));
END;
/
----------------------------------------------------------------------------------
/*
    2. BEGIN �����
*/

-- < ���ǹ� > ���� PL SQL�� ���̾���.
-- 1) IF ���ǽ� THEN ���೻�� END IF; �ܵ� IF��

-- ����� �Է¹��� �� �ش� ����� ���, �̸�, �޿�, ���ʽ���(%) ���
-- ��, ���ʽ��� ���� �ʴ� ����� ���ʽ����� ����ϱ� ���� '���ʽ��� ���޹��� �ʴ� ����Դϴ�. '���
DECLARE
    EID EMPLOYEE.EMP_ID%TYPE;
    ENAME EMPLOYEE.EMP_NAME%TYPE;
    SAL EMPLOYEE.SALARY%TYPE;
    BONUS EMPLOYEE.BONUS%TYPE;
BEGIN
    SELECT EMP_ID, EMP_NAME, SALARY, NVL(BONUS,0)
    INTO EID, ENAME, SAL, BONUS
    FROM EMPLOYEE
    WHERE EMP_ID = &���;
    
    DBMS_OUTPUT.PUT_LINE('��� : '||EID);
    DBMS_OUTPUT.PUT_LINE('�̸� : '||ENAME);
    DBMS_OUTPUT.PUT_LINE('�޿� : '||SAL);

    IF BONUS = 0
        THEN DBMS_OUTPUT.PUT_LINE('���ʽ��� ���޹��� �ʴ� ����Դϴ�.');
    END IF;
    
    DBMS_OUTPUT.PUT_LINE('���ʽ���(%) : ' || BONUS*100 ||'%');
    
END;
/

--2. IF ���ǽ� THEN ���೻�� ELSE ���೻�� END IF;(IF - ELSE��)
DECLARE
    EID EMPLOYEE.EMP_ID%TYPE;
    ENAME EMPLOYEE.EMP_NAME%TYPE;
    SAL EMPLOYEE.SALARY%TYPE;
    BONUS EMPLOYEE.BONUS%TYPE;
BEGIN
    SELECT EMP_ID, EMP_NAME, SALARY, NVL(BONUS,0)
    INTO EID, ENAME, SAL, BONUS
    FROM EMPLOYEE
    WHERE EMP_ID = &���;
    
    DBMS_OUTPUT.PUT_LINE('��� : '||EID);
    DBMS_OUTPUT.PUT_LINE('�̸� : '||ENAME);
    DBMS_OUTPUT.PUT_LINE('�޿� : '||SAL);

    IF BONUS = 0
        THEN DBMS_OUTPUT.PUT_LINE('���ʽ��� ���޹��� �ʴ� ����Դϴ�.');
    ELSE
        DBMS_OUTPUT.PUT_LINE('���ʽ���(%) : ' || BONUS*100 ||'%');
    END IF;   
END;
/

-------------------------------�ǽ�����-------------------------------------------
-- ���۷���Ÿ�� ���� EID, ENAME, DTITLE, NCODE
-- ������ ���̺� EMPLOYEE, DEPARTMENT, LOCATION

-- �Ϲ�Ÿ�� ���� TEAM ������(10) <= ������ �Ǵ� �ؿ��� ���� ����
-- ����ڰ� �Է��� ����� ���, �̸�, �μ���, �ٹ� ���� �ڵ� ��ȸ �� �� ������ ����
-- NCODE���� KO�� ��� TEAM�� ������ 
-- �ƴ� ��� �ؿ����� �ֱ�
-- ���, �̸�, �μ�, �Ҽ�(������, �ؿ���)�� ���� ���

DECLARE
    EID EMPLOYEE.EMP_ID%TYPE;
    ENAME EMPLOYEE.EMP_NAME%TYPE;
    DTITLE DEPARTMENT.DEPT_TITLE%TYPE;
    NCODE LOCATION.NATIONAL_CODE%TYPE;
    TEAM VARCHAR2(10);
BEGIN
    SELECT EMP_ID, EMP_NAME, DEPT_TITLE, NATIONAL_CODE
    INTO EID, ENAME, DTITLE, NCODE
    FROM EMPLOYEE
    JOIN DEPARTMENT ON(DEPT_ID = DEPT_CODE)
    JOIN LOCATION ON(LOCAL_CODE = LOCATION_ID)
    WHERE EMP_ID = &���;
    
    IF NCODE = 'KO'
        THEN TEAM:= '������';
    ELSE
        TEAM:='�ؿ���';
    END IF;
    
    DBMS_OUTPUT.PUT_LINE('��� : ' || EID);
    DBMS_OUTPUT.PUT_LINE('�̸� : '|| ENAME);
    DBMS_OUTPUT.PUT_LINE('�μ� :'|| DTITLE );
    DBMS_OUTPUT.PUT_LINE('�Ҽ� : '|| TEAM);
    
END;
/

------------------------------------�ǽ�����----------------------------------------
--1. ����� ������ ���ϴ� PL/SQL ���� �ۼ� ���࿡ ���ʽ��� ���� �� ���ʽ��� �����Ͽ� ��� : ��� �Է¹���.
-- ���ʽ��� ������ ���ʽ� ������ ������ ����
-- ���ʽ� ������ ���ʽ� ���� ����
-- ��� �޿�, �̸� ���޷�\999,999,999()
-- ROWTYPE

DECLARE
    E EMPLOYEE%ROWTYPE;
BEGIN
    SELECT *
    INTO E
    FROM EMPLOYEE
    WHERE EMP_ID = &���;
    
    IF E.BONUS IS NOT NULL
        THEN DBMS_OUTPUT.PUT_LINE('�޿� : '||E.SALARY||'  �̸� : '||E.EMP_NAME||'  ���� : '||LTRIM(TO_CHAR((E.SALARY +E.SALARY * E.BONUS)*12,'L999,999,999')));
    ELSE
         DBMS_OUTPUT.PUT_LINE('�޿� : '||E.SALARY||'  �̸� : '||E.EMP_NAME||'  ���� : '||LTRIM(TO_CHAR(E.SALARY *12,'L999,999,999')));
    END IF;
    -- �̹�� ���� ���� ������ ���� ��¹� �ϳ��� ó���غ���
END;
/

--------------------------------------------------------------------------------
-- 3. IF ���ǽ�1 THEN ���೻��1 ELSIF ���ǽ�2 THEN ���೻��2 ELSE ....END IF;(IF - ELSIF - ELSE)
-- ������ �Է¹޾Ƽ� SCORE ������ ����
-- 90�� �̻� 'A', 80���̻� 'B' 70�̻� 'C' 60�� �̻� 'D' �׹̸��� F
-- GRADE�� �����ϰ� ����� ������ XX���̰�, ������ X�����Դϴ�.

DECLARE
    GRADE VARCHAR2(1);
    SCORE NUMBER;
BEGIN
    SCORE := &����;
    
    IF SCORE >= 90 THEN GRADE := 'A';
    ELSIF SCORE >= 80 THEN GRADE := 'B';
    ELSIF SCORE >= 70 THEN GRADE := 'C';
    ELSIF SCORE >= 60 THEN GRADE := 'D';
    ELSE GRADE := 'F';
    END IF;
    
    DBMS_OUTPUT.PUT_LINE('����� ������ '||SCORE||'���̰�, ������ '||GRADE||'�����Դϴ�.');
    
END;
/


-- �޿�
-- 500���� �̻� '���'
-- 300���� �̻� '�߱�'
-- 300 �̸� '�ʱ�'
-- �ش� ����� �޿������ XX�Դϴ�.

DECLARE
    SAL EMPLOYEE.SALARY%TYPE;
    GRADE VARCHAR2(10);
BEGIN
    SELECT SALARY 
    INTO SAL
    FROM EMPLOYEE
    WHERE EMP_ID = &���;
    
    IF SAL> 5000000 THEN GRADE := '���';
    ELSIF SAL> 3000000 THEN GRADE:= '�߱�';
    ELSE GRADE:= '�ʱ�';
    END IF;
    
    DBMS_OUTPUT.PUT_LINE('�ش� ����� �޿������ '||GRADE||'�Դϴ�.');

END;
/
--------------------------------------------------------------------------------
--4. CASE �񱳴���� WHEN ������Ұ�1 THEN �����1 WHEN ������Ұ�2 THEN �����2..... ELSE ����� END;
-- SWITCH CASE�� ����� ������ �Ѵ�.

DECLARE
    EMP EMPLOYEE%ROWTYPE;
    DNAME VARCHAR2(30); -- �μ��� �����ϴ� ����
BEGIN
    SELECT *
    INTO EMP
    FROM EMPLOYEE
    WHERE EMP_ID = &���;
    
    DNAME := CASE EMP.DEPT_CODE 
                WHEN 'D1' THEN '�λ���'
                WHEN 'D2' THEN 'ȸ����'
                WHEN 'D3' THEN '��������'
                WHEN 'D4' THEN '����������'
                WHEN 'D9' THEN '�ѹ���'
                ELSE '�ؿܿ�����'
                END;
                
    DBMS_OUTPUT.PUT_LINE(EMP.EMP_NAME||'��(��) '||DNAME||'�Դϴ�.');

END;
/
--------------------------------------------------------------------------------
SET SERVEROUTPUT ON;

---- < �ݺ��� > 
/*
    1. BASIC LOOP�� 
    
    [ǥ����]
    LOOP
        �ݺ������� ������ ����
        * �ݺ����� �������� �� �ִ� ����
    END LOOP;
    
    * �ݺ��� �������� �� �ִ� ����(2����)
    1) IF ���ǽ� THEN EXIT;
    2) EXIT WHEN ���ǽ�;
    �������� ������ �����߻���.
*/

-- 1~5���� ���������� 1�� �����ؼ� ���
DECLARE
    I NUMBER := 1;
BEGIN
    LOOP
        DBMS_OUTPUT.PUT_LINE(I);
        I:=I+1;
--        IF I = 6 THEN EXIT; END IF;
        EXIT WHEN I = 6;
    END LOOP;
END;
/

--------------------------------------------------------------------------------
/*
    2) FOR LOOP��
    
    [ǥ����]
    FOR ���� IN [REVERSE -> ���� ���� �۾����� �ϰ� ������] �ʱⰪ..������
    LOOP
        �ݺ������� ������ ����;
    END LOOP;
    
    REVERSE �ص� ������..ū��
*/

BEGIN
    FOR I IN 1..5
    LOOP
        DBMS_OUTPUT.PUT_LINE(I);
    END LOOP;
END;
/

BEGIN
    FOR I IN REVERSE 1..5
    LOOP
        DBMS_OUTPUT.PUT_LINE(I);
    END LOOP;
END;
/

SELECT * FROM TEST;

CREATE TABLE TEST(
    TNO NUMBER PRIMARY KEY,
    TDATE DATE
);

SELECT * FROM TEST;
CREATE SEQUENCE SEQ_TNO
START WITH 1
INCREMENT BY 2
MAXVALUE 1000
NOCYCLE
NOCACHE;

BEGIN
    FOR I IN 1..100 -- �⺻������ 1�� ����.
    LOOP
        INSERT INTO TEST VALUES(SEQ_TNO.NEXTVAL, SYSDATE);
    END LOOP;

END;
/

SELECT * FROM TEST;

--------------------------------------------------------------------------------
/*
    3) WHILE LOOP��
    [ǥ����]
    WHILE �ݺ����� ����� ����
    LOOP
        �ݺ������� ����
    END LOOP;
*/

DECLARE
    I NUMBER := 1;
BEGIN
    WHILE I <6
    LOOP
        DBMS_OUTPUT.PUT_LINE(I);
        I := I+1;
    END LOOP;
END;
/
--------------------------------------------------------------------------------
/*
    3. ����ó����
    
    ����(EXCEPTION) : ���� �� �߻��ϴ� ����
    
    [ǥ����]
    EXCEPTION
        WHEN ���ܸ�1 THEN ����ó������1;
        WHEN ���ܸ�2 THEN ����ó������2;
        ......
        WHEN OTHERS THEN ����ó������N; ��� ���ܸ� �޴°��� OTHERS
        
        * ���ܸ� �� ����ұ�?
        * �ý��� ���� (����Ŭ���� �̸� �����ص� ����)
        - NO_DATA_FOUND : SELECT �ߴµ� ����� �� �൵ ���� ���
        - TOO_MANY_ROWS : SELECT �� ����� �������� ���
        - ZERO_DIVIDE : 0���� ���� ��
        - DUP_VAL_ON_INDEX: UNIQUE�������ǿ� ���� ���� ���
        ...
*/
-- ����ڰ� �Է��� ���� ������ ������ ��� ���
DECLARE
    RESULT NUMBER;
BEGIN
    RESULT := 10/&����;
    DBMS_OUTPUT.PUT_LINE('��� : ' || RESULT);
    
EXCEPTION
--    WHEN ZERO_DIVIDE THEN DBMS_OUTPUT.PUT_LINE('������ ����� 0���� ������ ����.');
    WHEN OTHERS THEN DBMS_OUTPUT.PUT_LINE('������ ����� 0���� ������ ����.');

END;
/

-- UNIQUE �������� ����
BEGIN
    UPDATE EMPLOYEE
        SET EMP_ID = '&�����һ��' --���ڿ��� '' �ٿ�����
    WHERE EMP_NAME = '���ö';
    
EXCEPTION
    WHEN DUP_VAL_ON_INDEX THEN DBMS_OUTPUT.PUT_LINE('�̹� �����ϴ� ����Դϴ�.');

END;
/

DECLARE
    EID EMPLOYEE.EMP_ID%TYPE;
    ENAME EMPLOYEE.EMP_NAME%TYPE;
BEGIN
    SELECT EMP_ID, EMP_NAME
    INTO EID, ENAME
    FROM EMPLOYEE
    WHERE MANAGER_ID = &������;
    
    DBMS_OUTPUT.PUT_LINE('��� : ' || EID);
    DBMS_OUTPUT.PUT_LINE('�̸� : ' || ENAME);
    
EXCEPTION
    WHEN TOO_MANY_ROWS THEN DBMS_OUTPUT.PUT_LINE('�ʹ� ���� ���� ��ȸ�ƽ��ϴ�.');
    WHEN NO_DATA_FOUND THEN DBMS_OUTPUT.PUT_LINE('�ش� ����� ���� ����� �����ϴ�.');

END;
/
















