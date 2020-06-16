class AddLoansCountToItems < ActiveRecord::Migration[6.0]
  def change
    add_column :items, :loans_count, :integer, null: false, default: 0
  end
end
