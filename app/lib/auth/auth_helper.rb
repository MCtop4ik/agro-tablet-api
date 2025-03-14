require 'digest'

module Auth
  class AuthHelper

    def hash_password(password)
      Digest::MD5.hexdigest(password)
    end

    def auth(email, password)
      resp = HayServices::RequestManagerService.get_authentication(email)
      return { json: 'Wrong credentials'.to_json, status: 401 } if resp[:status] != 200
      user = resp[:data]
      if hash_password(password) == user["password_digest"]
        token_data = generate_token(email)
        AuthenticatedUsers.create(
          :user_id => user["user_id"],
          :token => token_data[:token],
          :expire_time => token_data[:expire_time])
        {
          json: {
            token_info: {
              token: token_data[:token],
              expire_time: token_data[:expire_time],
            },
            user_info: {
              user_id: user["user_id"],
              first_name: user["first_name"],
              last_name: user["last_name"],
              email: email,
              record_pk: user["record_pk"]
            }
          }.to_json,
          status: 200
        }
      else
        { json: 'Wrong credentials'.to_json, status: 401 }
      end
    end

    def generate_token(email)
      current_date = Time.now + 5 * 3600
      expire_time = current_date.to_i * 1000000
      token = Digest::MD5.hexdigest("start-salt#{email}$!311#{expire_time}")
      {
        token: token,
        expire_time: expire_time
      }
    end
  end
end
