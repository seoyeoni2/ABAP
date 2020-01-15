*&---------------------------------------------------------------------*
*& Report ZDEVA08_RE11
*&---------------------------------------------------------------------*

"ZDEVA00_TA01 정보를 추출한다                // INTERNAL TABLE 1
"나이(ZAGE)를 유니크하게 담는다.             // INTERNAL TABLE 2
"INTERNAL TABLE 2를 LOOP로 돌아 WRITE 한다.
"결과를 LOOP로 돌아 라인카운트와 나이를 WRTIE 한다.

REPORT ZDEVA08_RE11.

TYPES: BEGIN OF TY_CLASS,
         ZAGE   TYPE ZDEVA00_TA01-ZAGE,
         ZCOUNT TYPE I,                          "I 는 수량을 나타냄
       END OF TY_CLASS.

DATA: LS_CLASS   TYPE TY_CLASS,                              "구조체1: 스트럭쳐
      LT_CLASS_1 TYPE TABLE OF TY_CLASS,                     "테이블1: ZAGE가 담길 테이블
      LT_CLASS_2 TYPE TABLE OF TY_CLASS.                     "테이블2: 결과값이 들어갈 테이블

CLEAR LT_CLASS_1[].
CLEAR LT_CLASS_2[].

"... ZDEVA00_TA01의 데이터를 가져오는 LT_CLASS_1
SELECT ZAGE                                                  "*: 테이블에 있는 데이터의 양을 다 읽기 때문에 처리할 데이터의 양이 많음
  INTO CORRESPONDING FIELDS OF TABLE LT_CLASS_1              "테이블1: ZDEVA00_TA01을 참조받음
  FROM ZDEVA00_TA01.

"... MAKE DATA
LOOP AT LT_CLASS_1 INTO LS_CLASS.                            "LT_CLASS_1가 가지고 있는 열 갯수만큼 돌린다.
  READ TABLE LT_CLASS_2 INTO LS_CLASS WITH KEY ZAGE = LS_CLASS-ZAGE.
  IF SY-SUBRC <> 0.                                          "ZAGE =! LS_CLASS-ZAGE      // 나이가 중복되는 값이 아니면, 값이 다르면 / LT_CLASS_2는 비어있는 테이블이다. 
    LS_CLASS-ZCOUNT = '1'.
    APPEND LS_CLASS TO LT_CLASS_2.
    CLEAR LS_CLASS.
  ELSE.                                                      "ZAGE = LS_CLASS-ZAGE       // 나이가 중복일 때
    ADD 1 TO LS_CLASS-ZCOUNT.
    MODIFY LT_CLASS_2 FROM LS_CLASS INDEX SY-TABIX.          "INDEX SY-TABIX: 행 번호는 READ를 했을 때 알아서 설정이 되고 그 행을 수정해준다.
  ENDIF.
ENDLOOP.

SORT LT_CLASS_2 BY ZAGE ASCENDING.
LOOP AT LT_CLASS_2 INTO LS_CLASS.
  WRITE:/ SY-TABIX,
          LS_CLASS-ZCOUNT,
          LS_CLASS-ZAGE.
  CLEAR LS_CLASS.
ENDLOOP.