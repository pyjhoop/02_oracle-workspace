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
--1. AND�� OR���� �켱������ ���⿡ ���ڵ尡 �߸� ����
--2. BONUS�� �ִ°Ÿ� IS NOT NULL
--3. EMAIL���� _�� ���ϵ� ī���̱⿡ ___$_ ESCAPE '$'�� ���� ������ ���ϵ� ī�带 ����������.
--4. ������ ������ ã������ ����.
--5. SALARY�� 2000000�̻����� �ٲ������.

--��������:
SELECT EMP_NAME, EMP_NO, JOB_CODE, DEPT_CODE, SALARY, BONUS
FROM EMPLOYEE
WHERE (JOB_CODE = 'J7' OR JOB_CODE = 'J6') AND SALARY >= 2000000
AND BONUS IS NOT NULL AND EMAIL LIKE '___$_%' ESCAPE '$'
AND SUBSTR(EMP_NO,8,1) = '2';

SELECT EMP_NAME, EMP_NO, JOB_CODE, DEPT_CODE, SALARY, BONUS
FROM EMPLOYEE
WHERE JOB_CODE IN('J7','J6') AND SALARY >= 2000000
AND BONUS IS NOT NULL AND EMAIL LIKE '___$_%' ESCAPE '$'
AND SUBSTR(EMP_NO,8,1) = '2';




SELECT EMP_NAME, EMP_NO, JOB_CODE, DEPT_CODE, SALARY, BONUS
FROM EMPLOYEE;





