module HayServices
  class RequestManagerService
    class << self
      def get_authentication(email)
        Caspio::CaspioQuery.instance.get('table', 'HAY_Users', ResponceParsersService.method(:get_authentication_parser), "q.where=Email%20%3D%20'#{email}'")
      end

      def update_users_info(insert_data, record_pk)
        Caspio::CaspioQuery.instance.update('table', 'HAY_Users', insert_data, "q.where=Record_PK%20%3D%20'#{record_pk}'")
      end

      def get_lookups(category)
        category = category.upcase
        Caspio::CaspioQuery.instance.get('table', 'HAY_Lookups', ResponceParsersService.method(:get_lookups_parser), "q.where=Category_KW%20%3D%20'#{category}'")
      end

      def get_time_hours
        get_lookups('TIMEHOURS')
      end

      def get_time_minutes
        get_lookups('TIMEMINUTES')
      end

      def get_hay_types
        get_lookups('HAYTYPE')
      end

      def get_hay_cuts
        get_lookups('HAYCUT')
      end

      def get_hay_farms
        Caspio::CaspioQuery.instance.get('table', 'HAY_Farms', ResponceParsersService.method(:get_hay_farms_parser))
      end

      def get_hay_fields
        Caspio::CaspioQuery.instance.get('table', 'HAY_Fields', ResponceParsersService.method(:get_hay_fields_parser))
      end

      def create_production_transactions(insert_data)
        old_record_pk = insert_data[:Record_PK]
        insert_data = ResponceParsersService.create_production_transactions_parser(insert_data)
        resp = Caspio::CaspioQuery.instance.create('table', 'HAY_Production_Transactions', insert_data)
        added_data = resp[:data].Result.first
        new_record_pk = added_data.Record_PK
        OldNewRecordPk.save_record(old_record_pk, new_record_pk)
      end

      def update_production_transactions(insert_data)
        record_pk = insert_data["Record_PK"]
        insert_data = ResponceParsersService.update_production_transactions_parser(insert_data)
        new_record_pk = OldNewRecordPk.find_new_pk_by_old_pk(record_pk)
        Caspio::CaspioQuery.instance.update('table', 'HAY_Production_Transactions', insert_data, "q.where=Record_PK%20%3D%20'#{new_record_pk}'")
      end
    end
  end
end