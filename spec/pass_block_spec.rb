# frozen_string_literal: true

require 'tempfile'
require 'file_kv_store'

RSpec.shared_examples 'KV store' do
  it 'allows you to fetch previously stored values' do
    kv_store.store(:language, 'Ruby')
    kv_store.store(:os, 'linux')
    expect(kv_store.fetch(:language)).to eq 'Ruby'
    expect(kv_store.fetch(:os)).to eq 'linux'
  end
end

RSpec.describe FileKVStore do
  it_behaves_like 'KV store' do
    let(:tempfile) { Tempfile.new('kv.store') }
    let(:kv_store) { FileKVStore.new(tempfile.path) }
  end
end
