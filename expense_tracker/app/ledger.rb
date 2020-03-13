# frozen_string_literal: true

module ExpenseTracker
  RecordResult = Struct.new(:success?, :expense_id, :error_message)
  # Ledger
  class Ledger
    def record(expense)
      DB[:expenses].insert(expense)
      id = DB[:expenses].max(:id)
      RecordResult.new(true, id, nil)
    end

    def expenses_on(date); end
  end
end
