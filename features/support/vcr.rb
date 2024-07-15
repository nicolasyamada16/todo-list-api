require 'vcr'

VCR.configure do |c|
  c.hook_into :webmock
  c.cassette_library_dir = 'features/cassettes'
  # Filtrar dados senssíveis nos cassettes:
  # LEIA: https://web.boaspraticas.jera.com.br/#/web/api/filtrar-dados-sensiveis-no-vcr
  google_clients = Rails.application.credentials.dig(Rails.env.to_sym, :google_oauth2)
  c.filter_sensitive_data('<google_client_id>') { google_clients.dig(:web, :client_id) }
  c.filter_sensitive_data('<google_client_secret>') { google_clients.dig(:web, :client_secret) }
  c.filter_sensitive_data('<google_redirect_uri>') { google_clients.dig(:web, :redirect_uri) }
end
