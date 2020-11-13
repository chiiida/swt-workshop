*** Settings ***
Library    SeleniumLibrary
Suite Teardown    Close All Browsers

*** Variables ***
${BROWSER}    chrome
${URL}    https://dminer.in.th/Product-list.html?

*** Test Cases ***
User purchase item select Kerry as shipping method and pay with Visa card and success
    show products
    show products detail
    specify qunity of product that going to buy
    add product to cart
    comfirm order
    pay with Visa card
    thank you

*** Keywords ***
show products
    Open Browser    ${URL}  ${BROWSER}
    Element Should Contain    id:productName-1    43 Piece Dinner Set
    Element Should Contain    id:productPrice-1    12.95 USD

show products detail
    Click Button    id:viewMore-1
    Wait Until Element Contains    id:productName    43 Piece dinner Set
    Wait Until Element Contains    id:productBrand    CoolKidz
    Wait Until Element Contains    id:productGender    UNISEX
    Wait Until Element Contains    id:productPrice    12.95 USD

specify qunity of product that going to buy
    Input Text    id:productQuantity    1

add product to cart
    Click Button    id:addToCart

comfirm order
    Wait Until Element Contains    id:receiverName    ณัฐญา ชุติบุตร
    Element Should Contain    id:recevierAddress    405/37 ถ.มหิดล ต.ท่าศาลา อ.เมือง จ.เชียงใหม่ 50000
    Element Should Contain    id:recevierPhonenumber    0970809292
    Element Should Contain    id:totalShippingCharge    2.00 USD
    Element Should Contain    id:totalAmount    14.95 USD
    Wait Until Page Contains Element    id:confirmPayment
    Click Button    id:confirmPayment

pay with Visa card
    Wait Until Page Contains Element    id:cardNumber
    Input Text    id:cardNumber    1234567812345678
    Input Text    id:expiredMonth    11
    Input Text    id:expiredYear    22
    Input Text    id:cvv    288
    Input Text    id:cardName    Nong Aui
    Click Button    id:Payment

thank you
    Wait Until Element Contains    id:notify    วันเวลาที่ชำระเงิน 1/3/2563 13:30:00 หมายเลขคำสั่งซื้อ 8004359103 คุณสามารถติดตามสินค้าผ่านช่องทาง Kerry ด้วยหมายเลข 1785261900
