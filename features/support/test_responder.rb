class TestResponder
  attr_reader :result, :status, :headers, :response

  def initialize(response)
    @result = parse_response(response.body)
    @status = response.status
    @headers = response.headers
    @response = response
  end

  def success?
    response.status >= 200 && response.status <= 299
  end

  private

  def parse_response(body)
    return {} unless body.present?

    json_response = JSON.parse(body)

    return json_response.deep_symbolize_keys unless json_response.is_a?(Array)

    json_response.map(&:deep_symbolize_keys)
  end

end
