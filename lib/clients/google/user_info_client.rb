class Google::UserInfoClient < BaseClient
  URL = 'https://www.googleapis.com/'.freeze

  def initialize
    super(URL)
  end

  def get_info(access_token)
    get(
      endpoint: 'userinfo/v2/me',
      headers: { authorization: "Bearer #{access_token}" }
    )
  end

end
