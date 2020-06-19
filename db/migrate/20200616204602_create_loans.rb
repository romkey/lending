class CreateLoans < ActiveRecord::Migration[6.0]
  def change
    create_table :loans do |t|
      t.belongs_to :user, null: false, foreign_key: true, index: true
      t.belongs_to :item, null: false, foreign_key: true, index: true

      t.datetime :requested_at, index: true
      t.datetime :fulfilled_at, index: true
      t.datetime :returned_at, index: true
      t.datetime :due_at, index: true

      t.integer :status, null: false, index: true

      t.timestamps index: true
    end
  end
end
