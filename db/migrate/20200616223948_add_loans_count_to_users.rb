class AddLoansCountToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :loans_count, :integer, null: false, default: 0
  end
end
