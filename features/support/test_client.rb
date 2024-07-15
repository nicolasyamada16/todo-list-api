require 'rack/test'

class TestClient
  extend Rack::Test::Methods

  def self.make_get(endpoint, query: {}, headers: {})
    handle_response(get(endpoint, query, headers))
  end

  def self.make_post(endpoint, body: {}, headers: {})
    handle_response(post(endpoint, body, headers))
  end

  def self.make_put(endpoint, body: {}, headers: {})
    handle_response(put(endpoint, body, headers))
  end

  def self.make_delete(endpoint, query: {}, headers: {})
    handle_response(delete(endpoint, query, headers))
  end

  def self.app
    Rails.application
  end

  def self.handle_response(response)
    log("Response with status code #{response.status}")
    TestResponder.new(response)
  end

  def self.log(message)
    Rails.logger.info(message)
  end

end
