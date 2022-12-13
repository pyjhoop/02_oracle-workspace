-- ����
/*
    < Ʈ���� TRIGGER > 
    ���� ������ ���̺� INSERT, UPDATE, DELETE �� DML���� ���� ��������� ���� ��
    (���̺� �̺�Ʈ�� �߻����� ��)
    �ڵ����� �Ź� ������ ������ �̸� �����ص� �� �ִ� ��ü
    
    EX) 
    ȸ��Ż��� ������ ȸ�����Ը��� �����͸� DELETE�� �� ��ٷ� Ż��� ȸ���鸸 ���� �����ϴ� ���̺� �ڵ����� INSERT ó���� �ؾ��Ѵ�.
    �Ű� ȸ���� ���� ���� �Ѿ��� �� ���������� �ش� ȸ���� ������Ʈ�� ó���ǰԲ�
    ����� ���� �����Ͱ� ���(INSERT)�� �� ���� �ش� ��ǰ�� ���� �������� �Ź� ����(UPDATE)�ؾ� �� ��.
   
    * Ʈ���� ����
    - SQL���� ����ñ⿡ ���� �з�
        > BEFORE TRIGGER : ���� ������ ���̺� �̺�Ʈ�� �߻��Ǳ� ���� Ʈ���Ű� ���� 
        > AFTER TRIGGER : ���� ������ ���̺� �̺�Ʈ�� �߻��� �Ŀ� Ʈ���Ű� ����

    - SQL���� ���� ������ �޴� �� �࿡ ���� �з�
        > STATEMENT TRIGGER(����Ʈ����) : �̺�Ʈ�� �߻��� SQL���� ���� �� �ѹ��� Ʈ���� ����
        > ROW TRIGGER(�� Ʈ����) : �ش� SQL�� ������ �� ���� �Ź� Ʈ���� ����
                                  (FOR EACH ROW �ɼ� ����ؾߵ�)
                                  > :OLD - BEFORE UPDATE(������ �ڷ�), BEFORE DELETE(������ �ڷ�)
                                  > :NEW - AFTER INSERT(�߰��� �ڷ�), AFTER UPDATE(������ �ڷ�)
                                  
    * Ʈ���� ��������
    [ǥ����]
    CREATE [OR REPLACE] TRIGGER Ʈ���Ÿ�
    BEFORE| AFTER       INSERT | UPDATE| DELETE ON ���̺��
    [FOR EACH ROW] -- �̰� ���ٸ� ����Ʈ������.
    �ڵ����� ������ ����;
     �� DECLARE
            ��������
        BEGIN   
            ���೻��(�ش� ���� ������ �̺�Ʈ �߻��� ����������(�ڵ�����) ������ ����)
        EXCEPTION
            ����ó������;
        END;
        /
*/

-- EMPLOYEE ���̺� ���ο� ���� INSERT �� ������ �ڵ����� �޼��� ��µǴ� Ʈ���� ����
CREATE OR REPLACE TRIGGER TRG_01
AFTER INSERT ON EMPLOYEE
BEGIN
    DBMS_OUTPUT.PUT_LINE('���Ի���� ȯ���մϴ�');

END;
/

INSERT INTO EMPLOYEE(EMP_ID, EMP_NAME, EMP_NO, DEPT_CODE, JOB_CODE, SAL_LEVEL, HIRE_DATE) 
VALUES(500,'�̼���','111111-1232222','D7','J7','S2',SYSDATE);

INSERT INTO EMPLOYEE(EMP_ID, EMP_NAME, EMP_NO, DEPT_CODE, JOB_CODE, SAL_LEVEL, HIRE_DATE) 
VALUES(501,'�ָ�','111111-2232222','D8','J7','S2',SYSDATE);

--------------------------------------------------------------------------------
-- ��ǰ �԰� �� ��� ���� ����
-- >> �׽�Ʈ�� ���� ���̺� �� �������� ����

--1. ��ǰ�� ���� �����͸� ������ ���̺� ����� TB_PRODUCT
CREATE TABLE TB_PRODUCT(
    PCODE NUMBER PRIMARY KEY,               -- ��ǰ��ȣ
    PNAME VARCHAR2(30) NOT NULL,            -- ��ǰ��
    BRAND VARCHAR2(30) NOT NULL,            -- �귣��
    PRICE NUMBER,                           -- ����
    STOCK NUMBER DEFAULT 0                  -- ������
);

-- ��ǰ��ȣ �ߺ� �ȵǰԲ� �Ź� ���ο� ��ȣ�� �߻���Ű�� ������(SEQ_PCODE)
CREATE SEQUENCE SEQ_PCODE
START WITH 200
INCREMENT BY 5
NOCACHE;

INSERT INTO TB_PRODUCT VALUES(SEQ_PCODE.NEXTVAL, '������20','�Ｚ',1400000,DEFAULT);
INSERT INTO TB_PRODUCT VALUES(SEQ_PCODE.NEXTVAL, '������14','����',1300000,10);
INSERT INTO TB_PRODUCT VALUES(SEQ_PCODE.NEXTVAL, '�����','������',600000,20);

SELECT * FROM TB_PRODUCT;
COMMIT;

--2. ��ǰ ����� �� �̷� ���̺�(TB_PRODETAIL)
-- � ��ǰ�� � ��¥�� ��� �԰� �� ��� �Ǿ������� ���� �����͸� ����ϴ� ���̺�
CREATE TABLE TB_PRODETAIL(
    DCODE NUMBER PRIMARY KEY,                       -- �̷¹�ȣ
    PCODE NUMBER REFERENCES TB_PRODUCT(PCODE),      -- ��ǰ��ȣ
    PDATE DATE NOT NULL,                            -- ��ǰ �������
    AMOUNT NUMBER NOT NULL,                         -- ����� ����
    STATUS CHAR(6) CHECK(STATUS IN ('�԰�','���'))   -- ����(�԰�/���)
);

-- �̷¹�ȣ�� �Ź� ���ο� ��ȣ�� �߻����Ѽ� �� �� �ְ� �����ִ� ������ SEQ_DCODE
CREATE SEQUENCE SEQ_DCODE
NOCACHE;

-- 200�� ��ǰ�� ���ó�¥�� 10�� �԰�
INSERT INTO TB_PRODETAIL VALUES(SEQ_DCODE.NEXTVAL,200,SYSDATE,10,'�԰�');
-- 200�� ��ǰ�� �������� 10 ����
UPDATE TB_PRODUCT
SET STOCK = STOCK+10
WHERE PCODE = 200;

-- �ϳ��� Ʈ�������� �԰�� �������
COMMIT; -- �ش� Ʈ����� COMMIT

-- 210�� ��ǰ�� ���� ��¥�� 5���� ����.
INSERT INTO TB_PRODETAIL VALUES(SEQ_DCODE.NEXTVAL,210,SYSDATE,5,'���');
UPDATE TB_PRODUCT
SET STOCK = STOCK -5
WHERE PCODE = 210;
COMMIT;
--205�� ���ó�¥�� 20�� �԰�
INSERT INTO TB_PRODETAIL VALUES(SEQ_DCODE.NEXTVAL, 205,SYSDATE,20,'�԰�');
UPDATE TB_PRODUCT
SET STOCK = STOCK +20
WHERE PCODE = 200;
ROLLBACK;
--205�� ���ó�¥�� 20�� �԰�
INSERT INTO TB_PRODETAIL VALUES(SEQ_DCODE.NEXTVAL, 205,SYSDATE,20,'�԰�');
-- �������� �Ʊ� �ѹ� ������⿡ 4���� ����
--205�� ��� ����.
UPDATE TB_PRODUCT
SET STOCK = STOCK +20
WHERE PCODE = 205;
COMMIT;

-- TB_PRODETAIL�� INSERT �̺�Ʈ �߻���
-- TB_PRODUCT �Ź� �ڵ����� �������� ������Ʈ �ǰԲ� Ʈ���� ����

/*
    - ��ǰ�� �԰�� ��� => �ش� ��ǰ ã�Ƽ� ������ ���� UPDATE
    UPDATE TB_PRODUCT
    SET STOCK = STOCK + �����԰�� ����(INSERT�� �ڷ��� AMOUNT��)
    WHERE PCODE = �����԰�� ��ǰ ��ȣ(INSERT�� �ڷ��� PCODE��);
    
    - ��ǰ�� ���� ��� => �ش� ��ǰ ã�Ƽ� ������ ���� UPDATE
    UPDATE TB_PRODUCT
    SET STOCK = STOCK - ���� ���� ����(INSERT�� �ڷ��� AMOUNT��)
    WHERE PCODE = �������� ��ǰ��ȣ(INSERT�� �ڷ��� PCODE��);
    
    -- �������� PL�� ������ ��ȣ ������ ����� ���������� CURRVAL�� �ش��ϴ� ���� ���� ����?
*/

-- :NEW �����
CREATE OR REPLACE TRIGGER TRG_02
AFTER INSERT ON TB_PRODETAIL
FOR EACH ROW -- :NEW Ű���徲�� �; �� Ʈ���� �����
BEGIN
    --��ǰ�� �԰�� ��� => ������ ����
    IF (:NEW.STATUS = '�԰�')
        THEN 
            UPDATE TB_PRODUCT
            SET STOCK = STOCK + :NEW.AMOUNT
            WHERE PCODE = :NEW.PCODE;
    END IF; 
    -- ��ǰ�� ���� ��� => ������ ����
    IF(:NEW.STATUS = '���')
        THEN
            UPDATE TB_PRODUCT
            SET STOCK = STOCK - :NEW.AMOUNT
            WHERE PCODE = :NEW.PCODE;
    END IF;
END;
/



--210 ��ǰ�� ���� ��¥�� 7�� �����.
INSERT INTO TB_PRODETAIL VALUES(SEQ_DCODE.NEXTVAL,210,SYSDATE,7,'���');

--200 ��ǰ�� ���� ��¥�� 100�� �԰��.
INSERT INTO TB_PRODETAIL VALUES(SEQ_DCODE.NEXTVAL,200,SYSDATE,100,'�԰�');



-- �л� ���̺� ����
-- TB_STU
-- �÷� : �й�, �̸�, ����, ��ȭ��ȣ, ��������(����Ʈ ����)
-- STU_NO, STU_NAME, GENDER(M,F), PHONE, STU_STATUS ����, ����, ����,���� DEFAULT ����
-- �й������� ���� SEQ_STU_NO
-- 900������ �����ϰ� (900,901)
CREATE TABLE TB_STU(
    STU_NO NUMBER PRIMARY KEY,
    STU_NAME VARCHAR2(20) NOT NULL,
    GENDER CHAR(1) CHECK(GENDER IN('F','M')),
    PHONE VARCHAR2(14),
    STU_STATUS VARCHAR2(6) CHECK(STU_STATUS IN('����','����','����','����'))
);

SELECT * FROM TB_STU;

CREATE SEQUENCE SEQ_STU_NO
START WITH 900
NOCYCLE
NOCACHE;
INSERT INTO TB_STU VALUES(SEQ_STU_NO.NEXTVAL, '�ڿ���','M','010-1111-2222','����');
INSERT INTO TB_STU VALUES(SEQ_STU_NO.NEXTVAL,'������','F','010-2322-3414','����');
INSERT INTO TB_STU VALUES(SEQ_STU_NO.NEXTVAL,'Ȳ��ȭ','F','010-2324-6533','����');
INSERT INTO TB_STU VALUES(SEQ_STU_NO.NEXTVAL, '���ع�','M','010-5356-4523','����');
INSERT INTO TB_STU VALUES(SEQ_STU_NO.NEXTVAL,'������','M','010-2342-3123','����');


-- ������ 5�� �����

-- ���� ���̺� ����
-- TB_ABSENCE
-- �÷� : ���й�ȣ �������� 1������, �й�(�ܷ�Ű), ��������, ���п���(CHECK Y N) ����Ʈ Y
-- ABS_NO, STU_NO, ABS_DATE, ABS_STATUS
-- ���� ������ ����
-- 1������ �����ϰ�
CREATE TABLE TB_ABSENCE (
    ABS_NO NUMBER PRIMARY KEY,
    STU_NO NUMBER REFERENCES TB_STU ON DELETE CASCADE,
    ABS_DATE DATE,
    ABS_STATUS CHAR(3) DEFAULT 'Y' CHECK(ABS_STATUS IN('Y','N'))
);

DROP TABLE TB_ABSENCE;

SELECT * FROM TB_ABSENCE;
CREATE SEQUENCE SEQ_ABS_NO
START WITH 1
NOCYCLE
NOCACHE;

SELECT * FROM TB_STU;

INSERT INTO TB_ABSENCE VALUES(SEQ_ABS_NO.NEXTVAL,901,SYSDATE,'Y');
INSERT INTO TB_ABSENCE VALUES(SEQ_ABS_NO.NEXTVAL,904,SYSDATE,'Y');


-- �л��� ������ ��쿡 => �л����̺��� �������ΰ� ������ ���  
-- ���� ���̺� INSERT ��Ű��

CREATE OR REPLACE TRIGGER TRG_STU_01
AFTER UPDATE ON TB_STU
FOR EACH ROW
BEGIN
    IF (:NEW.STU_STATUS = '����')
        THEN DELETE FROM TB_STU WHERE STU_NO = :NEW.STU_NO;
    END IF;

END;
/

SELECT * FROM TB_STU;
SELECT * FROM TB_ABS ENCE;

UPDATE TB_STU
SET STU_STATUS = '����'
WHERE STU_NO = 901;
SELECT * FROM TB_ABSENCE;

CREATE OR REPLACE TRIGGER TRG_STU_02
AFTER UPDATE ON TB_ABSENCE
FOR EACH ROW
BEGIN
     IF (:NEW.ABS_STATUS = 'N')
        THEN UPDATE TB_STU 
                SET STU_STATUS = '����'
                WHERE STU_NO = :NEW.STU_NO;
    END IF;
END;
/
CREATE OR REPLACE TRIGGER TRG_STU_03
AFTER UPDATE ON TB_ABSENCE
FOR EACH ROW
BEGIN
     IF (:NEW.ABS_STATUS = 'N')
        THEN DELETE FROM TB_STU
            WHERE STU_NO = :NEW.STU_NO;
    END IF;
END;
/

DROP TRIGGER TRG_STU_03;

UPDATE TB_ABSENCE
SET ABS_STATUS = 'N'
WHERE ABS_NO = 3;
SELECT * FROM TB_ABSENCE;
SELECT * FROM TB_STU;

UPDATE TB_STU
SET STU_STATUS = '����'
WHERE STU_NO = 901;
COMMIT;
ROLLBACK;

-- �л����̺��� �������ΰ� ������ �Ǵ� ���
-- �ش絥���͸� DELETE ó��(���п��� ������ ���е� ����Ʈ) �Ѵ�.
-- ���� ���̺� ���п��ΰ� N���� �ٲ�°��
-- �л����̺��� �������� �������� ����



























