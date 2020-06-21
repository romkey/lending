class AddSlackNameToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :slack_name, :string, null: false, default: '', index: true
  end
end
