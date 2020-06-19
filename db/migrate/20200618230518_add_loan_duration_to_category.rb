class AddLoanDurationToCategory < ActiveRecord::Migration[6.0]
  def change
    add_column :categories, :loan_duration, :integer
  end
end
