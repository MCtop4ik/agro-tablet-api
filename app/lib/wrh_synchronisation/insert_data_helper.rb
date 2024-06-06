module WrhSynchronisation
  class InsertDataHelper

    def insert_profile_info(data)
      [{
         'First_Name' => data['first_name'],
         'Last_Name' => data['last_name'],
         'Email' => data['email']
       }, data['user_id']]
    end

  end
end