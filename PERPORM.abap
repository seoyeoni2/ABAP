PERFORM 

= 제어문

1. 소스의 간결화
2. 동일한 소스를 여러번 사용할 수 있다
 
*-------------------------------------------------------------
PERFORM form.
  가장 일반적으로 사용하는 유형이며 form 문이 정의된 곳으로 실행의 위치가 이동.

  1) USING
    : PARAMETER들을 정의하고, PERFORM 문에서 사용될 값을 넘겨준다.
    : 즉, PERFORM으로 값을 던지기 위한 단어

  -> 밖에서 안으로 들어온다.
  -> 데이터 던지기, 받기 둘 다 가능
    (USING에서 값을 던지고, FORM 에서 받음) 


EX)
PERFORM MAKE_DATA USING '1911A08'
                        '김서연'
                        '25'.

PERFORM MAKE_DATA USING '1911A07'
                        '정민우'
                        '24'.


FORM MAKE_DATA  USING   PV_ZID
                        PV_ZNAME
                        PV_ZAGE.

LS_CLASS-ZID = PV_ZID.
LS_CLASS-ZNAME = PV_ZNAME.
LS_CLASS-ZAGE = PV_ZAGE.
APPEND LS_CLASS TO LT_CLASS.
CLEAR LS_CLASS.

*-------------------------------------------------------------

2) CHANGING  
  : USING 문과 동일한 의미
  
  : USING 과 차이점
    -> USING 은 변수를 넘겨줄 때 INPUT 의 의미,
    -> CHANGING 은 PERFORM 문이 수행되고 난 후의 OUTPUT 을 의미

  : 즉, PERFORM이라고 하는것은 USING(밖에서 안으로), CHANGING(안에서 밖으로)이 있다.

EX)
PERFORM CALCUL USING LV_VALUE1
                     LV_VALUE2
               CHANGING LV_RESULT.

FORM CALCUL  USING    PV_VALUE1
PV_VALUE2
CHANGING PV_RESULT.

*-------------------------------------------------------------
3) TABLES IT1 IT2 ...
  : 일반 변수가 아닌 INTERNAL TABLE을 PARAMETER로 넘길 때 사용


*TABLES   VS  USING, CHANGING

-> TABLES: INTERNAL TABLE 을 위한 것
-> USING, CHANGING 구조체나 변수 하나 던져 줄 때 


*-------------------------------------------------------------
[ STRUCTURE ] 

스트럭처는 LIKE 를 이용해서 던지고 받는다.

EX)
PERFORM CALCUL2 USING LS_VALUE.
WRITE LS_VALUE-TOTAL.

FORM CALCUL2  USING    PS_VALUE LIKE LS_VALUE.

  PS_VALUE-TOTAL = PS_VALUE-VALUE1
                 + PS_VALUE-VALUE2
                 + PS_VALUE-VALUE3
                 + PS_VALUE-VALUE4
                 + PS_VALUE-VALUE5.
ENDFORM.

전역변수: 프로그램 가장 상단에 선언, 해당 프로그램 어디에서든 인지 가능
지역변수: PERFORM 의 FORM, PERFORM 안에서만 사용 가능,


*-------------------------------------------------------------
[ INCLUDE ] 

INCLUDE: ZDEVA08_RE21T01.                "Global definition: 전역변수    ->    GT_CLASS 로 바꿈
         ZDEVA08_RE21F01,                "Subroutine

ZDEVA08_RE21T01
  -> DATA: GT_CLASS TYPE TABLE OF ZDEVA00_TA01.
  => T에 전역변수 DATA 선언

STRUCTURE ZDEVA00_TA01을 사용하는 것보다 LIKE GT_CLASS를 사용!
  -> 왜냐하면 GT_CLASS를 ZDEVA08_RE21T01 전역변수로 만들어 주었기 때문!!

*-------------------------------------------------------------
[ EVENT ]

1. START-OF-SELECTION

일종의 변수.
단, 한번 멈춘다음 실행

2. Initialization

