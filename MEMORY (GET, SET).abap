<SAP MEMORY & ABAP MEMORY>

사용목적: 한 명의 사용자가 연관성 있는 프로그램을 사용하게 될 경우,
         A -> B  OR  B -> A 로 데이터를 넘겨주는 상황을 처리

*-----------------------------------------------------------------------------------------         
1. 용어설명

    <SAP MEMORY>
        1) EXTERNAL SESSTION 간 데이터를 공유할 목적으로 
          로그인 된 순간부터 종료될 때까지 유지되는 메모리 영역

    <ABAP MEMORY>
        1) 1개의 프로그램 WINDOW 가 'CALL TRANSATION' 을 통해 
          순간적으로 데이터를 넘겨주고 받아야 할 경우 사용되는 메모리 영역

*-----------------------------------------------------------------------------------------
2. [프로그램A]에서 [프로그램B]로 데이터를 넘겨주는 방법

    <SAP MEMORY>
        [프로그램A]와 [프로그램B]가 동시에 실행중이라면,
        - [프로그램A]는 SET 명령을 통해 데이터를 기록
        - [프로그램B]는 GET 명령을 통해 데이터를 확인

    <ABAP MEMORY>
        - [프로그램A]에서 EXPORT 명령을 통해 데이터를 내보낸 후, 
           CALL TRANSACTION 을 통해 [프로그램B]실행
        - [프로그램B]에서 IMPORT 명령을 통해 데이터를 확인

*-----------------------------------------------------------------------------------------
3. 비교

    <SAP MEMORY>
        - 사용하기 전 SAP MEMORY에서 사용할 파라미터의 값을 설정 해야한다.
        
        1) PARAMETERS : p_1 TYPE c MEMORY ID 'pid'.  
            " ABAP Memory 'pid'를 화면파라멘타 p_1에 연계시킨다.

        2) SET PARAMETER ID <pid> FIELD <f>. 
            " ABAP Memory에 <pid> = <f>를 할당한다. 
        3) GET PARAMETER ID <pid> FIELD <f>. 
            " ABAP Memory로 부터 <f> = <pid>를 할당한다. 
              
        EX) SET PARAMETER ID 'Z1911A08' FIELD LV_VALUE.
            GET PARAMETER ID 'Z1911A08' FIELD LV_GET.

    
        - 장점: 글로벌하게 사용할 수 있다.
        - 단점  
            1) SAP MEMORY에 저장할 수 있는 데이터의 제약이 너무 크다. 
                ★파라미터만 가능★ , 'INTERNAL TABLE, STRUCTURE 불가능'
            
                2) SAP MEMORY를 사용하기 전 'MEMORY ID'를 지정해야만 한다.

    <ABAP MEMORY>
        - 주로 'CALL TRANSATION' 명령들을 통해 다른 화면을 호출할 경우, 
          'INTERNAL TABLE, 변수, STRUCTURE'를 넘길 때 사용한다.
        
*-----------------------------------------------------------------------------------------
<EXERCISE>

[프로그램A]
    SET PARAMETER ID 'Z1911A08' FIELD 'ZZZ'.

[프로그램B]
    DATA LV_VALUE(50).

    GET PARAMETER ID 'Z1911A08' FIELD LV_VALUE.
    WRITE LV_VALUE.
        

[GET/SET 가져와서 프로그램 실행]
    REPORT ZDEVA08_RE24 MESSAGE-ID ZDEVA08_MSG01.

    DATA: LV_CODE   TYPE CHAR1,
        LS_RETURN TYPE ZDEVA00_ST04,
        LV_RESULT TYPE MENGE_D.


    PARAMETERS: VALUE1 TYPE NUMC2,    "값1
                VALUE2 TYPE NUMC2.    "값2

    PARAMETERS: P_R1 RADIOBUTTON GROUP G1,
                P_R2 RADIOBUTTON GROUP G1 DEFAULT 'X',
                P_R3 RADIOBUTTON GROUP G1,
                P_R4 RADIOBUTTON GROUP G1.


    INITIALIZATION.

    DATA LV_GET.
    GET PARAMETER ID 'Z1911A08' FIELD LV_GET.

    IF LV_GET = '+'.
        P_R1 = 'X'.
        P_R3 = ''.

    ELSEIF LV_GET = '-'.
        P_R2 = 'X'.
        P_R3 = ''.

    ELSEIF LV_GET = '*'.
        P_R3 = 'X'.

    ELSEIF LV_GET = '/'.
        P_R4 = 'X'.
        P_R3 = ''.
    ENDIF.


    "활성화 조회하고 값 넣은 후 한번 더 조회버튼 눌러주어야 값이 나온다.
    START-OF-SELECTION.                 

    IF P_R1 = 'X'.
        LV_CODE = '+'.
    ELSEIF P_R2 = 'X'.
        LV_CODE = '-'.
    ELSEIF P_R3 = 'X'.
        LV_CODE = '*'.
    ELSE.
        LV_CODE = '/'.
    ENDIF.

    "여기서 SET이 타야만 CALL 함수로 넘어가서 값이 넘어간다.
    SET PARAMETER ID 'Z1911A08' FIELD LV_CODE.      

    CALL FUNCTION 'ZDEVA08_F01'
    EXPORTING
    IP_VALUE1       =  VALUE1
    IP_VALUE2       =  VALUE2
    IV_CODE         =  LV_CODE
    IMPORTING
    EV_RESULT       = LV_RESULT
    ES_RETURN       = LS_RETURN.

    IF LS_RETURN-MTYPE = 'E'.
    MESSAGE S000(ZDEVA08_MSG01) WITH LS_RETURN-MESSAGE DISPLAY LIKE 'E'.
    EXIT.
    ELSE.
    MESSAGE S000(ZDEVA08_MSG01) WITH '계산이 정상적으로 실행되었습니다.'.
    ENDIF.

