module Auth
  class AccessControl
    def is_authenticated(bearer)
      bearer.slice! "Bearer "
      user = AuthenticatedUsers.find_by(:token => bearer)
      user && user.expire_time > Time.now.to_i * 100000
    end

    def get_user_id_by_token(bearer)
      bearer.slice! "Bearer "
      if AuthenticatedUsers.exists?(:token => bearer)
        AuthenticatedUsers.find_by(:token => bearer).user_id
      else
        "Not exists"
      end
    end
  end
end
