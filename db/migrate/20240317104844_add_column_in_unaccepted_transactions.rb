class AddColumnInUnacceptedTransactions < ActiveRecord::Migration[7.1]
  def change
    add_column :unaccepted_transactions, :data, :string
    add_column :unaccepted_transactions, :status, :string
  end
end
