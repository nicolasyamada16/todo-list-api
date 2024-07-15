Dado('informações válidas para solicitar uma nova senha') do
  @recovery_body = {
    email: @user.email
  }
end

Dado('informações inválidas para solicitar uma nova senha') do
  @recovery_body = {
    email: Faker::Internet.email
  }
end

Quando('ele clica no botão para solicitar nova senha') do
  @response = TestClient.make_put('/api/v1/users/recovery_password', body: @recovery_body)
end

Então('o usuário deve receber um email') do
  emails = ActionMailer::Base.deliveries

  expect(emails.count).to eq(1)
end

Então('o usuário não deve receber um email') do
  emails = ActionMailer::Base.deliveries

  expect(emails.count).to eq(0)
end
