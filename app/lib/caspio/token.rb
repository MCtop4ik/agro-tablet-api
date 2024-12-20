module Caspio
  class Token
    include Singleton

    BRIDGE = "c4hch455"
    TOKEN_URL = "https://#{BRIDGE}.caspio.com/oauth/token"

    attr_accessor :token, :expired_time

    def get_token
      if check_token_expired
        get_new_token
      end
      token
    end

    private def check_token_expired
      @expired_time.nil? || @expired_time - 300 <= Time.now
    end

    private def get_new_token
      params = {
        grant_type: "client_credentials",
        client_id: '6ae25a1af8e64375d5fedfb6dc8362be563294b0c946e93689',
        client_secret: 'c7b028c772134381a686f2b0f69b8947f45d747aba54789c4c',
      }
      response = RestClient.post(TOKEN_URL, params)

      @token = JSON.parse(response.body, object_class: OpenStruct)
      @expired_time = Time.now + token.expires_in
    end
  end
end