module Caspio
  require 'date'
  class Client < Token

    def get_authentication(email)
      CaspioQuery.instance.get('table', 'HAY_Users', method(:get_authentication_parser), "q.where=Email%20%3D%20'#{email}'")
    end

    def get_authentication_parser(data)
      {
        "user_id": data["Record_PK"],
        "email": data["Email"],
        "user_name": data["Full_Name"],
        "password": data["Password"],
        "first_name": data["First_Name"],
        "last_name": data["Last_Name"],
        "record_pk": data["Record_PK"]
      }
    end


    def update_users_info(insert_data, record_pk)
      CaspioQuery.instance.update('table', 'HAY_Users', insert_data, "q.where=Record_PK%20%3D%20'#{record_pk}'")
    end


    def get_lookups(category)
      category = category.upcase
      CaspioQuery.instance.get('table', 'HAY_Lookups', method(:get_lookups_parser), "q.where=Category_KW%20%3D%20'#{category}'")
    end

    def get_lookups_parser(data)
      {
        'Record_PK' => data.Record_PK,
        'Keyword_CK' => data.Keyword_CK,
        'Description' => data.Description,
        'Active_YN' => data.Active_YN,
      }
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
      CaspioQuery.instance.get('table', 'HAY_Farms', method(:get_hay_farms_parser))
    end

    def get_hay_farms_parser(data)
      {
        'Record_PK' => data.Record_PK,
        'Farm_Name' => data.Farm_Name,
      }
    end

    def get_hay_fields
      CaspioQuery.instance.get('table', 'HAY_Fields', method(:get_hay_fields_parser))
    end

    def get_hay_fields_parser(data)
      {
        'Record_PK' => data.Record_PK,
        'Parent_Farm' => data.Parent_Farm_FK,
        'Field_ID' => data.Field_ID,
        'Field_Acres' => data.Field_Acres,
        'Active_YN' => data.Active_YN,
      }
    end


    def create_production_transactions(insert_data)
      old_record_pk = insert_data[:Record_PK]
      insert_data = create_production_transactions_parser(insert_data)
      resp = CaspioQuery.instance.create('table', 'HAY_Production_Transactions', insert_data)
      added_data = resp[:data].Result.first
      new_record_pk = added_data.Record_PK
      OldNewRecordPk.save_record(old_record_pk, new_record_pk)
    end

    def create_production_transactions_parser(data)
      {
        'Channel_KW' => 'NEWYORKHAY',
        'Field_FK' => data['Field'],
        'User_FK' => data['Individual'],
        'Transaction_Date' => data['Date'],
        'Hay_Type_KW' => data['Hay_Type'],
        'Hay_Cut_KW' => data['Hay_Cut'],
        'Start_Hours_KW' => data['Start_Time_Hours'],
        'Start_Minutes_KW' => data['Start_Time_Minutes'],
        'End_Hours_KW' => data['End_Time_Hours'],
        'End_Minutes_KW' => data['End_Time_Minutes'],
        'Total_Time_Hours' => (data['Total_Hours'].present? && !data['Total_Hours'].empty? && data['Total_Hours'] != 'NaN') ? data['Total_Hours'] : nil,
        'Tons_Baled' => (data['Tons_Baled'].present? && !data['Tons_Baled'].empty? && data['Tons_Baled'] != 'NaN')  ? data['Tons_Baled'] : nil,
        'Bales_Baled' => (data['Bales_Baled'].present? && !data['Bales_Baled'].empty? && data['Bales_Baled'] != 'NaN')  ? data['Bales_Baled'] : nil,
        'Average_Moisture_Percent' => (data['Moisture'].present? && !data['Moisture'].empty? && data['Moisture'] != 'NaN')  ? data['Moisture'] : nil,
        'Acres' => (data['Acres'].present? && !data['Acres'].empty? && data['Acres'] != 'NaN')  ? data['Acres'] : nil,
        'Tons_per_Acre' => (data['Tons_Acre'].present? && !data['Tons_Acre'].empty? && data['Tons_Acre'] != 'NaN') ? data['Tons_Acre'] : nil,
        'Bales_per_Acre' => (data['Bales_Acre'].present? && !data['Bales_Acre'].empty? && data['Bales_Acre'] != 'NaN') ? data['Bales_Acre'] : nil,
        'Tons_per_Hour' => (data['Tons_Hour'].present? && !data['Tons_Hour'].empty? && data['Tons_Hour'] != 'NaN')  ? data['Tons_Hour'] : nil,
        'Bales_per_Hour' => (data['Bales_Hour'].present? && !data['Bales_Hour'].empty? && data['Bales_Hour'] != 'NaN')  ? data['Bales_Hour'] : nil,
        'Active_YN' => true,
      }
    end

    def update_production_transactions(insert_data)
      record_pk = insert_data["Record_PK"]
      insert_data = update_production_transactions_parser(insert_data)
      new_record_pk = OldNewRecordPk.find_new_pk_by_old_pk(record_pk)
      CaspioQuery.instance.update('table', 'HAY_Production_Transactions', insert_data, "q.where=Record_PK%20%3D%20'#{new_record_pk}'")
    end

    def update_production_transactions_parser(data)
      {
        'Channel_KW' => 'NEWYORKHAY',
        'Field_FK' => data['Field'],
        'User_FK' => data['Individual'],
        'Transaction_Date' => data['Date'],
        'Hay_Type_KW' => data['Hay_Type'],
        'Hay_Cut_KW' => data['Hay_Cut'],
        'Start_Hours_KW' => data['Start_Time_Hours'],
        'Start_Minutes_KW' => data['Start_Time_Minutes'],
        'End_Hours_KW' => data['End_Time_Hours'],
        'End_Minutes_KW' => data['End_Time_Minutes'],
        'Total_Time_Hours' => (data['Total_Hours'].present? && !data['Total_Hours'].empty? && data['Total_Hours'] != 'NaN') ? data['Total_Hours'] : nil,
        'Tons_Baled' => (data['Tons_Baled'].present? && !data['Tons_Baled'].empty? && data['Tons_Baled'] != 'NaN')  ? data['Tons_Baled'] : nil,
        'Bales_Baled' => (data['Bales_Baled'].present? && !data['Bales_Baled'].empty? && data['Bales_Baled'] != 'NaN')  ? data['Bales_Baled'] : nil,
        'Average_Moisture_Percent' => (data['Moisture'].present? && !data['Moisture'].empty? && data['Moisture'] != 'NaN')  ? data['Moisture'] : nil,
        'Acres' => (data['Acres'].present? && !data['Acres'].empty? && data['Acres'] != 'NaN')  ? data['Acres'] : nil,
        'Tons_per_Acre' => (data['Tons_Acre'].present? && !data['Tons_Acre'].empty? && data['Tons_Acre'] != 'NaN') ? data['Tons_Acre'] : nil,
        'Bales_per_Acre' => (data['Bales_Acre'].present? && !data['Bales_Acre'].empty? && data['Bales_Acre'] != 'NaN') ? data['Bales_Acre'] : nil,
        'Tons_per_Hour' => (data['Tons_Hour'].present? && !data['Tons_Hour'].empty? && data['Tons_Hour'] != 'NaN')  ? data['Tons_Hour'] : nil,
        'Bales_per_Hour' => (data['Bales_Hour'].present? && !data['Bales_Hour'].empty? && data['Bales_Hour'] != 'NaN')  ? data['Bales_Hour'] : nil,
        'Active_YN' => true,
      }
    end
  end
end
