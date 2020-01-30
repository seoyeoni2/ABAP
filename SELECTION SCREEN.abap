<SELECTIO SCREEN>

1. SELECTION-SCREEN BEGIN OF LINE.
   SELECTION-SCREEN END OF LINE.

   - 파라미터를 여러 개 묶어서 한 라인으로 생성
   - 라인에서 SELECT-OPTIONS, SELECTION-SCREEN SKIP N 구문을 사용할 수 없음

2. SELECTION-SCREEN BEGIN OF block.
   SELECTION-SCREEN END OF block.

   - 파라미터, SELECT-OPTIONS 등 블록 형성
   - WITH FRAME : 프레임을 추가함
   - TITLE title : 프레임의 TITLE 을 추가함
   - NO INTERVALS : 블록 안의 SELECT-OPNTIONS 의 LOW 값만 보임

*-----------------------------------------------------------------------------------------
EX)
    SELECTION-SCREEN BEGIN OF BLOCK B1 WITH FRAME TITLE TEXT-S01.
        SELECT-OPTIONS S_ZID FOR ZDEVA00_TA01-ZID
                                MEMORY ID ZID        "SET 파라미터에 넣은 값이 나온다는 뜻
                                "  NO-EXTENSION
                                "  NO INTERVALS
                                .

        PARAMETERS: P_ZADDR  TYPE ZDEVA01_DEZADDR VISIBLE LENGTH 25,
                    P_C2 AS CHECKBOX USER-COMMAND U1,
                    P_C1 AS CHECKBOX MODIF ID M1.

        SELECTION-SCREEN BEGIN OF BLOCK B3 WITH FRAME TITLE TEXT-S03.
            PARAMETERS: P_ZPHONE TYPE NUMC2 MODIF ID M2,
                        P_ZNAME  TYPE NUMC1 MODIF ID M2.

        SELECTION-SCREEN END OF BLOCK B3.
    SELECTION-SCREEN END OF BLOCK B1.


    SELECTION-SCREEN BEGIN OF BLOCK B2 WITH FRAME TITLE TEXT-S02.
        PARAMETERS: P_R1 RADIOBUTTON GROUP G1,  "<- 남성만 조회
                    P_R2 RADIOBUTTON GROUP G1,  "<- 여성만 조회
                    P_R3 RADIOBUTTON GROUP G1.  "<- 전체 조회
    SELECTION-SCREEN END OF BLOCK B2.
