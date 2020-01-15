## ABAP

### 1. T-Code

> SE16N : 일반 데이터 조회

> SE11 : ABAP Dictionary 생성

> SE80 : Repository Brower


#### SAP MM T-Code 리스트


- 1) 자재마스터 ( Material Master )
* MM01 - 자재마스터 생성(확장)
* MM02 - 자재마스터 변경
* MM03 - 자재마스터 조회
* MM04 - 자재마스터 변경내역 조회
* MM50 - 자재마스터 뷰 확장

- 2) 단가생성: 정보레코드 ( Purchasing Info Record ) 
* ME11 - 정보레코드 생성
* ME1M - 정보레코드 리스트(자재별) *잘 생성 되었나!!!
* ME12 - 정보레코드 변경
* ME13 - 정보레코드 조회
* ME14 - 정보레코드 변경내역 조회
* ME15 - 정보레코드 삭제

- 3) 구매요청 ( Purchase Requisition )
* ME51N - 구매요청 생성 (수동)    OR   MD02 – 구매요청 MRP로 생성 (자동)
* MD04 – 제고 소요량 리스터 검토
* ME52N - 구매요청 변경
* ME53N - 구매요청 조회

- 4) 구매오더 ( Purchase Order )
* ME21N – 구매오더 생성 (수동) *문서개요 필요
* ME59 – 구매오더 생성 (자동) 
* ME22N - 구매오더 변경
* ME23N - 구매오더 조회
* ME2M - 구매오더 리스트(자재별)
* ME2N - 구매오더 리스트(구매오더번호별)


- 5) 재고관리 ( Inventory Management )
* MIGO – 입고잡기!!!!! 자재이동(입고,조회,대체전기 종합)
* 대체전기: 자재를 이동할 때, EX) 311 (자재간 위치 이동), 321 (품질검사 중 가용재고로 하는 것)
* MMBE - 재고 개요
MD04 – 구매번호 아는 것!!!!!! 재고/소요량 리스트 *구매요청 조회

- 6) 물류송장검증 ( Invoice Verification )
* MIRO - 송장 입력
* MD04 – 구매번호 아는 것!!!!!! 재고/소요량 리스트 *구매요청 조회

------

:+1: 
* 자재 마스터로 자재생성 MM01-> 단가생성 ME11 -> 잘 생성되었나 ME1M
* 수동 구매요청 ME51M -> 수동 구매오더 ME21M / 자동 구매오더 ME59
* 자동 구매요청 MD02 -> 검토 MD04 -> 수동 구매오더 ME21N / 자동 구매오더 ME59

------

:+1:
* 입고잡기 MIGO -> 조회 및 재고 개요 -> 대체전기 *오른쪽 위치 번호 확인
* 송장처리 MIRO -> 자재에 대한 구매오더 ME2M

------


### 2. Internal-Table
