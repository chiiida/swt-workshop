*** Settings ***
Library    SeleniumLibrary

*** Variables ***
${URL}    https://www.facebook.com
${BROWSER}    Chrome
${POST_TEXT}    Hello from Robotframework
${EXPECTED_NAME}    Eye Chananchida
${EMAIL}    email@email.com
${PASS}    password

*** Test Cases ***
Test login and post status on Facebook
    ${options}=    Evaluate    sys.modules['selenium.webdriver.chrome.options'].Options()    sys
    Call Method     ${options}    add_argument    --disable-notifications
    ${driver}=    Create Webdriver    ${BROWSER}    options=${options}
    type facebook.com
    login
    verify Facebook Name
    type post message
    press Post

*** Keywords ***
type facebook.com
    Go To    ${URL}

login
    Input Text    name:email    ${EMAIL}
    Input Text    name:pass    ${PASS}
    Click Element    name:login

verify Facebook Name
    Page Should Contain    ${EXPECTED_NAME}

type post message
    Input Text    name:xhpc_message    ${POST_TEXT}

press Post
    Wait Until Element Is Enabled    xpath://button[@type="submit"]/span[.="Post"]
    Click Element    xpath://button[@type="submit"]/span[.="Post"]
