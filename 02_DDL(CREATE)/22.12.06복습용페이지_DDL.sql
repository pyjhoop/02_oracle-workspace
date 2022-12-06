--22-12-06 ������ ������
CREATE TABLE MEM_GRADE(
    GRADE_CODE NUMBER PRIMARY KEY,
    GRADE_NAME VARCHAR2(30) NOT NULL
);
INSERT INTO MEM_GRADE VALUES(10,'�Ϲ�ȸ��');
INSERT INTO MEM_GRADE VALUES(20,'���ȸ��');
INSERT INTO MEM_GRADE VALUES(30,'Ư��ȸ��');


-- FOREIGN KEY(�ܷ�Ű) ��������
-- ���� : �ٸ� ���̺� �����ϴ� ���� ���;� �Ǵ� Ư�� �÷��� �ο��ϴ� ���� ����

-- �÷��������
--> �÷��� �ڷ���[CONSTRAINT �������Ǹ�] REFERENCES ���������̺��[(������ �÷���)]
-- ���̺������
-->[CONSTRAINT] FOREIGN KEY(�÷���) REFERENCES ���������̺��[(������ �÷���)]

CREATE TABLE MEM(
    MEM_NO NUMBER PRIMARY KEY,
    MEM_ID VARCHAR2(20) NOT NULL UNIQUE,
    MEM_PWD VARCHAR2(20) NOT NULL,
    MEM_NAME VARCHAR2(20) NOT NULL,
    GENDER CHAR(3) CHECK(GENDER IN ('��','��')),
    PHONE VARCHAR2(13),
    EMAIL VARCHAR2(50),
    GRADE_ID NUMBER REFERENCES MEM_GRADE(GRADE_CODE)
    -- FOREIGN KEY(GRADE_ID) REFERENCES MEM_GRADE(GRADE_CODE)
);

INSERT INTO MEM
VALUES(1,'user01','pass02','�����','��',null,null,null);
INSERT INTO MEM
VALUES(2,'user02','pass02','Ȳ����',null,null,null,10);

INSERT INTO MEM
VALUES(3,'user03','pass03','�̰���',null,null,null,40);
--ORA-02291: integrity constraint (DDL.SYS_C007115) violated - parent key not found
-- PARENT���Դ�? �ܷ�Ű�� ������ �����.
INSERT INTO MEM
VALUES(3,'user03','pass03','�̰���',null,null,null,20);
INSERT INTO MEM
VALUES(4,'user04','pass04','�̽���',null,null,null,10);

-- �ܷ�Ű�� �θ�� �ڽ� ���踦 �ξ��µ� �θ��� �����͸� �����ϸ� ��� �ɱ�?
-- �ڽ����̺��� �θ��� ����ϰ������� ���� ��ü�� �ȵ�
-- �������� �ɼ��� �ɷ�����.

-- �׷� MEM_GRADE���� CODE 10�� �����غ���
DELETE FROM MEM_GRADE
WHERE GRADE_CODE = '10';
--ORA-02292: integrity constraint (DDL.SYS_C007115) violated - child record found
-- �ܷ�Ű�� ���Ǳ⿡ ������ �� ����.
--��, �������� �ɼ��� �ɷ�����.

DELETE FROM MEM_GRADE
WHERE GRADE_CODE = '30';
ROLLBACK;
SELECT * FROM MEM_GRADE;

/*
    �ڽ� ���̺� ������ �ܷ�Ű �������� �ο��� �� �����ɼ� ��������
    * �����ɼ� : �θ����̺��� ������ ������ �� �����͸� ����ϰ� �ִ� �ڽ� ���̺��� ����
                ��� ó���Ұ���
    - ON DELETE RESTRICTED(�⺻��) : �������� �ɼ�����, �ڽ� �����ͷ� ���̴� �θ����ʹ� ������ �ƿ��ȵǰԲ�!!
    - ON DELETE SET NULL : �θ����� ������ �ش� �����͸� ���� �ִ� �ڽĵ������� ���� NULL�� ����
    - ON DELETE CASCADE : �θ����� ������ �ش� �����͸� �����ִ� �ڽĵ����͵� ���� ����
*/

DROP TABLE MEM;
-- ON SELETE SET NULL�� �ٲ㼭 ���̺��� ������
CREATE TABLE MEM(
    MEM_NO NUMBER PRIMARY KEY,
    MEM_ID VARCHAR2(20) NOT NULL UNIQUE,
    MEM_PWD VARCHAR2(20) NOT NULL,
    MEM_NAME VARCHAR2(20) NOT NULL,
    GENDER CHAR(3) CHECK(GENDER IN ('��','��')),
    PHONE VARCHAR2(13),
    EMAIL VARCHAR2(50),
    GRADE_ID NUMBER REFERENCES MEM_GRADE(GRADE_CODE) ON DELETE SET NULL
);
INSERT INTO MEM 
VALUES(1,'user01','pass02','�����','��',null,null,null);

INSERT INTO MEM
VALUES(2,'user02','pass02','Ȳ����',null,null,null,10);

INSERT INTO MEM
VALUES(3,'user03','pass03','�̰���',null,null,null,20);

INSERT INTO MEM
VALUES(4,'user04','pass04','�̽���',null,null,null,10);

SELECT * FROM MEM;

--���⼭ �ܷ�Ű�� ����� �θ�Ű�� �����غ��ڴ�.
DELETE FROM MEM_GRADE
WHERE GRADE_CODE = '10';
SELECT * FROM MEM_GRADE;
INSERT INTO MEM_GRADE VALUES(10,'�Ϲ�ȸ��');

DROP TABLE MEM;
ROLLBACK;

-- ON DELETE CASCDE�� �ٲ㼭 ���̺��� ������.
CREATE TABLE MEM(
    MEM_NO NUMBER PRIMARY KEY,
    MEM_ID VARCHAR2(20) NOT NULL UNIQUE,
    MEM_PWD VARCHAR2(20) NOT NULL,
    MEM_NAME VARCHAR2(20) NOT NULL,
    GENDER CHAR(3) CHECK(GENDER IN ('��','��')),
    PHONE VARCHAR2(13),
    EMAIL VARCHAR2(50),
    GRADE_ID NUMBER REFERENCES MEM_GRADE(GRADE_CODE) ON DELETE CASCADE
);
INSERT INTO MEM 
VALUES(1,'user01','pass02','�����','��',null,null,null);

INSERT INTO MEM
VALUES(2,'user02','pass02','Ȳ����',null,null,null,10);

INSERT INTO MEM
VALUES(3,'user03','pass03','�̰���',null,null,null,20);

INSERT INTO MEM
VALUES(4,'user04','pass04','�̽���',null,null,null,10);

SELECT * FROM MEM_GRADE;
SELECT * FROM MEM;
DELETE FROM MEM_GRADE
WHERE GRADE_CODE = '10';

SELECT * FROM MEM;


/*
    < DEFAULT >
    �÷��� �������� �ʰ� INSERT�� NULL�� �ƴ� �ٸ����� �⺻������ ����
    ���̺� ������ ����
    �÷��� �ڷ�� DEFAULT '�⺻��' �������� ....
    �׻� DEFAULT�� �������� ���� �տ� �־�� �Ѵ�.
    
*/
DROP TABLE MEMBER;

CREATE TABLE MEMBER(
    MEM_NO NUMBER PRIMARY KEY,
    MEM_NAME VARCHAR2(20) NOT NULL,
    MEM_AGE NUMBER,
    HOBBY VARCHAR2(20) DEFAULT '����',
    ENROLL_DATE DATE DEFAULT SYSDATE
);

INSERT INTO MEMBER VALUES(1,'�����',20,'�౸','19/12/13');
INSERT INTO MEMBER VALUES(2,'Ȳ����',NULL,NULL,NULL);
INSERT INTO MEMBER VALUES(3,'�̰���',NULL,DEFAULT,DEFAULT);
-- �̷��� DEFAULT�� ����ҰŸ� ����? ����� �ʿ䰡 ������
-- �̷���쿡 ����.
INSERT INTO MEMBER(MEM_NO, MEM_NAME) VALUES(4,'�̽���');

/*
========KH����==============
    ���������� �̿��� ���̺� ����
    
    [ǥ����]
    CREATE TABLE ���̺��
    AS ��������;
    
    ������ NOT NULL�� ������ ���������� ����ȵǰ�,
    DEFAULT���� ���簡 �ȵȴ�. 
    => ���Ŀ� �߰��ϴ� ����� ����.
    
    ���̺� ������
    1. ��ü ���� �����ϱ�
    2. ���̺� ������ �������� �ʹ�.
    3. ���̺��� Ư�� �÷��� ����� �Ǵ� �Լ����� ��������ʹ�.
*/
CREATE TABLE EMPLOYEE_COPY
AS SELECT *
    FROM EMPLOYEE;

SELECT * FROM EMPLOYEE_COPY;
-- NOT NULL�� ������ �������ǵ��� �� �����
-- DEFAULT ���� �����

--2. �÷��� �������� �ʹ�.
CREATE TABLE EMPLOYEE_COPY2
AS SELECT EMP_ID, EMP_NAME, SALARY, BONUS
    FROM EMPLOYEE
    WHERE 1=0;
-- �̶� �������� FALSE �� ���� �ִ´�.

SELECT * FROM EMPLOYEE_COPY2;

-- �������� �÷� �Ǵ� �Լ��� ����� �÷�
CREATE TABLE EMPLOYEE_COPY3
AS SELECT EMP_ID, EMP_NAME, SALARY, SALARY*12 AS "����"
    FROM EMPLOYEE;
--�̷����̽������� ��Ī�� ����ؾ� �Ѵ�.
    
SELECT EMP_ID, ����
FROM EMPLOYEE_COPY3;

/*
    ���̺� �� �����Ŀ� �������� �߰� ��� �Ǵ� �������
    
    �������� �߰� ���
    ALTER TABLE ���̺�� ������ ����
    - PRIMARY KEY : ALTER TABLE ���̺�� ADD PRIMARY KEY(�÷���);
    - FOREIGN KEY : ALTER TABLE ���̺�� ADD FOREIGN KEY(�÷���) REFERENCES ���������̺��[(�������÷���)]
    - UNIQUE      : ALTER TABLE ���̺�� ADD UNIQUE(�÷���);
    - CHECK       : ALTER TABLE ���̺�� ADD CHECK(�÷��� ���� ���ǽ�);
    - NOT NULL    : ALTER TABLE ���̺�� MODIFY �÷��� NOT NULL;
    
    �������� ���� ���
    --ALTER TABLE '���̺��' DROP CONSTRAINT '�������Ǹ�'
    
*/
-- ���������� �̿��ؼ� ������ ���̺��� NN �������� ���� ���� �ȵ�
-- EMPLOYEE_COPY ���̺� PRIMARY KEY �������� �߰� (EMP_ID)
ALTER TABLE EMPLOYEE_COPY ADD PRIMARY KEY(EMP_ID);
ALTER TABLE EMPLOYEE ADD FOREIGN KEY(DEPT_CODE) REFERENCES DEPARTMENT(DEPT_ID);
-- �̷��� �ܷ�Ű�� ���ָ� �θ𿡼� ������ ������ ������ �� �ִ�.

-- EMPLOYEE ���̺��� JOB_CODE�� �ܷ�Ű �������� �߰� JOB���̺� ����
-- �߰����ҽ� JOB_CODE�� '������' �̷� �������� �����Ͱ� �� �� ����.
ALTER TABLE EMPLOYEE ADD FOREIGN KEY(JOB_CODE) REFERENCES JOB;
--EMPLOYEE ���̺��� SAL_LEVEL�� �ܷ�Ű �������� �߰� SAL_GRADE���̺� ����
ALTER TABLE EMPLOYEE ADD FOREIGN KEY(SAL_LEVEL) REFERENCES SAL_GRADE;
--DEPARTMENT ���̺��� LOCATION_ID�� �ܷ�Ű �������� �߰� LOCATION ���̺� ����
ALTER TABLE DEPARTMENT ADD FOREIGN KEY(LOCATION_ID) REFERENCES LOCATION;


















