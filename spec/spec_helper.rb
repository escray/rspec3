# frozen_string_literal: true

RSpec.configure do |config|
  config.define_derived_metadata(file_path: %r{spec/unit}) do |meta|
    meta[:fast] = true
  end
  config.define_derived_metadata(type: :model) do |meta|
  end
  config.define_derived_metadata do |meta|
    meta[:aggregate_failures] = true unless meta.key?(:aggregate_failures)
  end
  config.filter_run_excluding :jruby_only unless RUBY_PLATFORM == 'java'
  config.filter_run_when_matching :focus
end
