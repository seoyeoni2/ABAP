SELECT SINGLE

    -> 하나의 유니크한 ROW값
    EX)  SELECT SINGLE ZNAME
            INTO TABLE LV_ZNAME
            FROM ZDEVA08_TA01
            WHERE ZID = '1911A08'.

    -> 선택한 열의 개수가 복수일 경우에 사용
    -> 특히 '('와 첫번째 변수 이름과 공백이 없어야 함

1. CORRESPONDING FIELDS OF TABLE 


    EX) SELECT ZNAME ZID
            INTO CORRESPONDING FIELDS OF TABLE LS_CLASS
            FROM ZDEVA08_TA01
            WHERE ZID = '1911A08'.
    
    : LS_CLASS에 있는 ZNAME, ZAGE를 따로 데이터를 만들어주지 않고 LS_CLASS에 있는 필드에 꽂아주겠다.

    : INTO로 값을 넣어준다는 의미!!


2. SELECT *
    INTO TABLE LT_CLASS
    FROM ZDEVA00_TA02.


    : * 는 TA02에 들어있는 모든 필드들 가져오겠다는 의미!

     SELECT [열] 
        INTO [새 테이블] 
        FROM [테이블] 
        ( WHERE [조건] )

3. INCLUDE STRUCTURE
    -> 공통으로 사용되는 필드들을  테이블에 Inlcude 하여 사용하는 Structure(구조)를 말합니다. 
    -> 테이블전체를 구조에 포함시키기 위한 구문