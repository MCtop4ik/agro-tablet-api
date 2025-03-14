module HayServices
  class RequestManagerService
    class << self 
      def get_authentication(email)
        {:data => HayUsers.find_by(email: email)&.attributes, :status => 200}
      end

      def update_users_info(insert_data, record_pk)
        user = HayUsers.find_by(record_pk: record_pk)
        user.update(insert_data) if user
      end

      def get_lookups(category)
        {
          :data => HayLookup.where(category_kw: category).as_json.map { |lookup| 
            lookup.transform_keys { |key| 
              key.to_s.split('_').map { |part| 
                part == 'fk' ? 'FK' : part == 'ck' ? 'CK' : part == 'kw' ? 'KW' : part == 'pk' ? 'PK' : part.capitalize
              }.join('_') 
            }
          },
          :status => 200
        }
      end

      def get_time_hours
        get_lookups('timehours')
      end

      def get_time_minutes
        get_lookups('timeminutes')
      end

      def get_hay_types
        get_lookups('haytype')
      end

      def get_hay_cuts
        get_lookups('haycut')
      end

      def get_hay_farms
        {:data => HayFarms.all.as_json(only: [:farm_name, :record_pk]).map { |farm| { 'Farm_Name' => farm['farm_name'], 'Record_PK' => farm['record_pk'] } }, :status => 200}
      end

      def get_hay_fields
        {:data => HayFields.all.as_json(only: [:record_pk, :field_id, :parent_farm_fk, :field_acres]).map { |field| { 'Record_PK' => field['record_pk'], 'Field_ID' => field['field_id'], 'Parent_Farm' => field['parent_farm_fk'], 'Field_Acres' => field['field_acres'] } }, :status => 200}
      end

      def create_production_transactions(insert_data)
        old_record_pk = insert_data[:Record_PK]
        insert_data = {
          "channel_kw" => "newyorkhay",
          "sequence" => 1000,
          "active_yn" => true,
          "field_fk" => insert_data[:Field],
          "user_fk" => nil,
          "transaction_date" => insert_data[:Date],
          "hay_type_kw" => insert_data[:Hay_Type],
          "hay_cut_kw" => insert_data[:Hay_Cut],
          "start_hours_kw" => insert_data[:Start_Time_Hours],
          "start_minutes_kw" => insert_data[:Start_Time_Minutes],
          "end_hours_kw" => insert_data[:End_Time_Hours],
          "end_minutes_kw" => insert_data[:End_Time_Minutes],
          "total_time_hours" => insert_data[:Total_Hours],
          "tons_baled" => insert_data[:Tons_Baled],
          "bales_baled" => insert_data[:Bales_Baled],
          "average_moisture_percent" => insert_data[:Moisture],
          "acres" => insert_data[:Acres],
          "tons_per_acre" => insert_data[:Tons_Acre],
          "bales_per_acre" => insert_data[:Bales_Acre],
          "tons_per_hour" => insert_data[:Tons_Hour],
          "bales_per_hour" => insert_data[:Bales_Hour],
          "add_user_pk" => nil,
          "add_user_name" => nil,
          "add_date_time" => "1970-01-01 00:00:00",
          "add_ip" => nil,
          "add_browser" => nil,
          "upd_user_fk" => nil,
          "upd_user_name" => nil,
          "upd_date_time" => "1970-01-01 00:00:00",
          "upd_ip" => nil,
          "upd_browser" => nil,
          "created_at" => insert_data[:Date],
          "updated_at" => insert_data[:Date]
        }
        p insert_data
        transaction = HayProductionTransactions.create!(insert_data)
        p transaction
        OldNewRecordPk.save_record(old_record_pk, transaction.id)
        transaction
      end

      def update_production_transactions(insert_data)
        record_pk = insert_data["Record_PK"]
        new_record_pk = OldNewRecordPk.find_new_pk_by_old_pk(record_pk)
         insert_data = {
          "channel_kw" => "newyorkhay",
          "sequence" => 1000,
          "active_yn" => true,
          "field_fk" => insert_data[:Field],
          "user_fk" => nil,
          "transaction_date" => insert_data[:Date],
          "hay_type_kw" => insert_data[:Hay_Type],
          "hay_cut_kw" => insert_data[:Hay_Cut],
          "start_hours_kw" => insert_data[:Start_Time_Hours],
          "start_minutes_kw" => insert_data[:Start_Time_Minutes],
          "end_hours_kw" => insert_data[:End_Time_Hours],
          "end_minutes_kw" => insert_data[:End_Time_Minutes],
          "total_time_hours" => insert_data[:Total_Hours],
          "tons_baled" => insert_data[:Tons_Baled],
          "bales_baled" => insert_data[:Bales_Baled],
          "average_moisture_percent" => insert_data[:Moisture],
          "acres" => insert_data[:Acres],
          "tons_per_acre" => insert_data[:Tons_Acre],
          "bales_per_acre" => insert_data[:Bales_Acre],
          "tons_per_hour" => insert_data[:Tons_Hour],
          "bales_per_hour" => insert_data[:Bales_Hour],
          "add_user_pk" => nil,
          "add_user_name" => nil,
          "add_date_time" => "1970-01-01 00:00:00",
          "add_ip" => nil,
          "add_browser" => nil,
          "upd_user_fk" => nil,
          "upd_user_name" => nil,
          "upd_date_time" => "1970-01-01 00:00:00",
          "upd_ip" => nil,
          "upd_browser" => nil,
          "created_at" => insert_data[:Date],
          "updated_at" => insert_data[:Date]
        }
        transaction = HayProductionTransactions.find_by(id: new_record_pk)
        transaction.update(insert_data) if transaction
      end
    end
  end
end

# module HayServices
#   class RequestManagerService
#     class << self
#       def get_authentication(email)
#         Caspio::CaspioQuery.instance.get('table', 'HAY_Users', ResponceParsersService.method(:get_authentication_parser), "q.where=Email%20%3D%20'#{email}'")
#       end

#       def update_users_info(insert_data, record_pk)
#         Caspio::CaspioQuery.instance.update('table', 'HAY_Users', insert_data, "q.where=Record_PK%20%3D%20'#{record_pk}'")
#       end

#       def get_lookups(category)
#         category = category.upcase
#         Caspio::CaspioQuery.instance.get('table', 'HAY_Lookups', ResponceParsersService.method(:get_lookups_parser), "q.where=Category_KW%20%3D%20'#{category}'")
#       end

#       def get_time_hours
#         get_lookups('TIMEHOURS')
#       end

#       def get_time_minutes
#         get_lookups('TIMEMINUTES')
#       end

#       def get_hay_types
#         get_lookups('HAYTYPE')
#       end

#       def get_hay_cuts
#         get_lookups('HAYCUT')
#       end

#       def get_hay_farms
#         Caspio::CaspioQuery.instance.get('table', 'HAY_Farms', ResponceParsersService.method(:get_hay_farms_parser))
#       end

#       def get_hay_fields
#         Caspio::CaspioQuery.instance.get('table', 'HAY_Fields', ResponceParsersService.method(:get_hay_fields_parser))
#       end

#       def create_production_transactions(insert_data)
#         old_record_pk = insert_data[:Record_PK]
#         insert_data = ResponceParsersService.create_production_transactions_parser(insert_data)
#         resp = Caspio::CaspioQuery.instance.create('table', 'HAY_Production_Transactions', insert_data)
#         added_data = resp[:data].Result.first
#         new_record_pk = added_data.Record_PK
#         OldNewRecordPk.save_record(old_record_pk, new_record_pk)
#       end

#       def update_production_transactions(insert_data)
#         record_pk = insert_data["Record_PK"]
#         insert_data = ResponceParsersService.update_production_transactions_parser(insert_data)
#         new_record_pk = OldNewRecordPk.find_new_pk_by_old_pk(record_pk)
#         Caspio::CaspioQuery.instance.update('table', 'HAY_Production_Transactions', insert_data, "q.where=Record_PK%20%3D%20'#{new_record_pk}'")
#       end
#     end
#   end
# end