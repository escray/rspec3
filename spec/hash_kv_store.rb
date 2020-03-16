# frozen_string_literal: true

class HashKVStore
  attr_accessor :kv
  def initialize
    @kv = {}
  end

  def store(key, value)
    @kv[key] = value
  end

  def fetch(key)
    return kv[key] if @kv.key?(key)

    raise KeyError
  end
end
