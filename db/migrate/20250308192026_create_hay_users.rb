class CreateHayUsers < ActiveRecord::Migration[7.1]
  def change
    create_table :hay_users do |t|
      t.integer :record_pk, null: false
      t.string :channel_kw, null: false
      t.integer :sequence, null: false
      t.boolean :active_yn, default: true
      t.string :first_name
      t.string :last_name
      t.string :full_name
      t.string :email, null: false
      t.string :password_digest, null: false # For password hashing using bcrypt
      t.integer :add_user_pk
      t.string :add_user_name
      t.datetime :add_date_time
      t.string :add_ip
      t.string :add_browser
      t.integer :upd_user_fk
      t.string :upd_user_name
      t.datetime :upd_date_time
      t.string :upd_ip
      t.string :upd_browser

      t.timestamps
    end
  end
end