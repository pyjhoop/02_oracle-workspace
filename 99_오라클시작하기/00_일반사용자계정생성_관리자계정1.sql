SELECT *
FROM EMPLOYEE;

SELECT EMP_ID, EMP_NAME, SALARY
FROM EMPLOYEE;

SELECT *
FROM JOB;

SELECT JOB_NAME
FROM JOB;

SELECT *
FROM department;

SELECT EMP_NAME, EMAIL, PHONE, HIRE_DATE, SALARY
FROM EMPLOYEE;

SELECT EMP_NAME, SALARY*12
FROM EMPLOYEE;

--1. JOB ���̺��� ���޸� ��ȸ

--2. DEPARTMENT ���̺��� ��� �÷� ��ȸ

--3. DEPARTMENT ���̺��� �μ��ڵ�, �μ��� ��ȸ

--4. EMPLOYEE ���̺��� �����, �̸���, ��ȭ��ȣ, �Ի���, �޿� ��ȸ

--EMPLOYEE ���̺��� �����, ����� ����(�޿�*12) ��ȸ

--EMPLOYEE ���̺��� �����, �޿�, ���ʽ� ��ȸ


--EMPLOYEE ���̺��� �����, �޿�, ���ʽ�, ����, ���ʽ��� ���Ե� ����(�޿�+���ʽ�*�޿�)*12 ��ȸ
-- > ������� ���� �� NULL���� ������ ��� ��������� ����� ������ ������ NULL�� ����

-- EMPLOYEE ���̺��� �����, �Ի��� ��ȸ


--EMPLOYEE ���̺��� �����, �Ի���, �ٹ��ϼ�(���ó�¥ -�Ի���)
--���� ��¥ : SYSDATE

--EMPLOYEE ���̺��� �����, �޿�, ����, ���ʽ��� ���Ե� ����(�޿�+���ʽ�*�޿�)*12 ��ȸ


--���, �̸�, �޿��� �ϳ��� �÷����� ��ȸ

--�÷����� ���ͷ��� ���� 
-- XXX�� ������ XXX�� �Դϴ�. ��Ī : �޿�����