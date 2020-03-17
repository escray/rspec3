# frozen_string_literal: true

require 'pp'

RSpec.describe Hash, :outer_group do
  it 'is used by RSpec for metadata', :fast, :focus do |example|
    pp example.metadata
  end
  context 'on a nested group' do
    it 'is also inherited' do |example|
      pp example.metadata[:full_description]
    end
  end
end
