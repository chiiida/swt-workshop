*** Settings ***
Library    SeleniumLibrary

*** Variables ***

*** Test Cases ***
Test search keyword and verify search result on Google
    type google.com
    search USElection2020
    press Enter
    verify US Election 2020 - BBC News

*** Keywords ***
type google.com
    Open Browser    https://www.google.com  chrome

search USElection2020
    Input Text    name:q    USElection2020

press Enter
    Press Keys    name:q    RETURN

verify US Election 2020 - BBC News
    Page Should Contain    US Election 2020 - BBC News
