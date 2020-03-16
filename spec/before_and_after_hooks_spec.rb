# frozen_string_literal: true

module MyApp
  class Configuration
  end
end

RSpec.describe MyApp::Configuration do
  before(:example) do
    @original_env = ENV.to_hash
  end
  after(:example) do
    ENV.replace(@original_env)
  end
  around(:example) do |ex|
    original_env = ENV.to_hash
    ex.run
    ENV.replace(original_env)
  end
end

RSpec.describe 'Web interface to my thermostat' do
  before(:context) do
    WebBrowser.launch
  end
  after(:context) do
    WebBrowser.shutdown
  end
end
