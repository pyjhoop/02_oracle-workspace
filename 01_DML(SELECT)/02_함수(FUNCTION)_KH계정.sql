--���� ����
/*
    < �Լ� FUNCTION >
    ���޵� �÷����� �о�鿩�� �Լ��� ������ ����� ��ȯ
    
    - ������ �Լ� : n���� ���� �о�鿩�� n���� ������� �����Ѵ�.(�� �ึ�� �Լ� ���� ��� ��ȯ)
    - �׷� �Լ� : N���� ���� �о�鿩�� 1���� ������� �����Ѵ�. (�׷��� ���� �׷캰�� �Լ� ���� ��� ��ȯ)
    
    >> SELECT ���� ������ �Լ��� �׷��Լ��� �Բ� ��� ����!!
        ��? : ������� ������ �ٸ��� ����!!!
    >> �Լ����� ��� �� �� �ִ� ��ġ : SELECT��, WHERE��, ORDER BY��, GROUP BY��, HAVING��
*/


/*
    < ����ó�� �Լ� >
    
    *LENGHT / LENGHTB   => ����� NUMBER Ÿ��
    
    LENGTH(�÷�|'���ڿ� ��') : �ش� ���ڿ� ���� ���ڼ� ��ȯ
    
    LENGTHB(�÷�|'���ڿ� ��') : �ش� ���ڿ� ���� ����Ʈ �� ��ȯ
    
    '��', '��','��' �ѱ��ڴ� 3BYTE => �ڿ��� 9����Ʈ
    ������, ����, Ư������ �ѱ��ڴ� 1BYTE
*/

SELECT SYSDATE
FROM DUAL;

SELECT LENGTH('����Ŭ'), LENGTHB('����Ŭ')
FROM DUAL; --�������̺�! ���̺� ���� ������ ���� ��!

SELECT LENGTH('oracle'), LENGTHB('oracle')
FROM DUAL;

SELECT EMP_NAME, LENGTH(EMP_NAME), LENGTHB(EMP_NAME), EMAIL, LENGTH(EMAIL), LENGTHB(EMAIL)
FROM EMPLOYEE; -- ���ึ�� �� ����ǰ� ���� => ������ �Լ�

/*
    * INSTR  => ���̾��̱⿡ �ܿ��� ��.
    ���ڿ��κ��� Ư�� ������ ������ġ�� ã�Ƽ� ��ȯ �׳� Ư�������� �ε����� ��ȯ��.
    
    INSTR(�÷�|'���ڿ�','ã�����ϴ� ����', ['ã����ġ�� ���۰�', [����]]) => ������� NUMBER��.
    
    ã�� ��ġ�� ���۰�
    1 : �տ������� ã�ڴ�.
    -1 : �ڿ������� ã�ڴ�.
*/

SELECT INSTR('AABAACAABBAA','B') -- �ε��� 1���� �����ϳ�
FROM DUAL; -- �ƹ��͵� �Ⱦ��� ã�� ��ġ�� ���۰��� 1�� �⺻�� => �տ������� ã�� ������ 1�� �⺻��

SELECT INSTR('AABAACAABBAA','B',1)FROM DUAL;
SELECT INSTR('AABAACAABBAA','B',-1)FROM DUAL;
SELECT INSTR('AABAACAABBAA','B',1,2)FROM DUAL; -- ���° B�� ã����? �� �����̳�
SELECT INSTR('AABAACAABBAA','B',-1,3)FROM DUAL;

SELECT EMAIL, INSTR(EMAIL,'_',1,1) AS "_�� ��ġ" --_�� ��ġ�� ã��.
FROM EMPLOYEE;

SELECT EMAIL, INSTR(EMAIL, '@') AS "@�� ��ġ"
FROM EMPLOYEE;
-- Ư�� �÷����� ������ ��ġ�� �˰�������� INSTR�� ���
-- INSTR(�÷�|'���ͷ�', 'ã�� ����', [ã�� ��ġ�� ���۰�, [����]]
--������ ���° ���ڸ� ã�� ���ΰ�?
-- ã�� ��ġ�� ���۰��� �տ�������? �ڿ�������>????

----------------------------------------------------------------------------
/*
    * SUBSTR
    ���ڿ����� Ư�� ���ڿ��� �����ؼ� ��ȯ(�ڹٿ� ����)
    
    SUBSTR(STRING, POSITION,[LENGTH])        => ������� CHARACTERŸ��
    - STRING : ����Ÿ���÷� �Ǵ� '���ڿ���'
    - POSITON : ���ڿ��� ������ ���� ��ġ��
    - LENGTH : ������ ���� ����(������ ������ �ǹ�)
*/

SELECT SUBSTR('SHOWMETHEMONEY', 7) FROM DUAL; --7��°���� ����ϳ�
SELECT SUBSTR('SHOWMETHEMONEY', 5,2) FROM DUAL; --5��°���� 2���ڸ� ����
SELECT SUBSTR('SHOWMETHEMONEY', 1,6) FROM DUAL;
SELECT SUBSTR('SHOWMETHEMONEY', -8,3) FROM DUAL; --�ڿ��� 8��°���� 3���ڸ� ����
SELECT SUBSTR('SHOWMETHEMONEY', -8,-3) FROM DUAL; -- ���̴� ����� ��.

SELECT EMP_NAME, EMP_NO,SUBSTR(EMP_NO,8,1) AS "����"
FROM EMPLOYEE;

--���ڻ���鸸 ��ȸ�ϼ���
SELECT EMP_NAME
FROM EMPLOYEE
--WHERE SUBSTR(EMP_NO,8,1) = '2' OR SUBSTR(EMP_NO,8,1) = '4';
WHERE SUBSTR(EMP_NO, 8,1) IN('2','4');

--���ڻ���鸸 ��ȸ
SELECT EMP_NAME
FROM EMPLOYEE
--WHERE SUBSTR(EMP_NO, 8,1) = '1' OR SUBSTR(EMP_NO, 8,1) = '3';
WHERE SUBSTR(EMP_NO,8,1) IN(1,3) --��Ģ������ ''�ؾ������� ���������� ����ȯ�� �Ǿ��⿡ ����.
ORDER BY EMP_NAME; -- �⺻������ ��������

--�Լ� ��ø���
SELECT EMP_NAME, EMAIL, SUBSTR(EMAIL,1,INSTR(EMAIL,'@')-1) AS "���̵�"
FROM EMPLOYEE;
------------------------------------------------------------------------------------
/*
    * LPAD/RPAD
    ���ڿ��� ��ȸ�� �� ���ϰ��ְ� ��ȸ�ϰ��� �� �� ���
    
    LPAD/RPAD(STRING, ���������� ��ȯ�� ������ ����, [�����̰��� �ϴ� ����])
    
    ���ڿ��� �����̰��� �ϴ� ���ڸ� ���� �Ǵ� �����ʿ� ���ٿ��� ���� N���̸�ŭ�� ���ڿ� ��ȯ
    
*/

--20��ŭ�� ������ EMAIL �÷����� ���������� �����ϰ� ������ �κ��� �������� ä����
SELECT EMP_NAME, LPAD(EMAIL, 20) --�����̰��� �ϴ� ���� ������ �⺻���� ����!!!
FROM EMPLOYEE;

SELECT EMP_NAME, LPAD(EMAIL, 20,'#')
FROM EMPLOYEE;
SELECT EMP_NAME, RPAD(EMAIL, 20,'#')
FROM EMPLOYEE;

--850101-2******������ ��ȸ => �� 14����.
SELECT RPAD('850101-2',14,'*')
FROM DUAL;

-- �򰥸��ϱ� �۷� �Ẹ�� �Լ���������
SELECT EMP_NAME, RPAD(SUBSTR(EMP_NO,1,8),14,'*') AS "�ֹι�ȣ"
FROM EMPLOYEE;
---------------------------------------------------------------------------------
/*
    LTRIM/ RTRIM
    ���ڿ����� Ư�� ���ڸ� ������ �������� ��ȯ
    
    LTRIM/RTRIM(STRING, ['������ ���ڵ�']) => ������ ���� �����ϸ� ������ ��������
    
    ���ڿ��� ���� Ȥ�� �����ʿ��� �����ϰ��� �ϴ� ���ڵ��� ã�Ƽ� ���� �� ���ڿ� ��ȯ
*/

SELECT LTRIM('   K H ') FROM DUAL; --���� ã�Ƽ� �����ϰ� ����ƴ� ���ڳ����� �׳� ����.
SELECT LTRIM('123123KH123','123') FROM DUAL;
SELECT LTRIM('ACABACCKH','ABC') FROM DUAL; -- ���ڿ����� Ư�� "����"�� ã�Ƽ� �����ϱ⿡ ���� ������� ABC�ΰ͵��� �� ����.

SELECT RTRIM('5782KH123','0123456789') FROM DUAL;

/*
    * TRIM
    ���ڿ��� ��/ �� / ���ʿ� �ִ� ������ ���ڵ��� ������ ������ ���ڿ� ��ȯ
    TRIM([[LEADING |TRAILING| BOTH]�����ϰ��� �ϴ� ���ڵ� FROM]STRING
*/

SELECT TRIM('   K H   ') FROM DUAL;
--SELECT TRIM('ZZZKHZZZ','Z') FROM DUAL;
SELECT TRIM('Z' FROM 'ZZZKHZZZ') FROM DUAL;

SELECT TRIM(LEADING 'Z' FROM 'ZZZKHZZZ') FROM DUAL; --LEADING : �� => LTRIM�� ����

SELECT TRIM(TRAILING 'Z' FROM 'ZZZKHZZZ') FROM DUAL;-- TRAILING: �� => RTRIM�� ����

SELECT TRIM(BOTH 'Z' FROM 'ZZZKHZZZ') FROM DUAL; --�⺻���� BOTH��� ����. ������ ���Ű� �ȴ�.������ �⺻��.

------------------------------------------------------------------------------------
/*
    * LOWER / UPPER / INITCAP
    
    LOWER / UPPER / INITCAP(STRING)   =>������� CHARACTER Ÿ��
    
    LOWER : �� �ҹ��ڷ� ������ ���ڿ� ��ȯ (�ڹٿ����� TOLOWERCASE�� ����)
    UPPER : �� �빮�ڷ� ������ ���ڿ� ��ȯ (�ڹٿ����� TOUPPERCASE�� ����)
    INITCAP : �ܾ� �ձ��ڸ��� �빮�ڷ� ������ ���ڿ� ��ȯ
*/

SELECT LOWER('Welcom To My World!') FROM DUAL;
SELECT UPPER('Welcom To My World!') FROM DUAL;
SELECT INITCAP('welcom to my world!') FROM DUAL;
---------------------------------------------------------------------------------
/*
    CONCAT
    ���ڿ� �ΰ� ���޹޾Ƽ� �ϳ��� ��ģ�� ��� ��ȯ
    
    CONCAT(STRING, STRING)          => ����� CHARACTER Ÿ��
    
*/

SELECT CONCAT('ABC','���ݸ�') FROM DUAL;
SELECT 'ABC'||'���ݸ�' FROM DUAL;

SELECT CONCAT('ABC','���ݸ�','�԰�ʹ�') FROM DUAL; -- ���� �߻�!! : 2���� ���� �� ����
SELECT 'ABC' || '���ݸ�' || '�԰�ʹ�' FROM DUAL;

--------------------------------------------------------------------------------
/*
    *REPLACE
    REPALCE(STRING, STR1, STR2)         => ������� CHARACTER Ÿ��
    
*/

SELECT EMP_NAME, EMAIL, REPLACE(EMAIL,'kh.or.kr','gmail.com')
FROM EMPLOYEE;

------------------------------------------------------------------------------------
/*
    <����ó�� �Լ�>
    
    *ABS
    ������ ���밪�� �����ִ� �Լ�
    
    ABS(NUMBER)         => ������� NUMBER Ÿ��!!
*/

SELECT ABS(-10) FROM DUAL;
SELECT ABS(-5.7) FROM DUAL;

--------------------------------------------------------------------------------
/*
    * MOD
    �� ���� ���� ���������� ��ȯ���ִ� �Լ�
    
    MOD(NUMBER,NUMBER)          =>����� NUMBER Ÿ��!!
*/

SELECT MOD(10,3) FROM DUAL;
SELECT MOD(10.9,3) FROM DUAL;

---------------------------------------------------------------------------------
/*  
    * ROUND
    �ݿø��� ����� ��ȯ�ϴ� �Լ�
    ROUND(NUMBER, [��ġ])           =>������� NUMBER Ÿ��
    ��ġ�����ϸ� 0��° �ڸ����� �ݿø��Ѵ�.
    �Ҽ��� 1��° �ڸ����� �ݿø��Ѵ�.
*/

SELECT ROUND(123.466)FROM DUAL;





