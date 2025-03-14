class CreateHayFields < ActiveRecord::Migration[7.1]
  def change
    create_table :hay_fields do |t|
      t.integer :record_pk, null: false
      t.string :channel_kw, null: false
      t.integer :sequence, null: false
      t.boolean :active_yn, default: true
      t.integer :parent_farm_fk
      t.string :field_id
      t.float :field_acres
      t.float :latitude
      t.float :longitude
      t.string :field_pdf
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