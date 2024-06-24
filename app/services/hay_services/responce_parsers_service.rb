module HayServices
  class ResponceParsersService
    class << self
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

      def get_lookups_parser(data)
        {
          'Record_PK' => data.Record_PK,
          'Keyword_CK' => data.Keyword_CK,
          'Description' => data.Description,
          'Active_YN' => data.Active_YN,
        }
      end

      def get_hay_farms_parser(data)
        {
          'Record_PK' => data.Record_PK,
          'Farm_Name' => data.Farm_Name,
        }
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
          'Total_Time_Hours' => is_numeric_value_valid?(data['Total_Hours']) ? data['Total_Hours'] : nil,
          'Tons_Baled' => is_numeric_value_valid?(data['Tons_Baled']) ? data['Tons_Baled'] : nil,
          'Bales_Baled' => is_numeric_value_valid?(data['Bales_Baled']) ? data['Bales_Baled'] : nil,
          'Average_Moisture_Percent' => is_numeric_value_valid?(data['Moisture']) ? data['Moisture'] : nil,
          'Acres' => is_numeric_value_valid?(data['Acres']) ? data['Acres'] : nil,
          'Tons_per_Acre' => is_numeric_value_valid?(data['Tons_Acre']) ? data['Tons_Acre'] : nil,
          'Bales_per_Acre' => is_numeric_value_valid?(data['Bales_Acre']) ? data['Bales_Acre'] : nil,
          'Tons_per_Hour' => is_numeric_value_valid?(data['Tons_Hour']) ? data['Tons_Hour'] : nil,
          'Bales_per_Hour' => is_numeric_value_valid?(data['Bales_Hour']) ? data['Bales_Hour'] : nil,
          'Active_YN' => true,
        }
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
          'Total_Time_Hours' => is_numeric_value_valid?(data['Total_Hours']) ? data['Total_Hours'] : nil,
          'Tons_Baled' => is_numeric_value_valid?(data['Tons_Baled']) ? data['Tons_Baled'] : nil,
          'Bales_Baled' => is_numeric_value_valid?(data['Bales_Baled']) ? data['Bales_Baled'] : nil,
          'Average_Moisture_Percent' => is_numeric_value_valid?(data['Moisture']) ? data['Moisture'] : nil,
          'Acres' => is_numeric_value_valid?(data['Acres']) ? data['Acres'] : nil,
          'Tons_per_Acre' => is_numeric_value_valid?(data['Tons_Acre']) ? data['Tons_Acre'] : nil,
          'Bales_per_Acre' => is_numeric_value_valid?(data['Bales_Acre']) ? data['Bales_Acre'] : nil,
          'Tons_per_Hour' => is_numeric_value_valid?(data['Tons_Hour']) ? data['Tons_Hour'] : nil,
          'Bales_per_Hour' => is_numeric_value_valid?(data['Bales_Hour']) ? data['Bales_Hour'] : nil,
          'Active_YN' => true,
        }
      end

      def is_numeric_value_valid?(value)
        value.present? && !value.empty? && value != 'NaN'
      end
    end
  end
end

