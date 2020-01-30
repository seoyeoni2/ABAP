< Field Symbol >

특징
1. C언어의 '포인터'와 비슷한 개념을 가짐

장점
1. Field Symbol 을 잘 이용하면 반복되는 필드들을 짧은 코드로 처리 가능
2. 루프의 속도 개선 가능
3. Internal Table을 동적으로 만들 수 있음

BUT, 무분별한 사용은 유지보수를 하는 사람에게 고통을 줄 수 있으니 개발 할 때
     꼭 필요하거나 성능개선이 꼭 필요한 부분에서만 쓰도록 해야함!!


- Field Symbol을 나름대로 정의를 내리자면 '어딘가를 가르키고 있다'라고 할 수 있다
- Field Symbol은 테이블의 한 row(행)을 가르키거나 변수를 가르킨다.
  그래서 그 곳에 데이터를 넣으면 가르키는 곳으로 바로 데이터가 들어간다.

=> 따라서, Internal Table의 경우 LOOP 를 돌면서 데이터를 변경하고 싶다면 Modify 를 할 필요가 없다.


*--------------------------------------------------------------------------------------------
EX)

FIELD-SYMBOLS <F>

CONCATENATE 'LV_FIELD' '1' INTO LV_FIELD.

"... 이 구문 만나서 포인터가 데이터에 할당 / LV_FIELD에 LV_FIELD1를 할당
ASSIGN (LV_FIELD) TO <F>.                      
WRITE:/ <F>.


*--------------------------------------------------------------------------------------------
EXERCISE)


" 1. ZDEVA00_TA04 IT를 선언한다.
" 2. 위 테이블 정보를 SELECT 하여 IT에 담는다.
" 3. 2에서 추출한 IT의 각 라인의 ZTOTAL을 SUM(FIELD-SYMBOL)이용하여 더하고
"    ZDEVAGE 필드 역시 평균을 계산하여 IT를 MODIFY한다.
" 4. 3을 통해 수정된 IT를 LOOP를 돌아 (MANDT FIELD는 제외) 결과를 WRITE 할 수 있도록 한다.
" 5. 전체 수량의 합: XXX개 <- IT LOOP 밑에 WRITE 하도록...

DATA: LT_TABLE TYPE TABLE OF ZDEVA00_TA04,
      LS_TABLE TYPE ZDEVA00_TA04,
      LV_AVG TYPE P DECIMALS 1,
      LV_INDEX(2) TYPE C,
      LV_FIELD(20),
      LV_FIELD2(20),
      SUM_TOTAL TYPE I,
      AVG_TOTAL TYPE P DECIMALS 1.

SELECT *
  INTO TABLE LT_TABLE
  FROM ZDEVA00_TA04.


FIELD-SYMBOLS <F>.

"... 테이블에 있는 라인 두 줄 돌기
LOOP AT LT_TABLE INTO LS_TABLE.

  "... 열 15개 돌기
  DO 15 TIMES.
    LV_INDEX = SY-INDEX.

    "... MONTH 써주고 싶어서!!!!
    CONCATENATE 'MONTH' LV_INDEX INTO LV_FIELD2.

    "... 라인 읽어오기
    CONCATENATE 'LS_TABLE-ZMONTH' LV_INDEX INTO LV_FIELD.
    ASSIGN (LV_FIELD) TO <F>.

    ADD <F> TO LS_TABLE-ZTOTAL.
    WRITE:/ LV_FIELD2, <F>.
  ENDDO.

  MODIFY LT_TABLE FROM LS_TABLE.
  LV_AVG = LS_TABLE-ZTOTAL / 15.

  ADD LS_TABLE-ZTOTAL TO SUM_TOTAL.
  ADD LV_AVG TO AVG_TOTAL.

  AVG_TOTAL = LV_AVG / 2.

SKIP 1.
  WRITE:/ LS_TABLE-ZKEY1, '수량의 합', LS_TABLE-ZTOTAL, '수량의 평균', LV_AVG.
SKIP 1.
ENDLOOP.

SKIP 1.
WRITE:/ '전체 수량의 합:', SUM_TOTAL, '전체 평균:', AVG_TOTAL.