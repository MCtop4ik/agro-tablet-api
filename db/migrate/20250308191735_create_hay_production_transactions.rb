class CreateHayProductionTransactions < ActiveRecord::Migration[7.1]
  def change
    create_table :hay_production_transactions, id: false do |t|
      t.primary_key :record_pk
      t.string  :channel_kw
      t.integer :sequence
      t.boolean :active_yn, default: true
      t.integer :field_fk
      t.integer :user_fk
      t.datetime :transaction_date
      t.string  :hay_type_kw
      t.string  :hay_cut_kw
      t.integer :start_hours_kw
      t.integer :start_minutes_kw
      t.integer :end_hours_kw
      t.integer :end_minutes_kw
      t.decimal :total_time_hours, precision: 5, scale: 2
      t.decimal :tons_baled, precision: 10, scale: 2
      t.integer :bales_baled
      t.decimal :average_moisture_percent, precision: 5, scale: 2
      t.decimal :acres, precision: 10, scale: 2
      t.decimal :tons_per_acre, precision: 10, scale: 2
      t.decimal :bales_per_acre, precision: 10, scale: 2
      t.decimal :tons_per_hour, precision: 10, scale: 2
      t.decimal :bales_per_hour, precision: 10, scale: 2
      t.integer :add_user_pk
      t.string  :add_user_name
      t.datetime :add_date_time
      t.string  :add_ip
      t.string  :add_browser
      t.integer :upd_user_fk
      t.string  :upd_user_name
      t.datetime :upd_date_time
      t.string  :upd_ip
      t.string  :upd_browser

      t.timestamps
    end
  end
end