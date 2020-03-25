# frozen_string_literal: true

RSpec.describe 'A group with a failure' do
  it 'has an exmaple that fails' do
    expect(1).to eq 2
  end
  it 'has an example that success' do
    expect(1).to eq 1
  end
end

RSpec.describe 'Another group with a failure' do
  it 'has an example that fails' do
    expect(1).to eq 2
  end
  it 'has an example that success' do
    expect(1).to eq 1
  end
end
