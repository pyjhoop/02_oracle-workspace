
CREATE TABLE MEMBER(
    MEM_NO NUMBER,
    MEM_ID VARCHAR2(20),
    MEM_PWD VARCHAR2(20),
    MEM_NAME VARCHAR2(20),
    GENDER CHAR(3),
    PHONE VARCHAR2(13),
    EMAIL VARCHAR2(50),
    MEM_DATE DATE
);

-- ���̺� �����ϰ��� �� ��
DROP TABLE MEMEBER;
SELECT * FROM MEMBER;
--���� ����
-- �÷��� ��Ÿ�� ���� ��ġ�� ������� ���̺� DROP�ؼ� �����
--�Ǵ� ALTER�� �����ؾ���.

SELECT * FROM USER_TABLES;

SELECT * FROM USER_TAB_COLUMNS;

-- �÷��� �ּ� �� Ŀ��Ʈ �ޱ�
COMMENT ON COLUMN MEMBER.MEM_NO IS 'ȸ����ȣ';
COMMENT ON COLUMN MEMBER.MEM_ID IS 'ȸ�����̵�';
COMMENT ON COLUMN MEMBER.MEM_PWD IS 'ȸ����й�ȣ';
COMMENT ON COLUMN MEMBER.MEM_NAME IS 'ȸ����';
COMMENT ON COLUMN MEMBER.GENDER IS '����(��/��)';
COMMENT ON COLUMN MEMBER.PHONE IS '��ȭ��ȣ';
COMMENT ON COLUMN MEMBER.EMAIL IS '�̸���';
COMMENT ON COLUMN MEMBER.MEM_DATE IS 'ȸ��������';

SELECT * FROM MEMBER;

-- ���̺� ������ �ֱ�.
INSERT INTO MEMBER VALUES(1,'user01','pass01','�����','��','010-1111-2222','aaa@naver.com','20/12/30');
INSERT INTO MEMBER VALUES(2,'user02','pass02','Ȳ����','��',null,NULL,SYSDATE);
INSERT INTO MEMBER VALUES(null,null,null,null,null,null,null,null);
-- ��ȿ���� �ʴ� ������
--�׷��� �츰 �������� ���Ἲ�� �����ϱ� ���� ���������� ����Ѵ�.

-- �÷��������: �÷��� Ÿ�� ��������

CREATE TABLE MEM_NOTNULL(
    MEM_NO NUMBER NOT NULL,
    MEM_ID VARCHAR2(20) NOT NULL,
    MEM_PWD VARCHAR2(20) NOT NULL,
    MEM_NAME VARCHAR2(20) NOT NULL,
    GENDER CHAR(3),
    PHONE VARCHAR2(13),
    EMAIL VARCHAR2(50)
);
INSERT INTO MEM_NOTNULL VALUES(1,'user01','pass01','�����','��',null,null);
INSERT INTO MEM_NOTNULL VALUES(2,'user02',null,'Ȳ����','��',null,'aaa@naver.com');
-- NULL �� ���� ������ ��.
INSERT INTO MEM_NOTNULL VALUES(2,'user01','pass02','Ȳ����',null,null,null);
SELECT * FROM MEM_NOTNULL;
-- ID, MEM_ID�� ������ ���� ���� �� ����� �ǳ�?? �̷��Ǿ�� ó����?
-- UNIQUE�� ����

-- UNIQUE������
CREATE TABLE MEM_UNIQUE(
    MEM_NO NUMBER NOT NULL,
    MEM_ID VARCHAR2(20) NOT NULL UNIQUE,
    MEM_PWD VARCHAR2(20) NOT NULL,
    MEM_NAME VARCHAR2(20) NOT NULL,
    GENDER CHAR(3),
    PHONE VARCHAR2(13),
    EMAIL VARCHAR2(50)
);
SELECT * FROM MEM_UNIQUE;
DROP TABLE MEM_UNIQUE;

-- ���̺� ���� ��� UNIQUE
CREATE TABLE MEM_UNIQUE(
    MEM_NO NUMBER NOT NULL,
    MEM_ID VARCHAR2(20) NOT NULL,
    MEM_PWD VARCHAR2(20) NOT NULL,
    MEM_NAME VARCHAR2(20) NOT NULL,
    GENDER CHAR(3),
    PHONE VARCHAR2(13),
    EMAIL VARCHAR2(50),
    UNIQUE(MEM_ID)
);

INSERT INTO MEM_UNIQUE VALUES(1,'user01','pass01','�����',null,null,null);
INSERT INTO MEM_UNIQUE VALUES(2,'user01','pass02','Ȳ����',null,null,null);
-- ���̵� �ߺ��Ǿ ������.

-- ���� �����޼����� �ϳ��ϳ� ã�Ⱑ ������ �����
-- �������� �ο��� �������Ǹ� �ο� ����.

--�÷����� ������� �������Ǹ� ���ϱ�
DROP TABLE MEM_UNIQUE;
CREATE TABLE MEM_UNIQUE(
    MEM_NO NUMBER CONSTRAINT MEMNO_NN NOT NULL,
    MEM_ID VARCHAR2(20) CONSTRAINT MEMID_NN NOT NULL,
    MEM_PWD VARCHAR2(20) CONSTRAINT MEMPWE_NN NOT NULL,
    MEM_NAME VARCHAR2(20) CONSTRAINT MEMNAME_NN NOT NULL,
    GENDER CHAR(3),
    PHONE VARCHAR2(13),
    EMAIL VARCHAR2(50),
    CONSTRAINT MEMID_UQ UNIQUE(MEM_ID)
);
INSERT INTO MEM_UNIQUE VALUES(1,'user01','pass01','�����',null,null,null);
INSERT INTO MEM_UNIQUE VALUES(2,'user01','pass02','Ȳ����',null,null,null);
-- ������
INSERT INTO MEM_UNIQUE VALUES(2,'user02','pass02','Ȳ����',null,null,null);
INSERT INTO MEM_UNIQUE VALUES(3,'user03','pass03','�̰���','��',null,null);

SELECT * FROM MEM_UNIQUE;

--������ �̻��� ���� ���Դµ� �����Ͱ� ���Դ�. ->�̷� �ȵ�.

CREATE TABLE MEM_CHECK(
    MEM_NO NUMBER NOT NULL,
    MEM_ID VARCHAR2(20) NOT NULL UNIQUE,
    MEM_PWD VARCHAR2(20) NOT NULL,
    MEM_NAME VARCHAR2(20) NOT NULL,
    GENDER CHAR(3) CHECK(GENDER IN('��','��')), -- �÷����� ���
    PHONE VARCHAR2(13),
    EMAIL VARCHAR2(50)
    --CHECK(GENDER IN('��','��'))
);
INSERT INTO MEM_CHECK
VALUES (1,'user01','pass01','�����','��',null,null);

INSERT INTO MEM_CHECK
VALUES (2,'user02','pass02','Ȳ����','z',null,null);
-- ������ ������ Z�� �־��� ������
-- NOT NULL������ �ȳֱ⿡ NULL���� �����ϴ�.































