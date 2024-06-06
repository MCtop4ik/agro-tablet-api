class OldNewRecordPk < ApplicationRecord
  def self.save_record(old_pk, new_pk)
    OldNewRecordPk.create(old_record_pk: old_pk, new_record_pk: new_pk)
  end

  def self.find_new_pk_by_old_pk(record_pk)
    record = OldNewRecordPk.find_by(old_record_pk: record_pk)
    record ? record.new_record_pk : record_pk
  end
end
