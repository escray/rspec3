# frozen_string_literal: true

RSpec.configure do |config|
  config.around(:example) do |example|
    pp example.metadata
  end
end
