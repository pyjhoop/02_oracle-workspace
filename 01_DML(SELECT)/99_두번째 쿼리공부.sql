-- ���� ����
---------------------------------QUIZ 1------------------------------------------
-- ROWNUM�� Ȱ���ؼ� �޿��� ���� ���� 5���� ��ȸ�ϰ� �;�����, ����� ��ȸ�� �ȵ���!!
-- �̶� �ۼ��� SQL���� �Ʒ��� ����.
SELECT ROWNUM, EMP_NAME, SALARY
FROM EMPLOYEE
WHERE ROWNUM <= 5
ORDER BY SALARY DESC;

-- � �������� �ִ���, �ذ�� SQL�� �ۼ�
--1. ORDER BY �� ���� �������� ����Ǳ⿡ ROWNUM�� ������ ����
--2. ���� ������ �����ϰ� �״��� ROWNUM�� �����ؾ���.

SELECT ROWNUM, E.*
FROM (SELECT EMP_NAME, SALARY
      FROM EMPLOYEE
      ORDER BY 2 DESC) E
WHERE ROWNUM <=5;
---------------------------------QUIZ 2------------------------------------------
-- �μ��� ��� �޿��� 270������ �ʰ��ϴ� �μ��鿡 ���� (�μ��ڵ�, �μ��� �ѱ޿���, �μ��� ��ձ޿�, �μ��� �����)
-- �̶� �ۼ��� SQL���� �Ʒ��� ����.
SELECT DEPT_CODE, SUM(SALARY) ����, FLOOR(AVG(SALARY)) ���, COUNT(*) �ο���
FROM EMPLOYEE
WHERE SALARY >2700000
GROUP BY DEPT_CODE
ORDER BY 1;

--� �������� �ִ���, �ذ�� SQL���ۼ�
-- �μ��� ��� �޿��� 270���� �ʰ��ε� WHERE���� ����� �޿��� 270���� �ʰ���� ���ǽ��� �����.
-- ���ǽ��� HAVING���� �־����.

SELECT DEPT_CODE, SUM(SALARY) ����, FLOOR(AVG(SALARY)) ���, COUNT(*) �ο���
FROM EMPLOYEE
GROUP BY DEPT_CODE
HAVING AVG(SALARY) > 2700000
ORDER BY 1;





