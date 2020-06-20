class Loan < ApplicationRecord
  belongs_to :user, counter_cache: true
  belongs_to :item, counter_cache: true

  def overdue?
    due_at < Time.now
  end
end
