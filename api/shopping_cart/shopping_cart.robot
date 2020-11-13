*** Settings ***
Library    RequestsLibrary
Suite Setup    Create Session    alias=${ALIAS}     url=${URL}

*** Variables ***
${URL}    https://dminer.in.th
${ALIAS}    shopping
&{HEADER}    Content-Type=application/json    accept=application/json

*** Test Cases ***
User purchase item select Kerry as shipping method and pay with Visa card and success
    Search
    Product Detail
    Sumbit Order
    Confirm Payment

*** Keywords ***
Search
    ${resp}=    Get Request    alias=${ALIAS}    uri=/api/v1/product
    Request Should Be Successful    ${resp}
    Should Be Equal    ${resp.json()['products'][1]['product_name']}     43 Piece dinner Set
    Should Be Equal As Numbers    ${resp.json()['products'][1]['product_price']}     12.95
    Should Be Equal As Integers    ${resp.json()['total']}     2

Product Detail
    ${resp}=    Get Request    alias=${ALIAS}    uri=/api/v1/product/2    headers=&{HEADER}
    Request Should Be Successful    ${resp}
    Should Be Equal    ${resp.json()['product_name']}     43 Piece dinner Set
    Should Be Equal As Numbers    ${resp.json()['product_price']}     12.95
    Should Be Equal    ${resp.json()['product_brand']}     CoolKidz

Sumbit Order
    ${data}=    To Json    {"cart" : [{ "product_id": 2,"quantity": 1}],"shipping_method" : "Kerry","shipping_address" : "405/37 ถ.มหิดล","shipping_sub_district" : "ต.ท่าศาลา","shipping_district" : "อ.เมือง","shipping_province" : "จ.เชียงใหม่","shipping_zip_code" : "50000","recipient_name" : "ณัฐญา ชุติบุตร","recipient_phone_number" : "0970809292"}
    ${resp}=    Post Request    alias=${ALIAS}    uri=/api/v1/order    json=${data}    headers=&{HEADER} 
    Request Should Be Successful    ${resp}
    Should Be Equal As Numbers    ${resp.json()['order_id']}     8004359122
    Should Be Equal As Numbers    ${resp.json()['total_price']}     14.95
    ${order_id}=    Set Variable    ${resp.json()['order_id']}
    Set Test Variable    ${order_id}

Confirm Payment
    ${data}=    To Json    {"order_id" : ${order_id},"payment_type" : "credit","type" : "visa","card_number" : "4719700591590995","cvv" : "752","expired_month" : 7,"expired_year" : 20,"card_name" : "Karnwat Wongudom","total_price" : 14.95}
    ${resp}=    Post Request    alias=${ALIAS}    uri=/api/v1/confirmPayment    json=${data}    headers=&{HEADER} 
    Request Should Be Successful    ${resp}
    Should Be Equal    ${resp.json()['notify_message']}     วันเวลาที่ชำระเงิน 1/3/2020 13:30:00 หมายเลขคำสั่งซื้อ 8004359122 คุณสามารถติดตามสินค้าผ่านช่องทาง Kerry หมายเลข 1785261900
