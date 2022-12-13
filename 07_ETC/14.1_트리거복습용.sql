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

SET SERVEROUTPUT ON;
CREATE OR REPLACE TRIGGER TRG_EMP
AFTER INSERT ON EMPLOYEE
BEGIN
    DBMS_OUTPUT.PUT_LINE('���ο��Ű� ȯ���մϴ�.');
END;
/
SELECT * FROM EMPLOYEE;

INSERT INTO EMPLOYEE VALUES(904,'�ڿ���','897979','������������','12321','D9','J1','S1',8000000,0.3,DEFAULT,SYSDATE,DEFAULT,'N');

-- ��ǰ �԰� �� ��� ���� ����
-- >> �׽�Ʈ�� ���� ���̺� �� �������� ����

--1. ��ǰ�� ���� �����͸� ������ ���̺� ����� TB_PRODUCT
-- ��ǰ��ȣ, ��ǰ��, �귣��, ����, ������

CREATE TABLE TB_PRODUCT(
    PCODE NUMBER PRIMARY KEY,
    PNAME VARCHAR2(30) NOT NULL,
    BRANT VARCHAR2(30) NOT NULL,
    PRICE NUMBER,
    STOCK NUMBER DEFAULT 0
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

--2. ��ǰ ����� �� �̷� ���̺�(TB_PRODETAIL)
--�̷¹�ȣ, ��ǰ��ȣ, ��ǰ �������, ����� ����, ����(�԰�/���)
-- � ��ǰ�� � ��¥�� ��� �԰� �� ��� �Ǿ������� ���� �����͸� ����ϴ� ���̺�
CREATE TABLE TB_PRODETAIL(
    DCODE NUMBER PRIMARY KEY,
    PCODE NUMBER REFERENCES TB_PRODUCT,
    PDATE DATE NOT NULL,
    AMOUNT NUMBER NOT NULL,
    STATUS CHAR(6) CHECK(STATUS IN('�԰�','���'))
);

-- �̷¹�ȣ�� �Ź� ���ο� ��ȣ�� �߻����Ѽ� �� �� �ְ� �����ִ� ������ SEQ_DCODE
CREATE SEQUENCE SEQ_DCODE
NOCACHE;

-- 200�� ��ǰ�� ���ó�¥�� 10�� �԰�
-- 200�� ��ǰ�� �������� 10 ����
SELECT * FROM TB_PRODETAIL;
SELECT * FROM TB_PRODUCT;
INSERT INTO TB_PRODETAIL VALUES(SEQ_DCODE.NEXTVAL,200,SYSDATE,10,'�԰�');
UPDATE TB_PRODUCT
SET STOCK = STOCK +10
WHERE PCODE = 200;
COMMIT;

-- 210�� ��ǰ�� ���� ��¥�� 5���� ����.
INSERT INTO TB_PRODETAIL VALUES(SEQ_DCODE.NEXTVAL,210,SYSDATE,5,'���');
UPDATE TB_PRODUCT
SET STOCK = STOCK -5
WHERE PCODE = 210;
COMMIT;

--205�� ���ó�¥�� 20�� �԰�
--205�� ���ó�¥�� 20�� �԰�
INSERT INTO TB_PRODETAIL VALUES(SEQ_DCODE.NEXTVAL,205,SYSDATE,20,'�԰�');
UPDATE TB_PRODUCT
SET STOCK = STOCK + 20
WHERE PCODE = 205;



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
    
*/

-- :NEW �����

--210 ��ǰ�� ���� ��¥�� 7�� �����.
CREATE OR REPLACE TRIGGER TRG_01
AFTER INSERT ON TB_PRODETAIL
FOR EACH ROW
BEGIN
    IF :NEW.STATUS = '���' 
        THEN UPDATE TB_PRODUCT
                SET STOCK = STOCK - :NEW.AMOUNT
                WHERE PCODE = :NEW.PCODE;
    END IF;
    IF :NEW.STATUS = '�԰�'
        THEN UPDATE TB_PRODUCT
                SET STOCK = STOCK + :NEW.AMOUNT
                WHERE PCODE = :NEW.PCODE;
    END IF;
END;
/
--200 ��ǰ�� ���� ��¥�� 100�� �԰��.
SELECT * FROM TB_PRODETAIL;
SELECT * FROM TB_PRODUCT;
INSERT INTO TB_PRODETAIL VALUES(SEQ_DCODE.NEXTVAL,200,SYSDATE,100,'�԰�');

