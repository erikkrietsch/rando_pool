module JSONRequest
  def get_json(path, parameters = nil, headers_or_env = {})
    get path, parameters, headers_or_env.merge({ 'HTTP_ACCEPT' => 'application/json' })
  end

  def post_json(path, parameters = nil, headers_or_env = {})
    post path, parameters, headers_or_env.merge({ 'HTTP_ACCEPT' => 'application/json' })
  end
end

RSpec.configure do |config|
  config.include JSONRequest
end
