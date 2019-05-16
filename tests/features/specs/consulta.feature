Feature: Query data from an address from the provided zipcode
    As part of the selection process for QA Tester's vacancy in VR,
    I want to perform a query of data of an address by the provided CEP

#TC_001 - 2.1 - Criar um cenário de sucesso na consulta, printando o código do IBGE do endereço no stdout.             
Scenario: Search for an address and return the IBGE code
Given client to provide an API for testing
When I make an valid CEP query "01001-000"
Then the IBGE code must be displayed and correspond to the provided zip code

#TC_002 - 2.2 - Criar um cenário passando um CEP inválido
Scenario: Search for an address with an invalid zip code
Given client to provide an API for testing
When I make an invalid CEP query "05001-XYZ"
Then an error message should be displayed
