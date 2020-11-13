*** Variables ***
${URL}    https://www.google.com
${BROWSER}    chrome
${KEYWORD}    USElection2020
${EXPECTED_RESULT}    US Election 2020 - BBC News

*** Keywords ***
type google.com
    Open Browser    ${URL}  ${BROWSER}

search
    Input Text    name:q    ${KEYWORD}

press Enter
    Press Keys    name:q    RETURN

verify US Election 2020 - BBC News
    Page Should Contain    ${EXPECTED_RESULT}
    Close Browser