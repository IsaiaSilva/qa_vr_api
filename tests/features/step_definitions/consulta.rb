Given("client to provide an API for testing") do
    @response = HTTParty.get 'https://viacep.com.br/ws/01001000/json'
    #puts "response code: #{@response.code}"
    #puts "response message: #{@response.message}"
    #puts "response headers: #{@response.headers}"
    #puts "response body: #{@response.body}"
end
  
When("I make an valid CEP query {string}") do |cep|
    @cep = cep
    @response = HTTParty.get "https://viacep.com.br/ws/#{@cep}/json"    
end

Then("the IBGE code must be displayed and correspond to the provided zip code") do
    @address = @response.parsed_response
    #puts @address
    #puts @cep
    #Válida se o CEP da API é igual ao CEP passado por parâmetro na consulta realizada anteriormente
    expect(@address['cep']).to eq(@cep)
    puts "O CÓDIGO DO IBGE: #{@address['ibge']}, CORRESPONDE AO CEP: #{@cep}!"
end

When("I make an invalid CEP query {string}") do |cep|
    @cep_invalido = cep
    @response = HTTParty.get "https://viacep.com.br/ws/#{@cep_invalido}/json"    
end

Then("an error message should be displayed") do
    puts "response code: #{@response.code}"
    expect(@response.code).to eq(400)
    puts "COM ESTE CEP: #{@cep_invalido} INVÁLIDO, A MENSAGEM -> #{@response.message} É ESPERADA!"
end