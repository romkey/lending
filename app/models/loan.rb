class Loan < ApplicationRecord
  belongs_to :user, counter_cache: true
  belongs_to :item, counter_cache: true

  enum status: { available: 0, on_loan: 1, wait_list_request: 2, unavailable: 3 }
end
