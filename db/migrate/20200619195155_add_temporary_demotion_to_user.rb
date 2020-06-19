class AddTemporaryDemotionToUser < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :temporarily_demoted, :boolean, null: false, default: false
  end
end
