*** Settings ***
Library    SeleniumLibrary
Resource    resource-g3.robot

*** Test Cases ***
Test search keyword and verify search result on Google
    type google.com
    search
    press Enter
    verify US Election 2020 - BBC News
