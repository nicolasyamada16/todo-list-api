# Common steps é um arquivo que define valores que podem
# ser usados por outros arquivos de testes ".feature"

Dado('um usuário da aplicação') do
  @user = FactoryBot.create(:user)

  @headers = {}
end

Dado('um usuário criado e autenticado') do
  @user = FactoryBot.create(:user, password: 'secret123', password_confirmation: 'secret123')

  @headers = {
    HTTP_USER_EMAIL: @user.email,
    HTTP_USER_TOKEN: @user.refresh_token[:token]
  }.stringify_keys
end

Dado('um usuário autenticado') do
  @user = FactoryBot.create(:user)

  @headers = {
    HTTP_USER_EMAIL: @user.email,
    HTTP_USER_TOKEN: @user.refresh_token[:token]
  }.stringify_keys
end

Então('deve dar erro de falha de autenticação') do
  expect(@response.status).to eq(401)
end
