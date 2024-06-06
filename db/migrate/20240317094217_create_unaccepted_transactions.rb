class CreateUnacceptedTransactions < ActiveRecord::Migration[7.1]
  def change
    create_table :unaccepted_transactions do |t|

      t.timestamps
    end
  end
end
