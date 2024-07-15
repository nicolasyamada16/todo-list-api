Quando('o usuário tenta visualizar suas informações') do
  @response = TestClient.make_get('/api/v1/users/me', headers: @headers)
end

Então('o usuário deve conseguir visualizar suas informações') do
  expect(@response.status).to eq(200)
end
