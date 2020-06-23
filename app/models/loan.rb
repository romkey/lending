class Loan < ApplicationRecord
  belongs_to :user, counter_cache: true
  belongs_to :item, counter_cache: true

  def fulfillable?
    !complete? && fulfilled_at.nil?
  end

  def overdue?
    due_at && due_at < Time.now && !returned_at
  end

  def complete?
    !returned_at.nil?
  end
end
