반복문

1. LOOP        
    - LOOP AT LT_VALUE INTO LS_VALUE.
    - LOOP 안에서는 SY-TABIX

2. DO

   - DO ? TIMES    " ? 만큼 돈다
     + READ 문

   - DO 안에서는 SY-INDEX

* 인덱스: 어떤 데이터가 어디에 있다는 위치 정보를 가진 주소록

*&--------------------------------------------------------------------------------------------------------------*
# 읽기: READ

READ TABLE INTERNAL_TABLE INTO INDEX ?? .        "INTO 뒤에는 테이블 라인 박는다고 생각.
    OR
READ TABLE INTERNAL_TABLE INTO WITH KEY NAME = LS_DATA-NAME.

*&--------------------------------------------------------------------------------------------------------------*

# 추가: APPEND

APPEND

*INTERNAL DATA
".. MAKE DATA
LS_VALUE-ZID = '1911A08'.
LS_VALUE-ZNAME = '김서연'.
LS_VALUE-ZSEX = 'F'.
LS_VALUE-ZAGE = 25.
APPEND LS_VALUE TO LT_VALUE.

READ TABLE LT_DATA INTO LS_DADTA INDEX / WITH KEY

*&--------------------------------------------------------------------------------------------------------------*
# 수정: MODIFY

LOOP AT LT_CLASS INTO LS_CLASS.
        ADD 2 TO LS_CLASS-ZAGE.

        MODIFY LT_CLASS FROM LS_CLASS.
        CLEAR LS_CLASS.
ENDLOOP.

*&--------------------------------------------------------------------------------------------------------------*
# 삭제: DELETE

1. 첫 번째 DELETE 방법

    DELETE LT_CLASS WHERE ZSEX = 'M'.   "EQ

2. 두 번째 DELETE 방법

    LOOP AT LT_CLASS INTO LS_CLASS.
        LV_TABIX = SY-TABIX.
        IF LS_CLASS-ZID = '1911A07' AND LS_CLASS-ZSEX = 'M'.
            DELETE LT_CLASS INDEX LV_TABIX.
            CLEAR LS_CLASS.          " CONTINUE 전에 헤더 클리어 해주는 것이 필요!!
                                     " -> 끝나지 않고 다시 위로 올라가서 수행하게.
            CONTINUE.                " LOOP안에서 쓰려면 CONTINUE 써야함
                                     " -> CONTINUE를 타서 밑에 로직까지 안가니깐 LOOP 끝나기 전 CLEAR가 안된다.
                                     " -> 그래서 CONTINUE 전, CLEAR를 해주어어야 한다. 안갔으니깐 CLAER.
        ENDIF.
        CLEAR LS_CLASS.                  
    ENDLOOP.

*&--------------------------------------------------------------------------------------------------------------*
# COLLECT : KEY값 중 중복되는 KEY의 값을 합쳐줌

EX) LOOP AT LT1_CLASS INTO LS1_CLASS.
        LS1_CLASS-ZCNT = 1.
        MODIFY LT1_CLASS FROM LS1_CLASS.
        COLLECT LS1_CLASS INTO LT2_CLASS.
    ENDLOOP.

=> COLLECT LS1_CLASS INTO LT2_CLASS.