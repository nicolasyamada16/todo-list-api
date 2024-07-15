Dado('informações válidas para cadastro de usuário') do
  @random_password = Faker::Alphanumeric.alphanumeric(number: 18)
  @auth = {
    name: Faker::Name.name,
    email: Faker::Internet.email,
    password: @random_password,
    password_confirmation: @random_password
  }
end

Dado('informações inválidas para cadastro de usuário') do
  @random_password = Faker::Alphanumeric.alphanumeric(number: 18)
  @auth = {
    name: Faker::Name.name,
    email: 'invalid@',
    password: @random_password,
    password_confirmation: @random_password
  }
end

Quando('ele clica no botão para fazer o cadastro') do
  @response = TestClient.make_post('/api/v1/users', body: @auth)
end

Então('o usuário deve ser cadastro com sucesso') do
  expect(@response.status).to eq(201)
  expect(@response.headers['HTTP_USER_TOKEN']).to be_truthy
  expect(@response.headers['HTTP_USER_EMAIL']).to be_truthy
  expect(@response.result[:email]).to eq(@auth[:email])
  expect(@response.result[:name]).to eq(@auth[:name])
end

Então('o usuário não deve ser cadastrado na aplicação') do
  expect(@response.status).to eq(422)
  expect(@response.headers['HTTP_USER_TOKEN']).to be_falsey
  expect(@response.headers['HTTP_USER_EMAIL']).to be_falsey
  expect(@response.result[:errors]).to be_truthy
  expect(User.find_by(email: @auth[:email])).to be(nil)
end
