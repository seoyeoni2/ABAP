INTERNAL TABLE 개념정리

- 프로그램 내에서 정의하여 사용할 수 있는 LOCAL TABLE
- 프로그램이 실행되고 있는 동안 생성되는 임시적인 테이블

# 추가: APPEND
# 읽기: READ
# 수정: MODIFY
# 삭제: DELETE

헤더가 무조건 있어야 하고, 헤더를 선언해주어야 한다.


INTERNAL TABLE 선언 방법 '4가지'

1. 변수 - LIKE TABLE OF

DATA: BEGIN OF LS_VALUE,
            ZID TYPE ZDEVA04_DEZID,
            ZNAME TYPE CHAR20,
            ZSEX TYPE ZDEVA04_DESEX,
            ZAGE TYPE ZDEVA04_DEAGE,
          END OF LS_VALUE.                             "INTERNAL TABLE용 HEADER
DATA: LT_VALUE LIKE TABLE OF LS_VALUE.      "INTERNAL TABLE


2. 구조
    
    2-1. 구조이용 - TYPE TABLE OF

    DATA: LS_VALUE TYPE ZDEVA04_ST02,
              LS_VALUE TYPE TABLE OF ZDEVA04_ST02.

    2-2.구조 이용 - LIKE TABLE OF

    DATA: LS_VALUE TYPE ZDEVA04_ST02,
              LS_VALUE LIKE TABLE OF LS_VALUE.


3. 타입

TYPE: BEGIN OF TY_CLASS,
            ZID  TYPE ZDEVA04_DEZID,
            ZNAME TYPE ZDEVA04_DENAME,
            ZAGE  TYPE ZDEVA04_DEAGE,
            ZSEX  TYPE ZDEVA04_DESEX,
            ZSEX_TEXT TYPE CHAR20,
         END OF TY_CLASS.

DATA: LS_CLASS TYPE TY_CLASS,                       "INTERNAL TABLE HEADER
          LT_CLASS TYPE TABLE OF TY_CLASS         "INTERNAL TABLE

"..MAKE DATA / 내용을 만들어줌
LS_CLASS-ZID = '1011A04'.
LS_CLASS-ZNAME = '김민지'.
LS_CLASS-ZSEX = 'F'.
LS_CLASS-ZAGE = '27'.
APPEND LS_CLASS TO LT_CLASS.                        "위 내용을 추가
CLEAR LS_CLASS.

LOOP AT LT_CLASS INTO LS_CLASS.
    WRITE:/ LS_CLASS-ZID,
                LS_CLASS-ZNAME,
                LS_CLASS-ZSEX,
                LS_CLASS-ZPHONE.
    CLEAR LS_CLASS.
ENDLOOP.
                                               

4. 타입 2   => TYPE + DATA 사용하면 SELECT문 써주어야 한다.

TYPES: BEGIN OF TY_CLASS.
            INCLUDE STRUCTURE ZDEVA00_TA01.
            TYPES: ZSEX_TEXT TYPE CHAR20,           "새로운 필드 추가
          END OF TY_CLASS.
DATA: LS_CLASS TYPE TY_CLASS,
          LT_CLASS TYPE TABLE OF TY_CLASS.


"..GET DATA
SELECT ZID ZNAME ZSEX ZPHONE
    INTO CORRESPONDING FIELDS OF TABLE LT_CLASS
    FROM ZDEVA00_TA01
    WHERE ZGROUP = '2'.


LOOP AT LT_CLASS INTO LS_CLASS.
    WRITE:/ LS_CLASS-ZID,
                LS_CLASS-ZNAME,
                LS_CLASS-ZSEX,
                LS_CLASS-ZPHONE.
    CLEAR LS_CLASS.
ENDLOOP.

-> TYPES: BEGIN OF TY_CLASS.                      "뒤에 나오는게 새로운 명령이라 , 이 아닌 .을 쓴다.
            INCLUDE STRUCTURE ZDEVA00_TA01.       "STRUCTURE, TABLE 등 다른 구조도 올 수 있다.
            TYPES: ZSEX_TEXT TYPE CHAR20,         "성별 필드를 하나 더 추가할 수 있다.
          END OF TY_CLASS.
    
    -> 공통으로 사용되는 필드들을  테이블에 Inlcude 하여 사용하는 Structure(구조)를 말합니다. 
    -> 테이블전체를 구조에 포함시키기 위한 구문



    