# frozen_string_literal: true

module Perennials
  class Rhubard
  end
end

class Garden
end

class WeatherStation
end

class Sprinkler
end

RSpec.describe 'My awesome gardening API' do
end

RSpec.describe Perennials::Rhubard do
end

RSpec.describe Garden, 'in winter' do
end

RSpec.describe WeatherStation, 'radar updates', uses_network: true do
end

RSpec.describe Sprinkler do
  it 'waters the garden', use_serial_bus: true do
  end
end

RSpec.describe 'A kettle of water' do
  context 'when boiling' do
    it 'can make tea'
    it 'can make coffee'
  end
end

class PhoneNumberParser
end

RSpec.describe PhoneNumberParser, 'parses phone numbers' do
  example 'in xxx-xxx-xxxx form'
  example 'in (xxx) xxx-xxxx form'
end

RSpec.describe 'Deprecations' do
  specify 'MyGem.config is deprecated in favor of MyGem.configure'
  specify 'MyGem.run is deprecated in favor of MyGem.start'
end
