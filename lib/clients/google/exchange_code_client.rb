class Google::ExchangeCodeClient < BaseClient
  URL = 'https://oauth2.googleapis.com/'.freeze
  GOOGLE_CLIENTS = Rails.application.credentials.dig(Rails.env.to_sym, :google_oauth2).freeze

  def initialize
    super(URL)
  end

  # Método responsável por trocar o código da resposta da tela de consentimento do usuário
  # por um token de acesso para acessar as API's do google
  def exchange_for_token(oauth2_code, platform)
    post(
      endpoint: 'token',
      body: body_params(oauth2_code, platform)
    )
  end

  private

  # Para mais detalhes, visite a documentação:
  # https://developers.google.com/identity/protocols/oauth2/web-server#exchange-authorization-code
  def body_params(oauth2_code, platform)
    {
      client_secret: GOOGLE_CLIENTS.dig(platform.to_sym, :client_secret),
      redirect_uri: GOOGLE_CLIENTS.dig(platform.to_sym, :redirect_uri),
      client_id: GOOGLE_CLIENTS.dig(platform.to_sym, :client_id),
      grant_type: 'authorization_code',
      code: oauth2_code
    }.to_json
  end

end
