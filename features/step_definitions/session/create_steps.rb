Dado('uma credencial válida de login') do
  @auth = { email: @user.email, password: @user.password }
end

Dado('uma credencial com email inválido de login') do
  @auth = { login: 'invalid@gmail.com', password: @user.password }
end

Dado('uma credencial com senha inválida de login') do
  @auth = { login: @user.email, password: 'invalid' }
end

Quando('ele clica no botão para fazer o login') do
  @response = TestClient.make_post('/api/v1/users/sign_in', body: @auth)
end

Então('o usuário deve ter um token válido') do
  @user.reload
  expect(@response.headers['HTTP_USER_TOKEN'].present?).to be_truthy
  expect(@response.headers['HTTP_USER_EMAIL'].present?).to be_truthy
  expect(@response.headers['HTTP_USER_EMAIL']).to eq(@user.email)
  expect(@user.token_match?(@response.headers['HTTP_USER_TOKEN'])).to be_truthy
end

Então('o usuário deve receber um erro de email ou senha inválida') do
  expect(@response.headers['HTTP_USER_TOKEN']).to be_falsey
  expect(@response.headers['HTTP_USER_EMAIL']).to be_falsey
  expect(@response.result[:errors][0]).to eq(I18n.t('services.session_service.errors.invalid_params'))
end
