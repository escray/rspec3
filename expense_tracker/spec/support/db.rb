# frozen_string_literal: true

RSpec.configure do |c|
  c.before(:suite) do
    FileUtils.mkdir_p('log')
    require 'logger'
    DB.loggers << Logger.new('log/sequel.log')
    Sequel.extension :migration
    Sequel::Migrator.run(DB, 'db/migrations')
    DB[:expenses].truncate
  end
  c.around(:example, :db) do |example|
    DB.transaction(rollback: :always) { example.run }
  end
end
