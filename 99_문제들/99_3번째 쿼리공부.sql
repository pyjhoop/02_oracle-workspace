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













