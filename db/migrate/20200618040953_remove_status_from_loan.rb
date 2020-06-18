class RemoveStatusFromLoan < ActiveRecord::Migration[6.0]
  def change
    remove_column :loans, :status, :integer
  end
end
