module JsonControllerTests
  def json_response
    JSON.parse(response.body)
  end
end

RSpec.configure do |config|
  config.include JsonControllerTests, type: :controller
end
