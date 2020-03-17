# frozen_string_literal: true

require 'addressable'

RSpec.describe Addressable do
  it 'parse the schema' do
    expect(Addressable::URI.parse('https://a.com').scheme).to eq 'https'
  end
  it 'parses the host' do
    expect(Addressable::URI.parse('https://foo.com').host).to eq 'foo.com'
  end
  it 'parses the port' do
    expect(Addressable::URI.parse('http://example.com:9876').port).to eq 9876
  end
  # it 'parses the default port' do
  #   expect(Addressable::URI.parse('http://example.com').port).to eq 80
  # end
  # it 'parses the port for an https URI to 443' do
  #   expect(Addressable::URI.parse('https://example.com').port).to eq 443
  # end
  it 'parses the path' do
    expect(Addressable::URI.parse('http://a.com/foo').path).to eq '/foo'
  end
end
