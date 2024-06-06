class AddColumnsToAuthenticatedUsers < ActiveRecord::Migration[7.1]
  def change
    add_column :authenticated_users, :user_id, :string
    add_column :authenticated_users, :token, :string
    add_column :authenticated_users, :expire_time, :integer
  end
end
