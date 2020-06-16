class CreateItems < ActiveRecord::Migration[6.0]
  def change
    create_table :items do |t|
      t.string :name, null: false
      t.belongs_to :category, null: false, foreign_key: true
      t.string :serial_number, null: false, default: ''
      t.boolean :available, null: false, default: true
      t.integer :max_loan_days, null: false, default: 0

      t.timestamps
    end
  end
end
