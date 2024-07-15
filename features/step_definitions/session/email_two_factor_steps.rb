Dado('um código inválido de login') do
  @two_factor_auth_token = '123456'
end

Quando('ele clica no botão para fazer o login com dois fatores') do
  @response = TestClient.make_post('/api/v1/users/two_factor_sign_in', body: @auth)
end

Quando('ele clica para verificar o código') do
  @response = TestClient.make_post('/api/v1/users/verify_two_factor_auth_token', body: { two_factor_auth_token: @two_factor_auth_token, email: @email })
end

Então('deve ter recebido o email com o código de verificação') do
  emails = ActionMailer::Base.deliveries
  @user.reload
  @two_factor_auth_token = @user.two_factor_auth_token
  @email = @user.email
  expect(emails.count).to eq(1)
end

Então('o usuário deve receber um erro de código inválido') do
  expect(@response.result[:errors][0]).to eq(I18n.t('services.user.verify_two_factor_auth_token_service.errors.invalid_token'))
end
