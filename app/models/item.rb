class Item < ApplicationRecord
  belongs_to :category
  has_many :loan
  has_one_attached :photo

  enum status: { available: 0, on_loan: 1, wait_list_request: 2, unavailable: 3 }
end
