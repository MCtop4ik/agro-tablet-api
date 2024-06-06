class CreateAuthenticatedUsers < ActiveRecord::Migration[7.1]
  def change
    create_table :authenticated_users do |t|

      t.timestamps
    end
  end
end
