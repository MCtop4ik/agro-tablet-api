module Auth
  class ProfileHelper
    def change_public_info(data)
      begin
        insert_data, user_id = insert_profile_info(data)
        Caspio::Client.instance.update_users_info(insert_data, user_id)
        return {
          json: data,
          status: 200
        }
      rescue => e
        puts "Error: #{e.message}"
        return {
          json: 'error',
          status: 500
        }
      end
    end

    def insert_profile_info(data)
      [{
         'First_Name' => data['first_name'],
         'Last_Name' => data['last_name'],
         'Email' => data['email']
       }, data['user_id']]
    end

  end
end