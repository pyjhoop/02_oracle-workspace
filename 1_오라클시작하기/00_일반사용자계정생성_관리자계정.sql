-- 한줄 주석--

/*
    여러줄
    주석
*/
-- 행번호 토글 추가하기
--모든 계정들에 대해서 조회하는 명령문
SELECT * FROM DBA_USERS;
--명령문 드래그 후 실행해야함.

--일반 사용자계정을 생성하는 구문, 계정생성은 관리자 계정인 sysdba에서 가능
--[표현법] CREATE USER 계정명 IDENTIFIED BY 비밀번호;
--계정명은 대소문자 안가림
CREATE USER kh IDENTIFIED BY kh; 
--이계정으로 + 눌러서 추가해보려 했는데 오류!! => 권한이 부여가 되지 않음.

--위에서 생성된 일반 사용자 계정에게 최소한의 권한(접속, 데이터 관리) 부여
--[표현법] GRANT 권한1, 권한2, ....TO 계정명

GRANT CONNECT, RESOURCE TO kh;
COMMIT;
