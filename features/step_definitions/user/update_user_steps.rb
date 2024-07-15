Dado('informações válidas para atualizar um usuário') do
  @body = { email: Faker::Internet.email }
end

Dado('informações inválidas para atualizar um usuário') do
  @body = { email: 'invalid@' }
end

Quando('o usuário tenta atualizar suas informações') do
  @response = TestClient.make_put('/api/v1/users/me', body: @body, headers: @headers)
end

Então('as informações do usuário devem ser atualizadas') do
  expect(@response.status).to eq(200)
  expect(@response.result[:email]).to eq(@body[:email])
  expect(@response.result[:errors]).to be_falsey
end

Então('as informações do usuário não devem ser atualizadas') do
  expect(@response.status).to eq(422)
  expect(@response.result[:errors]).to be_truthy
end
