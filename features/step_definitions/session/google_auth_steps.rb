Dado('um código de autorização validado pelo google') do
  @auth = { oauth2_code: '<authorization_code>', platform: 'web' }
end

Dado('um código de autorização invalidado pelo google') do
  @auth = { oauth2_code: '<invalid_authorization_code>', platform: 'web' }
end

Quando('ele tenta logar com o google informando um com código de autorização {string}') do |text|
  condition = text == 'válido' ? 'valid' : 'invalid'

  VCR.use_cassette("google_auth_with_#{condition}_token") do
    @response = TestClient.make_post('/api/v1/users/google_auth', body: @auth)
    @user = User.find_by(email: @response.result[:email])
  end
end

Então('o usuário deve receber um erro de falha de login com o google') do
  expect(@response.headers['HTTP_USER_TOKEN']).to be_falsey
  expect(@response.headers['HTTP_USER_EMAIL']).to be_falsey
  expect(@response.result[:errors][0]).to eq(I18n.t('services.google_auth_service.errors.invalid_token'))
end
