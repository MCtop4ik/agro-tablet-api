class CreateOldNewRecordPk < ActiveRecord::Migration[7.1]
  def change
    create_table :old_new_record_pks do |t|
      t.string :old_record_pk
      t.string :new_record_pk

      t.timestamps
    end
  end
end
