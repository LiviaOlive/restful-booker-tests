*** Settings ***
Library    RequestsLibrary
Library    Collections

*** Variables ***
${BASE_URL}    https://restful-booker.herokuapp.com

*** Keywords ***
# --- SETUP & HEALTH CHECK ---
Start API Session
    Create Session    api    ${BASE_URL}

Health Check
    ${response}=    GET On Session    api    /ping
    Status Should Be    201    ${response}

# --- AUTH ---
Get Auth Token
    &{credentials}=    Create Dictionary    username=admin    password=password123
    ${response}=    POST On Session    api    /auth    json=${credentials}
    Status Should Be    200    ${response}
    ${token}=    Set Variable    ${response.json()}[token]
    Log    Token recebido: ${token}
        RETURN    ${token}

# --- BOOKING KEYWORDS ---
Create New Booking
    [Arguments]    ${firstname}    ${lastname}    ${totalprice}    ${depositpaid}    ${checkin}    ${checkout}
    &{booking_dates}=    Create Dictionary    checkin=${checkin}    checkout=${checkout}
    &{payload}=    Create Dictionary
    ...    firstname=${firstname}
    ...    lastname=${lastname}
    ...    totalprice=${totalprice}
    ...    depositpaid=${depositpaid}
    ...    bookingdates=${booking_dates}
    ...    additionalneeds=Breakfast

    ${response}=    POST On Session    api    /booking    json=${payload}
    Status Should Be    200    ${response}
    Log    Reserva criada: ${response.json()}
        RETURN    ${response.json()}

Get Booking By ID
    [Arguments]    ${booking_id}
    ${response}=    GET On Session    api    /booking/${booking_id}
    Status Should Be    200    ${response}
        RETURN    ${response.json()}

Update Booking
    [Arguments]    ${booking_id}    ${token}
    &{headers}=    Create Dictionary    Content-Type=application/json    Accept=application/json    Cookie=token=${token}
    &{booking_dates}=    Create Dictionary    checkin=2025-10-01    checkout=2025-10-10
    &{payload}=    Create Dictionary
    ...    firstname=Fulano
    ...    lastname=Atualizado
    ...    totalprice=999
    ...    depositpaid=${False}
    ...    bookingdates=${booking_dates}
    ...    additionalneeds=All inclusive

    ${response}=    PUT On Session    api    /booking/${booking_id}    json=${payload}    headers=${headers}
    Status Should Be    200    ${response}
        RETURN    ${response.json()}

Delete Booking
    [Arguments]    ${booking_id}    ${token}
    &{headers}=    Create Dictionary    Content-Type=application/json    Cookie=token=${token}
    ${response}=    DELETE On Session    api    /booking/${booking_id}    headers=${headers}
    Status Should Be    201    ${response}

Partially Update Booking
    [Arguments]    ${booking_id}    ${token}
    &{headers}=    Create Dictionary    Content-Type=application/json    Accept=application/json    Cookie=token=${token}
    &{payload}=    Create Dictionary    firstname=Livia    totalprice=500
    ${response}=    PATCH On Session    api    /booking/${booking_id}    json=${payload}    headers=${headers}
    Status Should Be    200    ${response}
        RETURN    ${response.json()}