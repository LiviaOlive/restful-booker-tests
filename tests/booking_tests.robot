*** Settings ***
Resource          ../resources/api_keywords.resource
Suite Setup       Start API Session

*** Test Cases ***
Cenário 01: [GET] Verificar se a API está online
    [Tags]    GET    SMOKE
    Health Check

Cenário 02: [POST e GET] Criar e consultar uma nova reserva
    [Tags]    POST    GET
    ${booking_data}=    Create New Booking
    ...    Ciclano
    ...    de Tal
    ...    150
    ...    ${True}
    ...    2025-09-20
    ...    2025-09-25
    Set Suite Variable    ${BOOKING_ID}    ${booking_data}[bookingid]

    ${response}=    Get Booking By ID    ${BOOKING_ID}
    Should Be Equal As Strings    ${response}[firstname]    Ciclano
    Should Be Equal As Strings    ${response}[lastname]    de Tal

Cenário 03: [PUT] Atualizar uma reserva existente com token
    [Tags]    PUT    AUTH
    # Pré-condição: Cria uma nova reserva para garantir que o teste seja independente
    ${booking_to_update}=    Create New Booking    Beltrano    Silva    200    ${False}    2025-11-01    2025-11-05
    ${booking_id_to_update}=    Set Variable    ${booking_to_update}[bookingid]

    # Ação Principal
    ${token}=       Get Auth Token
    ${updated_booking}=    Update Booking    ${booking_id_to_update}    ${token}

    # Validação
    Should Be Equal As Strings    ${updated_booking}[firstname]    Fulano
    Should Be Equal As Strings    ${updated_booking}[lastname]    Atualizado
    Should Be Equal As Numbers    ${updated_booking}[totalprice]    999

Cenário 04: [DELETE] Deletar uma reserva existente com token
    [Tags]    DELETE    AUTH
    # Pré-condição: Cria uma nova reserva para ser deletada
    ${booking_to_delete}=    Create New Booking    Para    Deletar    50    ${True}    2025-12-01    2025-12-02
    ${booking_id_to_delete}=    Set Variable    ${booking_to_delete}[bookingid]

    # Ação Principal
    ${token}=    Get Auth Token
    Delete Booking    ${booking_id_to_delete}    ${token}

    # Validação: Tentar buscar a reserva deletada e esperar um erro 404
    Run Keyword And Expect Error    *HTTPError: 404 Client Error*    Get Booking By ID    ${booking_id_to_delete}
    # No need to assign ${response}, the error message is checked by the built-in keyword