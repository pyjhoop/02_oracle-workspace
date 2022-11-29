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

SELECT ROUND(123.466)FROM DUAL; -- ��ġ ������ 0
SELECT ROUND(123.456,1) FROM DUAL;
SELECT ROUND(123.456,5) FROM DUAL; -- �ڸ������� ũ�� �״�� ����.
SELECT ROUND(123.456,-1) FROM DUAL;
SELECT ROUND(123.456,-2) FROM DUAL;
--------------------------------------------------------------------------------
/*
    *CEIL
    �ø�ó�� ���ִ� �Լ�
    CEIL(NUMBER)
*/
SELECT CEIL(123.156)FROM DUAL; -- �ø��̴� ������ �ø� ��ġ���� �Ұ�.
-------------------------------------------------------------------------------
/*
    *FLOOR
    �Ҽ��� �Ʒ� ���� ó���ϴ� �Լ�
    FLOOR(NUMBER)
*/
SELECT FLOOR(3.141528) FROM DUAL;
SELECT FLOOR(123.973) FROM DUAL; -- �Ҽ��� ������ ����, ��ġ���� �Ұ��ϴ�.
--------------------------------------------------------------------------------
/*
    *TRUNC(�����ϴ�)  �߿� 
    ��ġ ���� ������ ����ó�����ִ� �Լ�
    TRUNC(NUMBER, [��ġ])
*/
SELECT TRUNC(123.456) FROM DUAL;
SELECT TRUNC(123.456,1) FROM DUAL;
SELECT TRUNC(123.456,2) FROM DUAL;
SELECT TRUNC(123.456,-1) FROM DUAL;
-- �Ҽ����� ����ǰ� �Ǽ� ������ ���� �������� �ٲ��.

--------------------------------------------------------------------------------
/*
    <��¥ ó�� �Լ�>
*/
--* SYSDATE : �ý��� ��¥ �� �ð� ��ȯ(���� ��¥ �� �ð�)
SELECT SYSDATE FROM DUAL; -- ���� Ŭ���ϸ� �ð��� Ȯ�� �����ϴ�.

-- *MONTHS_BETWEEN (DATE1, DATE2) : �� ��¥ ������ ���� �� => ���������� DATE 1 - DATE2 �� ������ 30,31 �� �����.
-- ������� NUMBER Ÿ��
-- EMPLOYEE���� �����, �ٹ� �ϼ�, �ٹ� ���� ��
SELECT EMP_NAME, LPAD(TRUNC(SYSDATE - HIRE_DATE),10) ||' ��' AS "�ٹ��ϼ�"
,FLOOR(MONTHS_BETWEEN(SYSDATE,HIRE_DATE))||' ����' AS "�ٹ����� ��"
FROM EMPLOYEE;

--* ADD_MONTHS(DATE, NUMBER) : Ư����¥�� �ش� ���ڸ�ŭ�� �������� ���ؼ� ��¥�� ����
-- ����� : DATE Ÿ��
SELECT ADD_MONTHS(SYSDATE,6) FROM DUAL;

--EMPLOYEE ���� �����, �Ի���, �Ի� �� 6������ �� ��¥
SELECT EMP_NAME, HIRE_DATE, ADD_MONTHS(HIRE_DATE,6) AS "������ ���� ��¥"
FROM EMPLOYEE;

-- NEXT_DAY (DATE, ����(����|����) : Ư����¥ ���Ŀ� ����� �ش� ������ ��¥�� ��ȯ���ִ� �Լ�.
-- ����� : DATE Ÿ��
SELECT SYSDATE, NEXT_DAY(SYSDATE,'�ݿ���') FROM DUAL;
SELECT SYSDATE, NEXT_DAY(SYSDATE,'��') FROM DUAL;
-- 1. �Ͽ���, 2. ������ ,...... 7. �����
SELECT SYSDATE, NEXT_DAY(SYSDATE,6) FROM DUAL;
SELECT SYSDATE, NEXT_DAY(SYSDATE,'FRIDAY') FROM DUAL; -- �� �ѱ���� �̰� �ȸ���.

-- ��� ����
SELECT * FROM NLS_SESSION_PARAMETERS;

ALTER SESSION SET NLS_LANGUAGE = KOREAN;

--* LAST_DAY(DATE): �ش� ���� ������ ��¥�� ��ȯ����.
-- => ����� : DATE Ÿ��
SELECT LAST_DAY(SYSDATE) FROM DUAL;

--EMPLOYEE���� �����, �Ի���, �Ի��Ѵ��� ������ ��¥, �Ի��� �޿� �ٹ��� �ϼ� 
SELECT EMP_NAME, HIRE_DATE, LAST_DAY(HIRE_DATE), LAST_DAY(HIRE_DATE)-HIRE_DATE AS "�ٹ��ϼ�"
FROM EMPLOYEE;

/*
    * EXTRACT : Ư����¥�κ��� �⵵| �� | �� ���� �����ؼ� ��ȯ�ϴ� �Լ�.
    
    EXTRACT(YEAR FROM DATE) :������ ����
    EXTRACT(MONTH FROM DATE) : ���� ����
    EXTRACT(DAY FROM DATE) : �ϸ� ����
*/

--�����, �Ի�⵵, �Ի��, �Ի��� �Ի�⵵������ ����
SELECT EMP_NAME, EXTRACT(YEAR FROM HIRE_DATE) AS "�Ի�⵵", EXTRACT(MONTH FROM HIRE_DATE) AS "�Ի��"
, EXTRACT(DAY FROM HIRE_DATE) AS "�Ի���"
FROM EMPLOYEE
--ORDER BY EXTRACT(YEAR FROM HIRE_DATE), EXTRACT(MONTH FROM HIRE_DATE), EXTRACT(DAY FROM HIRE_DATE);
--ORDER BY "�Ի�⵵", "�Ի��", "�Ի���"; --ASC, DESC
ORDER BY 2,3,4;
-- ������ FROM -> WHERE -> SELECT -> ORDER BY �̱⿡ ORDER BY������ ��Ī��� ����.
-- ���� WHERE �� ORDER BY������ �÷��� ������ �Է��ؼ� ��뵵 �����ϴ�. 


-----------------------------------------------------------------------------------
/*
    < ����ȯ �Լ� >
    ������ �ܿ�����.
    
    *TO_CHAR() : ���� Ÿ�� �Ǵ� ��¥ Ÿ���� ���� ����Ÿ������ ��ȯ�����ִ� �Լ�
    
    TO_CHAR(����|��¥, [����])        => ������� CHARATER Ÿ��!!
*/

-- ����Ÿ�� => ����Ÿ��
SELECT TO_CHAR(1234) FROM DUAL; --'1234'�� �ٲ������

SELECT TO_CHAR(12345,'99999') FROM DUAL; --'99999' 5ĭ¥�� ����Ȯ�� ������ ���ĵ���, ��ĭ ���� 
SELECT TO_CHAR(1234,'0000') FROM DUAL; -- 9�Ǵ� 0�� ����. 0�ϰ�� ������� 0���� ä��.
--LPAD�� ����ϳ�
SELECT TO_CHAR(1234,'L99999') FROM DUAL; -- ���� ������ ����(L: LOCAL)�� ȭ�����
SELECT TO_CHAR(1234,'$99999') FROM DUAL;
SELECT TO_CHAR(12345,'L999,999') FROM DUAL; -- �̷��� ������ ������ �� �ִ�.

SELECT EMP_NAME, TO_CHAR(SALARY,'L999,999,999') AS "SALARY"
FROM EMPLOYEE;
-- �ᱹ ���ڸ� ������ �ҷ��� ���ڿ��� �ٲ������.

--��¥ Ÿ�� => ����Ÿ��
SELECT SYSDATE FROM DUAL;
SELECT TO_CHAR(SYSDATE)FROM DUAL; -- Ŭ���غ��� �ٸ�! ��¥ Ÿ���� �ð� ���� ��� �ȳ���
SELECT TO_CHAR(SYSDATE,'AM HH:MI:SS')FROM DUAL; --HH: 12�ð� ����
SELECT TO_CHAR(SYSDATE,'PM HH24:MI:SS')FROM DUAL; --HH24: 24�ð� ����
SELECT TO_CHAR(SYSDATE,'YYYY-MM-DD DAY DY')FROM DUAL;
-- ��¥�� �ڹٺ��� DB���� ���� �ٷ��. �ڹٴ� �� �̻��ؼ�
SELECT TO_CHAR(SYSDATE,'MON, YYYY')FROM DUAL;
SELECT TO_CHAR(SYSDATE,'YEAR MM-DD')FROM DUAL;
SELECT TO_CHAR(SYSDATE,'YYYY.MM.DD AM HH:MI:SS DAY')FROM DUAL;

SELECT EMP_NAME, TO_CHAR(HIRE_DATE,'YYYY-MM-DD DAY HH:MI:SS')
FROM EMPLOYEE;

--EX) 1990�� 02�� 06�� ��������
SELECT EMP_NAME, HIRE_DATE, TO_CHAR(HIRE_DATE,'YYYY"��" MM"��" DD"��"') -- ���信 ���� ���� �ֵ���ǥ�� ���θ� ��.
FROM EMPLOYEE;

--�⵵�� ���õ� ����
SELECT TO_CHAR(SYSDATE,'YYYY'),
       TO_CHAR(SYSDATE, 'YY'),
       TO_CHAR(SYSDATE,'RRRR'),
       TO_CHAR(SYSDATE,'RR'),
       TO_CHAR(SYSDATE,'YEAR')
FROM DUAL;

--���� ���õ� ����
SELECT TO_CHAR(SYSDATE,'MM'),
       TO_CHAR(SYSDATE,'MON'),
       TO_CHAR(SYSDATE,'MONTH'),
       TO_CHAR(SYSDATE,'RM')
FROM DUAL;

--�ϰ� ���õ� ����
SELECT TO_CHAR(SYSDATE,'DDD'), --���� �������� ������ ��ĥ°����
       TO_CHAR(SYSDATE,'DD'), --�� �������� ������ ����° ����.
        TO_CHAR(SYSDATE,'D') --�� �������� ����° ���� 1. �Ͽ��� 2. ������,..
FROM DUAL;

--���Ͽ� ���� ����
SELECT TO_CHAR(SYSDATE,'DAY'),
       TO_CHAR(SYSDATE,'DY') 
FROM DUAL;
-----------------------------------------------------------------------------
/*
    * TO_DATE : ����Ÿ�� �Ǵ� ����Ÿ�� �����͸� ��¥ Ÿ������ ��ȯ�����ִ� �Լ�
    
    TO_DATE(����|����,[����])         => ����� : DATE Ÿ��
*/
SELECT TO_DATE(20100101) FROM DUAL;
SELECT TO_DATE(100101) FROM DUAL;

SELECT TO_DATE(070101) FROM DUAL; -- �����߻�
SELECT TO_DATE('070101') FROM DUAL; --ù���ڰ� 0�� ��쿡�� ����Ÿ������ ������ �ؾ��Ѵ�.

SELECT TO_DATE('041030 143000') FROM DUAL; --�����߻�
SELECT TO_DATE('041030 143000','YYMMDD HH24MISS') FROM DUAL;

SELECT TO_DATE('140630','YYMMDD') FROM DUAL; --2014��
SELECT TO_DATE('980630','YYMMDD') FROM DUAL; -- 2098������ ���� => ������ ���� ����� �ݿ�

SELECT TO_DATE('140630','RRMMDD') FROM DUAL; --2014
SELECT TO_DATE('980630','RRMMDD') FROM DUAL; --1998
--RR: �ش� ���ڸ� �⵵ ���� 50 �̸��� ��� ���� ���⸦ �ݿ�, 50 �̻��� ��� �������⸦ �ݿ�
-- �ֹ� ��ȣ�� RR�� �ٷ��.
--������������ ��¥�� �Է��ϸ� �ڹٷ� �Ѿ�� ���ڿ� Ÿ������ �Ѿ. ���� DB���� ���ڿ� Ÿ������ �Ѿ
--���� �����ʹ� DATE Ÿ���̱⿡ �̷� ����ȯ�� �������.

----------------------------------------------------------------------------------------
/*
    *TO_NUMBER : ����Ÿ���� �����͸� ����Ÿ������ ��ȯ�����ִ� �Լ�
    
    TO_NUMBER(����,[����])      => ����� : NUMBER Ÿ��
*/

SELECT TO_NUMBER('013234320') FROM DUAL; --0�� ������ ����Ÿ������ �����.

SELECT '100000000' + '5500000' FROM DUAL; --����Ŭ������ �ڵ�����ȯ�� �� ������
SELECT '100,000,000' + '5,500,000' FROM DUAL; -- ������ �ȿ� ���ڸ� �־�� �ڵ� ����ȯ�� �ȴ�.
SELECT TO_NUMBER('100,000,000','999,999,999')+ TO_NUMBER('55,000','99,999') FROM DUAL; -- ��������ȯ
--------------------------------------------------------------------------------
/*
    < NULL ó�� �Լ� > �߿� �� �ܿ�����.
*/
--NVL(�÷�, �ش� �÷����� NULL�ϰ�� ��ȯ�� ��)
SELECT EMP_NAME, BONUS,NVL(BONUS,0)
FROM EMPLOYEE;

--��ü ����� �̸��� ���ʽ� ���� ������ �غ��ڴ�.
SELECT EMP_NAME, TO_CHAR((SALARY+SALARY*NVL(BONUS,0))*12, 'L999,999,999' ) || '��' AS "����"
FROM EMPLOYEE;

SELECT EMP_NAME, NVL(DEPT_CODE,'�μ�����')
FROM EMPLOYEE;

SELECT NVL(NULL, 'NULL��') FROM DUAL;

--NVL2(�÷�, ��ȯ��1, ��ȯ��2) : NULL�� �ƴϸ� ��ȯ��1�� ��µǰ� NULL�̸� ��ȯ��2�� ��µ�.
--�÷����� ������ ��� ��ȯ�� 1�� ��ȯ
-- �÷����� NULL�� ��� ��ȣ���� 2�� ��ȯ
SELECT EMP_NAME, NVL2(DEPT_CODE, '�μ�����', '"�μ�����"')
FROM EMPLOYEE;

-- ���ʽ��� �ִ�: 0.7/ ���� : 0.1
SELECT EMP_NAME, NVL2(BONUS,0.7,0.1)
FROM EMPLOYEE;

-- NULLIF(�񱳴��1, �񱳴��2)
-- �� ���� ���� ��ġ�ϸ� NULL ��ȯ
-- �� ���� ���� ��ġ���� ������ �񱳴��1 ���� ��ȯ
SELECT NULLIF('123','123')FROM DUAL;
SELECT NULLIF('123','456')FROM DUAL;

--------------------------------------------------------------------------------
/*
    <���� �Լ�>  �ܿ�� ��
    *DECODE(���ϰ����ϴ� ���(�÷�|�������|�Լ���), �񱳰�1, �����1, �񱳰�2, �����2)
    
    SWITCH(����� ���){
    CASE �񱳰�1:BREAK;
    CASE �񱳰�2:BREAK;
    ...
    DEFAULT: BREAK;
*/

--���, �����, �ֹι�ȣ
SELECT
EMP_ID, EMP_NAME, EMP_NO,SUBSTR(EMP_NO, 8,1),
DECODE(SUBSTR(EMP_NO,8,1),'1','��','2','��','3','��','4','��') AS "����"
FROM EMPLOYEE;

--������ �޿��� ��ȸ�� ���޺��� �λ��ؼ� ��ȸ
-- J7 10% �λ� SALARY*1.1�ϸ� ��.
--J6�� ��� 15%�λ�
--J5�� ��� 20% �λ�
-- �׿��� ������ ����� �޿��� 5%�λ�
SELECT EMP_NAME, JOB_CODE, SALARY,
DECODE(JOB_CODE,'J7',SALARY*1.1,'J6',SALARY*1.15,'J5',SALARY*1.2,SALARY*1.05) AS "�λ�� �޿�" -- ����Ʈ�� �׳� �������� ���� �ظ��� ��
FROM EMPLOYEE;

/*
    *CASE WHEN THEN
    
    CASE WHEN ���ǽ�1 THEN �����1
        WHEN ���ǽ�2 THEN �����2
        ...
        ELSE �����
    END
*/

SELECT EMP_NAME, SALARY,
       CASE WHEN SALARY >= 5000000 THEN '��ް�����'
            WHEN SALARY >=3500000 THEN '�߱ް�����'
            ELSE '�ʱް�����'
        END AS "����"
FROM EMPLOYEE;

---------------------------------------< �׷� �Լ� >-----------------------------
--1. SUM(NUMBER) : �ش� �÷� ������ ���հ踦 ���ؼ� ��ȯ���ִ� �Լ�

-- EMPLOYEE ���̺��� �� ����� �� �޿���
SELECT SUM(SALARY)
FROM EMPLOYEE; --��ü ����� �� �׷����� ����

-- ���� ������� �� �޿� ��
SELECT SUM(SALARY)
FROM EMPLOYEE
WHERE SUBSTR(EMP_NO, 8,1) IN ('1','3'); --���� ������� �� �׷����� ����

-- �μ��ڵ尡 D5�� ������� �� ���� ��
SELECT TO_CHAR(SUM(SALARY*12),'999,999,999')||'��' AS "���� ��"
FROM EMPLOYEE
WHERE DEPT_CODE = 'D5';

--2. AVG(NUMBER) : �ش� �÷����� ��հ��� ���ؼ� ��ȯ�Ѵ�.
-- ��ü����� ��� �޿� ��ȸ
SELECT TRUNC(AVG(SALARY))
FROM EMPLOYEE;

--3. MIN(����Ÿ��) : �ش� �÷����� �߿� ���� ���� �� ���ؼ� ��ȯ
SELECT MIN(EMP_NAME),MIN(SALARY), MIN(HIRE_DATE)
FROM EMPLOYEE;

-- 4. MAX(����Ÿ��) : �ش� �÷����� �߿� ���� ū �� ���ؼ� ��ȯ
SELECT MAX(EMP_NAME), MAX(SALARY), MAX(HIRE_DATE)
FROM EMPLOYEE;

-- 5. COUNT(*|�÷�|DISTINCT �÷�) : ��ȸ�� �� ������ ���� ��ȯ
-- COUNT(*): ��ȸ�� ����� ��� �� ������ ���� ��ȯ
-- COUNT(�÷�) : ������ �ش� �÷����� NULL�� �ƴ� �͸� �� ���� ���� ��ȯ
-- COUNT(DISTINCT �÷�) : �ش� �÷��� �ߺ��� ������ �� �� ���� ���� ��ȯ

-- ��ü ��� ��
SELECT COUNT(*)
FROM EMPLOYEE;

-- ���� ����� 
SELECT COUNT(*)
FROM EMPLOYEE
WHERE SUBSTR(EMP_NO, 8,1) IN ('2','4');

-- �μ��� ���»����
SELECT COUNT(*)
FROM EMPLOYEE
WHERE DEPT_CODE IS NULL;

-- ���ʽ��� �޴� ��� ��
SELECT COUNT(BONUS) -- �÷��� NULL�� �ƴѰŸ� ī���� �Ѵ�.
FROM EMPLOYEE;

--�μ���ġ�� ���� ����� 
SELECT COUNT(DEPT_CODE)
FROM EMPLOYEE;

SELECT COUNT(DISTINCT DEPT_CODE)
FROM EMPLOYEE;

SELECT DISTINCT DEPT_CODE
FROM EMPLOYEE;















