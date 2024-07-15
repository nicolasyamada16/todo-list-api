Dado('informações válidas para alterar sua senha') do
  @update_body = {
    password: 'new_password_123',
    current_password: 'secret123',
    password_confirmation: 'new_password_123'
  }
end

Dado('informações inválidas para alterar sua senha') do
  @update_body = {
    password: 'new_password_1234',
    current_password: 'wrog_password',
    password_confirmation: 'new_password_123'
  }
end

Quando('ele clica no botão para alterar a senha') do
  @response = TestClient.make_put('/api/v1/users/update_password', body: @update_body, headers: @headers)
  @user.reload
end

Então('a senha do usuário deve ser alterada') do
  expect(@user.valid_password?('new_password_123')).to be_truthy
end

Então('a senha do usuário não deve ser alterada') do
  expect(@user.valid_password?('new_password_123')).to be_falsey
end
