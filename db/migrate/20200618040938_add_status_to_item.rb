class AddStatusToItem < ActiveRecord::Migration[6.0]
  def change
    add_column :items, :status, :integer, null: false, default: 0, index: true
  end
end
