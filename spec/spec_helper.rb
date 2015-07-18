require "codeclimate-test-reporter"
CodeClimate::TestReporter.start

require 'webmock/rspec'
require 'factory_girl'

RSpec.configure do |config|
  WebMock.disable_net_connect!(:allow => "codeclimate.com")

  config.order = 'random'

  # FactoryGirl
  FactoryGirl.find_definitions
  config.include FactoryGirl::Syntax::Methods

  config.before(:suite) do
    begin
      FactoryGirl.lint
    ensure
      #
    end
  end
end
