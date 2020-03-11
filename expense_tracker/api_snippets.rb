require_relative 'spec/unit/app/api_spec.rb'

class Ledger
  def record(_expense)
    ExpenseTracker::RecordResult.new
  end
end

class API < Sinatra::Base
  def initialize(ledger: Ledger.new)
    @ledger = ledger
    super()
  end
end

app = API.new(ledger: Ledger.new)
